![gatc2017_logo.png](docs/shared-images/gatc2017_logo.png)

# Galaxy Administrators Course

dagobah - The Solar System for Galaxy Training
> "The planet shown in Dagobah, in the Sluis sector, is a world of murky swamps, steaming bayous, and petrified forests."

---
**Melbourne - 6th to 9th February 2017**

[Event Logisitics]() | [Admin Training Home Page]()

jump to [Monday](#monday) | [Tuesday](#tuesday) | [Wednesday](#wednesday) | [Thursday](#thursday)

Built slides have [an index](https://galaxyproject.github.io/dagobah-training/2017-melbourne/).

### Instructors

* (N)ate Coraor - Galaxy Project, BMB, Penn State University, USA
* (S)imon Gladman - VLSCI, University of Melbourne, Australia
* (E)nis Afgan - Galaxy Project, Department of Biology, Johns Hopkins University, USA
* (B)jörn Grüning - Head of Freiburg Galaxy Team, University of Freiburg, Germany
* (R)oss Lazarus - Galaxy Project and formerly of Baker IDI, Australia.

List of instances for course:

[spreadsheet](https://docs.google.com/spreadsheets/d/1uaOpQcKNv6iOG8lbURW1_cFsLhrMrJivuQSh6Wfq7pM/edit?usp=sharing)

## Timetable
#### Monday
**6th February** - [Lab 14 Seminar Room, 700 Swanston St, Carlton, Victoria](https://goo.gl/maps/FD2cdrFeDfG2)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 08:30 | Registration |  |  |
| 09:15 | Welcome and introduction | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/00-intro/intro.html) | All |
| 09:30 | Deployment and platform options | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/01-deployment-platforms/choices.html) | (N) |
| 10:00 | Get a basic Galaxy server up and running | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/02-basic-server/get-galaxy.html) | (N) + (E)?) |
| 10:45 | **Morning break** | | |
| 11:00 | Galaxy server optional necessities: PostgreSQL and nginx | [First Steps Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/03-production-basics/production.html), [First Steps Exercise](sessions/03-production-basics/ex1-first-steps.md), [PostgreSQL Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/03-production-basics/databases.html), [PostgreSQL Exercise](sessions/03-production-basics/ex2-postgres.md),  [nginx/Apache Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/03-production-basics/webservers.html), [nginx Exercise](sessions/03-production-basics/ex3-nginx.md), [Apache Exercise](sessions/03-production-basics/ex4-apache.md) (for reference)| (N) + (E) |
| 12:15 | **Lunch** | | |
| 13:00 | Galaxy server optional necessities (continued)| | |
| 13:45 | Introduction to the Galaxy Tool Shed: Identifying and installing well-defined tools | [Slides (Shed)](https://galaxyproject.github.io/dagobah-training/2017-melbourne/04-tool-shed/shed_intro.html), [Slides (Tools)](https://galaxyproject.github.io/dagobah-training/2017-melbourne/04-tool-shed/tool_installation.html), [Slides (Dependencies)](https://galaxyproject.github.io/dagobah-training/2017-melbourne/04-tool-shed/tool-dependencies.html), [Exercise](sessions/04-tool-shed/ex-tool-management.md)| (B) |
| 15:00 | **Afternoon break** | | |
| 15:15 | Defining and importing genomes, Data Managers | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/05-reference-genomes/reference_genomes.html), [Exercise](sessions/05-reference-genomes/ex1-reference-genomes.md) | (S) |
| 16:50 | Extending your installation: FTP, SMTP, and more | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/06-extending-installation/extending.html), [Exercise](sessions/06-extending-installation/ex1-proftpd.md) | (N) |
| 18:00 | Close Day 1 | | All |

#### Tuesday
**7th February** - [Lab 14 Seminar Room, 700 Swanston St, Carlton, Victoria](https://goo.gl/maps/FD2cdrFeDfG2)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and questions |  | All |
| 09:15 | Users, Groups, and Quotas | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/07-users-groups-quotas/users-groups-quotas.html) | (S) |
| 10:30 | Upgrading to a new Galaxy release | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/08-upgrading-release/upgrading.html) | (E) + (R)? |
| 11:00 | **Morning break** | | |
| 11:15 | Updating tools and supporting multiple versions of tools | [Exercise](sessions/04-tool-shed/ex-tool-management.md) | (B) |
| 12:30 | **Lunch** | | |
| 13:15 | Improving the web serving experience with uWSGI | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/10-uwsgi/uwsgi.html) [Exercise](sessions/10-uwsgi/ex1-uwsgi.md) | (N) |
| 14:15 | Controlling Galaxy with systemd and supervisor | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/11-systemd-supervisor/systemd-supervisor.html), [Exercise](sessions/11-systemd-supervisor/ex1-supervisor.md) | (N) |
| 15:15 | **Afternoon break** | | |
| 15:30 | Server monitoring and maintenance: Admin UI, Log files, Direct database queries, command line & scripts, what to backup and how | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/12-monitoring-maintenance/monitoring-maintenance.html), [Exercise](sessions/12-monitoring-maintenance/ex1-reports.md) | (S) + (N) |
| 16:30 | Using and configuring external authentication services | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/13-external-auth/external-auth.html), [PAM Auth Exercise](sessions/13-external-auth/ex1-pam-auth.md), [Upstream Auth Exercise](sessions/13-external-auth/ex2-upstream-auth.md) | (N) |
| 17:45 | Questions and ad-hoc troubleshooting | | All |
| 18:00 | Close Day 2 | | All |

#### Wednesday
**8th February** - [Lab 14 Seminar Room, 700 Swanston St, Carlton, Victoria](https://goo.gl/maps/FD2cdrFeDfG2)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and questions |  | All |
| 09:15 | Configuration management choices: Introduction to Ansible | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/14-ansible/ansible-introduction.html), [Exercise](sessions/14-ansible/ex1-intro-ansible.md) | (S) |
| 10:00 | Using Ansible to deploy Galaxy I |  [Exercise](sessions/14-ansible/ex2-galaxy-ansible.md)| (S) |
| 10:30 | **Morning break** | | |
| 10:45 | Using Ansible to deploy Galaxy II |  | (S) + (N) |
| 12:20 | **Lunch** | | |
| 13:05 | Exploring the Galaxy job configuration file | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/15-job-conf/job_conf.html) | (N) |
| 13:50 | Connecting Galaxy to a compute cluster I | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/16-compute-cluster/compute-cluster.html), [Exercise 1](sessions/16-compute-cluster/ex1-slurm.md), [Exercise 2](sessions/16-compute-cluster/ex2-advanced-job-configs.md) | (N)|
| 15:30 | **Afternoon break** | | |
| 15:45 | Connecting Galaxy to a compute cluster II |  | (N) |
| 16:30 | Using heterogeneous compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/17-heterogenous/heterogeneous.html), [Exercise](sessions/17-heterogenous/ex1-pulsar.md) | (N) |
| 17:30 | Using public and private cloud compute resources | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/18-clouds/clouds.html) | (E) |
| 18:00 | Close day 3 | | All |

**We will most likely all go out for dinner together somewhere local tonight**

#### Thursday
**9th February** - [Lab 14 Seminar Room, 700 Swanston St, Carlton, Victoria](https://goo.gl/maps/FD2cdrFeDfG2)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:00 | Welcome and questions |  | All |
| 09:15 | Storage management and using heterogeneous storage services | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/19-storage/storage.html), [Exercise](sessions/19-storage/ex1-objectstore.md) | (N) |
| 10:30 | **Morning break** | | |
| 10:50 | Containerize all the things: Galaxy in Docker and Docker in Galaxy | [Docker Slides](https://galaxy.slides.com/bgruening/the-galaxy-docker-project) [Conda Slides](http://galaxy.slides.com/bgruening/deck-7#/) | (B) |
| 12:30 | **Lunch** | | |
| 13:15 | Running Jupyter in Galaxy with Galaxy Interactive Environments | [Exercise](sessions/21-gie/ex1-jupyter.md) | (B) + (N) |
| 14:30 | When things go wrong: Galaxy Server Troubleshooting | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/22-troubleshooting/troubleshooting.html) | (N) |
| 15:30 | **Afternoon break** | | |
| 15:45 | OPEN: Submitted topics | [link to nomination document](https://docs.google.com/document/d/1PTPulqS_Ki7DPmYYoUsdvfHyeJRQBP8jOS6kRl7_fZ4/edit?usp=sharing), [uWSGI Zerg Mode](https://gist.github.com/natefoo/9dc5c349350770094c9fb14259e5c88a) | |
| 16:45 | Galaxy server architecture | [Slides](https://galaxyproject.github.io/dagobah-training/2017-melbourne/23-architecture/galaxy_architecture.html) | |
| 18:00 | Wrap up and close | | All |
