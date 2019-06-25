# Intro to Galaxy Administration @ GCC2019

- [Timetable](#timetable)
	- [Monday](#monday)
- [Join the Discussion](https://gitter.im/dagobah-training/Lobby)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Location

TBD
Konzerthaus Freiburg

## Training VM instances

We are using instances from the [de.NBI cloud](https://www.denbi.de/cloud) with X cores, Y GiB memory, 12 GiB disk, running a minimal Ubuntu 18.04 image

The instances have been bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Timetable

_Timetable with sessions and material is being continuously updated._

### Monday
**28th January**

| **Time** | **Topic**                                | **Slides**                                             | **Exercises**                | **Instructor** |
| -------- | ---------                                | ---------                                              | -----------                  | -----------    |
| 10:00    | Welcome and introduction                 | [Welcome][welcome-slides]                              |                              | All            |
| 10:20    | Intro to Ansible                         | [Ansible][ansible-slides]                              | [Exercise][ansible-exercise] | S              |
| 11:00    | Galaxy Server Part 1: Basic Install      | [Database][db-slides], [uWSGI][uwsgi-slides]           | [Exercise][ansible-galaxy]   | M, N, H        |
| 12:00    | Lunch                                    |                                                        |                              |                |
| 13:00    | Galaxy Server Part 2: Towards Production | [NGINX][nginx-slides], [Supervisor][supervisor-slides] |                              | M, S, H        |
| 15:00    | Break (coffee & snacks)                  |                                                        |                              |                |
| 15:30    | Galaxy Server Part 3: Advanced Install   | [Production][production-slides]                        |                              | M, H           |
| 16:30    | Connecting Galaxy to a compute cluster   | [Slides][cluster-slides]                               | [Exercise][cluster-exercise] | N, N           |
| 17:30    | Close Day 1                              |                                                        |                              |                |

[welcome-slides]:      https://galaxyproject.github.io/dagobah-training/2019-gcc/00-intro/intro.html
[deployment-slides]:   https://galaxyproject.github.io/training-material/topics/admin/slides/introduction.html
[ansible-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[db-slides]:           https://galaxyproject.github.io/training-material/topics/admin/tutorials/database/slides.html
[ansible-galaxy]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[production-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/production/slides.html
[nginx-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/webservers/slides.html
[uwsgi-slides]:        https://galaxyproject.github.io/training-material/topics/admin/tutorials/uwsgi/slides.html
[supervisor-slides]:   https://galaxyproject.github.io/training-material/topics/admin/tutorials/systemd-supervisor/slides.html
[cluster-slides]:      https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:    https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html


### Instructors

* Simon Gladman - Galaxy Australia, Melbourne Bioinformatics, University of Melbourne, Australia
* Helena Rasche - Galaxy Europe (ELIXIR Galaxy WG, Elixir Germany, de.NBI), University of Freiburg, Germany
* Nate Coraor - Galaxy Project, Penn State University, USA
* John Chilton - Galaxy Project, Penn State University, USA
* Martin Čech - Galaxy Project, Penn State University, USA
* Enis Afgan
* Marius van den Beek
