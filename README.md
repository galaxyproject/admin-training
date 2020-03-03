# Intro to Galaxy Administration @ Barcelona

**2-6 March 2020**

- [Timetable](#timetable)
	- [Monday](#monday)
	- [Tuesday](#tuesday)
	- [Wednesday](#wednesday)
	- [Thursday](#thursday)
	- [Friday](#friday)
- [Admin Training Materials](https://training.galaxyproject.org/training-material/topics/admin/)
- [Join the Discussion](https://gitter.im/dagobah-training/Lobby)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Location, Logistics, and Registration

**This training will be offered 2-6 March at the [Barcelona Supercomputing Center](https://www.bsc.es/).**

See the [workshop's Galaxy Community Hub page](https://galaxyproject.org/events/2020-03-admin/) for details on logistics and registration.

## Training VM instances

Galaxy training instances will be bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Important Links

- [Q&A!](https://docs.google.com/document/d/1mmhZRpV4XQnMB5UoPGDw0qT8I3oF2DIEYPxvPH4tDz0/edit#)
- [https://gxy.io/gatchat - Chat for this workshop](https://gxy.io/gatchat)
- [https://gxy.io/gatmachines - VMs](https://gxy.io/gatmachines)

## Timetable

_Timetable with sessions and material is being continuously updated. **This is NOT final**._

### Monday

This day covers getting a Galaxy server setup with Ansible, a server you will develop for the rest of the week.

**2nd March**

| **Time** | **Topic**                                  | **Slides**                                                                            | **Exercises**                  | **Instructor** |
| -------- | ---------                                  | ---------                                                                             | -----------                    | -----------    |
| 08:30    | Registration                               |                                                                                       |                                |                |
| 09:00    | Welcome and introduction                   | [Welcome][welcome-slides]                                                             |                                | All            |
| 09:20    | Deployment and platform options            | [Deployment][deployment-slides]                                                       |                                | M              |
| 09:40    | Intro to Ansible                           | [Ansible][ansible-slides]                                                             | [Exercise][ansible-exercise]   | Ni             |
| 10:30    | Break (coffee & snacks)                    |                                                                                       |                                |                |
| 10:45    | Galaxy Server Part 1: Basic Install        | [Galaxy Install][ansible-galaxy-slides], [Database][db-slides], [uWSGI][uwsgi-slides] | [Exercise][ansible-galaxy]     | H, M, Na       |
| 12:00    | Lunch (catered)                            |                                                                                       |                                |                |
| 13:00    | Galaxy Server Part 2: Towards Production   | [systemd][systemd-slides]                                                             |                                | H, Na          |
| 14:00    | Break (coffee & snacks)                    |                                                                                       |                                |                |
| 15:15    | Galaxy Server Part 3: Advanced Install     | [Production][production-slides]                                                       |                                | H, Na          |
| 15:45    | Galaxy Tool Shed                           | [Toolshed][toolshed-slides]                                                           |                                | M              |
| 16:15    | Ephemeris                                  | [Ephemeris][ephemeris-slides]                                                         | [Exercise][ephemeris-exercise] | Ni             |
| 17:00    | Guided tour of the Supercomputing facility |                                                                                       |                                |                |

[welcome-slides]:        https://galaxyproject.github.io/dagobah-training/2020-barcelona/00-intro/intro.html
[deployment-slides]:     https://training.galaxyproject.org/training-material/topics/admin/slides/introduction.html
[ansible-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[ansible-galaxy-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/slides.html
[ansible-galaxy]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[db-slides]:             https://training.galaxyproject.org/training-material/topics/admin/tutorials/database/slides.html
[production-slides]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/production/slides.html
[uwsgi-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/uwsgi/slides.html
[systemd-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/systemd-supervisor/slides.html
[toolshed-slides]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/toolshed/slides.html
[ephemeris-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/slides.html
[ephemeris-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/tutorial.html


### Tuesday
**3rd March**

Today we pivot to focus on making that server useful: adding tools and data, configuring quotas and authentication

| **Time** | **Topic**                                   | **Slides**                    | **Exercises**                                                                    | **Instructor** |
| -------- | ---------                                   | ---------                     | -----------                                                                      | -----------    |
| 09:00    | Welcome and questions                       |                               |                                                                                  |                |
| 09:15    | Ephemeris: Continued                        |                               |                                                                                  |                |
| 10:30    | Break (coffee & snacks)                     |                               |                                                                                  |                |
| 10:45    | Users, Groups, and Quotas (+Demo)           | [Slides][users-groups-slides] |                                                                                  | S              |
| 12:30    | External authentication                     | [Slides][pam-slides]          | [Upstream Auth Exercise][upstream-auth-exercise]                                 | H              |
| 13:00    | Lunch (catered)                             |                               |                                                                                  |                |
| 14:00    | Reference Data                              | [Slides][ref-genomes-slides]  | [CVMFS Exercise][cvmfs-exercise], [Data Manager Exercise][data-manager-exercise] | Na             |
| 15:00    | Exploring the Galaxy job configuration file | [Slides][cluster-slides]      | [`job_conf.xml`][job-conf-xml]                                                   | M              |
| 15:45    | Connecting Galaxy to a compute cluster      | [Slides][cluster-slides]      | [Exercise][cluster-exercise]                                                     | Na             |
| 17:00    | Close Day 2                                 |                               |                                                                                  |                |

[users-groups-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/users-groups-quotas/slides.html
[ref-genomes-slides]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/slides.html
[cvmfs-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/tutorial.html
[data-manager-exercise]:    https://gist.github.com/natefoo/fba6465c1eccb95ffdcfa67d78d8d6b4
[pam-slides]:               https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/slides.html
[upstream-auth-exercise]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/tutorial.html
[job-conf-xml]:             https://github.com/galaxyproject/galaxy/blob/dev/lib/galaxy/config/sample/job_conf.xml.sample_advanced
[cluster-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html

### Wednesday
**4th March**

| **Time** | **Topic**                                             | **Slides**                  | **Exercises**                            | **Instructor** |
| -------- | ---------                                             | ---------                   | -----------                              | -----------    |
| 09:00    | Welcome and questions                                 |                             |                                          |                |
| 09:15    | Pulsar                                                | [Slides][hetero-slides]     | [Exercise][hetero-exercise]              | H              |
| 10:45    | Break (coffee & snacks)                               |                             |                                          |                |
| 11:00    | BioBlend                                              | [Slides][bioblend-slides]   |                                          | Ni             |
| 12:00    | Storage management                                    | [Slides][storage-slides]    | [Exercise][storage-exercise]             | Ni             |
| 13:00    | Lunch (catered)                                       |                             |                                          |                |
| 14:00    | Monitoring Part 1: Reports                            |                             | [Reports Exercise][monitoring-reports]   | M              |
| 14:35    | Monitoring Part 2: Telegraf, InfluxDB, Grafana        | [Slides][monitoring-slides] | [Telegraf Exercise][monitoring-exercise] | S              |
| 15:15    | Break (coffee & snacks)                               |                             |                                          |                |
| 15:30    | Monitoring Part 3: DB queries, command line & scripts | [Slides][gxadmin-slides]    | [gxadmin][gxadmin-exercise]              | H              |
| 17:00    | Close day 3                                           |                             |                                          |                |

[hetero-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html
[hetero-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html
[bioblend-slides]:     https://training.galaxyproject.org/training-material/topics/dev/tutorials/bioblend-api/slides.html
[monitoring-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/slides.html
[monitoring-exercise]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[storage-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/slides.html
[storage-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/tutorial.html
[gxadmin-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[gxadmin-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/slides.html
[monitoring-reports]:  https://training.galaxyproject.org/training-material/topics/admin/tutorials/reports/tutorial.html

### Thursday
**5th March**

TBD :)

| **Time** | **Topic**                                             | **Slides**                  | **Exercises**                            | **Instructor** |
| -------- | ---------                                             | ---------                   | -------------                            | -----------    |
| 09:00    | Welcome and questions                                 |                             |                                          |                |
| 09:15    | Interactive Tools                                     | [Slides][interactive-tools-slides] | [Exercise][interactive-tools]            | Na             |
| 17:00    | Wrap up and close                                     |                             |                                          |                |

[interactive-tools-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/slides.html#1
[interactive-tools]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/tutorial.html

### Friday
**6th March**

The last day! We made it. Even more assorted topics

| **Time**   | **Topic**                                           | **Slides**                       | **Exercises**                    | **Instructor** |
| --------   | ---------                                           | ---------                        | -----------                      | -----------    |
| 09:00      | Welcome and questions                               |                                  |                                  |                |
| 09:15      | What's new in Galaxy? (2019 edition)                | [Slides][whats-new]              |                                  | M              |
| 10:15      | Break (coffee & snacks)                             |                                  |                                  |                |
| 10:30      | TIaaS                                               |                                  | [TIaaS Exercise][tiaas-exercise] | H & S          |
| 11:30      | Upgrading Galaxy                                    | [Slides][upgrade]                |                                  | Ni             |
| 12:00      | When things go wrong: Galaxy Server Troubleshooting | [Slides][troubleshooting-slides] |                                  | Na             |
| 13:00      | Lunch (catered)                                     |                                  |                                  |                |
| Spare Time | Extra Topics                                        |                                  |                                  |                |
| 15:00      | Wrap up and close                                   |                                  |                                  |                |

[whats-new]:              http://bit.ly/gxwhatsnew2019
[updating-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html#1
[troubleshooting-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/troubleshooting/slides.html
[telegraf-exercise]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[tiaas-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/tiaas/tutorial.html
[upgrade]:                https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html

### Instructors

* (H)elena Rasche - Galaxy Europe
* (S)askia Hiltemann - Erasmus Medical Center, the Netherlands
* (Na)te Coraor - Galaxy Project, Penn State University, United States
* (M)arius van den Beek - Galaxy Project, Penn State University, *Europe*
* (Ni)cola Soranzo - Earlham Institute
