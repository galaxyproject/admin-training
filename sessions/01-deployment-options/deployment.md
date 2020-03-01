layout: true
class: inverse, middle, large

---
class: special
# Platform Options and Requirements

Author: @natefoo

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!
We like questions.

---
# Where can Galaxy run?
* Cloud (SaaS)
  - usegalaxy.org|eu|org.au
  - [Public Galaxy Servers](https://galaxyproject.org/use/)
  - [Amazon EC2](https://galaxyproject.org/cloudman/)
  - Semi-private cloud (e.g.: [Genomics Virtual Lab](https://www.gvl.org.au/get/), [Jetstream](http://jetstream-cloud.org/))
* Private cloud (build your own Galaxy SaaS)
* Cloud (IaaS)
  - Any cloud
* Scalable Local Server
  - Dedicated or shared compute cluster(s)
  - Cloud compute resources
* Standalone Local Server

---
# Software Requirements

Required:
  - Galaxy is written in Python and depends on **Python 3.5** or newer

Optional (but not really):
  - [PostgreSQL](https://galaxyproject.github.io/dagobah-training/2018-oslo/03-production-basics/databases.html)
  - [uWSGI](https://galaxyproject.github.io/dagobah-training/2018-oslo/10-uwsgi/uwsgi.html) (will come with Galaxy from 18.01 onwards)
  - [Reverse proxy server](https://galaxyproject.github.io/dagobah-training/2018-oslo/03-production-basics/webservers.html) (NGINX)

.footnote[<sup>[1]</sup> Point of order: Unless stated otherwise, "RHEL" refers to RHEL and derivatives (CentOS, Scientific Linux, etc.)]

---
# What can run Galaxy

UNIX-like operating system:

- **Linux (any distribution)**
- **OS X / macOS**
- Windows using the Windows Subsystem for Linux (WSL)
- Other architectures (maybe?)

---
# Hardware Requirements and estimates

If possible, run the Galaxy server **separate** from Galaxy jobs.

Based on concurrent user count and assuming separate compute for jobs:

Users     | Resource estimate
----------|-------------------
1 - 5     | 1 core, 1GB, 10 TB
5 - 20    | 2 cores, 2 GB, 40 TB
20 - 40   | 8 cores, 8 GB, 200 TB
40+       | multiple hosts, 16 GB/host, 500 TB, dedicated DB host

Storage is the big variable since it, like compute, is **analysis** and **policy** dependent

---

# Storage Requirements

An "average" NGS analysis (by Anton Nekrutenko): **66 GB**

10 users, 10 histories: **> 6 TB**

Solutions:

- Quotas
- Clean up deleted data (aggressively)
- Forced removal based on age available

---

# Compute Requirements

This depends:

- What tools will your users be using?
  - What are their requirements?
- In general, the most commonly used tools use a single core.
  - But can use lots of memory!
- Some compute-intensive tools use multiple cores

usegalaxy.org allocates from **8 GB/core** to **16 GB/core**

---

# How is Galaxy deployed?

- `git clone https://github.com/galaxyproject/galaxy.git`
- *Framework dependencies* provided as Python "wheels", fetched at first startup with `pip`
- *Tool dependencies* provided as Conda packages, Docker/Singualrity images or legacy Tool Shed packages

---
# Making Plans

**Before** deploying your first Galaxy server:

- Get PostgreSQL (you do not want to switch later)
- Figure out where Galaxy will be stored
  - Make sure it will be accessible to any eventual compute
- Figure out where data will be stored
  - Make sure it will be accessible to any eventual compute

---
# Deployment Best Practices

- **Use configuration management.** Most used amongst Galaxy admins is [Ansible](http://docs.ansible.com) ([tutorial](https://galaxyproject.github.io/dagobah-training/2018-oslo/14-ansible/ansible-introduction.html))

-  Record every change you make somehow (maybe using configuration management? ^^).
  - Large, complex deployments grow organically
  - If you don't know what you did you can't do it again
  - "My context switching penalty is high and my process isolation is not what it used to be." - Elon Musk

---

# System Administration Best Practices

Take security seriously
- OS security best practices
- **Update Galaxy when security updates are released**

Privilege separate if you can
- Separate code and job/data ownership

Write protect Galaxy and data if you can
- Read-only cluster mounts

Back up everything (except that which is managed by configuration management)

---

A full-fledged version of these slides available at https://training.galaxyproject.org

