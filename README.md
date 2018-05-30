# Intro to Galaxy Administration

**Portland, Monday 25th of June, 2018**


jump to [Morning](#morning) | [Noon](#noon) | [Afternoon](#afternoon)

Built slides have [an index](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/).

[Galaxy Training material](http://galaxyproject.github.io/training-material/)

### Instructors

* (N)ate Coraor - Galaxy Project, Penn State University, USA
* (S)imon Gladman - VLSCI, University of Melbourne, Australia
* (M)arius van den Beek - ELIXIR Galaxy WG, Institute Curie, Paris, France
* (C)arrie Ganote - Indiana University Bloomington, USA
* Nuwan (G)oonasekera - University of Melbourne, Australia
* (E)nis Afgan - Galaxy Project, Johns Hopkins University, USA
* (J)ohn Chilton - Galaxy Project, Penn State University, USA
* Martin (Č)ech - Galaxy Project, Penn State University, USA

### Location


## Timetable

Timetable with sessions and material will be continuously updated towards the workshop.

## Training VM instances (recommended specs)

2 cores, 4 GiB memory, and 20 GiB disk

## Timetable
#### Morning

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and introduction | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/00-intro/intro.html) | All |
| 09:20 | Deployment and platform options | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/deployment-platforms-options/slides.html) | (B) |
| 9:40 | Get a basic Galaxy server up and running | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/02-basic-server/get-galaxy.html) | (A) |
| 13:15 | Configuration management choices: Introduction to Ansible | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/14-ansible/ansible-introduction.html) | (E) |
| 14:00 | Using Ansible to deploy Galaxy | [Exercise 1](sessions/14-ansible/ex1-intro-ansible.md), [Exercise 2](sessions/14-ansible/ex2-galaxy-ansible.md) | (E) |
| 11:00 | Defining and importing genomes, Data Managers | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/05-reference-genomes/reference_genomes.html), [Exercise](sessions/05-reference-genomes/ex1-reference-genomes.md) | (E) |
| 11:15 | Extending your installation: FTP, SMTP, and more | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/06-extending-installation/extending.html), [Exercise](sessions/06-extending-installation/ex1-proftpd.md) | (A) |
| 11:30 | Close Morning Session | | All |


#### Noon

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 12:30 | Start Noon Session |  | All |
| 12:30 | Anatomy of a Tool Definition |  | (M) |
| 12:45 | Writing tools with Planemo |  | (M) |
| 14:00 | Introduction to the Galaxy Tool Shed: Identifying and installing well-defined tools | [Slides (Shed)](https://galaxyproject.github.io/dagobah-training/2018-oslo/04-tool-shed/shed_intro.html), [Slides (Tools)](https://galaxyproject.github.io/dagobah-training/2018-oslo/04-tool-shed/tool_installation.html), [Slides (Dependencies)](https://galaxyproject.github.io/dagobah-training/2018-oslo/04-tool-shed/tool-dependencies.html)| (M) |
| 14:30 | Updating tools and supporting multiple versions of tools | [Exercise](sessions/04-tool-shed/ex-tool-management.md) | (M) |
| 15:00 | Close Noon Session | | All |



#### Afternoon

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 15:30 | Start Afternoon Session |  | All |
| 15:30 | Exploring the Galaxy job configuration file | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/15-job-conf/job_conf.html) | (N) |
| 09:50 | Connecting Galaxy to a compute cluster | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html), [Exercise](http://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html) | (B) |
| 09:15 | Storage management and using heterogeneous storage services | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/19-storage/storage.html), [Exercise](sessions/19-storage/ex1-objectstore.md) | (E) |
| 15:45 | Using public and private cloud compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/18-clouds/clouds.html) | (E) |
| 10:15 | Upgrading to a new Galaxy release | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/08-upgrading-release/upgrading.html) | (N) |
| 11.00 | What's new in Galaxy 18.01? | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/whatsnew/18.01.html) | (N) |
| 13:30 | When things go wrong: Galaxy Server Troubleshooting | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/22-troubleshooting/troubleshooting.html) | (M) |
| 18:00 | Close Afternoon Session | | All |




#### Extra

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 10:30 | Galaxy server optional necessities: PostgreSQL and nginx | [First Steps Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/03-production-basics/production.html), [PostgreSQL Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/03-production-basics/databases.html), [nginx/Apache Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/03-production-basics/webservers.html)| (N) |
| 16:45 | Using and configuring external authentication services | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/13-external-auth/external-auth.html), [PAM Auth Exercise](sessions/13-external-auth/ex1-pam-auth.md), [Upstream Auth Exercise](sessions/13-external-auth/ex2-upstream-auth.md) | (N) |
| 13:15 | Running Jupyter in Galaxy with Galaxy Interactive Environments | [Exercise](sessions/21-gie/ex1-jupyter.md) | (B) |
| 16:45 | Using heterogeneous compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/17-heterogenous/heterogeneous.html), [Exercise](sessions/17-heterogenous/ex1-pulsar.md) | (M) |
| 16:30 | Server monitoring and maintenance: Admin UI, Log files, Direct database queries, command line & scripts, what to backup and how | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/slides.html), [Exercise 1](http://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/tutorial.html), [Exercise 2](sessions/22-troubleshooting/ex1-sentry.md) | (B,M) |
| 11:00 | Containerize all the things: Galaxy in Docker and Docker in Galaxy | [Docker Slides](https://galaxy.slides.com/bgruening/the-galaxy-docker-project), [Conda Slides](http://galaxy.slides.com/bgruening/deck-7#/), [Galaxy Docker tool example](https://github.com/apetkau/galaxy-hackathon-2014/tree/master/smalt)| (B) |
| 14:30 | Improving the web serving experience with uWSGI | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/10-uwsgi/uwsgi.html), [Exercise](sessions/10-uwsgi/ex1-uwsgi.md) | (B) |
| 15:45 | Controlling Galaxy with systemd and supervisor | [Slides](https://galaxyproject.github.io/dagobah-training/2018-oslo/11-systemd-supervisor/systemd-supervisor.html), [Exercise](sessions/11-systemd-supervisor/ex1-supervisor.md) | (E) |
| 09:15 | Users, Groups, and Quotas | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/users-groups-quotas/slides.html) | (B) |
