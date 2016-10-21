layout: true
class: inverse, middle, large

---
class: special
# How to get Galaxy

slides by @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!
Your questions will be answered.

---
# Reasons to Install Your Own Galaxy

You only need to download Galaxy if you plan to:

- Run a local production Galaxy because you want to
  - install and use tools unavailable on public Galaxies
  - use sensitive data (e.g. clinical)
  - process large datasets that are too big for public Galaxies
  - plug-in new datasources
- Develop Galaxy tools
- Develop Galaxy itself

---
# Requirements
- UNIX/Linux or Mac OS
- Python 2.7

Optional
  - Git (optional)
  - GNU Make, gcc to compile and install tool dependencies
  - Additional tool requirements as detailed in Tool Dependencies

---
# Clone the repository
1. check what is the latest [release](https://docs.galaxyproject.org/en/master/releases/index.html)
1. run `$ git clone -b release_16.07 https://github.com/galaxyproject/galaxy.git`
  - you can change `release_16.07` to any release you want

---
# Start Galaxy
1. `$ cd galaxy`
1. `$ ./run.sh`
1. visit `http://localhost:8080`

You now have default Galaxy running.

.footnote[Note that first startup needs internet connection and takes longer than subsequent ones.]

---
# What happened?

* Galaxy created a Python virtual environment.
* Galaxy fetched and added needed Python binaries ('wheels') into this environment
* Galaxy created the default SQLite database and migrated it to the latest version.

---
# Look around

1. Run a basic job (e.g. upload a file).
1. Check `http://localhost:8080/api/version` to see Galaxy's version.
1. Kill the server by terminating the console process.

---
# Basic configuration


---
# Update the welcome page

---
# What to do next?
- Keep your code up to date
- Make yourself an administrator
- Install tools
- Join the mailing list
- Set up a backup process for your instance
- Configure for production
