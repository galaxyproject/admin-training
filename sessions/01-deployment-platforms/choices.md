layout: true
class: inverse, large

---

class: special, middle
# Deployment and Platform Options

## What is needed to Make Galaxy Work for You!

slides by @natefoo, @jmchilton

.footnote[\#usegalaxy / @galaxyproject]

---
class: left
# Where can Galaxy run?
* Cloud (SaaS)
  - [usegalaxy.org](https://usegalaxy.org)
  - [Public Galaxy Servers](https://wiki.galaxyproject.org/PublicGalaxyServers)
  - [Amazon EC2](https://wiki.galaxyproject.org/CloudMan)
  - Semi-private cloud (e.g. [Genomics Virtual Lab](https://www.genome.edu.au/), [Jetstream](http://jetstream-cloud.org/))
* Private cloud (build your own Galaxy SaaS)
* Scalable Local Server
  - Dedicated or shared compute cluster(s)
  - Cloud compute resources
* Standalone Local Server

---

# Choosing where to run

Public Prebuilt SaaS (usegalaxy.org, public servers)
- Quickest to use today, but probably not why you're here...
- Institutional/Protected data a concern

Private Prebuilt SaaS (EC2, GVL, Jetstream) or build your own
- Great choices for people needing access to compute for a fixed time analysis
- Not as conducive to collaboration, publishing

---
# Choosing where to run

Local Server and Cluster
- Permanent Galaxy server
- Flexible compute scalability
- Full privacy control

Standalone Local Server
- Permanent Galaxy server
- Full privacy control
- Should only consider this in cases of expected light usage
- Get a beefy server
- Docker is a great choice!

---
# Software Requirements

Required:
  - Galaxy is written in Python and depends on **Python 2.7**

Optional:
  - PostgreSQL
  - uWSGI (will soon come with Galaxy)
  - Reverse proxy server (nginx, Apache)

---
# What can run Galaxy

UNIX-like operating system:

- Linux (any distribution)
- OS X / macOS

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

Users | Resource estimate (cores/RAM/disk)
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
class: special, middle
# Deployment Options and Best Practices

.footnote[\#usegalaxy / @galaxyproject]

---
# How is Galaxy deployed?

Current:

- `git clone https://github.com/galaxyproject/galaxy.git`
- *Framework dependencies* provided as Python "wheels", fetched at first startup with `pip`
- *Tool dependencies* provided as Conda packages mostly (installed when you start up Galaxy the first time)

---
# Making Plans

**Before** deploying your first Galaxy server:

- Get PostgreSQL (you do not want to switch later)
- Figure out where Galaxy will be stored
  - Make sure it will be accessible to any eventual compute
- Figure out where data will be stored
  - Make sure it will be accessible to any eventual compute

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
class: special
# Let's get our hands dirty!

Any questions first?

---
# Deployment Best Practices

**Use configuration management**
- Ansible
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
- OS security best practices
- **Update Galaxy when security updates are released**
  - We put a lot of effort into these!

Privilege separate if you can
- Separate code and job/data ownership

Write protect Galaxy and data if you can
- Read-only cluster mounts

Back up everything (except that which is managed by configuration management)
