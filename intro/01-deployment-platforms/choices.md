layout: true
class: inverse, middle, large

---
class: special
# Deployment and Platform Options

slides by @natefoo

.footnote[\#usegalaxy / @galaxyproject]

---
class: special
# Platform Options and Requirements

.footnote[\#usegalaxy / @galaxyproject]

---
class: smaller
# Where can Galaxy run?

Cloud (SaaS)
- [usegalaxy.org](https://usegalaxy.org)
- [Public Galaxy Servers](https://wiki.galaxyproject.org/PublicGalaxyServers)
- [Amazon EC2](https://wiki.galaxyproject.org/CloudMan)
- Semi-private cloud (e.g.: [Genomics Virtual Lab](https://www.genome.edu.au/), [Jetstream](http://jetstream-cloud.org/))
- Private cloud (build your own Galaxy SaaS)

Cloud (IaaS)
- Any cloud

Scalable Local Server
- Dedicated or shared compute cluster(s)
- Cloud compute resources

Standalone Local Server

---
# Choosing where to run

Public Prebuilt SaaS (usegalaxy.org, public servers)
- Quickest to use today, but probably not why you're here...
- Institutional/Protected data a concern
- Not covered in this training

Private Prebuilt SaaS (EC2, GVL, Jetstream) or build your own
- Great choices for people needing access to compute for a fixed time analysis
- Not as conducive to collaboration, publishing
- Covered in:
  - Thurday, 19:00: Using public and private cloud compute resources
  - Friday: 10:50: Complex Galaxy servers examples: usegalaxy.org, GVL

Build your own Galaxy SaaS
- Personalized Galaxy instances for beginner-to-intermediate users
- Requires a lot of infrastructure building
- Covered in:
  - Thurday, 19:00: Using public and private cloud compute resources
  - Friday: 10:50: Complex Galaxy servers examples: usegalaxy.org, GVL

---
# Choosing where to run

Scalable Local Server
- Permanent Galaxy server
- Flexible compute scalability
- Full privacy control
- Covered on: Thursday

Standalone Local Server
- Permanent Galaxy server
- Full privacy control
- Should only consider this in cases of expected light usage
- Get a beefy server
- Covered on: Today

---
# Software Requirements

Required:

- Galaxy is written in Python and depends on **Python 2.7**
- All major distros in wide circulation have 2.7, *except* RHEL<sup>[1]</sup> 6
  - See: Software Collections for [RHEL](https://access.redhat.com/solutions/472793), [CentOS](https://wiki.centos.org/AdditionalResources/Repositories/SCL), [Scientific Linux](http://linux.web.cern.ch/linux/scl/)

Optional (but not really):

- PostgreSQL
  - Covered in: Today, 11:20: Database choices and configuration. Introduction to PostgreSQL
- uWSGI (will soon come with Galaxy)
  - Covered in: Wednesday, 9:50: Using Ansible to deploy Galaxy I
- Reverse proxy server (nginx, Apache)
  - Covered in: Today, 13:20: Web server choices and configuration. Introduction to Apache and NGINX.

.footnote[<sup>[1]</sup> Point of order: Unless stated otherwise, "RHEL" refers to RHEL and derivatives (CentOS, Scientific Linux, etc.)]

---
# What can run Galaxy

UNIX-like operating system:

- Linux (any distribution)
- OS X / macOS
- Windows under MinGW (maybe?)
- Other architectures (maybe?)

---
# What can run Galaxy

UNIX-like operating system:

- **Linux (any distribution)**
- **OS X / macOS**
- Windows under MinGW (maybe?)
- Other architectures (maybe?)

---
# Hardware Requirements

This depends:

- What do you intend to run?
- Where do you intend to run it?

If possible, run the Galaxy server *separate* from Galaxy jobs

**Storage** will be the bigger concern

---
# Hardware Estimates

Based on concurrent user count and assuming separate compute for jobs:

Users | Resource estimate
------|-------------------
1-5   | 1 core, 1GB, 10 TB
5-20  | 2 cores, 2 GB, 40 TB
20-40 | 8 cores, 8 GB, 200 TB
40+   | multiple hosts, 16 GB/host, 500 TB, dedicated DB host

Storage is the big variable since it, like compute, is *analysis* and *policy dependent*

---
# On Storage...

The Philosophy of Galaxy:

- Foster transparency and reproducibility
- Data is always created, *never overwritten*
- Data is never deleted unless *explicitly instructed*
- Even deleted data can be undeleted unless *forcibly purged*

Additionally, tools can produce large amounts of transient data while running.

---
# Storage Requirements

An "average" NGS analysis (by Anton): **66 GB**

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
- In general, the most commonly used tools use a single core
  - But can use lots of memory!
- Some computive-intensive tools use multiple cores

usegalaxy.org allocates from **8 GB/core** to **16 GB/core**

Connecting Galaxy to clusters/HPC is covered in the advanced section.

---
class: special
# Deployment Options and Best Practices

.footnote[\#usegalaxy / @galaxyproject]

---
# How is Galaxy deployed?

Current:

- `git clone https://github.com/galaxyproject/galaxy.git`
- *Framework dependencies* provided as Python "wheels", fetched at first startup with `pip`

Future:

- RPM, Debian packages
- Galaxy wheel in PyPI
- Watch: [Pull Request #921](https://github.com/galaxyproject/galaxy/pull/921)

---
# Making Plans

**Before** deploying your first Galaxy server:

Get PostgreSQL (you do not want to switch later)

Figure out where Galaxy will be stored
- Make sure it will be accessible to any eventual compute

Figure out where data will be stored
- Make sure it will be accessible to any eventual compute

---
# Deployment Best Practices

**Use configuration management**
- Ansible (covered in advanced section)
- Chef
- Puppet
- SaltStack
- CFEngine

**Use configuration management** but if you don't, *record every change you make somehow.*
- Large, complex deployments grow organically
- If you don't know what you did you can't do it again
- "My context switching penalty is high and my process isolation is not what it used to be." -Elon Musk

---
# System Administration Best Practices

Take security seriously
- OS security best practices (not covered)
- **Update Galaxy when security updates are released**
  - We put a lot of effort into these!

Privilege separate if you can
- Separate code and job/data ownership

Write protect Galaxy and data if you can
- Read-only cluster mounts

Back up everything (except that which is managed by configuration management)

---
# Galaxy Server Styles

- Public, anonymous allowed
- Public, registration conditionally required (e.g. usegalaxy.org)
- Public, self registration required
- Public, admin registration required
- Private, all of the above
- Private, registration/access controlled externally (upstream proxy)
- Private, registration/access controlled externally (Galaxy pluggable auth)

---
# Options

For this training:

- OS: Ubuntu (16.04)
- Database: PostgreSQL
- Application server: uWSGI
- Reverse proxy servers: nginx, Apache
- FTP: ProFTPD

---
class: special
# Let's get our hands dirty!

Any questions first?
