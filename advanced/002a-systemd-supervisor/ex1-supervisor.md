![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Managing Multiprocess Galaxy with Supervisor - Exercise.

#### Authors: Nate Coraor. 2016

## Introduction

A multiprocess Galaxy server is essential for scalability. However, it can also be unwieldy to manage. Supervisor is a process manager that makes the management task simple.

## Section 1 - Installation and basic configuration

You have already done this using Ansible during that session. Ansible did the following:

1. Install the `supervisor` package from apt
2. Create a config to start Galaxy using uWSGI, located at `/etc/supervisor/conf.d/galaxy.conf`

Moving right along...

## Section 2 - Add handlers and a group

We have defined two handlers in `/srv/galaxy/config/job_conf.xml` (also installed in the Ansible session):

```xml
    <handlers default="handlers">
        <handler id="handler0" tags="handlers"/>
        <handler id="handler1" tags="handlers"/>
    </handlers>
```

**Part 1 - Define a handler**

We need to add a `[program:x]` section to manage these handlers. Because we have cleverly named our handlers as a string followed by an incrementing integer (beginning with 0) we only need one `[program:x]` and we use the `numprocs` feature to spawn multiple. This is added to the bottom of `/etc/supervisor/conf.d/galaxy.conf`:

```ini
[program:handler]
command         = python ./scripts/galaxy-main -c /srv/galaxy/server/galaxy.ini --server-name=handler%(process_num)s
directory       = /srv/galaxy/server
process_name    = handler%(process_num)s
numprocs        = 2
umask           = 022
autostart       = true
autorestart     = true
startsecs       = 10
user            = galaxy
environment     = VIRTUAL_ENV="/srv/galaxy/server/.venv",PATH="/srv/galaxy/server/.venv/bin:%(ENV_PATH)s"
stdout_logfile  = /srv/galaxy/server/handler%(process_num)s.log
redirect_stderr = true
```

The magic is in these two lines, which cause supervisor to create two instances of the program and set their program names accordingly:

```ini
process_name    = handler%(process_num)s
numprocs        = 2
```

Notify supervisor of the changes with `supervisorctl update`:

```console
$ sudo supervisorctl update
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

Now you can control all 3 processes with `sudo supervisorctl <op> all` or `sudo supervisorctl <op> gx:*`.

In addition, you can *gracefully* restart the uWSGI Galaxy process with `sudo supervisorctl signal HUP gx:galaxy`. uWSGI is configured to start Galaxy in a "master" process and then fork the configured number of worker processes. Because of this, if sent a `SIGHUP` signal, it will kill the workers but the master process will hold its socket open, blocking client (browser) connections until new workers are forked. This prevents users from seeing a proxy error page during restarts. Using this, you can restart both the uWSGI server and Galaxy handlers with:

```console
$ sudo supervisorctl signal HUP gx:galaxy && sudo supervisorctl restart gx:handler0 gx:handler1
```

## Having trouble?

- Logs in `/var/log/supervisor`
- Program stdout accessible directly at `supervisorctl tail <program>`

## Further reading

- [Supervisor docs](http://supervisord.org/)
