![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Connecting Galaxy to PostgreSQL - Exercise.

#### Authors: Nate Coraor. 2016

## Section 1 - Installation

**Part 1 - Install PostgreSQL**

Install PostgreSQL on your Galaxy VM:

```console
$ sudo apt-get install postgresql
```

## Section 2 - Add PostgreSQL user and database

PostgreSQL maintains its own user database apart from the system user database. By default, PostgreSQL uses the "peer" authentication method which allows access for system users with matching PostgreSQL usernames (other authentication mechanisms are available, see the [PostgreSQL Client Authentication documentation](https://www.postgresql.org/docs/current/static/client-authentication.html).

For this tutorial, we will use the default "peer" authentication, so we need to create a PostgreSQL user matching the system user under which Galaxy is running, i.e. `galaxy`. This is done with the PostgreSQL `createuser` command, and it must be run as the `postgres` user:

```console
$ sudo -Hu postgres createuser galaxy
```

Next, we need to create an empty database. Once a database exists, Galaxy will populate it. The `createdb` command creates a database, and we want to make sure to create it with the `galaxy` user as the owner:

```console
$ sudo -Hu postgres createdb -O galaxy galaxy
```

Change this 'ident' to 'md5' :
/var/lib/pgsql/data/pg_hba.conf
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
su - postgres
pg_ctl reload

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
$ sudo -Hu galaxy galaxy
...
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
