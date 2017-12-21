![GATC Logo](../../docs/shared-images/gatc2017_logo_150.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2017 - Melbourne

# Managing Multiprocess Galaxy with Supervisor - Exercise.

## Introduction

A multiprocess Galaxy server is essential for scalability. However, it can also be unwieldy to manage. Supervisor is a process manager that makes the management task simple.

## Section 1 - Installation and basic configuration

Install supervisor from the system package manager using:

```console
$ sudo apt install supervisor
```

Check if Supervisor is running and start it if it isn't:

```console
$ sudo systemctl status supervisor
$ sudo systemctl start supervisor
```

If `supervisorctl status` returns no output, it means it's working (but nothing has been configured yet):

```console
$ sudo supervisorctl status
$
```

## Section 2 - Add uWSGI process

If you are still running uWSGI, use `CTRL+C` to stop it.

We need to add a `[program:x]` section to the supervsior config to manage uWSGI. The default supervisor config file is at `/etc/supervisor/supervisord.conf`. This file includes any files matching `/etc/supervisor/conf.d/*.conf`. We'll create a `galaxy.conf`:

```console
$ sudo -e /etc/supervisor/conf.d/galaxy.conf
```

Add the following new section:

```ini
[program:galaxy]
command         = uwsgi --plugin python --virtualenv /srv/galaxy/venv --ini-paste /srv/galaxy/config/galaxy.ini
directory       = /srv/galaxy/server
autostart       = true
autorestart     = true
startsecs       = 10
user            = galaxy
stopsignal      = INT
```

The command that we used to start uWSGI in the uWSGI exercise was:

```console
$ sudo --set-home -u galaxy sh -c 'cd /srv/galaxy/server && uwsgi --plugin python --virtualenv /srv/galaxy/venv --ini-paste /srv/galaxy/config/galaxy.ini'
```

As you can see, supervisor is running the same command, and runs it as the same user, from the same working directory.

## Section 3 - Add handler processes and group

**Part 1 - Define a handler**

We need to add a `[program:x]` section to manage the job handlers we added. Because we have cleverly named our handlers as a string followed by an incrementing integer (beginning with 0) we only need one `[program:x]` and we use the `numprocs` feature to spawn multiple. This is added to the bottom of `/etc/supervisor/conf.d/galaxy.conf`:

```ini
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
```

Now, save and quit your editor.

The magic is in these two lines, which cause supervisor to create two instances of the program and set their program names accordingly:

```ini
process_name    = handler%(process_num)s
numprocs        = 2
```

Notify supervisor of the changes with `supervisorctl update`:

```console
$ sudo supervisorctl update
galaxy: added process group
handler: added process group
$ sudo supervisorctl status
galaxy                           RUNNING   pid 6710, uptime 15:37:57
handler:handler0                 STARTING  
handler:handler1                 STARTING  
```

**Part 2 - Define a group**

Supervisor allows you to group programs together for easier control using the `[group:x]` config section. A group has already been created for your handlers using their program name, but you can override this default and add the uWSGI process as well. The `[group:x]` section is simple and should be added to the bottom of `/etc/supervisor/conf.d/galaxy.conf`:

```ini
[group:gx]
programs = galaxy,handler
```

And read the changes again with `sudo supervisorctl update`:

```console
$ sudo supervisorctl update
handler: stopped
handler: removed process group
galaxy: stopped
galaxy: removed process group
gx: added process group
$ sudo supervisorctl status
gx:galaxy                        STARTING  
gx:handler0                      STARTING  
gx:handler1                      STARTING  
```

Now you can control all 3 processes with `sudo supervisorctl <action> all` or `sudo supervisorctl <action> gx:*`.

In addition, you can *gracefully* restart the uWSGI Galaxy process with `sudo supervisorctl signal HUP gx:galaxy`. uWSGI is configured to start Galaxy in a "master" process and then fork the configured number of worker processes. Because of this, if sent a `SIGHUP` signal, it will kill the workers but the master process will hold its socket open, blocking client (browser) connections until new workers are forked. This prevents users from seeing a proxy error page during restarts. Using this, you can restart both the uWSGI server and Galaxy handlers with:

```console
$ sudo supervisorctl signal HUP gx:galaxy && sudo supervisorctl restart gx:handler0 gx:handler1
```

## Having trouble?

- Logs in `/var/log/supervisor`

## Further reading

- [Supervisor docs](http://supervisord.org/)
