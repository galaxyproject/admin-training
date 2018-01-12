layout: true
class: inverse, middle, large

---
class: special
# Upgrading Galaxy
Tracking releases

slides by @martenson, @afgane, @nsoranzo

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!

Answer your questions we will.

---
# Release Cycle

* Galaxy aims to release each 4 months
* Releases are tagged with year and month, for example 17.09, 18.01
* Per the [security policy](https://github.com/galaxyproject/galaxy/blob/dev/SECURITY_POLICY.md), releases within the past 12 months are supported

---
# Releases

* Every release has [release notes](https://docs.galaxyproject.org/en/master/releases)
  * We put substantial effort in making them as useful as we can
  * Highlights, security announcements, deprecation notices, enhancements grouped by impact, etc...
* Every release has its own branch in the `galaxy` GitHub repository
  * Named as `release_YY_MM`
  * Kept up to date (especially for recent releases)

---
# Keeping a release up to date

To keep your `release_*` branch up to date you can:

```console
$ git stash  # optional
$ git pull --ff-only
$ git stash pop  # optional
```

and restart Galaxy

Works well if no local commits exist

---
# Major release upgrade

When a new release is out:
* Plan a service downtime for the upgrade and inform your users
* Configure your reverse proxy to serve a custom error page, e.g. for nginx inside the `server` section add:
  ```ini
  error_page 502 /static/custom_502.html;
  ```
* When it's time, stop the Galaxy servers

---
# Housekeeping

Not usually necessary but can't hurt, might help:

```console
$ find . -name '*.pyc' -delete
$ rm -rf database/compiled_templates/*
```

---
# Upgrading the galaxy repo

```console
$ git fetch
$ git stash  # optional
$ git checkout release_YY.MM
$ git pull --ff-only
$ git stash pop  # optional
```

---
# Diff samples

```console
$ diff -u galaxy.ini galaxy.ini.sample
$ diff -u datatypes_conf.xml datatypes_xml.conf.sample
```

Merge changes as desired/necessary.

???
Alternatively:

```console
$ git diff release_17.05..release_17.09 -- config/galaxy.ini.sample
```

---
# Upgrade virtualenv

```console
$ . $GALAXY_VIRTUAL_ENV/bin/activate
$ pip install --upgrade pip setuptools
$ GALAXY_VIRTUAL_ENV=/srv/galaxy/venv ./scripts/common_startup.sh
$ deactivate
```

---
# Tool migrations?

Galaxy source tools -> Tool Shed

We haven't done these in a long time, but may do more

Galaxy will notify you on first startup after upgrade including migration

---
# Database migrations

**Backup** your database and:

```console
$ GALAXY_VIRTUAL_ENV=/srv/galaxy/venv sh manage_db.sh upgrade -c /srv/galaxy/config/galaxy.ini
```

---
# Start Galaxy

* Monitor the log files
* Check that everything still works

---
# Locally modified Galaxy

Two options:
1. Commit your changes to a local branch, merge/rebase upstream Galaxy
2. `git stash && git checkout ... && git pull ... && git stash pop`

The former is probably better than the latter

---
# Distribute Galaxy

If you're using a compute cluster and not running from shared file system
