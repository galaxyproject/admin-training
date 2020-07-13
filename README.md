# Intro to Galaxy Administration @ BCC2020

- [Timetable](#timetable)
- [Admin Training Materials](https://training.galaxyproject.org/training-material/topics/admin/)
- [Join the Discussion](https://gitter.im/dagobah-training/Lobby)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Training VM instances

Galaxy training instances will be bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Important Links

- [Q&A!](https://docs.google.com/document/d/1mmhZRpV4XQnMB5UoPGDw0qT8I3oF2DIEYPxvPH4tDz0/edit#)
- [https://gxy.io/gatchat - Chat for this workshop](https://gxy.io/gatchat)
- [https://gxy.io/gatmachines - VMs](https://gxy.io/gatmachines)

#### Note: This workshop will be run twice. Once in the North American/European Timzones (WEST) and once in the Asian/Australian Timezones (EAST) - 12 hours apart. Please look at the timetable that suits your timezone.

## Timetable - WEST - Friday 17th July

| **Time** (CDT) | **Time** (CEST) |  **Topic**                                | **Slides**                                                                            | **Exercises**                  |
| --------       | --------        |  ---------                                | ---------                                                                             | -----------                    |
| 09:00          | 15:00           |  Welcome and Introduction                 |                                                                                       |                                |
| 09:15          | 15:15           |  Deployment and platform options          | [Deployment][deployment-slides]                                                       |                                |
|                |                 |  Intro to Ansible                         | [Ansible][ansible-slides]                                                             | [Exercise][ansible-exercise]   |
| 11:30          | 17:30           |  Break                                    |                                                                                       |                                |
| 12:15          | 18:15           |  Galaxy Server Part 1: Basic Install      | [Galaxy Install][ansible-galaxy-slides], [Database][db-slides], [uWSGI][uwsgi-slides] | [Exercise][ansible-galaxy]     |
|                |                 |  Galaxy Server Part 2: Towards Production | [systemd][systemd-slides]                                                             |                                |
| 14:45          | 20:45           |  Break                                    |                                                                                       |                                |
| 15:30          | 21:30           |  Galaxy Server Part 3: Advanced Install   | [Production][production-slides]                                                       |                                |
|                |                 |  Galaxy Tool Shed                         | [Toolshed][toolshed-slides]                                                           |                                |
|                |                 |  Ephemeris                                | [Ephemeris][ephemeris-slides]                                                         | [Exercise][ephemeris-exercise] |
| 18:00          |                 |  Close                                    |                                                                                       |                                |

## Timetable - EAST - Saturday 18th July

| **Time** (AEST) | **Time** (IST) |  **Topic**                                | **Slides**                                                                            | **Exercises**                  |
| --------       | --------        |  ---------                                | ---------                                                                             | -----------                    |
| 11:00          | 06:30           |  Welcome and Introduction                 |                                                                                       |                                |
| 11:15          | 06:45           |  Deployment and platform options          | [Deployment][deployment-slides]                                                       |                                |
|                |                 |  Intro to Ansible                         | [Ansible][ansible-slides]                                                             | [Exercise][ansible-exercise]   |
| 13:30          | 09:00           |  Break                                    |                                                                                       |                                |
| 14:15          | 09:45           |  Galaxy Server Part 1: Basic Install      | [Galaxy Install][ansible-galaxy-slides], [Database][db-slides], [uWSGI][uwsgi-slides] | [Exercise][ansible-galaxy]     |
|                |                 |  Galaxy Server Part 2: Towards Production | [systemd][systemd-slides]                                                             |                                |
| 16:45          | 12:15           |  Break                                    |                                                                                       |                                |
| 17:30          | 13:00           |  Galaxy Server Part 3: Advanced Install   | [Production][production-slides]                                                       |                                |
|                |                 |  Galaxy Tool Shed                         | [Toolshed][toolshed-slides]                                                           |                                |
|                |                 |  Ephemeris                                | [Ephemeris][ephemeris-slides]                                                         | [Exercise][ephemeris-exercise] |
| 20:00          | 15:30           |  Close                                    |                                                                                       |                                |

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

### Instructors

* Nate Coraor
* Helena Rasche
* Marten Čech
* Nicola Soranzo
* Sergey Golitsynskiy
* Simon Gladman
* Nicholas Rhodes
* Kiran Telukunta
* Catherine Bromhead
