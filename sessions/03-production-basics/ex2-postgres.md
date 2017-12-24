![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Connecting Galaxy to PostgreSQL - Exercise.

#### Authors: Nate Coraor. 2016

## Section 1 - Installation

**Part 1 - Install PostgreSQL**

Install PostgreSQL from apt. In the case of the training instances, it has already been installed. However, it cannot hurt to try to install it anyway:

```console
$ sudo apt install postgresql
Reading package lists... Done
Building dependency tree       
Reading state information... Done
postgresql is already the newest version (9.5+173).
0 to upgrade, 0 to newly install, 0 to remove and 60 not to upgrade.
$
```

## Section 2 - Add PostgreSQL user and database

PostgreSQL maintains its own user database apart from the system user database. As such, we need to create a PostgreSQL user matching the system user we are logged in as - `galaxy`.  By default, PostgreSQL is configured to allow access for system users with matching PostgreSQL usernames once created. This is done with the PostgreSQL `createuser` command, and it must be run as the `postgres` user:

```console
$ sudo -Hu postgres createuser galaxy
```

Next, we need to create an empty database. Once a database exists, Galaxy will populate it. The `createdb` command creates a database, and we want to make sure to create it with the `galaxy` user as the owner:

```console
$ sudo -Hu postgres createdb -O galaxy galaxy
```

We have created a new database with the name `galaxy`.

## Section 3 - Configure Galaxy

Next, we need to configure Galaxy to use PostgreSQL. To do this, open up the Galaxy config file, `galaxy.ini`, in an editor as the galaxy user:

```console
$ sudo -u galaxy -e /srv/galaxy/config/galaxy.ini
```

Locate the line:

```ini
#database_connection = sqlite:///./database/universe.sqlite?isolation_level=IMMEDIATE
```

Uncomment it and change it to:

```ini
database_connection = postgresql:///galaxy?host=/var/run/postgresql
```

The `?host=/var/run/postgresql` portion of the database URI instructs the database connection layer to look for PostgreSQL's socket in the given directory (because by default, it looks in `/tmp`, and Debian/Ubuntu use a different path).

## Section 4 - Start Galaxy

If you are already running Galaxy, hit `Ctrl+C` to stop it (or `sudo -Hu galaxy galaxy --stop-daemon` if running as a daemon), then start it again with `sudo -Hu galaxy galaxy`. It will first fetch the `psycopg2` wheel (the Python PostgreSQL library), then proceed to populate the database from scratch as it did the first time with SQLite.

```console
$ sh run.sh
Collecting psycopg2==2.6.1 (from -r /dev/stdin (line 1))
  Downloading https://wheels.galaxyproject.org/packages/psycopg2-2.6.1-cp27-cp27mu-manylinux1_x86_64.whl (2.0MB)
    100% |████████████████████████████████| 2.0MB 1.3MB/s
Installing collected packages: psycopg2
Successfully installed psycopg2-2.6.1
  ...
galaxy.queue_worker INFO 2016-11-07 01:47:24,494 Initializing main Galaxy Queue Worker on sqlalchemy+postgresql:///galaxy?host=/var/run/postgresql
  ...
galaxy.model.migrate.check INFO 2016-11-07 01:47:25,230 No database, initializing
galaxy.model.migrate.check INFO 2016-11-07 01:47:25,352 Migrating 0 -> 1...
galaxy.model.migrate.check INFO 2016-11-07 01:47:25,900
galaxy.model.migrate.check INFO 2016-11-07 01:47:25,900 Migrating 1 -> 2...
galaxy.model.migrate.check INFO 2016-11-07 01:47:26,185
  ...
Starting server in PID 2962.
serving on http://127.0.0.1:8080
```

Visit [http://localhost:8080/](http://localhost:8080) and you should see that Galaxy is running (again).
