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
* `$ git checkout release_YY.MM && git pull --ff-only origin release_YY.MM`

???
* (optional)`git stash`

---
