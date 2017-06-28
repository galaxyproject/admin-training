layout: true
class: inverse, larger

---
class: special, middle
# uWSGI, job handlers, and supervisor

slides by @natefoo, @Slugger70

.footnote[\#usegalaxy / @galaxyproject]

---
# What is uWSGI?

Web/application/WSGI server

Replaces `Paste#http` (see `galaxy.ini`)

---
# The Python GIL

![Python GIL](https://lh4.googleusercontent.com/HXDr4afwx28XEZgogOWBMEcaU0updIy_BsRqOnq7kaGVq3kEyXMlwmrDTvi9ZlMRI7fdW4TT5sPO4z_9kSVxlhrUznOdvK_rHQtP6pfic8ABrVcm3lOWPEoMH8sDKK2fMhw1YLI)

.footnote[Image credit: [Dariusz Fryta](http://www.tivix.com/blog/lets-go-python/)]

---
# Why uWSGI?

- Python GIL is a severe limitation for multicore servers
- Isolate job functions from web functions
  - Can be done with Paste, but uWSGI does it better/simpler
- Work around the GIL without manually managing multiple Galaxy processes

---
# Why uWSGI?

- Built in load balancing
- Speak native high performance uWSGI protocol to nginx
- Will be the default anyway
- Uninterrupted restarting

---
# A note on processes

uWSGI will run and control a configured number of *anonymous processes* to **serve web requests**

These processes **do not** handle jobs. For this, we start *webless* processes called *job handlers*

---
# uWSGI communication

- uWSGI can serve http directly using the `--http` option
- uWSGI speaks a native protocol (which nginx also speaks) using `--socket`

It's best to keep the proxy server, especially if you intend to host more than just a single Galaxy server on this system

---
# How to use it

- Install/configure uWSGI
- Configure Galaxy job handlers
- Run uWSGI
- Run job handlers

---
# uWSGI is installed

It was installed and configured for us by the Ansible playbook we ran earlier:

```console
$ dpkg --list | grep uwsgi
ii  uwsgi                              2.0.12-5ubuntu3                     amd64        fast, self-healing application container server
ii  uwsgi-core                         2.0.12-5ubuntu3                     amd64        fast, self-healing application container server (core)
ii  uwsgi-plugin-python                2.0.12-5ubuntu3                     amd64        WSGI plugin for uWSGI (Python 2)
```

As was the `uwsgidecorators` module, into the Galaxy virtualenv:

```console
$ ls -ld /srv/galaxy/venv/lib/python2.7/site-packages/uwsgidecorators*
drwxr-xr-x 2 galaxy galaxy  4096 Jun 27 09:19 /srv/galaxy/venv/lib/python2.7/site-packages/uwsgidecorators-1.1.0.dist-info
-rw-r--r-- 1 galaxy galaxy 10409 Jun 27 09:19 /srv/galaxy/venv/lib/python2.7/site-packages/uwsgidecorators.py
-rw-r--r-- 1 galaxy galaxy 19890 Jun 27 09:19 /srv/galaxy/venv/lib/python2.7/site-packages/uwsgidecorators.pyc
```

---
# uWSGI configuration

Files to check out:

- `/srv/galaxy/config/galaxy.ini` - `[uwsgi]` section
- `/srv/galaxy/config/job_conf.xml` - `<handlers>` section
- `/etc/supervisor/conf.d/galaxy.conf`

---
class: middle
# Supervisor detour

---
# What is supervisor?

A process manager written in Python

- `supervisord` daemon
  - Privileged or unprivileged
- `supervisorctl` command line interface
- INI config format
- Programs run in the **foreground**, supervisord daemonizes to run them in the background

---
class: smaller
# Supervisor - supervisorctl

```console
$ supervisorctl help

default commands (type help <topic>):
=====================================
add    clear  fg        open  quit    remove  restart   start   stop  update
avail  exit   maintail  pid   reload  reread  shutdown  status  tail  version

$ supervisorctl status
galaxy_main:handler0             RUNNING    pid 30554, uptime 7 days, 23:15:11
galaxy_main:handler1             RUNNING    pid 30555, uptime 7 days, 23:15:11
galaxy_main:handler2             RUNNING    pid 30556, uptime 7 days, 23:15:10
galaxy_main:impersonate          RUNNING    pid 30567, uptime 7 days, 23:15:08
galaxy_main:installer            RUNNING    pid 30574, uptime 7 days, 23:15:07
galaxy_main:reports              RUNNING    pid 30563, uptime 7 days, 23:15:09
galaxy_main_supervisord          RUNNING    pid 2108, uptime 8 days, 6:43:54
galaxy_main_uwsgi                RUNNING    pid 3568, uptime 8 days, 6:39:07
nginx                            RUNNING    pid 1917, uptime 8 days, 6:44:21
proftpd                          RUNNING    pid 1916, uptime 8 days, 6:44:21
```

---
# Supervisor - program

A config for running a Galaxy server under uWSGI has been installed at `/etc/supervisor/conf.d/galaxy.conf`

(take a look)

Config includes:

- Galaxy uWSGI process
- Two handlers (using `numprocs`)
- Program group

---
class: normal
# Supervisor - process control

Most useful subcommands:

- `start`, `stop`, `restart` - as you might imagine...
- `status` - show status of the managed process(es)
- `update` - reread configuration and restart any changed processes *and groups*
- `reread` - reread configuration but don't restart
- `pid` - return pid of the managed process
- `signal` - send signal to the managed process
- no subcommand - start an interactive session

Try some now...

---
class: middle
# uWSGI Zerg Mode

Get restarts without interruption or blocking

---
# uWSGI Zerg Mode - How it works

- Runs a special **Zerg Pool** process
- **Zergling**s (Galaxy application processes) connect to the zerg pool
- Connections are passed from zerg pool to zergling vy passing file descriptors over a UNIX domain socket
- As long as at least one is connected, requests are served (by any connected zergling)

---
class: normal
# uWSGI Zerg Mode - Galaxy config

Zerg Mode can be configured in a variety of ways. In our case:

- One zergling will start automatically when supervisor starts
- To restart Galaxy, a second zergling is started (via supervisor) by the admin
- Once it has fully loaded, it will signal the first zergling to terminate by writing to a FIFO
- The first terminates, and the second takes over serving requests

---
class: middle
- [uWSGI Zerg Mode - Exercise](https://github.com/galaxyproject/dagobah-training/blob/2017-montpellier/sessions/10-uwsgi/ex2-zerg-mode.md)
