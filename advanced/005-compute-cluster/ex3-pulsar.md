![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Running jobs on remote resources using Pulsar - Exercise

#### Authors: Nate Coraor. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1.

## Introduction


## Section 1 - Pulsar installation

**Part 1 - Create a Pulsar user**

Pulsar does not need to run as the same user as Galaxy, and in many cases it cannot, for example, if the same user does not exist on both the Galaxy server and the remote compute resource. We want to simulate such an environment, so we'll begin by creating a new user with `useradd`:

```console
$ sudo useradd -d /home/pulsar -m -r -s /bin/bash pulsar
```

**Part 2 - Create a new virtualenv**

Like Galaxy, Pulsar is a python application. It's best to install it into its own virtualenv for isolation of it and its dependencies from changes to the system python. A good location for it would be `/srv/pulsar`. Because `/srv` is owned by `root`, The `pulsar` user can't create its own directory there, so we need to create it first:

```console
$ sudo mkdir /srv/pulsar
$ sudo chown pulsar:pulsar /srv/pulsar
```

Now it should be possible to create a new virtualenv in that directory. Start by getting a shell as the `pulsar` user:

```console
galaxyguest$ sudo -H -u pulsar -s
pulsar$ virtualenv /srv/pulsar
Running virtualenv with interpreter /usr/bin/python2
New python executable in /srv/pulsar/bin/python2
Also creating executable in /srv/pulsar/bin/python
Installing setuptools, pkg_resources, pip, wheel...done.
$
```

You can see a familiar unix-like directory structure in `/srv/pulsar`:

```console
$ ls -l /srv/pulsar
total 20
drwxr-xr-x 2 pulsar pulsar 4096 Nov  6 10:45 bin
drwxr-xr-x 3 pulsar pulsar 4096 Nov  6 10:44 lib
drwxr-xr-x 2 pulsar pulsar 4096 Nov  6 10:44 local
-rw-r--r-- 1 pulsar pulsar   60 Nov  6 10:45 pip-selfcheck.json
drwxr-xr-x 3 pulsar pulsar 4096 Nov  6 10:44 share
```

It will be convenient to have the virtualenv's `bin/` directory on your `$PATH` now. You can do this with the shell source file `bin/activate`:

```console
$ . /srv/pulsar/bin/activate
(pulsar) $
```

**Part 3 - Install Pulsar**

We'll now use the freshly created virtualenv's `pip` to install Pulsar from PyPI:

```console
(pulsar) $ pip install pulsar-app
Collecting pulsar-app
  Downloading pulsar_app-0.7.3-py2-none-any.whl (161kB)
    100% |████████████████████████████████| 163kB 1.9MB/s
Collecting webob (from pulsar-app)
  Downloading WebOb-1.6.2-py2.py3-none-any.whl (78kB)
    100% |████████████████████████████████| 81kB 3.6MB/s
Collecting six (from pulsar-app)
  Downloading six-1.10.0-py2.py3-none-any.whl
Collecting pyyaml (from pulsar-app)
  Downloading PyYAML-3.12.tar.gz (253kB)
    100% |████████████████████████████████| 256kB 2.7MB/s
Collecting psutil (from pulsar-app)
  Downloading psutil-4.4.2.tar.gz (1.8MB)
    100% |████████████████████████████████| 1.8MB 526kB/s
Collecting paste (from pulsar-app)
  Downloading Paste-2.0.3-py2-none-any.whl (625kB)
    100% |████████████████████████████████| 634kB 1.4MB/s
Collecting PasteScript (from pulsar-app)
  Downloading PasteScript-2.0.2-py2.py3-none-any.whl (74kB)
    100% |████████████████████████████████| 81kB 2.2MB/s
Collecting galaxy-lib (from pulsar-app)
  Downloading galaxy_lib-16.10.10-py2.py3-none-any.whl (250kB)
    100% |████████████████████████████████| 256kB 2.1MB/s
Collecting PasteDeploy (from PasteScript->pulsar-app)
  Downloading PasteDeploy-1.5.2-py2.py3-none-any.whl
Collecting docutils (from galaxy-lib->pulsar-app)
  Downloading docutils-0.12.tar.gz (1.6MB)
    100% |████████████████████████████████| 1.6MB 233kB/s
Building wheels for collected packages: pyyaml, psutil, docutils
  Running setup.py bdist_wheel for pyyaml ... done
  Stored in directory: /home/pulsar/.cache/pip/wheels/2c/f7/79/13f3a12cd723892437c0cfbde1230ab4d82947ff7b3839a4fc
  Running setup.py bdist_wheel for psutil ... done
  Stored in directory: /home/pulsar/.cache/pip/wheels/2e/b3/7a/aa0a8b885996527302ecd2586f5d41a8530f3e925d4861affe
  Running setup.py bdist_wheel for docutils ... done
  Stored in directory: /home/pulsar/.cache/pip/wheels/db/de/bd/b99b1e12d321fbc950766c58894c6576b1a73ae3131b29a151
Successfully built pyyaml psutil docutils
Installing collected packages: webob, six, pyyaml, psutil, paste, PasteDeploy, PasteScript, docutils, galaxy-lib, pulsar-app
Successfully installed PasteDeploy-1.5.2 PasteScript-2.0.2 docutils-0.12 galaxy-lib-16.10.10 paste-2.0.3 psutil-4.4.2 pulsar-app-0.7.3 pyyaml-3.12 six-1.10.0 webob-1.6.2
```

If `psutil` fails to compile due to a missing header `Python.h`, that's because the `python-dev` package has not been installed yet. Do that with `sudo apt-get install python-dev` as the `galaxyguest` user and rerun the `pip install` above (as the `pulsar` user with the virtualenv activated).

We'll be using a few optional Pulsar features which have additional dependencies. Install these dependencies now with:

```console
(pulsar) $ pip install poster
Collecting poster
  Downloading poster-0.8.1.tar.gz
Building wheels for collected packages: poster
  Running setup.py bdist_wheel for poster ... done
  Stored in directory: /home/pulsar/.cache/pip/wheels/7f/50/85/e015e7056e73b6dac4653f1d27cee339c5adfa1b34c47bab9a
Successfully built poster
Installing collected packages: poster
Successfully installed poster-0.8.1
```

## Section 2 - Pulsar configuration

**Part 1 - Configuration setup**

Pulsar includes a handy command to create its config files called `pulsar-config`. By default it creates them in your current working directory. A reasonable place to put these is in `/srv/pulsar/etc`, which we need to create:

```console
(pulsar) $ mkdir /srv/pulsar/etc
(pulsar) $ cd /srv/pulsar/etc
```

`pulsar-config` has a number of handy options which you can see with `pulsar-config --help`. For our purposes, we want to do a few things:
- Create a supervisor config we can use to start and stop Pulsar with supervisor
- Configure Pulsar to run uWSGI as its web server rather than Paste
- Point Pulsar at slurm-drmaa so it can submit jobs through the cluster
- Configure Pulsar to only accept jobs from Pulsar clients that provide a known private token

```console
(pulsar) $ pulsar-config --supervisor --wsgi_server uwsgi --libdrmaa_path /usr/lib/slurm-drmaa/lib/libdrmaa.so.1 --private_token foo --install
Bootstrapping pulsar configuration into directory .
Collecting uwsgi
  Downloading uwsgi-2.0.14.tar.gz (788kB)
    100% |████████████████████████████████| 798kB 782kB/s
Collecting drmaa
  Downloading drmaa-0.7.6-py2.py3-none-any.whl
Collecting supervisor
  Downloading supervisor-3.3.1.tar.gz (415kB)
    100% |████████████████████████████████| 419kB 1.3MB/s
Collecting meld3>=0.6.5 (from supervisor)
  Downloading meld3-1.0.2-py2.py3-none-any.whl
Building wheels for collected packages: uwsgi, supervisor
  Running setup.py bdist_wheel for uwsgi ... done
  Stored in directory: /home/pulsar/.cache/pip/wheels/c4/ad/56/f70a70b63fa4b0f2c0518db6f41381c9d33cd5cc5ac9a9494b
  Running setup.py bdist_wheel for supervisor ... done
  Stored in directory: /home/pulsar/.cache/pip/wheels/13/ea/25/c236d39561d2be9c427655e5d48d0bd2b75dc8e7e8b51d029d
Successfully built uwsgi supervisor
Installing collected packages: uwsgi, drmaa, meld3, supervisor
Successfully installed drmaa-0.7.6 meld3-1.0.2 supervisor-3.3.1 uwsgi-2.0.14
 - app.yml created, update to configure Pulsar application.
 - server.ini created, update to configure web server.
   * Target web server uwsgi
   * Binding to host localhost, remote clients will not be able to connect.
   * Target web server uwsgi
 - local_env.sh created, update to configure environment.


Start pulsar by running the command from directory [.]:
    pulsar --mode uwsgi
Any extra commands passed to pulsar will be forwarded along to uwsgi.
$
```

Note that Pulsar has installed its own copy of uWSGI into the virtualenv. We could also configure it to use the apt-installed one in `/usr/bin/uwsgi`, but for simplicity's sake, we'll use the one Pulsar expects. It installs supervisor as well, but we'll ignore that - it's much easier to work with a single supervisor.

Investigate the config files created in `/srv/pulsar/etc`:

- `local_env.sh` - Sets environment variables for Pulsar to find the DRMAA library and Galaxy (for remote setting of job output metadata)
- `server.ini` - Configures web server options such as bind address and port, logging, etc.
- `app.yml` - Configures the Pulsar application including staging root directory and Pulsar managers

**Part 2 - Additional configuration**

You can see that `app.yml` is minimally configured. We want to add to this. The full suite of options available for app.yml is explained in [app.yml.sample in the Pulsar source](https://github.com/galaxyproject/pulsar/blob/master/app.yml.sample). I have made [a copy of app.yml.sample into the training materials with syntax highlighting](https://github.com/martenson/dagobah-training/blob/master/advanced/005-compute-cluster/app.sample.yml).

Add the following to `app.yml`:

```yaml
staging_directory: /srv/pulsar/var/jobs
persistence_directory: /srv/pulsar/var/active
tool_dependency_dir: /srv/pulsar/var/deps
dependency_resolvers_config_file: /srv/pulsar/etc/dependency_resolvers_conf.xml
```

We've referenced a number of new directories in `app.yml`, and a new config file, `dependency_resolvers_conf.xml`. For the former, we need to create the base directory with `mkdir /srv/pulsar/var`. The subdirectories will be created automatically. The latter config file needs to be created. Luckily, it's the same format as Galaxy's dependency resolver config. We want to instruct Pulsar to use Conda to resolve dependencies, and we want to automatically install Conda and any missing dependencies at runtime.

Create a new file `dependency_resolvers_conf.xml` in an editor and add the following contents:

```xml
<dependency_resolvers>
    <conda auto_install="True" auto_init="True" />
</dependency_resolvers>
```

Finally, uWSGI has been configured to listen with the uWSGI protocol. We want to listen with HTTP instead. Do this by opening `server.ini`, navigating to the `[uwsgi]` section, and replacing the line `socket = ...` with `http = localhost:8913`. In addition, add the `buffer-size` option to allow uWSGI to handle the large requests that the Pulsar client generates. It'd also be useful to configure Pulsar to log to a file rather than stdout/stderr (which is subsequently captured by supervisor). When finished, the `[uwsgi]` section should look like:

```ini
[uwsgi]
master = True
paste-logger = true
http = localhost:8913
processes = 1
enable-threads = True
buffer-size = 16384
logto = /srv/pulsar/var/uwsgi.log
```

**Part 3 - Configure Supervisor**

`pulsar-config` has created a supervisor config file for us. However, this config needs to be modified slightly so that Pulsar's virtualenv can be found. Do so by adding an `environment` setting to `supervisor.conf`, and prepending the full path to `pulsar` in the `command` setting. We also configure supervisor to stop uWSGI with a `SIGINT` rather than the default `SIGTERM`:

```ini
command         = /srv/pulsar/bin/pulsar --mode 'uwsgi' --config '/srv/pulsar/etc'
environment     = VIRTUAL_ENV="/srv/pulsar",PATH="/srv/pulsar/bin:%(ENV_PATH)s"
stopsignal      = INT
```

All we need to do is drop this in to `/etc/supervisor/conf.d`. As the `galaxyguest` user, you can:

```console
$ sudo cp /srv/pulsar/etc/supervisor.conf /etc/supervisor/conf.d/pulsar.conf
```

**Part 4 - Run Pulsar**

All that remains to be done is update supervisor so it reads the new config. This will automatically start Pulsar:

```console
$ sudo supervisorctl update
pulsar: added process group
```

Verify that Pulsar has started with Supervisor's log `tail` function:

```console
$ sudo supervisorctl tail pulsar
os: Linux-4.4.0-45-generic #66-Ubuntu SMP Wed Oct 19 14:12:37 UTC 2016
nodename: gat2016
machine: x86_64
clock source: unix
detected number of CPU cores: 2
current working directory: /srv/pulsar/etc
detected binary path: /srv/pulsar/bin/uwsgi
!!! no internal routing support, rebuild with pcre support !!!
your processes number limit is 2809
your memory page size is 4096 bytes
detected max file descriptor number: 1024
lock engine: pthread robust mutexes
thunder lock: disabled (you can enable it with --thunder-lock)
uWSGI http bound on localhost:8913 fd 4
uwsgi socket 0 bound to TCP address 127.0.0.1:37724 (port auto-assigned) fd 3
Python version: 2.7.12 (default, Jul  1 2016, 15:12:24)  [GCC 5.4.0 20160609]
Python main interpreter initialized at 0xf8a5d0
python threads support enabled
your server socket listen backlog is limited to 100 connections
your mercy for graceful operations on workers is 60 seconds
mapped 145520 bytes (142 KB) for 1 cores
*** Operational MODE: single process ***
Loading paste environment: config:/srv/pulsar/etc/server.ini
2016-11-06 12:00:53,230 INFO  [pulsar.core][MainThread] Securing Pulsar web app with private key, please verify you are using HTTPS so key cannot be obtained by monitoring traffic.
2016-11-06 12:00:53,231 INFO  [pulsar.core][MainThread] Starting the Pulsar without a toolbox to white-list.Ensure this application is protected by firewall or a configured private token.
2016-11-06 12:00:53,231 WARNI [galaxy.tools.deps][MainThread] Path '/srv/pulsar/var/deps' does not exist, ignoring
2016-11-06 12:00:53,232 WARNI [galaxy.tools.deps][MainThread] Path '/srv/pulsar/var/deps' is not directory, ignoring
PREFIX=/srv/pulsar/var/deps/_conda
installing: _cache-0.0-py27_x0 ...
installing: python-2.7.11-0 ...
installing: conda-env-2.4.5-py27_0 ...
installing: openssl-1.0.2g-0 ...
installing: pycosat-0.6.1-py27_0 ...
installing: pyyaml-3.11-py27_1 ...
installing: readline-6.2-2 ...
installing: requests-2.9.1-py27_0 ...
installing: sqlite-3.9.2-0 ...
installing: tk-8.5.18-0 ...
installing: yaml-0.1.6-0 ...
installing: zlib-1.2.8-0 ...
installing: conda-4.0.5-py27_0 ...
installing: pycrypto-2.6.1-py27_0 ...
installing: pip-8.1.1-py27_1 ...
installing: wheel-0.29.0-py27_0 ...
installing: setuptools-20.3-py27_0 ...
Python 2.7.11 :: Continuum Analytics, Inc.
creating default environment...
installation finished.
Fetching package metadata: ....
Solving package specifications: .........

Package plan for installation in environment /srv/pulsar/var/deps/_conda:

The following packages will be downloaded:

    package                    |            build
    ---------------------------|-----------------
    sqlite-3.13.0              |                0         4.0 MB
    python-2.7.12              |                1        12.1 MB
    conda-3.19.3               |           py27_0         178 KB
    ------------------------------------------------------------
                                           Total:        16.2 MB

The following packages will be UPDATED:

    python: 2.7.11-0     --> 2.7.12-1
    sqlite: 3.9.2-0      --> 3.13.0-0

The following packages will be DOWNGRADED:

    conda:  4.0.5-py27_0 --> 3.19.3-py27_0

2016-11-06 12:01:30,352 INFO  [pulsar.locks][MainThread] pylockfile module not found, skipping experimental lockfile handling.
2016-11-06 12:01:30,359 DEBUG [pulsar.managers.util.drmaa][MainThread] Initializing DRMAA session from thread MainThread
WSGI app 0 (mountpoint='') ready in 0 seconds on interpreter 0x1558b90 pid: 15112 (default app)
*** uWSGI is running in multiple interpreter mode ***
spawned uWSGI master process (pid: 15112)
spawned uWSGI worker 1 (pid: 15115, cores: 1)
spawned uWSGI http 1 (pid: 15116)

```

Now, have a look in `/srv/pulsar/var`. All of the directories defined in `app.yml` have been created. What's more, a conda install has automatically been initialized for us:

```console
$ ls -l /srv/pulsar/var
total 12
drwxr-xr-x 3 pulsar pulsar 4096 Nov  6 12:01 active
drwxr-xr-x 3 pulsar pulsar 4096 Nov  6 12:01 deps
drwxr-xr-x 2 pulsar pulsar 4096 Nov  6 12:01 jobs
$ ls -l /srv/pulsar/var/deps/_conda
total 36
drwxr-xr-x  2 pulsar pulsar 4096 Nov  6 12:01 bin
drwxr-xr-x  2 pulsar pulsar 4096 Nov  6 12:01 conda-meta
drwxr-xr-x  2 pulsar pulsar 4096 Nov  6 12:01 envs
drwxr-xr-x  5 pulsar pulsar 4096 Nov  6 12:01 include
drwxr-xr-x  8 pulsar pulsar 4096 Nov  6 12:01 lib
-rw-r--r--  1 pulsar pulsar 3699 Feb  4  2016 LICENSE.txt
drwxr-xr-x 22 pulsar pulsar 4096 Nov  6 12:01 pkgs
drwxr-xr-x  4 pulsar pulsar 4096 Nov  6 12:01 share
drwxr-xr-x  3 pulsar pulsar 4096 Nov  6 12:01 ssl
```

## Section 3 - Connect Galaxy to Pulsar

**Part 1 - Galaxy job configuration**

As with all other aspects of running Galaxy jobs, we configure Galaxy's side in `job_conf.xml`. As the `galaxy` user (or `sudo -u galaxy` as `galaxyguest`) open `/srv/galaxy/server/job_conf.xml` in an editor. First, add a new job runner plugin for the RESTful Pulsar:

```xml
        <plugin id="pulsar_rest" type="runner" load="galaxy.jobs.runners.pulsar:PulsarRESTJobRunner" />
```

Then add a new destination:

```xml
        <destination id="pulsar" runner="pulsar_rest">
            <param id="url">http://localhost:8913/</param>
            <param id="private_token">foo</param>
            <param id="default_file_action">remote_transfer</param>
            <param id="jobs_directory">/srv/pulsar/var/jobs</param>
        </destination>
```

Note that we've configured Pulsar to use the `remote_transfer`, aka **pull** staging method. I have found this method to be more robust, since it more gracefully recovers from restarting the Galaxy server while transfers are occurring. It also supports resuming transfers when Pulsar is configured to use libcurl.

Finally, we need to map a tool to the Pulsar destination. Do so by commenting out the previous `<tool ...>` mapping for the `multi` tool and adding a new static mapping to our new destination:

```xml
        <tool id="multi" destination="pulsar"/>
```

Now, restart your Galaxy server:

```console
$ sudo supervisorctl restart gx:*
Gx:handler0: stopped
gx:handler1: stopped
gx:galaxy: stopped
gx:galaxy: started
gx:handler0: started
gx:handler1: started
```

**Part 2 - Verify**

We can test that the connection is working by running our favorite Multicore Tool. The input to the tool does not matter in this case. Simply run the tool on any input while watching the Galaxy job handler logs (`tail -f /srv/galaxy/server/handler?.log`):

```
galaxy.jobs DEBUG 2016-11-06 12:38:14,985 (29) Working directory for job is: /srv/galaxy/server/database/jobs/000/29
galaxy.jobs.handler DEBUG 2016-11-06 12:38:14,989 (29) Dispatching to pulsar_rest runner
galaxy.jobs DEBUG 2016-11-06 12:38:15,057 (29) Persisting job destination (destination id: pulsar)
galaxy.jobs.runners DEBUG 2016-11-06 12:38:15,071 Job [29] queued (81.299 ms)
galaxy.jobs.handler INFO 2016-11-06 12:38:15,085 (29) Job dispatched
galaxy.jobs.runners.pulsar INFO 2016-11-06 12:38:15,129 pulsar_version is 0.7.0.dev5
galaxy.jobs.runners.pulsar INFO 2016-11-06 12:38:15,489 Pulsar job submitted with job_id 29
galaxy.jobs DEBUG 2016-11-06 12:38:15,489 (29) Persisting job destination (destination id: pulsar)
pulsar.client.staging.down INFO 2016-11-06 12:38:17,679 collecting output None with action FileAction[url=http://localhost/api/jobs/4ff6f47412c3e65e/files?job_key=6d214a3ad32abe80&path=/srv/galaxy/server/database/datasets/000/dataset_29.dat&file_type=outputpath=/srv/galaxy/server/database/datasets/000/dataset_29.dataction_type=remote_transfer]
pulsar.client.staging.down DEBUG 2016-11-06 12:38:17,680 Cleaning up job (failed [False], cleanup_job [always])
  ... local set_meta stuff ...
galaxy.model.metadata DEBUG 2016-11-06 12:38:22,738 loading metadata from file for: HistoryDatasetAssociation 29
galaxy.jobs INFO 2016-11-06 12:38:22,882 Collecting metrics for Job 29
galaxy.jobs DEBUG 2016-11-06 12:38:22,892 job 29 ended (finish() executed in (289.931 ms))
galaxy.model.metadata DEBUG 2016-11-06 12:38:22,895 Cleaning up external metadata files
```

## Section 4 - Run a tool with dependencies

**Part 1 - Create a tool with dependencies**

We'll update our trusty Multicore tool to have a simple conda dependency on `zlib` 1.2.8. Do this by opening up `/srv/galaxy/server/tools/multi.xml` as the `galaxy` user, and adding the following new set of tags to the tool:

```xml
    <requirements>
        <requirement type="package" version="1.2.8">zlib</requirement>
    </requirements>
```

Restart Galaxy with `sudo supervisorctl restart gx:*` to read the updated tool config. Then, follow the Pulsar log with `tail -f /srv/pulsar/var/uwsgi.log`:

```
```

Conda has installed `zlib` for us and set it up as a dependency for the job.

## So, what did we learn?

Hopefully, you now understand:
- 

## Further Reading

- 
