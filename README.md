![gat_pennstate_logo_wtext.png](docs/shared-images/gat_pennstate_logo_wtext.png)
# Intro to Galaxy Administration @ Pennsylvania State University

**Monday 1/28/2019 - Friday 2/1/2019**

- [Timetable](#timetable)
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

List of training instances is available in https://bit.ly/gadminmachines. Please pick one instance and enter your name in the user column.

We are using instances from the [Jetstream cloud](https://jetstream-cloud.org/) with 2 cores, 4 GiB memory, 20 GiB disk, running a minimal Ubuntu 18.04 image

The instances have been bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Timetable

_Timetable with sessions and material is being continuously updated._

### Monday
**28th January**

| **Time** | **Topic**                                | **Slides**                                             | **Exercises**                | **Instructor** |
| -------- | ---------                                | ---------                                              | -----------                  | -----------    |
| 08:30    | Registration                             |                                                        |                              |                |
| 09:00    | Welcome and introduction                 | [Welcome][welcome-slides]                              |                              | All            |
| 09:20    | Deployment and platform options          | [Deployment][deployment-slides]                        |                              | M              |
| 09:40    | Intro to Ansible                         | [Ansible][ansible-slides]                              | [Exercise][ansible-exercise] | S              |
| 10:30    | Break (coffee & snacks)                  |                                                        |                              |                |
| 10:45    | Galaxy Server Part 1: Basic Install      | [Database][db-slides], [uWSGI][uwsgi-slides]           | [Exercise][ansible-galaxy]   | H              |
| 12:30    | Lunch (catered)                          |                                                        |                              |                |
| 13:30    | Galaxy Server Part 2: Towards Production | [NGINX][nginx-slides], [Supervisor][supervisor-slides] |                              | H              |
| 15:30    | Break (coffee & snacks)                  |                                                        |                              |                |
| 15:50    | Galaxy Server Part 3: Advanced Install   | [Production][production-slides]                        |                              | H              |
| 17:00    | Close Day 1                              |                                                        |                              |                |

[welcome-slides]:      https://galaxyproject.github.io/dagobah-training/2019-pennstate/00-intro/intro.html
[deployment-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/deployment-platforms-options/slides.html#1
[ansible-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[db-slides]:           https://galaxyproject.github.io/training-material/topics/admin/tutorials/database/slides.html
[ansible-galaxy]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[production-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/production/slides.html
[nginx-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/webservers/slides.html
[uwsgi-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/uwsgi/slides.html
[supervisor-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/systemd-supervisor/slides.html


### Tuesday
**29th January**

| **Time** | **Topic**                 | **Slides**                                        | **Exercises**                                                     | **Instructor** |
| -------- | ---------                 | ---------                                         | -----------                                                       | -----------    |
| 09:00    | Welcome and questions     |                                                   |                                                                   |                |
| 09:15    | Galaxy Tool Shed          | [Tools][tool-slides], [Toolshed][toolshed-slides] |                                                                   | H, S, M        |
| 10:00    | Ephemeris                 | [Ephemeris][ephemeris-slides]                     | [Exercise][ephemeris-exercise]                                    | J, M           |
| 10:30    | Break (coffee & snacks)   |                                                   |                                                                   |                |
| 10:50    | Ephemeris: Continued      |                                                   |                                                                   | M, H           |
| 12:00    | Lunch (catered)           |                                                   |                                                                   |                |
| 13:00    | Users, Groups, and Quotas | [Slides][users-groups-slides]                     |                                                                   | M              |
| 14:00    | Reference Data            | [Slides][ref-genomes-slides]                      | [Exercise][ref-genome-exercise], [CMVFS Exercise][cvmfs-exercise] | S              |
| 16:15    | External authentication   | [Slides][pam-slides]                              | [Upstream Auth Exercise][upstream-auth-exercise]                  | H              |
| 17:00    | Close Day 2               |                                                   |                                                                   |                |

[tool-slides]:              https://galaxyproject.github.io/training-material/topics/admin/tutorials/tool-install/slides.html
[toolshed-slides]:          https://galaxyproject.github.io/training-material/topics/admin/tutorials/toolshed/slides.html
[ephemeris-slides]:         https://galaxyproject.github.io/training-material/topics/admin/tutorials/tool-management/slides.html
[ephemeris-exercise]:       https://galaxyproject.github.io/training-material/topics/admin/tutorials/tool-management/tutorial.html
[users-groups-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/users-groups-quotas/slides.html
[ref-genomes-slides]:       https://galaxyproject.github.io/training-material/topics/admin/tutorials/reference-genomes/slides.html
[ref-genome-exercise]:      sessions/05-reference-genomes/ex1-reference-genomes.md
[cvmfs-exercise]:           https://galaxyproject.github.io/training-material/topics/admin/tutorials/cvmfs/tutorial.html
[pam-slides]:               https://galaxyproject.github.io/training-material/topics/admin/tutorials/external-auth/slides.html
[upstream-auth-exercise]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/upstream-auth/tutorial.html

### Wednesday
**30th January**

| **Time** | **Topic**                                   | **Slides**                | **Exercises**                | **Instructor** |
| -------- | ---------                                   | ---------                | -----------                  | -----------    |
| 09:00    | Welcome and questions                       |                          |                              |                |
| 09:15    | Exploring the Galaxy job configuration file | [Slides][jobconf-slides] |                              | J              |
| 09:45    | Connecting Galaxy to a compute cluster      | [Slides][cluster-slides] | [Exercise][cluster-exercise] | N, H           |
| 10:20    | Break (coffee & snacks)                     |                          |                              |                |
| 10:40    | Compute cluster (continued)                 |                          |                              |                |
| 12:00    | Lunch (on your own)                         |                          |                              |                |
| 13:30    | Using heterogeneous compute resources       | [Slides][hetero-slides]  | [Exercise][hetero-exercise]  | S, N           |
| 15:15    | Break (coffee & snacks)                     |                          |                              |                |
| 15:35    | compute resources continued                 |                          |                              |                |
| 17:00    | Close day 3                                 |                          |                              |                |

[jobconf-slides]:     https://galaxyproject.github.io/training-material/topics/admin/tutorials/job-conf/slides.html
[cluster-slides]:     https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html
[hetero-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html
[hetero-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html

### Thursday
**31th January**

| **Time** | **Topic**                                                                            | **Slides**                     | **Exercises**                   | **Instructor** |
| -------- | ---------                                                                            | ---------                      | -------------                   | -----------    |
| 09:00    | Welcome and questions                                                                |                                |                                 |                |
| 09:15    | Compute Resources: Continued (Job Resources)                                         |                                |                                 | N              |
| 10:45    | Break (coffee & snacks)                                                              |                                |                                 |                |
| 11:00    | Containerize all the things: Galaxy in Docker and Docker in Galaxy                   | [Docker Slides][docker-slides] |                                 | J              |
| 12:00    | Lunch (catered)                                                                      |                                |                                 |                |
| 13:00    | Cloudbursting showcase                                                               | [Cloud slides][clouds-everywhere]                               |                                 | S              |
| 13:30    | Storage management                                                                   | [Slides][storage-slides]       | [Exercise][storage-exercise]    | M, S           |
| 14:30    | Server Monitoring and Maintenance Part 1: Telegraf, InfluxDB, Grafana                | [Slides][monitoring-slides]    | [Telegraf Exercise][monitoring-exercise] [Reports Exercise][monitoring-reports]| M, H           |
| 15:15    | Break (coffee & snacks)                                                              |                                |                                 |                |
| 15:30    | Server Monitoring and Maintenance Part 2: DB queries, command line & scripts, backup |                                | [gxadmin][gxadmin-exercise]     |                |
| 17:00    | Wrap up and close                                                                    |                                |                                 |                |

[docker-slides]:       https://galaxyproject.github.io/training-material/topics/admin/tutorials/galaxy-docker/slides.html
[monitoring-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring/slides.html
[monitoring-exercise]: https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring/tutorial.html
[storage-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/object-store/slides.html
[storage-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/object-store/tutorial.html
[gxadmin-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[monitoring-reports]:  https://galaxyproject.github.io/training-material/topics/admin/tutorials/reports/tutorial.html
[clouds-everywhere]:   https://galaxyproject.github.io/dagobah-training/2019-pennstate/18-clouds/clouds.html#1

### Friday
**1st February**

| **Time** | **Topic**                                           | **Slides**                       | **Exercises**                 | **Instructor** |
| -------- | ---------                                           | ---------                        | -----------                   | -----------    |
| 09:00    | Welcome and questions                               |                                  |                               |                |
| 09:15    | Dockerizing a Galaxy Tool                           |                                  | [Exercise][docker-exercise]   | J              |
| 10:00    | Break (coffee & snacks)                             |                                  |                               |                |
| 10:15    | What's new in Galaxy?                               | [Slides][whats-new]              |                             | N, J           |
| 10:40    | Upgrading Galaxy                               | [Slides][upgrade]              |                             | M           |
| 11:00    | Telegraf                                            |                                  | [Exercise][telegraf-exercise] | H              |
| 11:30    | gxadmin                                             |                                  | [Exercise][gxadmin-exercise]  | H              |
| 11:50    | Empathy                                             | [Slides][empathy-slides]         |                               | H              |
| 12:00    | Lunch (catered)                                     |                                  |                               |                |
| 13:00    | When things go wrong: Galaxy Server Troubleshooting | [Slides][troubleshooting-slides] |                               | N              |
| 15:00    | Wrap up and close                                   |                                  |                               |                |

[whats-new]:              http://bit.ly/gxwhatsnew2019
[updating-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/upgrading/slides.html#1
[troubleshooting-slides]: https://galaxyproject.github.io/training-material/topics/admin/tutorials/troubleshooting/slides.html
[docker-exercise]:        https://github.com/galaxyproject/dagobah-training/pull/84/commits/7c9722a2ceaf46d15ea859a16f77bb047c2f42c5
[empathy-slides]:         https://galaxyproject.github.io/training-material/topics/admin/tutorials/empathy/slides.html
[telegraf-exercise]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring/tutorial.html
[gxadmin-exercise]:       https://galaxyproject.github.io/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[upgrade]:                https://galaxyproject.github.io/training-material/topics/admin/tutorials/upgrading/slides.html
### Instructors

* (S)imon Gladman - Melbourne Bioinformatics, University of Melbourne, Australia
* (H)elena Rasche - ELIXIR Galaxy WG, Elixir Germany, de.NBI, University of Freiburg, Germany
* (N)ate Coraor - Galaxy Project, Penn State University, USA
* (J)ohn Chilton - Galaxy Project, Penn State University, USA
* (M)artin Čech - Galaxy Project, Penn State University, USA
