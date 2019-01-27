![gat_pennstate_logo_wtext.png](docs/shared-images/gat_pennstate_logo_wtext.png)
# Intro to Galaxy Administration @ Pennsylvania State University

**Monday 1/28/2019 - Friday 2/1/2019**

- Index
	- [Monday](#monday)
	- [Tuesday](#tuesday)
	- [Wednesday](#wednesday)
	- [Thursday](#thursday)
	- [Friday](#friday)
- [Slide Index](https://galaxyproject.github.io/dagobah-training/2019-pennstate/)
- [Join the Discussion](https://gitter.im/dagobah-training/Lobby)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Location

**Room W306, Millennium Science Complex** - [map](https://goo.gl/maps/1WwT15jfi5y)
Penn State University, State College, Pennsylvania, USA

## Training VM instances

List of training instances is available in [TODO]. Please pick one instance and enter your name in the user column.

We are using instances from the [Jetstream cloud](https://jetstream-cloud.org/) with 2 cores, 4 GiB memory, 20 GiB disk, running Ubuntu 18.04

## Timetable

_Timetable with sessions and material will be continuously updated towards the workshop._

### Monday
**28th January**

| **Time** | **Topic**                                | **Links**                                                                                          | **Instructor** |
| -------- | ---------                                | ---------                                                                                          | -----------    |
| 08:30    | Registration                             |                                                                                                    |                |
| 09:00    | Welcome and introduction                 | [Slides][welcome-slides]                                                                           | All            |
| 09:20    | Deployment and platform options          | [Slides][deployment-slides]                                                                        | M              |
| 09:40    | Intro to Ansible                         | [Slides][ansible-slides], [Exercise][ansible-exercise]                                             | S              |
| 10:30    | Break (coffee & snacks)                  |                                                                                                    |                |
| 10:45    | Galaxy Server Part 1: Basic Install      | [Database Slides][db-slides], [Exercise][ansible-galaxy]                                           | H              |
| 12:30    | Lunch (catered)                          |                                                                                                    |                |
| 13:30    | Galaxy Server Part 2: Towards Production | [Production Slides][production-slides]                                                             | H              |
| 15:30    | Break (coffee & snacks)                  |                                                                                                    |                |
| 15:50    | Galaxy Server Part 3: Advanced Install   | [NGINX Slides][nginx-slides], [uWSGI Slides][uwsgi-slides], [Supervisor Slides][supervisor-slides] | H              |
| 17:00    | Close Day 1                              |                                                                                                    |                |

[welcome-slides]:      https://galaxyproject.github.io/dagobah-training/2019-pennstate/00-intro/intro.html
[deployment-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/deployment-platforms-options/slides.html#1
[ansible-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[db-slides]:           https://galaxyproject.github.io/dagobah-training/2019-pennstate/03-production-basics/databases.html
[ansible-galaxy]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[production-slides]:   https://galaxyproject.github.io/dagobah-training/2019-pennstate/03-production-basics/production.html
[nginx-slides]:        https://galaxyproject.github.io/dagobah-training/2019-pennstate/03-production-basics/webservers.html
[uwsgi-slides]:        https://galaxyproject.github.io/dagobah-training/2019-pennstate/10-uwsgi/uwsgi.html
[supervisor-slides]:   https://galaxyproject.github.io/dagobah-training/2019-pennstate/11-systemd-supervisor/systemd-supervisor.html

### Tuesday
**29th January**

| **Time** | **Topic**                 | **Links**                                                                                                 | **Instructor** |
| -------- | ---------                 | ---------                                                                                                 | -----------    |
| 09:00    | Welcome and questions     |                                                                                                           |                |
| 09:15    | Galaxy Tool Shed          | [Tools][tool-slides], [Toolshed][toolshed-slides]                                                         | H, S, M        |
| 10:00    | Ephemeris                 | [Slides][ephemeris-slides]                                                                                | J, M           |
| 10:30    | Break (coffee & snacks)   |                                                                                                           |                |
| 10:50    | Managing Galaxy tools     | [Exercise][ephemeris-exercise]                                                                            | M, H           |
| 12:00    | Lunch (catered)           |                                                                                                           |                |
| 13:00    | Users, Groups, and Quotas | [Slides][users-groups-slides]                                                                             | M              |
| 14:00    | Reference Data            | [Slides][ref-genomes-slides], [Exercise][ref-genome-exercise], [CMVFS Exercise][cvmfs-exercise]           | S              |
| 16:15    | External authentication   | [Slides][pam-slides], [PAM Auth Exercise][pam-exercise], [Upstream Auth Exercise][upstream-auth-exercise] | H              |
| 17:00    | Close Day 2               |                                                                                                           |                |

[tool-slides]:              https://galaxyproject.github.io/dagobah-training/2019-pennstate/04-tool-shed/tool_installation.html
[toolshed-slides]:          https://galaxyproject.github.io/dagobah-training/2019-pennstate/04-tool-shed/shed_intro.html
[ephemeris-slides]:         https://galaxyproject.github.io/training-material/topics/admin/tutorials/tool-management/tutorial.html
[ephemeris-exercise]:       https://galaxyproject.github.io/training-material/topics/admin/tutorials/tool-management/tutorial.html
[users-groups-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/users-groups-quotas/slides.html
[ref-genomes-slides]:       https://galaxyproject.github.io/dagobah-training/2019-pennstate/05-reference-genomes/reference_genomes.html
[ref-genome-exercise]:      sessions/05-reference-genomes/ex1-reference-genomes.md
[cvmfs-exercise]:           https://galaxyproject.github.io/training-material/topics/admin/tutorials/cvmfs/tutorial.html
[pam-slides]:               https://galaxyproject.github.io/dagobah-training/2019-pennstate/13-external-auth/external-auth.html
[pam-exercise]:             sessions/13-external-auth/ex1-pam-auth.md
[upstream-auth-exercise]:   sessions/13-external-auth/ex2-upstream-auth.md

### Wednesday
**30th January**

| **Time** | **Topic**                                   | **Links**                                              | **Instructor** |
| -------- | ---------                                   | ---------                                              | -----------    |
| 09:00    | Welcome and questions                       |                                                        |                |
| 09:15    | Exploring the Galaxy job configuration file | [Slides][jobconf-slides]                               | J              |
| 09:45    | Connecting Galaxy to a compute cluster      | [Slides][cluster-slides], [Exercise][cluster-exercise] | N, H           |
| 10:20    | Break (coffee & snacks)                     |                                                        |                |
| 10:40    | Compute cluster (continued)                 |                                                        |                |
| 12:00    | Lunch (on your own)                         |                                                        |                |
| 13:30    | Storage management                          | [Slides][storage-slides], [Exercise][storage-exercise] | M, S           |
| 14:15    | Using heterogeneous compute resources       | [Slides][hetero-slides], [Exercise][hetero-exercise]   | S, N           |
| 15:15    | Break (coffee & snacks)                     |                                                        |                |
| 15:35    | compute resources continued                 |                                                        |                |
| 17:00    | Close day 3                                 |                                                        |                |

[jobconf-slides]:     https://galaxyproject.github.io/dagobah-training/2019-pennstate/15-job-conf/job_conf.html
[cluster-slides]:     https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html
[storage-slides]:     https://galaxyproject.github.io/training-material/topics/admin/tutorials/object-store/slides.html
[storage-exercise]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/object-store/tutorial.html
[hetero-slides]:      https://galaxyproject.github.io/dagobah-training/2019-pennstate/17-heterogenous/heterogeneous.html
[hetero-exercise]:    sessions/17-heterogenous/ex1-pulsar.md

### Thursday
**31th January**

| **Time** | **Topic**                                                          | **Links**                                                                                                   | **Instructor** |
| -------- | ---------                                                          | ---------                                                                                                   | -----------    |
| 09:00    | Welcome and questions                                              |                                                                                                             |                |
| 09:15    | Containerize all the things: Galaxy in Docker and Docker in Galaxy | [Docker Slides][docker-slides], [Conda Slides][conda-slides], [Galaxy Docker tool example][docker-exercise] | J              |
| 10:45    | Break (coffee & snacks)                                            |                                                                                                             |                |
| 11:00    | Galaxy Interactive Environments                                    |                                                                                                             | H              |
| 12:00    | Lunch (catered)                                                    |                                                                                                             |                |
| 13:00    | Cloudbursting                                                      |                                                                                                             | S              |
| 14:00    | Server monitoring and maintenance                                  | [Slides][monitoring-slides], [Exercise 1][monitoring-ex1], [Exercise 2][monitoring-ex2]                     | M, H           |
| 15:15    | Break (coffee & snacks)                                            |                                                                                                             |                |
| 15:30    | monitoring & maintenance continued                                 |                                                                                                             |                |
| 17:00    | Wrap up and close                                                  |                                                                                                             |                |

[docker-slides]:       https://galaxy.slides.com/bgruening/the-galaxy-docker-project
[conda-slides]:        http://galaxy.slides.com/bgruening/deck-7#/
[docker-exercise]:     https://github.com/apetkau/galaxy-hackathon-2014/tree/master/smalt
[monitoring-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/slides.html
[monitoring-ex1]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring-maintenance/tutorial.html
[monitoring-ex2]:      sessions/22-troubleshooting/ex1-sentry.md


### Friday
**1st February**

| **Time** | **Topic**                                           | **Links**                        | **Instructor** |
| -------- | ---------                                           | ---------                        | -----------    |
| 09:00    | Welcome and questions                               |                                  |                |
| 09:15    | Upgrading to a new Galaxy release                   | [Slides][updating-slides]        | M              |
| 10:00    | Break (coffee & snacks)                             |                                  |                |
| 10:15    | What's newer than year?                             |                                  | N, J           |
| 12:00    | Lunch (catered)                                     |                                  |                |
| 13:00    | When things go wrong: Galaxy Server Troubleshooting | [Slides][troubleshooting-slides] | N              |
| 15:00    | Wrap up and close                                   |                                  |                |

[updating-slides]: https://galaxyproject.github.io/training-material/topics/admin/tutorials/upgrading/slides.html#1
[troubleshooting-slides]: https://galaxyproject.github.io/dagobah-training/2019-pennstate/22-troubleshooting/troubleshooting.html

### Instructors

* (S)imon Gladman - Melbourne Bioinformatics, University of Melbourne, Australia
* (H)elena Rasche - ELIXIR Galaxy WG, Elixir Germany, de.NBI, University of Freiburg, Germany
* (N)ate Coraor - Galaxy Project, Penn State University, USA
* (J)ohn Chilton - Galaxy Project, Penn State University, USA
* (M)artin Čech - Galaxy Project, Penn State University, USA
