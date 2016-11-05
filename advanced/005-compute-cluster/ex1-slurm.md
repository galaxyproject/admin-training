![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Running Galaxy Jobs with Slurm - Example

#### Authors: Nate Coraor. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Be familiar with the basics of installing, configuring, and using Slurm
2. Understand all components of the Galaxy job running stack
3. Understand how the `job_conf.xml` file controls Galaxy's jobs subsystem

## Introduction

## Section 1 - Install and configure Slurm

**Part 1 - Install Slurm**

Install Slurm from apt:

```console
$ sudo apt-get install slurm-wlm
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  ...
Suggested packages:
  ...
The following NEW packages will be installed:
  ...
0 upgraded, 56 newly installed, 0 to remove and 31 not upgraded.
Need to get 28.4 MB of archives.
After this operation, 119 MB of additional disk space will be used.
Do you want to continue? [Y/n] 
Get:1 http://archive.ubuntu.com/ubuntu xenial/main amd64 libxau6 amd64 1:1.0.8-1 [8376 B]
  ...
Get:56 http://archive.ubuntu.com/ubuntu xenial/universe amd64 slurm-wlm amd64 15.08.7-1build1 [6482 B]
Fetched 28.4 MB in 3s (9030 kB/s)     
Selecting previously unselected package libxau6:amd64.
(Reading database ... 16043 files and directories currently installed.)
Preparing to unpack .../libxau6_1%3a1.0.8-1_amd64.deb ...
Unpacking libxau6:amd64 (1:1.0.8-1) ...
  ...
Setting up munge (0.5.11-3) ...
Generating a pseudo-random key using /dev/urandom completed.
Please refer to /usr/share/doc/munge/README.Debian for instructions to generate more secure key.
Job for munge.service failed because the control process exited with error code. See "systemctl status munge.service" and "journalctl -xe" for details.
invoke-rc.d: initscript munge, action "start" failed.
dpkg: error processing package munge (--configure):
 subprocess installed post-installation script returned error exit status 1
  ...
dpkg: error processing package slurm-wlm (--configure):
 dependency problems - leaving unconfigured
Processing triggers for libc-bin (2.23-0ubuntu3) ...
Processing triggers for systemd (229-4ubuntu7) ...
Processing triggers for ureadahead (0.100.0-19) ...
Errors were encountered while processing:
 munge
 slurm-client
 slurmd
 slurmctld
 slurm-wlm
E: Sub-process /usr/bin/dpkg returned an error code (1)
$
```

Installed with Slurm is MUNGE (MUNGE Uid 'N Gid Emporium...) which authenticates users between cluster hosts. You would normally need to ensure the same Munge key is distributed across all cluster hosts (in `/etc/munge/munge.key`) - A great task for Ansible. However, the installation of the munge package has created a random key for you, and you will not need to distribute this since you'll run jobs locally.

However, MUNGE installs in Ubuntu in a broken state(!): It does not like that `/var/log` is group writable. This can be seen by the failed `apt-get install` output, and some digging:

```console
$ systemctl status munge
● munge.service - MUNGE authentication service
   Loaded: loaded (/lib/systemd/system/munge.service; enabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Fri 2016-11-04 15:46:03 EDT; 1min 27s ago
     Docs: man:munged(8)

Nov 04 15:46:03 gat2016 systemd[1]: Starting MUNGE authentication service...
Nov 04 15:46:03 gat2016 systemd[1]: munge.service: Control process exited, code=exited status=1
Nov 04 15:46:03 gat2016 systemd[1]: Failed to start MUNGE authentication service.
Nov 04 15:46:03 gat2016 systemd[1]: munge.service: Unit entered failed state.
Nov 04 15:46:03 gat2016 systemd[1]: munge.service: Failed with result 'exit-code'.
$ journalctl | grep munged
Nov 04 15:46:03 gat2016 munged[4430]: munged: Error: Logfile is insecure: group-writable permissions set on "/var/log"
$
```

You can fix this by instructing MUNGE to log to syslog instead of writing its log files to `/var/log/munge/` directly. To do this, modify its systemd service definition using `sudo systemctl edit --full munge`. Modify the `ExecStart` option and append ` --syslog` so that the entire file appears as:

``ini
[Unit]
Description=MUNGE authentication service
Documentation=man:munged(8)
After=network.target
After=time-sync.target

[Service]
Type=forking
ExecStart=/usr/sbin/munged --syslog
PIDFile=/var/run/munge/munged.pid
User=munge
Group=munge
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

You can then complete the installation by running `sudo apt-get install` without any package arguments:

```console
$ sudo apt-get install
Reading package lists... Done
Building dependency tree
Reading state information... Done
0 upgraded, 0 newly installed, 0 to remove and 91 not upgraded.
5 not fully installed or removed.
After this operation, 0 B of additional disk space will be used.
Setting up munge (0.5.11-3) ...
Setting up slurm-client (15.08.7-1build1) ...
Setting up slurmd (15.08.7-1build1) ...
update-alternatives: using /usr/sbin/slurmd-wlm to provide /usr/sbin/slurmd (slurmd) in auto mode
Setting up slurmctld (15.08.7-1build1) ...
update-alternatives: using /usr/sbin/slurmctld-wlm to provide /usr/sbin/slurmctld (slurmctld) in auto mode
Setting up slurm-wlm (15.08.7-1build1) ...
Processing triggers for systemd (229-4ubuntu7) ...
Processing triggers for ureadahead (0.100.0-19) ...
```

Verify that MUNGE is now running with `systemctl status munge`:

```console
$ systemctl status munge
● munge.service - MUNGE authentication service
   Loaded: loaded (/etc/systemd/system/munge.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2016-11-04 16:05:29 EDT; 4min 55s ago
     Docs: man:munged(8)
 Main PID: 4805 (munged)
   CGroup: /system.slice/munge.service
           └─4805 /usr/sbin/munged --syslog

Nov 04 16:05:29 gat2016 munged[4805]: Found 2 users with supplementary groups in 0.000 seconds
Nov 04 16:05:29 gat2016 systemd[1]: Started MUNGE authentication service.
Nov 04 16:05:30 gat2016 munged[4805]: Stirring PRNG entropy pool
$
```

You can also see that Slurm's controller and execution daemon processes are configured to start automatically, and that they attempted to start, but failed:

```console
$ systemctl status slurmctld
● slurmctld.service - Slurm controller daemon
   Loaded: loaded (/lib/systemd/system/slurmctld.service; enabled; vendor preset: enabled)
   Active: inactive (dead)
Condition: start condition failed at Fri 2016-11-04 16:05:30 EDT; 39s ago
$ systemctl status slurmd
● slurmd.service - Slurm node daemon
   Loaded: loaded (/lib/systemd/system/slurmd.service; enabled; vendor preset: enabled)
   Active: inactive (dead)
Condition: start condition failed at Fri 2016-11-04 16:05:29 EDT; 43s ago
```

The start condition that failed was the missing slurm config file.

**Part 2 - Configure Slurm**

Under Ubuntu, Slurm configs are stored in `/etc/slurm-llnl`<sup>[1]</sup>. No config is created by default.

Slurm provides a tool to create a configuration file. This is [available online](https://slurm.schedmd.com/configurator.html) for the latest version, but Ubuntu 16.04 ships with Slurm 15.08. There's a copy of the configurator in `/usr/share/doc/slurmctld/slurm-wlm-configurator.html`. I've copied that to the training repository:

[Slurm Version 15.08 Configuration Tool](https://martenson.github.io/dagobah-training/005-compute-cluster/slurm-wlm-configurator.html)

Enter the following values into the configuration tool (leaving others at their defaults):
- ControlMachine: `localhost`
- NodeName: `localhost`

Then click **Submit** at the bottom of the form. You should now see the contents of a `slurm.conf` which you can copy and paste into `/etc/slurm-llnl/slurm.conf`.

**Part 3 - Start Slurm daemons**

It should now be possible to start Slurm's daemons. Begin by starting `slurmctld`, The Slurm controller daemon (only one host runs the controller, this orchestrates job scheduling, dispatching, and completion):

```console
$ sudo systemctl start slurmctld
$ systemctl status slurmctld
● slurmctld.service - Slurm controller daemon
   Loaded: loaded (/lib/systemd/system/slurmctld.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2016-11-04 16:46:08 EDT; 4s ago
  Process: 5134 ExecStart=/usr/sbin/slurmctld $SLURMCTLD_OPTIONS (code=exited, status=0/SUCCESS)
 Main PID: 5138 (slurmctld)
    Tasks: 10
   Memory: 884.0K
      CPU: 11ms
   CGroup: /system.slice/slurmctld.service
           └─5138 /usr/sbin/slurmctld

Nov 04 16:46:08 gat2016 systemd[1]: Starting Slurm controller daemon...
Nov 04 16:46:08 gat2016 systemd[1]: Started Slurm controller daemon.
```

Next, start up `slurmd`, the Slurm execution daemon. Every host that will execute jobs runs slurmd, which manages the processes that the slurm controller dispatches to it:

```console
$ sudo systemctl start slurmd
$ systemctl status slurmd
● slurmd.service - Slurm node daemon
   Loaded: loaded (/lib/systemd/system/slurmd.service; enabled; vendor preset: enabled)
   Active: active (running) since Fri 2016-11-04 16:50:35 EDT; 2s ago
  Process: 5169 ExecStart=/usr/sbin/slurmd $SLURMD_OPTIONS (code=exited, status=0/SUCCESS)
 Main PID: 5173 (slurmd)
    Tasks: 1
   Memory: 2.0M
      CPU: 10ms
   CGroup: /system.slice/slurmd.service
           └─5173 /usr/sbin/slurmd

Nov 04 16:50:35 gat2016 systemd[1]: Starting Slurm node daemon...
Nov 04 16:50:35 gat2016 systemd[1]: slurmd.service: PID file /var/run/slurm-llnl/slurmd.pid not readable (yet?) after start: No such
Nov 04 16:50:35 gat2016 systemd[1]: Started Slurm node daemon.
```

You should now be able to see that your slurm cluster is operational with the `sinfo` command. This shows the state of nodes and partitions (synonymous with queues in other DRMs). The "node-oriented view" provided with the `-N` flag is particularly useful:

```console
$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
debug*       up   infinite      1   idle localhost
$ sinfo -Nel
Fri Nov  4 16:51:24 2016
NODELIST   NODES PARTITION       STATE CPUS    S:C:T MEMORY TMP_DISK WEIGHT FEATURES REASON
localhost      1    debug*        idle    1    1:1:1      1        0      1   (null) none
```

If your node state is not `idle`, something has gone wrong. If your node state ends with an asterisk `*`, the slurm controller is attempting to contact the slurm execution daemon but has not yet been successful.

## Section 2 - Get Slurm ready for Galaxy

**Part 1 - Test Slurm**

We want to ensure that Slurm is actually able to run jobs. There are two ways this can be done:o

- `srun`: Run an interactive job (e.g. a shell, or a specific program with its stdin, stdout, and stderr all connected to your terminal.
- `sbatch`: Run a batch job, with stdin closed and stdout/stderr redirected to a file.

Galaxy runs `sbatch` jobs but we can use both `srun` and `sbatch` to test:

```console
$ srun uname -a
Linux gat2016 4.4.0-31-generic #50-Ubuntu SMP Wed Jul 13 00:07:12 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
```

Although it looks like this command ran as if I had not used `srun`, it was in fact routed through Slurm.

Next, createa a test job script somewhere, such as in `~/sbatch-test.sh`. This should be a shell script and must include the shell "shebang" line:

```bash
#!/bin/sh

uname -a
uptime
cat /etc/issue
sleep 30
```

Submit it with `sbatch` and monitor it with `squeue`:

```console
$ sbatch sbatch-test.sh
Submitted batch job 3
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                 3     debug sbatch-t galaxygu  R       0:03      1 localhost
$ cat slurm-4.out
Linux gat2016 4.4.0-31-generic #50-Ubuntu SMP Wed Jul 13 00:07:12 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
 17:09:18 up  1:28,  2 users,  load average: 0.00, 0.00, 0.00
Ubuntu 16.04.1 LTS \n \l

$
```

If you've made it this far, your Slurm installation is working!

**Part 2 - Install slurm-drmaa**

Above Slurm in the stack sits slurm-drmaa, a library that provides a translational interface from the Slurm API to the generalized DRMAA API in C. Thankfully, Ubuntu has a package for it as well:

```console
$ sudo apt-get install slurm-drmaa1
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  libslurm29
The following NEW packages will be installed:
  libslurm29 slurm-drmaa1
0 upgraded, 2 newly installed, 0 to remove and 91 not upgraded.
Need to get 574 kB of archives.
After this operation, 1,676 kB of additional disk space will be used.
Do you want to continue? [Y/n]
Get:1 http://us.archive.ubuntu.com/ubuntu xenial/universe amd64 libslurm29 amd64 15.08.7-1build1 [522 kB]
Get:2 http://us.archive.ubuntu.com/ubuntu xenial/universe amd64 slurm-drmaa1 amd64 1.0.7-1build3 [52.3 kB]
Fetched 574 kB in 0s (1,102 kB/s)
Selecting previously unselected package libslurm29.
(Reading database ... 60829 files and directories currently installed.)
Preparing to unpack .../libslurm29_15.08.7-1build1_amd64.deb ...
Unpacking libslurm29 (15.08.7-1build1) ...
Selecting previously unselected package slurm-drmaa1.
Preparing to unpack .../slurm-drmaa1_1.0.7-1build3_amd64.deb ...
Unpacking slurm-drmaa1 (1.0.7-1build3) ...
Processing triggers for libc-bin (2.23-0ubuntu3) ...
Setting up libslurm29 (15.08.7-1build1) ...
Setting up slurm-drmaa1 (1.0.7-1build3) ...
Processing triggers for libc-bin (2.23-0ubuntu3) ...
$
```

## Section 3 - Run Galaxy jobs through Slurm

**Part 1 - Install DRMAA Python**

Moving one level further up the stack, we find DRMAA Python. This is a Galaxy framework *conditional dependency*. Conditional dependencies are only installed if, during startup, a configuration option is set that requires that dependency. Galaxy will automatically install it into the virtualenv if we're using the `run.sh` (which calls `scripts/common_startup.sh`) method of starting. Since our Galaxy now starts the application directly with uWSGI or the "headless" `galaxy-main`, we need to install it into Galaxy's virtualenv directly.

The `galaxyprojectdotorg.galaxy` Ansible role *does* install conditional dependencies. An alternative option would be to modify `job_conf.xml` as described in the next part and then rerun the Ansible playbook from the second exercise in the Ansible section.

Assuming we will install DRMAA Python ourselves, we must:

1. Become the `galaxy` user.
2. Run `pip` from Galaxy's virtualenv in `/srv/galaxy/server/.venv`
3. Install the `drmaa` package from PyPI.

We can do this with a single command: `sudo -H -u galaxy /srv/galaxy/server/.venv/bin/pip install drmaa`:

```console
$ sudo -H -u galaxy /srv/galaxy/server/.venv/bin/pip install drmaa
Collecting drmaa
  Downloading drmaa-0.7.6-py2.py3-none-any.whl
Installing collected packages: drmaa
Successfully installed drmaa-0.7.6
You are using pip version 8.1.2, however version 9.0.0 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
$
```

**Part 2 - Configure Galaxy**

At the top of the stack sits Galaxy. Galaxy must now be configured to use the cluster we've just set up. The DRMAA Python documentation (and Galaxy's own documentation) instruct that you should set the `$DRMAA_LIBRARY_PATH` environment variable so that DRMAA Python can find `libdrmaa.so` (aka slurm-drmaa). Because Galaxy is now being started under supervisor, the environment that Galaxy starts under is controlled by the `environment` option in `/etc/supervisor/conf.d/galaxy.conf`. The `[program:handler]` should thus be updated to refer to the path to slurm-drmaa, which is `/usr/lib/slurm-drmaa/lib/libdrmaa.so.1`:

```ini
environment     = VIRTUAL_ENV="/srv/galaxy/server/.venv",PATH="/srv/galaxy/server/.venv/bin:%(ENV_PATH)s",DRMAA_LIBRARY_PATH="/usr/lib/slurm-drmaa/lib/libdrmaa.so.1"
```

This change is not read until `supervisord` is notified with `sudo supervisorctl update`, but we'll wait to do that until after we've updated Galaxy's job configuration.

We need to modify `job_conf.xml` to instruct Galaxy's job handlers to load the Slurm job runner plugin, and set the Slurm job submission parameters. This file was installed by Ansible and can be found in `/srv/galaxy/server` (remember, it's owned by the `galaxy` user so you'll need to use `sudo` to edit it). A job runner plugin definition must have the `id`, `type`, and `load` attributes. The entire `<plugins>` tag group should look like:

```xml
    <plugins workers="4">
        <plugin id="local" type="runner" load="galaxy.jobs.runners.local:LocalJobRunner"/>
        <plugin id="slurm" type="runner" load="galaxy.jobs.runners.slurm:SlurmJobRunner"/>
    </plugins>
```

Next, we need to add a new destination for the Slurm job runner. This is a basic destination with no parameters, Galaxy will do the equivalent of submitting a job as `sbatch /path/to/job_script.sh`. Note that we also need to set a default destination now that more than one destination is defined. In a `<destination>` tag, the `id` attribute is a unique identifier for that destination and the `runner` attribute must match the `id` of defined plugin:

```xml
    <destinations default="slurm">
        <destination id="slurm" runner="slurm"/>
        <destination id="local" runner="local"/>
    </destinations>
```

To reread the job config, Galaxy must be restarted. You can do this with `sudo supervisorctl restart all`. Technically these changes only require restarting the handlers (if we were changing a tool-to-handler mapping it'd require restarting the web server as well) so `sudo supervisorctl restart gx:handler0 gx:handler1` would suffice.

Before you restart, you can follow the handler log files using `tail`: `tail -f /srv/galaxy/server/handler?.log`.

```xml
$ sudo supervisorctl restart all
gx:handler0: stopped
gx:handler1: stopped
gx:galaxy: stopped
gx:handler0: started
gx:handler1: started
gx:galaxy: started
```

Two sections of the log output are of interest. First, when Galaxy parses `job_conf.xml`:

```
galaxy.jobs DEBUG 2016-11-05 14:07:12,649 Loading job configuration from /srv/galaxy/server/job_conf.xml
galaxy.jobs DEBUG 2016-11-05 14:07:12,650 Read definition for handler 'handler0'
galaxy.jobs DEBUG 2016-11-05 14:07:12,651 Read definition for handler 'handler1'
galaxy.jobs DEBUG 2016-11-05 14:07:12,652 <handlers> default set to child with id or tag 'handlers'
galaxy.jobs DEBUG 2016-11-05 14:07:12,652 <destinations> default set to child with id or tag 'slurm'
galaxy.jobs DEBUG 2016-11-05 14:07:12,653 Done loading job configuration
```

Second, when Galaxy loads job runner plugins:

```
galaxy.jobs.manager DEBUG 2016-11-05 14:07:22,341 Starting job handler
galaxy.jobs INFO 2016-11-05 14:07:22,347 Handler 'handler0' will load all configured runner plugins
galaxy.jobs.runners DEBUG 2016-11-05 14:07:22,355 Starting 4 LocalRunner workers
galaxy.jobs DEBUG 2016-11-05 14:07:22,367 Loaded job runner 'galaxy.jobs.runners.local:LocalJobRunner' as 'local'
pulsar.managers.util.drmaa DEBUG 2016-11-05 14:07:22,434 Initializing DRMAA session from thread MainThread
galaxy.jobs.runners DEBUG 2016-11-05 14:07:22,443 Starting 4 SlurmRunner workers
galaxy.jobs DEBUG 2016-11-05 14:07:22,455 Loaded job runner 'galaxy.jobs.runners.slurm:SlurmJobRunner' as 'slurm'
galaxy.jobs.handler DEBUG 2016-11-05 14:07:22,455 Loaded job runners plugins: slurm:local
```

**Part 2 - Go!**

You should now be able to run a Galaxy job through Slurm. The simplest way to test is using the upload tool to upload some text. If you're not still following the log files with `tail`, do so now.

Then, upload to Galaxy to create a new job:

1. Click the upload button at the top of the tool panel (on the left side of the Galaxy UI).
2. In the resulting modal dialog, click the "Paste/Fetch data" button.
3. Type some random characters into the text field that has just appeared.
4. Click "Start" and then "Close"

In your `tail` terminal window you should see the following messages:

```
galaxy.jobs DEBUG 2016-11-05 14:07:22,862 (2) Persisting job destination (destination id: slurm)
galaxy.jobs.runners DEBUG 2016-11-05 14:07:22,958 Job [2] queued (328.180 ms)
galaxy.jobs.handler INFO 2016-11-05 14:07:22,996 (2) Job dispatched
galaxy.tools.deps DEBUG 2016-11-05 14:07:23,621 Building dependency shell command for dependency 'samtools'
  ...
galaxy.tools.deps WARNING 2016-11-05 14:07:23,631 Failed to resolve dependency on 'samtools', ignoring
galaxy.jobs.command_factory INFO 2016-11-05 14:07:23,674 Built script [/srv/galaxy/server/database/jobs/000/2/tool_script.sh] for tool command[python /srv/galaxy/server/tools/data_source/upload.py /srv/galaxy/server /srv/galaxy/server/database/tmp/tmpkiMZKd /srv/galaxy/server/database/tmp/tmpJuSMo5 2:/srv/galaxy/server/database/jobs/000/2/dataset_2_files:/srv/galaxy/server/database/datasets/000/dataset_2.dat]
galaxy.tools.deps DEBUG 2016-11-05 14:07:24,033 Building dependency shell command for dependency 'samtools'
  ...
galaxy.tools.deps WARNING 2016-11-05 14:07:24,038 Failed to resolve dependency on 'samtools', ignoring
galaxy.jobs.runners DEBUG 2016-11-05 14:07:24,052 (2) command is: mkdir -p working; cd working; /srv/galaxy/server/database/jobs/000/2/tool_script.sh; return_code=$?; cd '/srv/galaxy/server/database/jobs/000/2'; python "/srv/galaxy/server/database/jobs/000/2/set_metadata_CALKH0.py" "/srv/galaxy/server/database/tmp/tmpkiMZKd" "/srv/galaxy/server/database/jobs/000/2/working/galaxy.json" "/srv/galaxy/server/database/jobs/000/2/metadata_in_HistoryDatasetAssociation_2_nnti4M,/srv/galaxy/server/database/jobs/000/2/metadata_kwds_HistoryDatasetAssociation_2_sN3gVP,/srv/galaxy/server/database/jobs/000/2/metadata_out_HistoryDatasetAssociation_2_jIhXJJ,/srv/galaxy/server/database/jobs/000/2/metadata_results_HistoryDatasetAssociation_2_v4v_dv,/srv/galaxy/server/database/datasets/000/dataset_2.dat,/srv/galaxy/server/database/jobs/000/2/metadata_override_HistoryDatasetAssociation_2_OQwwTH" 5242880; sh -c "exit $return_code"
galaxy.jobs.runners.drmaa DEBUG 2016-11-05 14:07:24,125 (2) submitting file /srv/galaxy/server/database/jobs/000/2/galaxy_2.sh
galaxy.jobs.runners.drmaa INFO 2016-11-05 14:07:24,172 (2) queued as 7
galaxy.jobs DEBUG 2016-11-05 14:07:24,172 (2) Persisting job destination (destination id: slurm)
galaxy.jobs.runners.drmaa DEBUG 2016-11-05 14:07:24,539 (2/7) state change: job is queued and active
```

At this point the job has been accepted by Slurm and is awaiting scheduling on a node. Once it's been sent to a node and starts running, Galaxy logs this event:

```
galaxy.jobs.runners.drmaa DEBUG 2016-11-05 14:07:25,559 (2/7) state change: job is running
```

Finally, when the job is complete, Galaxy performs its job finalization process:

```
galaxy.jobs.runners.drmaa DEBUG 2016-11-05 14:07:30,883 (2/7) state change: job finished normally
galaxy.model.metadata DEBUG 2016-11-05 14:07:31,132 loading metadata from file for: HistoryDatasetAssociation 2
galaxy.jobs INFO 2016-11-05 14:07:31,336 Collecting metrics for Job 2
galaxy.jobs DEBUG 2016-11-05 14:07:31,370 job 2 ended (finish() executed in (411.821 ms))
galaxy.model.metadata DEBUG 2016-11-05 14:07:31,375 Cleaning up external metadata files
```

Note a few useful bits in the output:
- `Persisting job destination (destination id: slurm)`: Galaxy has selected the `slurm` destination we defined
- `submitting file /srv/galaxy/server/database/jobs/000/2/galaxy_2.sh`: This is the path to the script that is submitted to Slurm as it would be with `sbatch`
- `(2) queued as 7`: Galaxy job id "2" is Slurm job id "7".
- If `job <id> ended` is reached, the job should show as done in the UI

Slurm allows us to query the exit state of jobs for a time period of the value of Slurm's `MinJobAge` option, which defaults to 300 (seconds, == 5 minutes):

```console
$ scontrol show job 7
JobId=7 JobName=g2_upload1_anonymous_10_0_2_2
   UserId=galaxy(999) GroupId=galaxy(999)
   Priority=4294901754 Nice=0 Account=(null) QOS=(null)
   JobState=COMPLETED Reason=None Dependency=(null)
   Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
   RunTime=00:00:06 TimeLimit=UNLIMITED TimeMin=N/A
   SubmitTime=2016-11-05T14:07:24 EligibleTime=2016-11-05T14:07:24
   StartTime=2016-11-05T14:07:24 EndTime=2016-11-05T14:07:30
   PreemptTime=None SuspendTime=None SecsPreSuspend=0
   Partition=debug AllocNode:Sid=gat2016:16025
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=localhost
   BatchHost=localhost
   NumNodes=1 NumCPUs=1 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   TRES=cpu=1,node=1
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryNode=0 MinTmpDiskNode=0
   Features=(null) Gres=(null) Reservation=(null)
   Shared=0 Contiguous=0 Licenses=(null) Network=(null)
   Command=(null)
   WorkDir=/srv/galaxy/server/database/jobs/000/2
   StdErr=/srv/galaxy/server/database/jobs/000/2/galaxy_2.e
   StdIn=StdIn=/dev/null
   StdOut=/srv/galaxy/server/database/jobs/000/2/galaxy_2.o
   Power= SICP=0
```

After the job has been purged from the active jobs database, a bit of information (but not as much as `scontrol` provides) can be retrieved from Slurm's logs. However, it's a good idea to set up Slurm's accounting database to keep old job information in a queryable format.

## So, what did we learn?

Hopefully, you now understand:
- How the various DRM and DRMAA pieces fit together to allow Galaxy to interface with a cluster
- Some basic Slurm inspection and usage: commands for other DRMs are different but the process is similar

## Further Reading

- [Galaxy's cluster documentation](https://wiki.galaxyproject.org/Admin/Config/Performance/Cluster) describes in detail alternative cluster configurations
- [The job_conf.xml documentation](https://wiki.galaxyproject.org/Admin/Config/Jobs) fully describes the syntax of the job configuration file.
- The [Distributed Resource Management Application API (DRMAA)](https://www.drmaa.org/) page contains the DRMAA specification as well as documentation for various implementations. It also includes a list of DRMs supporting DRMAA.
- The [Slurm documentation](http://slurm.schedmd.com/) is extensive and covers all the features and myriad of ways in which you can configure slurm.
- [PSNC slurm-drmaa](http://apps.man.poznan.pl/trac/slurm-drmaa)'s page includes documentation and the SVN repository, which has a few minor fixes since the last released version. PSNC also wrote the initial implementations of the DRMAA libraries for PBSPro and LSF, so all three are similar.
- [My own fork of slurm-drmaa](http://github.com/natefoo/slurm-drmaa) includes support for Slurms `-M`/`--clusters` multi-cluster functionality.
- [Slurm Accounting documentation](http://slurm.schedmd.com/accounting.html) explains how to set up SlurmDBD.

## Notes

<sup>1. The package and config directory name oddities are due to an unrelated `slurm` package existing in Debian before Slurm was added to Debian. `slurm-llnl` refers to Lawrence Livermore National Laboratory, where Slurm was originally developed, but the package was later renamed to `slurm-wlm` (for **W**ork**L**oad **M**anager) when the Slurm authors quit LLNL and </sup>
