# GCCBOSC2018 - Intro to Galaxy Administration

**Portland, OR; Monday, 25th of June, 2018; 9:00 to 18:00**

Link to session: [Morning](#morning) | [Noon](#noon) | [Afternoon](#afternoon)

Built slides have [an index](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/).

Join the chat at https://gitter.im/dagobah-training/Lobby

### Location

PAB 320 Performing Arts Building, Reed Campus

## Training VM instances

List of training instances is available in [this spreadhseet](https://docs.google.com/spreadsheets/d/1sIoU4qpv4HdKNUNOtsAtW-XKKZvIsDfReAoS7uBbCZM/edit?usp=sharing). Please pick one instance, enter your name in the user column and then copy the private ssh key to your machine and clear that cell (that way others won't be able to ssh into your instance and we have to switch focus to intrusion detection).

#### Recommended instance specs

2 cores, 4 GiB memory, and 20 GiB disk, Ubuntu 16.04

We are using instances from the [Jetstream cloud](https://jetstream-cloud.org/), image ID _acb53109-941f-4593-9bf8-4a53cb9e0739_.

## Timetable

_Timetable with sessions and material will be continuously updated towards the workshop._

#### Morning

Setting up production Galaxy

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and introduction | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/00-intro/intro.html) | (Č) |
| 09:15 | Deployment and platform options | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/01-deployment-options/deployment.html#1) | (Č) |
| 9:30 | Using Ansible to deploy Galaxy | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/14-ansible/ansible-introduction.html#1), [Exercise](sessions/14-ansible/ex2-galaxy-ansible.md) | (E)(G) |
| 10:40 | Extending installation | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/06-extending-installation/extending.html), [Exercise](sessions/06-extending-installation/ex1-proftpd.md) | (G) |
| 11:00| Defining and importing genomes, Data Managers | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/05-reference-genomes/reference_genomes.html), [Exercise](sessions/05-reference-genomes/ex1-reference-genomes.md#exercise-3-install-a-datamanager-from-the-toolshed) | (E) |
| 11:15 | Galactic Database | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/03-production-basics/databases.html) | (M)(N) |
| 11:30 | Close Morning Session | |  |


#### Noon

All about Galaxy tools

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 12:30 | Web Servers nginx/Apache |  [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/03-production-basics/webservers.html)| (M)(N) |
| 12:45 | Writing tools with Planemo | [Tutorial](http://planemo.readthedocs.io/en/latest/writing_standalone.html) | (J) |
| 13:30 | Galaxy Tools and Tool Shed | [Slides (Shed)](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/04-tool-shed/shed_intro.html), [Slides (Tools)](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/04-tool-shed/tool_installation.html)| (M)(Č) |
| 14:30 | Updating tools and supporting multiple versions of tools | [Exercise](sessions/04-tool-shed/ex-tool-management.md) | (M)(N) |
| 14:45 | Running tools in containers| | (J)(N) |
| 15:00 | Close Noon Session | |  |


#### Afternoon

Galaxy jobs, clusters, infrastructure, and maintenance

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 15:30 | Exploring the Galaxy job configuration file | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/15-job-conf/job_conf.html) | (S) |
| 15:50 | Connecting Galaxy to a compute cluster | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html), [Exercise](http://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html#section-4---statically-map-a-tool-to-a-job-destination) | (N)(S) |
| 16:30 | Storage management and using heterogeneous storage services | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/19-storage/storage.html), [Exercise](sessions/19-storage/ex1-objectstore.md) | (N)(C) |
| 16:50 | Upgrading to a new Galaxy release | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/08-upgrading-release/upgrading.html) | (C) |
| 17:10 | Galaxy on uWSGI | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/10-uwsgi/uwsgi.html) | (N) |
| 17:30 | When things go wrong: Galaxy Server Troubleshooting | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/22-troubleshooting/troubleshooting.html) | (N)(C)(S) |
| 18:00 | Close Afternoon Session | |  |

<!--
#### Extra (not planned to be covered in person)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 15:45 | Using public and private cloud compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/18-clouds/clouds.html) | (E)(G) |
| 9:40 | Get a basic Galaxy server up and running | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/02-basic-server/get-galaxy.html) | (A) |
| 13:15 | Configuration management choices: Introduction to Ansible | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/14-ansible/ansible-introduction.html) | (E) |
| 16:45 | Using and configuring external authentication services | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/13-external-auth/external-auth.html), [PAM Auth Exercise](sessions/13-external-auth/ex1-pam-auth.md), [Upstream Auth Exercise](sessions/13-external-auth/ex2-upstream-auth.md) | (N) |
| 13:15 | Running Jupyter in Galaxy with Galaxy Interactive Environments | [Exercise](sessions/21-gie/ex1-jupyter.md) | (B) |
| 16:45 | Using heterogeneous compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/17-heterogenous/heterogeneous.html), [Exercise](sessions/17-heterogenous/ex1-pulsar.md) | (M) |
| 16:30 | Server monitoring and maintenance: Admin UI, Log files, Direct database queries, command line & scripts, what to backup and how | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/slides.html), [Exercise 1](http://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/tutorial.html), [Exercise 2](sessions/22-troubleshooting/ex1-sentry.md) | (B)(M) |
| 11:00 | Containerize all the things: Galaxy in Docker and Docker in Galaxy | [Docker Slides](https://galaxy.slides.com/bgruening/the-galaxy-docker-project), [Conda Slides](http://galaxy.slides.com/bgruening/deck-7#/), [Galaxy Docker tool example](https://github.com/apetkau/galaxy-hackathon-2014/tree/master/smalt)| (B) |
| 15:45 | Controlling Galaxy with systemd and supervisor | [Slides](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/11-systemd-supervisor/systemd-supervisor.html), [Exercise](sessions/11-systemd-supervisor/ex1-supervisor.md) | (E) |
| 09:15 | Users, Groups, and Quotas | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/users-groups-quotas/slides.html) | (B) |
 -->

### Instructors

* (N)ate Coraor - Galaxy Project, Penn State University, USA
* (S)imon Gladman - Melbourne Bioinformatics, University of Melbourne, Australia
* (M)arius van den Beek - ELIXIR Galaxy WG, Institute Curie, Paris, France
* (C)arrie Ganote - Indiana University Bloomington, USA
* Nuwan (G)oonasekera - Melbourne Bioinformatics, University of Melbourne, Australia
* (E)nis Afgan - Galaxy Project, Johns Hopkins University, USA
* (J)ohn Chilton - Galaxy Project, Penn State University, USA
* Martin (Č)ech - Galaxy Project, Penn State University, USA
