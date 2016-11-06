![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Connecting Galaxy to PostgreSQL - Exercise.

#### Authors: Nate Coraor. 2016

## Section 1 - Installationo

**Part 0 - Disable sudo password**

`sudo` allows you to run programs as the `root` (admin) user. We will do this a lot during the training, so to make life easier, we'll disable the password requirement. To do this, run `sudo visudo`. Locate the following line:

```
%sudo   ALL=(ALL:ALL) ALL
```

And change it to:

```
%sudo   ALL=(ALL:ALL) NOPASSWD:ALL
```

Then, save the file and quit the editor.

**Part 1 - Install PostgreSQL**

Install PostgreSQL from apt:

```console
$ sudo apt-get install postgresql
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  ...
Suggested packages:
  ...
The following NEW packages will be installed:
  ...
0 upgraded, 11 newly installed, 0 to remove and 61 not upgraded.
Need to get 5,006 kB of archives.
After this operation, 20.1 MB of additional disk space will be used.
Do you want to continue? [Y/n]
Get:1 http://us.archive.ubuntu.com/ubuntu xenial-updates/main amd64 libpq5 amd64 9.5.5-0ubuntu0.16.04 [78.1 kB]
  ...
Creating new cluster 9.5/main ...
  config /etc/postgresql/9.5/main
  data   /var/lib/postgresql/9.5/main
  locale en_US.UTF-8
  socket /var/run/postgresql
  port   5432
update-alternatives: using /usr/share/postgresql/9.5/man/man1/postmaster.1.gz to provide /usr/share/man/man1/postmaster.1.gz (postmaster.1.gz) in auto mode
Setting up postgresql (9.5+173) ...
Setting up postgresql-contrib-9.5 (9.5.5-0ubuntu0.16.04) ...
Setting up sysstat (11.2.0-1ubuntu0.1) ...

Creating config file /etc/default/sysstat with new version
update-alternatives: using /usr/bin/sar.sysstat to provide /usr/bin/sar (sar) in auto mode
Processing triggers for libc-bin (2.23-0ubuntu3) ...
Processing triggers for systemd (229-4ubuntu10) ...
Processing triggers for ureadahead (0.100.0-19) ...
$
```

## Section 2 - Add PostgreSQL user
