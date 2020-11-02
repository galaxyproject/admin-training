![Galaxy Admin Training logo: GTN star over center of a galaxy background with the text Galaxy Admin Training](./logo.png)

logo based on a [Hubble Image](https://hubblesite.org/contents/media/images/2018/48/4280-Image.html)

# Galaxy Administration Training


- [Timetable](#timetable)
	- [Monday](#monday)
	- [Tuesday](#tuesday)
	- [Wednesday](#wednesday)
	- [Thursday](#thursday)
	- [Friday](#friday)
- [Admin Training Materials](https://training.galaxyproject.org/training-material/topics/admin/)
- [Join the Discussion](https://gxy.io/gatchat)
- [Galaxy Training Materials](https://training.galaxyproject.org/)

## Location, Logistics, and Registration

**This training will be offered Online, January 25-29**

## Training VM instances

Galaxy training instances will be bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises at home using a VM, Docker image, etc.

## Important Links

- [https://gxy.io/gat-questions - Q&A!](https://gxy.io/gat-questions)
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
| 09:20    | Deployment and platform options            | [Deployment][deployment-slides]                                                       |                                |                |
| 09:40    | Intro to Ansible                           | [Ansible][ansible-slides]                                                             | [Exercise][ansible-exercise]   |                |
| 10:30    | Break (coffee & snacks)                    |                                                                                       |                                |                |
| 10:45    | Galaxy Server Part 1: Basic Install        | [Galaxy Install][ansible-galaxy-slides], [Database][db-slides], [uWSGI][uwsgi-slides] | [Exercise][ansible-galaxy]     |                |
| 12:00    | Lunch (catered)                            |                                                                                       |                                |                |
| 13:00    | Galaxy Server Part 2: Towards Production   | [systemd][systemd-slides]                                                             |                                |                |
| 14:00    | Break (coffee & snacks)                    |                                                                                       |                                |                |
| 15:15    | Galaxy Server Part 3: Advanced Install     | [Production][production-slides]                                                       |                                |                |
| 15:45    | Galaxy Tool Shed                           | [Toolshed][toolshed-slides]                                                           |                                |                |
| 16:15    | Ephemeris                                  | [Ephemeris][ephemeris-slides]                                                         | [Exercise][ephemeris-exercise] |                |
| 17:00    | Guided tour of the Supercomputing facility |                                                                                       |                                |                |

[welcome-slides]:        https://galaxyproject.github.io/admin-training/2020-barcelona/00-intro/intro.html
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
| 10:45    | Users, Groups, and Quotas (+Demo)           | [Slides][users-groups-slides] |                                                                                  |                |
| 12:30    | External authentication                     | [Slides][pam-slides]          | [Upstream Auth Exercise][upstream-auth-exercise]                                 |                |
| 13:00    | Lunch (catered)                             |                               |                                                                                  |                |
| 14:00    | Reference Data                              | [Slides][ref-genomes-slides]  | [CVMFS Exercise][cvmfs-exercise], [Data Manager Exercise][data-manager-exercise] |                |
| 15:00    | Exploring the Galaxy job configuration file | [Slides][cluster-slides]      | [`job_conf.xml`][job-conf-xml]                                                   |                |
| 15:45    | Connecting Galaxy to a compute cluster      | [Slides][cluster-slides]      | [Exercise][cluster-exercise]                                                     |                |
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

| **Time** | **Topic**                                            | **Slides**                  | **Exercises**                            | **Instructor** |
| -------- | ---------                                            | ---------                   | -----------                              | -----------    |
| 09:00    | Welcome and questions                                |                             |                                          |                |
| 09:15    | Connecting Galaxy to a compute cluster (continued)   | [Slides][cluster-slides]    | [Exercise][cluster-exercise]             |                |
| 10:45    | Break (coffee & snacks)                              |                             |                                          |                |
| 11:00    | BioBlend                                             | [Slides][bioblend-slides]   | [Exercise][bioblend-exercise]            |                |
| 12:00    | Pulsar                                               | [Slides][hetero-slides]     | [Exercise][hetero-exercise]              |                |
| 13:00    | Lunch (catered)                                      |                             |                                          |                |
| 14:00    | Storage management                                   |                             | [Exercise][storage-exercise]             |                |
| 15:00    | Monitoring Part 1: Reports                           |                             | [Reports Exercise][monitoring-reports]   |                |
| 15:30    | Break (coffee & snacks)                              |                             |                                          |                |
| 15:45    | Monitoring Part2: DB queries, command line & scripts | [Slides][gxadmin-slides]    | [gxadmin][gxadmin-exercise]              |                |
| 16:15    | Monitoring Part 3: Telegraf, InfluxDB, Grafana       | [Slides][monitoring-slides] | [Telegraf Exercise][monitoring-exercise] |                |
| 17:00    | Close day 3                                          |                             |                                          |                |

[hetero-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html
[hetero-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html
[bioblend-slides]:     https://training.galaxyproject.org/training-material/topics/dev/tutorials/bioblend-api/slides.html
[bioblend-exercise]:   https://mybinder.org/v2/gh/nsoranzo/bioblend-tutorial/master?filepath=bioblend_histories.ipynb
[monitoring-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/slides.html
[monitoring-exercise]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[storage-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/tutorial.html
[gxadmin-exercise]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[gxadmin-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/slides.html
[monitoring-reports]:  https://training.galaxyproject.org/training-material/topics/admin/tutorials/reports/tutorial.html

### Thursday
**5th March**

| **Time** | **Topic**                                                  | **Slides**                         | **Exercises**                            | **Instructor** |
| -------- | ---------                                                  | ---------                          | -------------                            | -----------    |
| 09:00    | Welcome and questions                                      |                                    |                                          |                |
| 09:15    | Monitoring Part 3: Telegraf, InfluxDB, Grafana (continued) | [Slides][monitoring-slides]        | [Telegraf Exercise][monitoring-exercise] |                |
| 10:15    | Maintenance, Backup and Restore                            | [Slides][maintenance]              |                                          |                |
| 10:45    | Break (coffee & snacks)                                    |                                    |                                          |                |
| 11:00    | TIaaS                                                      |                                    | [TIaaS Exercise][tiaas-exercise]         |                |
| 12:30    | Recording Job Metrics                                      |                                    | [Exercise][job-metrics-exercise]         |                |
| 12:45    | Interactive Tools                                          | [Slides][interactive-tools-slides] | [Exercise][interactive-tools]            |                |
| 13:00    | Lunch                                                      |                                    |                                          |                |
| 14:00    | Interactive Tools                                          | [Slides][interactive-tools-slides] | [Exercise][interactive-tools]            |                |
| 15:00    | Dev vs Prod                                                |                                    | (Conversation)                           |                |
| 15:30    | Break (coffee & snacks)                                    |                                    |                                          |                |
| 15:45    | Jenkins & Automation                                       |                                    | [Exercise][jenkins-exercise]             |                |
| 16:35    | Advanced Customisation                                     | [Slides][advanced-customisation]   |                                          |                |
| 17:00    | Wrap up and close                                          |                                    |                                          |                |


[advanced-customisation]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/advanced-galaxy-customisation/slides.html
[jenkins-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/jenkins/tutorial.html
[job-metrics-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/job-metrics/tutorial.html
[maintenance]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/maintenance/slides.html
[interactive-tools-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/slides.html
[interactive-tools]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/tutorial.html
[tool-dev-slides]:          https://training.galaxyproject.org/training-material/topics/dev/tutorials/tool-integration/slides.html
[planemo]:                  https://planemo.readthedocs.io/en/latest/writing_standalone.html


### Friday
**6th March**

The last day! We made it. Today we have some additional topics, some of which are not admin related. Please feel free to leave at any point in the day and go enjoy Barcelona if the topics are maybe a bit less interesting for you.

| **Time** | **Topic**                                           | **Slides**                       | **Exercises**                                                    | **Instructor** |
| -------- | ---------                                           | ---------                        | -----------                                                      | -----------    |
| 09:00    | Welcome and questions                               |                                  |                                                                  |                |
| 09:15    | When things go wrong: Galaxy Server Troubleshooting | [Slides][troubleshooting-slides] |                                                                  |                |
| 10:45    | Break (coffee & snacks & [survey][survey])          |                                  |                                                                  |                |
| 11:00    | What's new in Galaxy                                | [Slides][whats-new]              |                                                                  |                |
| 11:45    | Python 2 to Python 3!                               | [Docs][py2to3]                   |                                                                  |                |
| 12:00    | Tool Development                                    | [Slides][tool-dev-slides]        | [Exercise][planemo]                                              |                |
| 13:00    | Lunch (catered)                                     |                                  |                                                                  |                |
| 14:00    | Dataset collections                                 |                                  | [DCs][dc], [Rule based][rb]                                      |                |
| 14:30    | Developing your own Training                        |                                  | [Setting up][training-jekyll], [Exercise][training-new-tutorial] |                |
| 15:00    | Wrap up and close                                   |                                  |                                                                  |                |

[survey]:                 https://bsc3.typeform.com/to/X5bqFf
[whats-new]:              https://docs.google.com/presentation/d/1LP6BFRc5yxnc5JAkQDlxDN7guPvQPftIsHkNlqQwr-w/edit?usp=sharing
[py2to3]:                 https://docs.galaxyproject.org/en/master/admin/python.html
[training-jekyll]:        https://training.galaxyproject.org/training-material/topics/contributing/tutorials/running-jekyll/tutorial.html
[training-new-tutorial]:  https://training.galaxyproject.org/training-material/topics/contributing/tutorials/create-new-tutorial/tutorial.html
[dc]:                     https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/processing-many-samples-at-once/tutorial.html#20-using-collections
[rb]:                     https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/upload-rules/tutorial.html
[whats-new]:              https://bit.ly/gxwhatsnew2019
[updating-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html#1
[troubleshooting-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/troubleshooting/slides.html
[telegraf-exercise]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[tiaas-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/tiaas/tutorial.html
[upgrade]:                https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html

### Instructors


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
