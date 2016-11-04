![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Running Galaxy Jobs with Slurm - Example

#### Authors: Nate Coraor. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. 
2. 
3. 

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

<sup>1. The package and config directory name oddities are due to an unrelated `slurm` package existing in Debian before Slurm was added to Debian. `slurm-llnl` refers to Lawrence Livermore National Laboratory, where Slurm was originally developed, but the package was later renamed to `slurm-wlm` (for **W**ork**L**oad **M**anager) when the Slurm authors quit LLNL and </sup>


## So, what did we learn?

Hopefully, you now understand:
-
-

## Further Reading
