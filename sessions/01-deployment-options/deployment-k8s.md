layout: true
class: inverse, middle, large

---
class: special
# Platform Options and Requirements

Authors: @natefoo, @nuwang

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!
Questions are always welcome!

---
# Where can Galaxy run?
* Cloud (SaaS)
  - usegalaxy.org|eu|org.au
  - [Public Galaxy Servers](https://wiki.galaxyproject.org/PublicGalaxyServers)
  - [Amazon EC2](https://wiki.galaxyproject.org/CloudMan)
  - Semi-private cloud (e.g.: [Genomics Virtual Lab](https://www.genome.edu.au/), [Jetstream](http://jetstream-cloud.org/))
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
  - Galaxy is written in Python and depends on **Python 2.7**
  - All major distros in wide circulation have 2.7, *except* RHEL<sup>[1]</sup> 6
    - See: Software Collections for [RHEL](https://access.redhat.com/solutions/472793), [CentOS](https://wiki.centos.org/AdditionalResources/Repositories/SCL), [Scientific Linux](http://linux.web.cern.ch/linux/scl/)

.footnote[<sup>[1]</sup> Point of order: Unless stated otherwise, "RHEL" refers to RHEL and derivatives (CentOS, Scientific Linux, etc.)]

---
# What can run Galaxy

UNIX-like operating system:

- **Linux (any distribution)**
- **OS X / macOS**
- But with Docker/Kubernetes, in principle, anywhere Docker is supported (including Windows?).

---
# Hardware Requirements and estimates

If possible, run the Galaxy server **separate** from Galaxy jobs.

Based on concurrent user count and assuming separate compute for jobs:

Users     | Resource estimate
----------|-------------------
1 - 5     | 2 cores, 8GB, 10 TB
5 - 20    | 4 cores, 12 GB, 40 TB
20 - 40   | 8 cores, 16 GB, 200 TB
40+       | multiple hosts, 16 GB/host, 500 TB, dedicated DB host

Storage is the big variable since it, like compute, is **analysis** and **policy** dependent

---
# Philosophy of Galaxy Storage

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
- In general, the most commonly used tools use a single core.
  - But can use lots of memory!
- Some compute-intensive tools use multiple cores

usegalaxy.org allocates from **8 GB/core** to **16 GB/core**

---

# How is Galaxy deployed?

Traditionally
- From git: `git clone https://github.com/galaxyproject/galaxy.git`
- Through Ansible playbooks
- Lots of manual configuration

A lot of control but this is just too hard!

---
# With Kubernetes

- A single command to get up and running
- The same command works on laptops, workstations, clouds, bare hosts
- Best practices built-in
- Fault tolerant, highly scalable
- In future (automatic updates)

---
# Kubernetes (downsides)

- Currently a bit heavyweight for a laptop, but we are working on making this leaner.
- Nevertheless, far less complicated than alternatives. 
