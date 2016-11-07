layout: true
class: inverse, middle, large

---
class: special
# Upgrading Galaxy
Tracking releases

slides by @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!

Answer your questions we will.

---
# Release Cycle

* Galaxy aims to release each 3 months.
* Releases are tagged with year and month (15.10, 16.07).

---
# Release

* Every release has [release notes](https://docs.galaxyproject.org/en/master/releases).
  * We put substantial effort in making them as useful as we can.
  * Highlights, security announcements, deprecation notices, enhancements grouped by impact etc.
* Every release has its own branch in GitHub repository.
  * Named as `release_YY_MM`.
  * Kept up to date (especially for recent releases).

---
# Keeping release up to date

To keep your `release_*` branch up to date you can:
* `git pull --ff-only`
* restart Galaxy

---
# Upgrading release

When new release is out:
```
$ git checkout release_YY.MM && git pull --ff-only origin release_YY.MM
```

???
* (optional)`git stash`

---
# Housekeeping

Not usually necessary but can't hurt, might help:
```
$ find lib -name \*.pyc -delete
$ rm -rf database/compiled_templates/*
```

---
# Diff samples

```
$ diff -u galaxy.ini galaxy.ini.sample
$ diff -u datatypes_conf.xml datatypes_xml.conf.sample
```

Merge changes as desired/necessary.

---
# Tool migrations?

Galaxy source tools -> Tool Shed

We haven't done these in a long time, but may do more

Galaxy will notify you on first startup after upgrade including migration

---
# Database migrations

Backup your database and:
```
$ sh manage_db.sh upgrade
```

---
# Locally modified Galaxy

Two options:
1. Commit your changes to a local branch, merge upstream Galaxy
2. `git stash && git checkout ... && git pull ... && git stash pop`

The former is probably better than the latter

---
# Distribute Galaxy

If you're using a compute cluster and not running from shared filesystem

---
