# Intro to Galaxy Administration @ Barcelona

**2-6 March 2020**

- [Timetable](#timetable)
	- [Monday](#monday)
	- [Tuesday](#tuesday)
	- [Wednesday](#wednesday)
	- [Thursday](#thursday)
	- [Friday](#friday)
- [Slide Index](https://galaxyproject.github.io/dagobah-training/2019-pennstate/)
- [Join the Discussion](https://gitter.im/dagobah-training/Lobby)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Location, Logistics, and Registration

**This training will be offered 2-6 March at the [Barcelona Supercomputing Center](https://www.bsc.es/).**

See the [workshop's Galaxy Community Hub page](https://galaxyproject.org/events/2020-03-admin/) for details on logistics and registration.

## Training VM instances

Galaxy training instances will be bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Timetable

_Timetable with sessions and material is being continuously updated._

### Monday
**2nd March**

| **Time** | **Topic**                                | **Slides**                                             | **Exercises**                | **Instructor** |
| -------- | ---------                                | ---------                                              | -----------                  | -----------    |
| 08:30    | Registration                             |                                                        |                              |                |
| 09:00    | Welcome and introduction                 | [Welcome][welcome-slides]                              |                              | All            |
| 09:20    | Deployment and platform options          | [Deployment][deployment-slides]                        |                              |                |
| 09:40    | Intro to Ansible                         | [Ansible][ansible-slides]                              | [Exercise][ansible-exercise] |                |
| 10:30    | Break (coffee & snacks)                  |                                                        |                              |                |
| 10:45    | Galaxy Server Part 1: Basic Install      | [Database][db-slides], [uWSGI][uwsgi-slides]           | [Exercise][ansible-galaxy]   |                |
| 12:30    | Lunch (catered)                          |                                                        |                              |                |
| 13:30    | Galaxy Server Part 2: Towards Production | [NGINX][nginx-slides], [Supervisor][supervisor-slides] |                              |                |
| 15:30    | Break (coffee & snacks)                  |                                                        |                              |                |
| 15:50    | Galaxy Server Part 3: Advanced Install   | [Production][production-slides]                        |                              |                |
| 17:00    | Close Day 1                              |                                                        |                              |                |

[welcome-slides]:      https://galaxyproject.github.io/dagobah-training/2019-pennstate/00-intro/intro.html
[deployment-slides]:   https://galaxyproject.github.io/training-material/topics/admin/slides/introduction.html
[ansible-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[db-slides]:           https://galaxyproject.github.io/training-material/topics/admin/tutorials/database/slides.html
[ansible-galaxy]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[production-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/production/slides.html
[nginx-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/webservers/slides.html
[uwsgi-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/uwsgi/slides.html
[supervisor-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/systemd-supervisor/slides.html


### Tuesday
**3rd March**

| **Time** | **Topic**                 | **Slides**                                        | **Exercises**                                                     | **Instructor** |
| -------- | ---------                 | ---------                                         | -----------                                                       | -----------    |
| 09:00    | Welcome and questions     |                                                   |                                                                   |                |
| 09:15    | Galaxy Tool Shed          | [Tools][tool-slides], [Toolshed][toolshed-slides] |                                                                   |                |
| 10:00    | Ephemeris                 | [Ephemeris][ephemeris-slides]                     | [Exercise][ephemeris-exercise]                                    |                |
| 10:30    | Break (coffee & snacks)   |                                                   |                                                                   |                |
| 10:50    | Ephemeris: Continued      |                                                   |                                                                   |                |
| 12:00    | Lunch (catered)           |                                                   |                                                                   |                |
| 13:00    | Users, Groups, and Quotas | [Slides][users-groups-slides]                     |                                                                   |                |
| 14:00    | Reference Data            | [Slides][ref-genomes-slides]                      | [Exercise][ref-genome-exercise], [CMVFS Exercise][cvmfs-exercise] |                |
| 16:15    | External authentication   | [Slides][pam-slides]                              | [Upstream Auth Exercise][upstream-auth-exercise]                  |                |
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
**4th March**

| **Time** | **Topic**                                   | **Slides**               | **Exercises**                | **Instructor** |
| -------- | ---------                                   | ---------                | -----------                  | -----------    |
| 09:00    | Welcome and questions                       |                          |                              |                |
| 09:15    | Exploring the Galaxy job configuration file | [Slides][jobconf-slides] |                              |                |
| 09:45    | Connecting Galaxy to a compute cluster      | [Slides][cluster-slides] | [Exercise][cluster-exercise] |                |
| 10:20    | Break (coffee & snacks)                     |                          |                              |                |
| 10:40    | Compute cluster (continued)                 |                          |                              |                |
| 12:00    | Lunch (on your own)                         |                          |                              |                |
| 13:30    | Using heterogeneous compute resources       | [Slides][hetero-slides]  | [Exercise][hetero-exercise]  |                |
| 15:15    | Break (coffee & snacks)                     |                          |                              |                |
| 15:35    | compute resources continued                 |                          |                              |                |
| 17:00    | Close day 3                                 |                          |                              |                |

[jobconf-slides]:     https://galaxyproject.github.io/training-material/topics/admin/tutorials/job-conf/slides.html
[cluster-slides]:     https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html
[hetero-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html
[hetero-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html

### Thursday
**5th March**

| **Time** | **Topic**                                                                            | **Slides**                        | **Exercises**                                                                   | **Instructor** |
| -------- | ---------                                                                            | ---------                         | -------------                                                                   | -----------    |
| 09:00    | Welcome and questions                                                                |                                   |                                                                                 |                |
| 09:15    | Compute Resources: Continued (Job Resources)                                         |                                   |                                                                                 |                |
| 10:45    | Break (coffee & snacks)                                                              |                                   |                                                                                 |                |
| 11:00    | Containerize all the things: Galaxy in Docker and Docker in Galaxy                   | [Docker Slides][docker-slides]    |                                                                                 |                |
| 12:00    | Lunch (catered)                                                                      |                                   |                                                                                 |                |
| 13:00    | Cloudbursting showcase                                                               | [Cloud slides][clouds-everywhere] |                                                                                 |                |
| 13:30    | Storage management                                                                   | [Slides][storage-slides]          | [Exercise][storage-exercise]                                                    |                |
| 14:30    | Server Monitoring and Maintenance Part 1: Telegraf, InfluxDB, Grafana                | [Slides][monitoring-slides]       | [Telegraf Exercise][monitoring-exercise] [Reports Exercise][monitoring-reports] |                |
| 15:15    | Break (coffee & snacks)                                                              |                                   |                                                                                 |                |
| 15:30    | Server Monitoring and Maintenance Part 2: DB queries, command line & scripts, backup |                                   | [gxadmin][gxadmin-exercise]                                                     |                |
| 17:00    | Wrap up and close                                                                    |                                   |                                                                                 |                |

[docker-slides]:       https://galaxyproject.github.io/training-material/topics/admin/tutorials/galaxy-docker/slides.html
[monitoring-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring/slides.html
[monitoring-exercise]: https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring/tutorial.html
[storage-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/object-store/slides.html
[storage-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/object-store/tutorial.html
[gxadmin-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[monitoring-reports]:  https://galaxyproject.github.io/training-material/topics/admin/tutorials/reports/tutorial.html
[clouds-everywhere]:   https://galaxyproject.github.io/dagobah-training/2019-pennstate/18-clouds/clouds.html#1

### Friday
**6th MArch**

| **Time**   | **Topic**                                           | **Slides**                       | **Exercises**                 | **Instructor** |
| --------   | ---------                                           | ---------                        | -----------                   | -----------    |
| 09:00      | Welcome and questions                               |                                  |                               |                |
| 09:15      | Dockerizing a Galaxy Tool                           |                                  | [Exercise][docker-exercise]   |                |
| 10:00      | Break (coffee & snacks)                             |                                  |                               |                |
| 10:15      | What's new in Galaxy?                               | [Slides][whats-new]              |                               |                |
| 10:40      | Upgrading Galaxy                                    | [Slides][upgrade]                |                               |                |
| 11:00      | Telegraf                                            |                                  | [Exercise][telegraf-exercise] |                |
| 11:30      | gxadmin                                             |                                  | [Exercise][gxadmin-exercise]  |                |
| 11:50      | Empathy                                             | [Slides][empathy-slides]         |                               |                |
| 12:00      | Lunch (catered)                                     |                                  |                               |                |
| 13:00      | When things go wrong: Galaxy Server Troubleshooting | [Slides][troubleshooting-slides] |                               |                |
| Spare Time | Extra Topics                                        | [Slides][extra_topics_slides]    |                               |                |
| 15:00      | Wrap up and close                                   |                                  |                               |                |

[whats-new]:              http://bit.ly/gxwhatsnew2019
[updating-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/upgrading/slides.html#1
[troubleshooting-slides]: https://galaxyproject.github.io/training-material/topics/admin/tutorials/troubleshooting/slides.html
[docker-exercise]:        https://github.com/galaxyproject/dagobah-training/pull/84/commits/7c9722a2ceaf46d15ea859a16f77bb047c2f42c5
[empathy-slides]:         https://galaxyproject.github.io/training-material/topics/admin/tutorials/empathy/slides.html
[telegraf-exercise]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/monitoring/tutorial.html
[gxadmin-exercise]:       https://galaxyproject.github.io/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[upgrade]:                https://galaxyproject.github.io/training-material/topics/admin/tutorials/upgrading/slides.html
[extra_topics_slides]:    https://galaxyproject.github.io/dagobah-training/2019-pennstate/extra_topics/extra_topic_resources.html#1

### Instructors

* (H)elena Rasche -
* (S)askia Hiltemann -
* (Na)te Coraor - Galaxy Project, Penn State University, United States
* (M)arius van den Beek - Galaxy Project, Penn State University, *Europe*
* (Ni)cola Soranzo - Earlham Institute
