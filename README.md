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

## Timetable

_Timetable with sessions and material is being continuously updated. **This is NOT final**._

### Monday

This day covers getting a Galaxy server setup with Ansible, a server you will develop for the rest of the week.

**2nd March**

| **Time** | **Topic**                                | **Slides**                                       | **Exercises**                | **Instructor** |
| -------- | ---------                                | ---------                                        | -----------                  | -----------    |
| 08:30    | Registration                             |                                                  |                              |                |
| 09:00    | Welcome and introduction                 | [Welcome][welcome-slides]                        |                              | All            |
| 09:20    | Deployment and platform options          | [Deployment][deployment-slides]                  |                              | M              |
| 09:40    | Intro to Ansible                         | [Ansible][ansible-slides]                        | [Exercise][ansible-exercise] | Ni             |
| 10:30    | Break (coffee & snacks)                  |                                                  |                              |                |
| 10:45    | Galaxy Server Part 1: Basic Install      | [Database][db-slides], [uWSGI][uwsgi-slides]     | [Exercise][ansible-galaxy]   | H, M, Na       |
| 13:00    | Lunch (catered)                          |                                                  |                              |                |
| 14:00    | Galaxy Server Part 2: Towards Production | [NGINX][nginx-slides], [SystemD][systemd-slides] |                              | H, Na          |
| 15:30    | Break (coffee & snacks)                  |                                                  |                              |                |
| 15:50    | Galaxy Server Part 3: Advanced Install   | [Production][production-slides]                  |                              | H, Na          |
| 17:00    | Close Day 1                              |                                                  |                              |                |

[welcome-slides]:      https://galaxyproject.github.io/dagobah-training/2020-barcelona/00-intro/intro.html
[deployment-slides]:   https://training.galaxyproject.org/training-material/topics/admin/slides/introduction.html
[ansible-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[db-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/database/slides.html
[ansible-galaxy]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[production-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/production/slides.html
[nginx-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/webservers/slides.html
[uwsgi-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/uwsgi/slides.html
[supervisor-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/systemd-supervisor/slides.html


### Tuesday
**3rd March**

Today we pivot to focus on making that server useful: adding tools and data, configuring quotas and authentication

| **Time** | **Topic**                 | **Slides**                                        | **Exercises**                                    | **Instructor** |
| -------- | ---------                 | ---------                                         | -----------                                      | -----------    |
| 09:00    | Welcome and questions     |                                                   |                                                  |                |
| 09:15    | Galaxy Tool Shed          | [Tools][tool-slides], [Toolshed][toolshed-slides] |                                                  | M              |
| 10:00    | Ephemeris                 | [Ephemeris][ephemeris-slides]                     | [Exercise][ephemeris-exercise]                   | Ni             |
| 10:30    | Break (coffee & snacks)   |                                                   |                                                  |                |
| 10:50    | Ephemeris: Continued      |                                                   |                                                  |                |
| 12:00    | Users, Groups, and Quotas | [Slides][users-groups-slides]                     |                                                  | S              |
| 13:00    | Lunch (catered)           |                                                   |                                                  |                |
| 14:00    | Reference Data            | [Slides][ref-genomes-slides]                      | [CMVFS Exercise][cvmfs-exercise]                 | Na             |
| 16:15    | External authentication   | [Slides][pam-slides]                              | [Upstream Auth Exercise][upstream-auth-exercise] | H              |
| 17:00    | Close Day 2               |                                                   |                                                  |                |

[tool-slides]:              https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-install/slides.html
[toolshed-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/toolshed/slides.html
[ephemeris-slides]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/slides.html
[ephemeris-exercise]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/tutorial.html
[users-groups-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/users-groups-quotas/slides.html
[ref-genomes-slides]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/reference-genomes/slides.html
[cvmfs-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/tutorial.html
[pam-slides]:               https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/slides.html
[upstream-auth-exercise]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/upstream-auth/tutorial.html

### Wednesday
**4th March**

Now that your server has some [bells and whistles](https://en.wiktionary.org/wiki/bells_and_whistles), let's connect it to a compute cluster, and learn about the job configuration file.

| **Time** | **Topic**                                   | **Slides**               | **Exercises**                | **Instructor** |
| -------- | ---------                                   | ---------                | -----------                  | -----------    |
| 09:00    | Welcome and questions                       |                          |                              |                |
| 09:15    | Exploring the Galaxy job configuration file | [Slides][jobconf-slides] |                              | M              |
| 09:45    | Connecting Galaxy to a compute cluster      | [Slides][cluster-slides] | [Exercise][cluster-exercise] | Na             |
| 10:20    | Break (coffee & snacks)                     |                          |                              |                |
| 10:40    | Compute cluster (continued)                 |                          |                              |                |
| 12:00    | Compute Resources: Continued                |                          |                              | Na             |
| 13:00    | Lunch                                       |                          |                              |                |
| 15:15    | Break (coffee & snacks)                     |                          |                              |                |
| 15:35    | Pulsar                                      | [Slides][hetero-slides]  | [Exercise][hetero-exercise]  | H              |
| 17:00    | Close day 3                                 |                          |                              |                |

[jobconf-slides]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/job-conf/slides.html
[cluster-slides]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html
[hetero-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html
[hetero-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html

### Thursday
**5th March**

Today is a bit of a [grab-bag](https://en.wiktionary.org/wiki/grab_bag), we'll cover stuff interactive tools, bioblend (galaxy API library), and then go back to admin focused issues of monitoring.

| **Time** | **Topic**                                             | **Slides**                  | **Exercises**                            | **Instructor** |
| -------- | ---------                                             | ---------                   | -------------                            | -----------    |
| 09:00    | Welcome and questions                                 |                             |                                          |                |
| 09:15    | Interactive Tools                                     |                             |                                          | Na             |
| 10:45    | Break (coffee & snacks)                               |                             |                                          |                |
| 11:00    | Bioblend                                              |                             |                                          | Ni             |
| 12:00    | Storage management                                    | [Slides][storage-slides]    | [Exercise][storage-exercise]             | Ni             |
| 13:00    | Lunch (catered)                                       |                             |                                          |                |
| 14:00    | Monitoring Part 1: Reports                            | [Slides][monitoring-slides] | [Reports Exercise][monitoring-reports]   | M              |
| 14:35    | Monitoring Part 2: Telegraf, InfluxDB, Grafana        | [Slides][monitoring-slides] | [Telegraf Exercise][monitoring-exercise] | S              |
| 15:15    | Break (coffee & snacks)                               |                             |                                          |                |
| 15:30    | Monitoring Part 3: DB queries, command line & scripts | [Slides][gxadmin-slides]    | [gxadmin][gxadmin-exercise]              | H              |
| 17:00    | Wrap up and close                                     |                             |                                          |                |

[interactive-tools]:   none
[docker-slides]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/galaxy-docker/slides.html
[monitoring-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/slides.html
[monitoring-exercise]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[storage-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/slides.html
[storage-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/tutorial.html
[gxadmin-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[gxadmin-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/slides.html
[monitoring-reports]:  https://training.galaxyproject.org/training-material/topics/admin/tutorials/reports/tutorial.html

### Friday
**6th March**

The last day! We made it. Even more assorted topics

| **Time**   | **Topic**                                           | **Slides**                       | **Exercises** | **Instructor** |
| --------   | ---------                                           | ---------                        | -----------   | -----------    |
| 09:00      | Welcome and questions                               |                                  |               |                |
| 09:15      | What's new in Galaxy?                               | [Slides][whats-new]              |               | M              |
| 10:15      | Break (coffee & snacks)                             |                                  |               |                |
| 10:30      | TIaaS                                               |                                  |               | H & S          |
| 11:30      | Upgrading Galaxy                                    | [Slides][upgrade]                |               | Ni             |
| 12:00      | When things go wrong: Galaxy Server Troubleshooting | [Slides][troubleshooting-slides] |               | Na             |
| 13:00      | Lunch (catered)                                     |                                  |               |                |
| Spare Time | Extra Topics                                        |                                  |               |                |
| 15:00      | Wrap up and close                                   |                                  |               |                |

[whats-new]:              http://bit.ly/gxwhatsnew2019
[updating-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html#1
[troubleshooting-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/troubleshooting/slides.html
[telegraf-exercise]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[upgrade]:                https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html

### Instructors

* (H)elena Rasche -
* (S)askia Hiltemann -
* (Na)te Coraor - Galaxy Project, Penn State University, United States
* (M)arius van den Beek - Galaxy Project, Penn State University, *Europe*
* (Ni)cola Soranzo - Earlham Institute
