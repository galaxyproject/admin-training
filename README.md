![gat_pennstate_logo_wtext.png](docs/shared-images/gat_pennstate_logo_wtext.png)
# Pennsylvania State University - Intro to Galaxy Administration

**Pennsylvania State University, State College, PA; Monday 1/28/2019 - Friday 2/1/2019**

jump to [Monday](#monday) | [Tuesday](#tuesday) | [Wednesday](#wednesday) | [Thursday](#thursday) | [Friday](#friday)

Built slides have [an index](https://galaxyproject.github.io/dagobah-training/2018-gccbosc/).

Join the chat at https://gitter.im/dagobah-training/Lobby

[Galaxy Training material](http://galaxyproject.github.io/training-material/)

### Location

TBA, State College, Pennsylvania, USA

## Training VM instances

TODO fill this section

List of training instances is available in [TODO]. Please pick one instance and enter your name in the user column.

2 cores, 4 GiB memory, and 20 GiB disk, Ubuntu 16.04

We are using instances from the [Jetstream cloud](https://jetstream-cloud.org/), image ID _acb53109-941f-4593-9bf8-4a53cb9e0739_.

## Timetable

_Timetable with sessions and material will be continuously updated towards the workshop._


#### Monday
**28th January**

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 08:30 | Registration |  |  |
| 09:15 | Welcome and introduction | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/00-intro/intro.html) | All |
| 09:45 | Deployment and platform options | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/deployment-platforms-options/slides.html) | (B) |
| 10:45 | **Morning break** | | |
| 11:00 | Get a basic Galaxy server up and running | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/02-basic-server/get-galaxy.html) | (A) |
| 12:00 | Galaxy server optional necessities: PostgreSQL and nginx | [First Steps Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/03-production-basics/production.html), [First Steps Exercise](sessions/03-production-basics/ex1-first-steps.md), [PostgreSQL Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/03-production-basics/databases.html), [PostgreSQL Exercise](sessions/03-production-basics/ex2-postgres.md),  [nginx/Apache Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/03-production-basics/webservers.html), [nginx Exercise](sessions/03-production-basics/ex3-nginx.md), [Apache Exercise](sessions/03-production-basics/ex4-apache.md) (for reference)| (N) |
| 12:30 | **Lunch** | | |
| 13:15 | Galaxy server optional necessities: PostgreSQL and nginx (continued) | | (N) |
| 15:15 | **Afternoon break** | | |
| 15:30 | Defining and importing genomes, Data Managers | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/05-reference-genomes/reference_genomes.html), [Exercise](sessions/05-reference-genomes/ex1-reference-genomes.md) | (E) |
| 17:00 | Extending your installation: FTP, SMTP, and more | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/06-extending-installation/extending.html), [Exercise](sessions/06-extending-installation/ex1-proftpd.md) | (A) |
| 18:00 | Close Day 1 | | All |


#### Tuesday
**29th January**

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and questions |  | All |
| 09:15 | Users, Groups, and Quotas | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/users-groups-quotas/slides.html) | (B) |
| 10:45 | **Morning break** | | |
| 11:00 | Introduction to the Galaxy Tool Shed: Identifying and installing well-defined tools | [Slides (Shed)](https://galaxyproject.github.io/dagobah-training/2019-pennstate/04-tool-shed/shed_intro.html), [Slides (Tools)](https://galaxyproject.github.io/dagobah-training/2019-pennstate/04-tool-shed/tool_installation.html), [Slides (Dependencies)](https://galaxyproject.github.io/dagobah-training/2019-pennstate/04-tool-shed/tool-dependencies.html)| (M) |
| 12:30 | **Lunch** | | |
| 13:15 | Updating tools and supporting multiple versions of tools | [Exercise](sessions/04-tool-shed/ex-tool-management.md) | (M) |
| 14:30 | Improving the web serving experience with uWSGI | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/10-uwsgi/uwsgi.html), [Exercise](sessions/10-uwsgi/ex1-uwsgi.md) | (B) |
| 15:30 | **Afternoon break** | | |
| 15:45 | Controlling Galaxy with systemd and supervisor | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/11-systemd-supervisor/systemd-supervisor.html), [Exercise](sessions/11-systemd-supervisor/ex1-supervisor.md) | (E) |
| 16:45 | Using and configuring external authentication services | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/13-external-auth/external-auth.html), [PAM Auth Exercise](sessions/13-external-auth/ex1-pam-auth.md), [Upstream Auth Exercise](sessions/13-external-auth/ex2-upstream-auth.md) | (N) |
| 18:00 | Close Day 2 | | All |

**Free common dinner at 7pm at [Elias mat og sånt](http://www.cafeelias.no/nb/) located downtown.**


#### Wednesday
**30th January**

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and questions |  | All |
| 09:15 | Exploring the Galaxy job configuration file | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/15-job-conf/job_conf.html) | (N) |
| 09:50 | Connecting Galaxy to a compute cluster | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html), [Exercise](http://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html) | (B) |
| 10:45 | **Morning break** | | |
| 11:00 | Connecting Galaxy to a compute cluster (continued) |  | (B) |
| 12:30 | **Lunch** | | |
| 13:15 | Configuration management choices: Introduction to Ansible | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/14-ansible/ansible-introduction.html) | (E) |
| 14:00 | Using Ansible to deploy Galaxy | [Exercise 1](sessions/14-ansible/ex1-intro-ansible.md), [Exercise 2](sessions/14-ansible/ex2-galaxy-ansible.md) | (E) |
| 15:30 | **Afternoon break** | | |
| 15:45 | Using Ansible to deploy Galaxy (continued) | | (E) |
| 16:45 | Using heterogeneous compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/17-heterogenous/heterogeneous.html), [Exercise](sessions/17-heterogenous/ex1-pulsar.md) | (M) |
| 18:00 | Close day 3 | | All |


#### Thursday
**31th January**

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and questions |  | All |
| 09:15 | Storage management and using heterogeneous storage services | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/19-storage/storage.html), [Exercise](sessions/19-storage/ex1-objectstore.md) | (E) |
| 10:45 | **Morning break** | | |
| 11:00 | Containerize all the things: Galaxy in Docker and Docker in Galaxy | [Docker Slides](https://galaxy.slides.com/bgruening/the-galaxy-docker-project), [Conda Slides](http://galaxy.slides.com/bgruening/deck-7#/), [Galaxy Docker tool example](https://github.com/apetkau/galaxy-hackathon-2014/tree/master/smalt)| (B) |
| 12:30 | **Lunch** | | |
| 13:15 | Running Jupyter in Galaxy with Galaxy Interactive Environments | [Exercise](sessions/21-gie/ex1-jupyter.md) | (B) |
| 15:30 | **Afternoon break** | | |
| 15:45 | Using public and private cloud compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/18-clouds/clouds.html) | (E) |
| 16:30 | Server monitoring and maintenance: Admin UI, Log files, Direct database queries, command line & scripts, what to backup and how | [Slides](http://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/slides.html), [Exercise 1](http://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/tutorial.html), [Exercise 2](sessions/22-troubleshooting/ex1-sentry.md) | (B,M) |
| 18:00 | Wrap up and close | | All |


#### Friday
**2nd February**

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and questions |  | All |
| 09.15 | OPEN: Lightning talks | | Trainees |
| 10:15 | Upgrading to a new Galaxy release | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/08-upgrading-release/upgrading.html) | (N) |
| 10:45 | **Morning break** | | |
| 11.00 | What's new in Galaxy 18.01? | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/whatsnew/18.01.html) | (N) |
| 12:30 | **Lunch** | | |
| 13:15 | **Trainees' feedback survey** | [Form](https://skjema.uio.no/galaxy-admin-workshop-2018-eva) | Trainees |
| 13:30 | When things go wrong: Galaxy Server Troubleshooting | [Slides](https://galaxyproject.github.io/dagobah-training/2019-pennstate/22-troubleshooting/troubleshooting.html) | (M) |
| 15:30 | Wrap up and close | | All |

### Instructors

* (N)ate Coraor - Galaxy Project, Penn State University, USA
* (J)ohn Chilton - Galaxy Project, Penn State University, USA
* (M)artin Čech - Galaxy Project, Penn State University, USA
