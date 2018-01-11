![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

# Run uWSGI Zerg Mode - Exercise.

#### Authors: Nate Coraor (2017)

## Introduction

The standard uWSGI operation mode allows you to restart the Galaxy application while blocking client connections. [Zerg Mode](https://uwsgi-docs.readthedocs.io/en/latest/Zerg.html) does away with the waiting by running a special **Zerg Pool** process, and connecting **Zergling** workers (aka Galaxy application processes) to the pool. As long as at least one is connected, requests can be served. We will utilize this to do transparent restarts. In our configuration, one zergling will start automatically when supervisor loads its configuration. To restart Galaxy, a second zergling will be started. Once it has fully loaded, it will signal the first zergling to terminate. The first terminates, and the second takes over serving requests.

## Section 1 - Configure Supervisor

We'll replace `/etc/supervisor/conf.d/galaxy.conf` with a new one and create a directory for the zergpool communication socket:

```console
sudo mv /etc/supervisor/conf.d/galaxy.conf /etc/supervisor/conf.d/galaxy.conf.disabled
sudo -Hu galaxy mkdir /srv/galaxy/var
```

The contents of the new galaxy.conf are:

```ini
[program:zergpool]
command         = uwsgi --plugin zergpool --master --zerg-pool /srv/galaxy/var/zergpool.sock:127.0.0.1:4001 --logto /srv/galaxy/log/zergpool.log
directory       = /srv/galaxy/server
priority        = 899
umask           = 022
autostart       = true
autorestart     = true
startsecs       = 5
user            = galaxy
environment     = HOME="/srv/galaxy",VIRTUAL_ENV="/srv/galaxy/venv",PATH="/srv/galaxy/venv/bin:%(ENV_PATH)s"
numprocs        = 1
stopsignal      = INT

[program:zergling0]
command         = uwsgi --plugin python --virtualenv /srv/galaxy/venv --ini-paste /srv/galaxy/config/galaxy.ini --stats 127.0.0.1:9190 --logto /srv/galaxy/log/zergling0.log
directory       = /srv/galaxy/server
priority        = 999
umask           = 022
autostart       = true
autorestart     = unexpected
startsecs       = 15
user            = galaxy
environment     = HOME="/srv/galaxy",VIRTUAL_ENV="/srv/galaxy/venv",PATH="/srv/galaxy/venv/bin:%(ENV_PATH)s",DRMAA_LIBRARY_PATH="/usr/lib/slurm-drmaa/lib/libdrmaa.so.1"
stopsignal      = INT

[program:zergling1]
command         = uwsgi --plugin python --virtualenv /srv/galaxy/venv --ini-paste /srv/galaxy/config/galaxy.ini --stats 127.0.0.1:9191 --logto /srv/galaxy/log/zergling1.log
directory       = /srv/galaxy/server
priority        = 999
umask           = 022
autostart       = false
autorestart     = unexpected
startsecs       = 15
user            = galaxy
environment     = HOME="/srv/galaxy",VIRTUAL_ENV="/srv/galaxy/venv",PATH="/srv/galaxy/venv/bin:%(ENV_PATH)s",DRMAA_LIBRARY_PATH="/usr/lib/slurm-drmaa/lib/libdrmaa.so.1"
stopsignal      = INT

[program:handler]
command         = python ./scripts/galaxy-main -c /srv/galaxy/config/galaxy.ini --server-name=handler%(process_num)s --log-file /srv/galaxy/log/handler%(process_num)s.log
directory       = /srv/galaxy/server
process_name    = handler%(process_num)s
numprocs        = 2
umask           = 022
autostart       = true
autorestart     = true
startsecs       = 10
user            = galaxy
environment     = VIRTUAL_ENV="/srv/galaxy/venv",PATH="/srv/galaxy/venv/bin:%(ENV_PATH)s"

[group:gx]
programs = zergpool,zergling0,zergling1,handler
```

## Section 2 - Configure Galaxy

Zerg mode works by passing file descriptors between the zerg pool and zerglings on a UNIX domain socket. The zerglings are controlled by communication over a FIFO. The `[uwsgi]` section of your `galaxy.ini` will need to be updated thusly (replacing the contents of the previous section, either by deletion or commenting):

```ini
[uwsgi]
; basics
processes = 2
threads = 2
pythonpath = lib
master = True
logfile-chmod = 644

; zerg mode
; http://lists.unbit.it/pipermail/uwsgi/2014-October/007683.html
; https://gist.githubusercontent.com/unbit/2674313f070673a720e3/raw/56c804136c917ce1204b656f2d46e9988b48b1c7/spinningfifo.c
; this plugin was manually built into the test/main virtualenvs with:
;   uwsgi --build-plugin spinningfifo.c
;   mkdir -p /srv/galaxy/venv/lib/uwsgi/plugins
;   mv spinningfifo_plugin.so /srv/galaxy/venv/lib/uwsgi/plugins
plugins-dir = /srv/galaxy/venv/lib/uwsgi/plugins
plugin = spinningfifo

; fifo '0'
master-fifo = /srv/galaxy/var/zerg-new.fifo
; fifo '1'
master-fifo = /srv/galaxy/var/zerg-run.fifo
; fifo '2'
master-fifo = /srv/galaxy/var/zerg-old.fifo

; attach to zerg
zerg = /srv/galaxy/var/zergpool.sock

; force the currently running instance to become old (slot 2) and terminate
if-exists = /srv/galaxy/var/zerg-run.fifo
  hook-accepting1-once = writefifo:/srv/galaxy/var/zerg-run.fifo 2q
endif =
; force this instance to became the running one (slot 1)
hook-accepting1-once = spinningfifo:/srv/galaxy/var/zerg-new.fifo 1

; perform restarts with `echo q >/srv/galaxy/var/zerg-old.fifo`
```

## Section 3 - Configure uWSGI

The zerg mode setup makes use of a small non-standard uWSGI plugin (from the uWSGI developers) called `spinningfifo`. uWSGI provides a built-in way to compile the plugin (as the `ubuntu` user):

```console
sudo apt install -y uuid-dev libcap-dev libpcre3-dev libssl-dev
curl -LO https://gist.githubusercontent.com/unbit/2674313f070673a720e3/raw/56c804136c917ce1204b656f2d46e9988b48b1c7/spinningfifo.c
uwsgi --build-plugin spinningfifo.c
```

Then install it with:

```console
sudo -u galaxy mkdir -p /srv/galaxy/venv/lib/uwsgi/plugins
sudo mv spinningfifo_plugin.so /srv/galaxy/venv/lib/uwsgi/plugins
sudo chown galaxy:galaxy /srv/galaxy/venv/lib/uwsgi/plugins/spinningfifo_plugin.so
```

## Section 4 - Start the zerg Galaxy

Stop your existing Galaxy services using:

```console
sudo supervisorctl stop all
```

Ensure no uwsgi processes remain e.g. with `ps`.

You can optionally monitor your new Galaxy processes when they're started and watch as they flip-flop with `uwsgitop`:

```console
sudo -Hu galaxy /srv/galaxy/venv/bin/pip install uwsgitop
while [ 1 ]; do sudo -Hu galaxy /srv/galaxy/venv/bin/uwsgitop localhost:9190; sleep 1; done
while [ 1 ]; do sudo -Hu galaxy /srv/galaxy/venv/bin/uwsgitop localhost:9191; sleep 1; done  # in a second terminal
```

Now it's time to notify supervisord of your changes, with:

```console
sudo supervisorctl update
```

You can watch the first zergling load by monitoring the log file:

```console
tail -f /srv/galaxy/log/zergling0.log
```

## Section 5 - Restart Galaxy

Galaxy is restarted (somewhat unintuitively) by launching the second zergling:

```console
sudo supervisorctl start gx:zergling1
```

You can monitor the process with `sudo supervisorctl status`:

- zergling1 will start - until it fully loads, both zergling0 and zergling1 will remain running
- Once fully loaded, zergling1 signals zergling0 to terminate via its FIFO
- zergling0 will exit and its `EXITED` status will be reflected in `sudo supervisorctl status`

## Further reading

- [uWSGI Zerg Mode documentation](http://uwsgi-docs.readthedocs.io/en/latest/Zerg.html)
- [uWSGI The Art of Graceful Reloading](http://uwsgi-docs.readthedocs.io/en/latest/articles/TheArtOfGracefulReloading.html)
- [uWSGI Master FIFO](http://uwsgi-docs.readthedocs.io/en/latest/MasterFIFO.html)
- [spinningfifo](http://lists.unbit.it/pipermail/uwsgi/2014-October/007683.html)
- [uWSGI docs](http://uwsgi-docs.readthedocs.org/)
