![Galaxy Admin Training logo: GTN star over center of a galaxy background with the text Galaxy Admin Training](./logo.png)

logo based on a [Hubble Image](https://hubblesite.org/contents/media/images/2018/48/4280-Image.html)

# Intro to Galaxy Administration @ BCC2020

- [Admin Training Materials](https://training.galaxyproject.org/training-material/topics/admin/)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Training VM instances

Galaxy training instances will be bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Important Links

- [https://gxy.io/gat-questions - Q&A!](https://gxy.io/gat-questions)
- [https://gxy.io/gatmachines - VMs](https://gxy.io/gatmachines)

#### Note: This workshop will be run twice. Once in the North American/European Timzones (WEST) and once in the Asian/Australian Timezones (EAST) - 12 hours apart. Please look at the timetable that suits your timezone.

## Timetable - WEST - Friday 17th July

| **Time** (EDT) | **Time** (CEST) | **Topic**                         | **Speaker** | **Slides**                                                                            | **Exercises**                  |
| --------       | --------        | ---------                         | ----------- | ---------                                                                             | -----------                    |
| 09:00          | 15:00           | Welcome and Introduction          | MC          | [Welcome][welcome-slides]                                                             |                                |
| 09:15          | 15:15           | Deployment and platform options   | MC          | [Deployment][deployment-slides]                                                       |                                |
|                |                 | Intro to Ansible                  | SG          | [Ansible][ansible-slides]                                                             | [Exercise][ansible-exercise]   |
| 11:30          | 17:30           | Break                             |             |                                                                                       |                                |
| 12:15          | 18:15           | Galaxy Part 1: Basic Install      | MC          | [Galaxy Install][ansible-galaxy-slides], [Database][db-slides], [uWSGI][uwsgi-slides] | [Exercise][ansible-galaxy]     |
|                |                 | Galaxy Part 2: Towards Production | NC          | [systemd][systemd-slides]                                                             |                                |
| 14:45          | 20:45           | Break                             |             |                                                                                       |                                |
| 15:30          | 21:30           | Galaxy Part 3: Advanced Install   | NC          | [Production][production-slides]                                                       |                                |
|                |                 | Galaxy Tool Shed                  | NS          | [Toolshed][toolshed-slides]                                                           |                                |
|                |                 | Ephemeris                         | NS          | [Ephemeris][ephemeris-slides]                                                         | [Exercise][ephemeris-exercise] |
| 18:00          |                 | Close                             |             |                                                                                       |                                |

## Timetable - EAST - Saturday 18th July

| **Time** (AEST)| **Time** (IST)  | **Topic**                         | **Speaker** | **Slides**                                                                            | **Exercises**                  |
| --------       | --------        | ---------                         | ----------- | ---------                                                                             | -----------                    |
| 11:00          | 06:30           | Welcome and Introduction          | SLG         | [Welcome][welcome-slides]                                                             |                                |
| 11:15          | 06:45           | Deployment and platform options   | SLG         | [Deployment][deployment-slides]                                                       |                                |
|                |                 | Intro to Ansible                  | SLG/CB      | [Ansible][ansible-slides]                                                             | [Exercise][ansible-exercise]   |
| 13:30          | 09:00           | Break                             |             |                                                                                       |                                |
| 14:15          | 09:45           | Galaxy Part 1: Basic Install      | NR/SLG/KT   | [Galaxy Install][ansible-galaxy-slides], [Database][db-slides], [uWSGI][uwsgi-slides] | [Exercise][ansible-galaxy]     |
|                |                 | Galaxy Part 2: Towards Production | NR/KT       | [systemd][systemd-slides]                                                             |                                |
| 16:45          | 12:15           | Break                             |             |                                                                                       |                                |
| 17:30          | 13:00           | Galaxy Part 3: Advanced Install   | SLG/KT      | [Production][production-slides]                                                       |                                |
|                |                 | Galaxy Tool Shed                  | CB          | [Toolshed][toolshed-slides]                                                           |                                |
|                |                 | Ephemeris                         | CB          | [Ephemeris][ephemeris-slides]                                                         | [Exercise][ephemeris-exercise] |
| 20:00          | 15:30           | Close                             | All         |                                                                                       |                                |

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
[welcome-slides]:        https://galaxyproject.github.io/admin-training/2020-bcc/00-intro/intro.html#1

### Instructors

* Nate Coraor (NC)
* Helena Rasche (HR)
* Martin Čech (MC)
* Nicola Soranzo (NS)
* Sergey Golitsynskiy (SG)
* Simon Gladman (SLG)
* Nicholas Rhodes (NR)
* Kiran Telukunta (KT)
* Catherine Bromhead (CB)

# After the Training

Everything you were taught in the past few days can be found in the [Galaxy Admin Training](https://github.com/galaxyproject/admin-training/) repository, which mostly points to the [admin section](https://training.galaxyproject.org/training-material/topics/admin/) of the Galaxy Training Materials.

For those of you who also need to do some Galaxy development, there is a [dev section of training materials](https://training.galaxyproject.org/training-material/topics/dev/) for those topics as well. There you can learn to integrate webhooks and tours, and learn about advanced tool development. For those who need to [teach Galaxy](https://training.galaxyproject.org/training-material/topics/instructors/) or want to [contribute training materials](https://training.galaxyproject.org/training-material/topics/contributing/), we have lots of tutorials for you!

**Community**

Chat with us on Gitter!

 - [Galaxy admins](http://gitter.im/galaxyproject/admins)
 - [Galaxy dev](https://gitter.im/galaxyproject/dev)
 - [General Galaxy topics](http://gitter.im/galaxyproject/Lobby)

**For your Users**

We recommend setting the `helpsite_url` in your Galaxy configuration to point to [https://help.galaxyproject.org/](https://help.galaxyproject.org/) where users can go and chat with each other. It's a great resource to help your users be independent and self-sufficient in their Galaxy learning. Admins are welcome too!

And don't forget that many, many [training materials](https://training.galaxyproject.org/training-material/) already exist covering different areas of \*omics and other research done with Galaxy. This can be a great resource for either giving training courses to your users (join the train-the-trainer session at GCC if you want to learn more) or to just point users to as a self-directed learning resource.

If you're asked to provide training infrastructure for your users, but do not have the capacity to support this, UseGalaxy.eu provides [training infrastructure](https://galaxyproject.eu/tiaas) for free.

**Going Forward**

We are working on updating the training materials with feedback from the training, and looking into the possibility to develop some automated linting of configurations, to help make Galaxy deployment more error-proof.

Let us know if you have any questions or feedback! Chat on Gitter, file issues on GitHub, let us know what features are interesting and important to the admin community.
