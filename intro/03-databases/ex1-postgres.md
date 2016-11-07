![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Connecting Galaxy to PostgreSQL - Exercise.

#### Authors: Nate Coraor. 2016

## Section 1 - Installation

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

## Section 2 - Add PostgreSQL user and database

PostgreSQL maintains its own user database apart from the system user database. As such, we need to create a PostgreSQL user matching the system user we're logged in as - `galaxyguest`.  By default, PostgreSQL is configured to allow access for system users with matching PostgreSQL usernames once created. This is done with the PostgreSQL `createuser` command, and it must be run as the `postgres` user:

```console
$ sudo -H -u postgres createuser galaxyguest
```

Next, we need to create an empty database. Once a database exists, Galaxy will populate it. The `createdb` command creates a database, and we want to make sure to create it with the `galaxyguest` user as the owner:

```console
$ sudo -H -u postgres createdb -O galaxyguest galaxyguest
```

We've created a new database with the name `galaxyguest`.

## Section 3 - Configure Galaxy

Next, we need to configure Galaxy to use PostgreSQL. To do this, open up the Galaxy config file, `galaxy.ini`, in an editor. You can find it it in `~/galaxy/config/`. Find the line:

```ini
#database_connection = sqlite:///./database/universe.sqlite?isolation_level=IMMEDIATE
```

Uncomment it and change it to:

```ini
database_connection = postgresql:///galaxyguest?host=/var/run/postgresql
```

The `?host=/var/run/postgresql` portion of the database URI instructs the database connection layer to look for PostgreSQL's socket in the given directory (because by default, it looks in `/tmp`.

## Section 4 - Start Galaxy

If you're already running Galaxy, hit `CTRL+C` to stop it, then start it again with `sh run.sh`. It will first fetch the `psycopg2` wheel, which is the python PostgreSQL library, and then proceed to populate the database as it did the first time with SQLite.

```console
```
