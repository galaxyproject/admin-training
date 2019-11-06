# Intro to Galaxy Administration @ Galaxy Africa 2019

- [Join the Discussion](https://gitter.im/dagobah-training/Lobby)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Location

Telepresence Room, KNUST
Kumasi, Ghana

## Training VM instances

We are using 'medium' instances from the [Nectar](https://nectar.rc.org.au) and [de.NBI](https://www.denbi.de/cloud) clouds with 2 cores, 6 GiB memory, 30 GiB disk, running a minimal Ubuntu 18.04 LTS image

The instances have been bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Timetable

### Friday
**15th November 2019**

| **Time** | **Topic**                                | **Slides**                                             | **Exercises**                | **Instructor** |
| -------- | ---------                                | ---------                                              | -----------                  | -----------    |
| 09:00    | Welcome and introduction                 | [Welcome][welcome-slides]                              |                              | All            |
| 09:20    | Intro to Ansible                         | [Ansible][ansible-slides]                              | [Exercise][ansible-exercise] | S, P           |
| 10:00    | Galaxy Server Part 1: Basic Install      | [Database][db-slides], [uWSGI][uwsgi-slides]           | [Exercise][ansible-galaxy]   | S, P, T        |
| 11:00    | Break                                    |                                                        |                              |                |
| 11:30    | Galaxy Server Part 2: Towards Production | [NGINX][nginx-slides], [Supervisor][supervisor-slides] |                              | s, P, T        |
| 13:00    | Lunch                                    |                                                        |                              |                |
| 14:00    | Galaxy Server Part 3: Advanced Install   | [Production][production-slides]                        |                              | S, P           |
| 15:00    | Break                                    |                                                        |                              |                |
| 16:30    | Connecting Galaxy to a compute cluster   | [Slides][cluster-slides]                               | [Exercise][cluster-exercise] | S              |
| 17:00    | Close                                    |                                                        |                              |                |

[welcome-slides]:      https://galaxyproject.github.io/dagobah-training/2019-gcc/00-intro/intro.html
[deployment-slides]:   https://training.galaxyproject.org/training-material/topics/admin/slides/introduction.html
[ansible-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[db-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/database/slides.html
[ansible-galaxy]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[production-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/production/slides.html
[nginx-slides]:        https://galaxyproject.github.io/dagobah-training/2019-gcc/03-production-basics/webservers.html#1
[uwsgi-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/uwsgi/slides.html
[supervisor-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/systemd-supervisor/slides.html
[cluster-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html


### Instructors

* Simon Gladman - Galaxy Australia, Melbourne Bioinformatics, University of Melbourne, Australia
* Peter van Heusden - South African National Bioinformatics Institute, Cape Town, South Africa
* Thoba Lose - South African National Bioinformatics Institute, Cape Town, South Africa
