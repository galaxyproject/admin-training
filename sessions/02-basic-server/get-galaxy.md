layout: true
class: inverse, middle, large

---
class: special
# How to get Galaxy

slides by @martenson, @jmchilton

.footnote[\#usegalaxy / @galaxyproject]

---
class: normal
# Reasons to Install Your Own Galaxy

You only need to download Galaxy if you plan to:

- Run a local production Galaxy because you want to
  - Install and use tools and visualizations unavailable on public Galaxies
  - Use sensitive data (e.g. clinical)
  - Process large datasets that are too big for public Galaxies
  - Plug-in new datasources
- Develop Galaxy tools and visualizations
- Develop Galaxy itself

Even when you plan any of the above sometimes you can leverage pre-configured
[Docker image](https://github.com/bgruening/docker-galaxy-stable)
or use [Cloudlaunch](https://launch.usegalaxy.org).

---
# Get logged in to your VM

For OS X/Linux/Windows w/ Linux Subsystem or OpenSSH:
```console
$ ssh -L 8080:localhost:8080 ubuntu@<your_ip>
```

For PuTTY on Windows:
- Create a session
- See [instructions here](http://realprogrammers.com/how_to/set_up_an_ssh_tunnel_with_putty.html).
- User: ubuntu
- Host Name: `<your_ip>`
- (Tunnel) Source port: 8080
- (Tunnel) Destination: 127.0.0.1:8080

---
# Clone the repository

1. Check what is the latest [release](https://docs.galaxyproject.org/en/master/releases/index.html)
1. Run
```shell
$ git clone -b release_17.05 https://github.com/galaxyproject/galaxy.git
```
Release is defined by the branch name: `release_17.05` see the [branch list](https://github.com/galaxyproject/galaxy/branches/all))

Without specifying branch during clone you are running the *development* version of Galaxy.

For the rolling stable release: `git checkout master`.

---
# Start Galaxy

1. `$ cd galaxy`
1. `$ ./run.sh`
1. visit `http://localhost:8080`

You should see default Galaxy running.

.footnote[Note that first startup needs an Internet connection and takes longer than the subsequent ones.]

---
# What happened?

* Galaxy started logging into the terminal from which it is run.
* Galaxy created a Python virtual environment (venv) in `.venv/`.
* Galaxy sourced this environment (`$ source .venv/bin/activate`)
* Galaxy fetched needed Python libraries into this environment.
* Galaxy created the default SQLite database and migrated it to the latest version.
* Galaxy bound to the default port `8080` on `localhost`.

.footnote[All of the above can be configured.]

---
# Look around

1. Run a basic job (e.g. upload a file).
1. Check http://localhost:8080/api/version to see Galaxy's version.
1. Stop Galaxy by terminating the console process (`CTRL+C`).

---
# Basic configuration

- Galaxy works out of the box with default configuration.
- Most important config files are in `config/`.
- Galaxy often uses the files with suffix `*.sample` as declared defaults.

---
# Exercise: make your own config

* Copy the provided sample and open editor.
```shell
$ cp config/galaxy.ini.sample config/galaxy.ini
$ nano config/galaxy.ini
```
* Set the following entries.
```shell
message_box_visible = True
message_box_content = Hey, at least I'm not a popup!
message_box_class = info
```
* (Re)start Galaxy.

---
# Update the welcome page

Welcome page is `$GALAXY_ROOT/static/welcome.html` and is the first thing that
users see. It is a good idea to extend it with things like:
- Downtimes/Maintenance periods
- New tools
- Publications relating to your Galaxy

No restarting is necessary.

???
You can load remote content to this iframe (blog, existing presentation, etc.).

---
# Make yourself an administrator

* Create an account (User -> Register) <sup>[1]</sup>
* Create a user using Galaxy interface.
* Modify `galaxy.ini` to include `admin_users = your@ema.il`.
* (Re)start Galaxy.

.footnote[<sup>[1]</sup> Registering in the UI *before* setting `admin_users` is not strictly necessary, but is the best security practice]

---
# Start/stop in the background

Start:
```shell
$ sh run.sh --daemon
  ...
Activating virtualenv at .venv
Entering daemon mode
```

Monitor:
```
$ tail -f paster.log
  ...
Starting server in PID 1469.
serving on http://127.0.0.1:8080
^C
```

Stop:
```console
$ sh run.sh --stop-daemon
```

---
# Be secure

You are running Galaxy as an **admin** user with **sudo** privileges (that's bad)!

---

# Toward a Production Server

- A Production Database
- A Production Web Server (Proxy)

---

# Database - Defaults

* Galaxy uses database abstraction layer [SQLAlchemy](http://www.sqlalchemy.org/). This allows for different databases to be plugged in.
* By default Galaxy will automatically create and use [SQLite](https://sqlite.org/) database during first startup.
  * The database is in file `database/universe.sqlite`

---

# Database - Choices

* SQLite
  * Useful for ad-hoc Galaxies or development.
* **PostgreSQL**
  * The recommended standard for anything serious.
* ~~MySQL~~
  * Supported but Galaxy is not tested against it.

---

# Database - Configuration

`database_connection` is specified as a connection string in `galaxy.ini` file.
  * Default SQLite: `sqlite:///./database/universe.sqlite?isolation_level=IMMEDIATE`
  * Local PostgreSQL (socket) `postgresql:///<db_name>?host=/var/run/postgresql`
  * Network PostgreSQL: `postgresql://<name>:<password>@<host>:5432/<db_name>`

---

# Database - Configuration (server cursor)

If large database query results are causing memory or response time issues in the Galaxy process leave it on server.
* `database_engine_option_server_side_cursors = False`

---

# More Resources

- https://github.com/galaxyproject/dagobah-training/blob/2017-melbourne/sessions/03-production-basics/ex2-postgres.md
- https://galaxyproject.github.io/training-material/topics/admin/tutorials/database-schema/tutorial.html

---

# Prouduction Web Server - Reverse Proxy

What is a reverse proxy?
- Sits between the client and Galaxy

Extra features:
- Serve static content
- Compress selected content
- Serve over HTTPS
- Serve byte range requests
- Serve other sites from the same server
- Can provide authentication
  - Will be covered on Tuesday: _Using and configuring external authentication services_

---
# Production Web Server - Apache

- The most popular web server
- Many authentication plugins written for Apache
- Can offload file downloads

---
# Production Web Server - nginx

- Designed specifically to be a load balancing reverse proxy
- Widely used by large sites (third most popular web server)
- Can offload both uploads and downloads

Galaxy team recommends nginx unless you have a specific need for Apache

---
# Production Web Server - nginx "flavors"

nginx plugins must be compiled in

Debian/Ubuntu provide multiple nginx "flavors":
- `nginx-light`: minimal set of core modules
- `nginx-full`: full set of core modules
- `nginx-extras`: full set of core modules and extras (3rd party modules)

There is also a "Galaxy" flavor (includes [upload module](https://github.com/vkholodkov/nginx-upload-module)):
- [RHEL](https://depot.galaxyproject.org/yum/) (derived from EPEL nginx)
- [Ubuntu PPA](https://launchpad.net/~galaxyproject/+archive/ubuntu/nginx)

---

# What to do next?

- Keep your code up to date
- Install tools
- Join the mailing list
- Set up a backup process for your instance
- Configure for production
