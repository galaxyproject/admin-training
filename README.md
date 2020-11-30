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

This training will be offered Online, January 25-29. [**Register here**](https://galaxyproject.org/events/2021-01-admin-training/)

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

| **Topic**                                  | **Slides**                                                                            | **Exercises**                  |
| ---------                                  | ---------                                                                             | -----------                    |
| Registration                               |                                                                                       |                                |
| Welcome and introduction                   | [Welcome][welcome-slides]                                                             |                                |
| Deployment and platform options            | [Deployment][deployment-slides]                                                       |                                |
| Intro to Ansible                           | [Ansible][ansible-slides]                                                             | [Exercise][ansible-exercise]   |
| Galaxy Server Part 1: Basic Install        | [Galaxy Install][ansible-galaxy-slides], [Database][db-slides], [uWSGI][uwsgi-slides] | [Exercise][ansible-galaxy]     |
| Galaxy Server Part 2: Towards Production   | [systemd][systemd-slides]                                                             |                                |
| Galaxy Server Part 3: Advanced Install     | [Production][production-slides]                                                       |                                |


### Tuesday


| **Topic**                         | **Slides**                    | **Exercises**                                                                    |
| ---------                         | ---------                     | -----------                                                                      |
| Galaxy Tool Shed                  | [Toolshed][toolshed-slides]   |                                                                                  |
| Ephemeris                         | [Ephemeris][ephemeris-slides] | [Exercise][ephemeris-exercise]                                                   |
| Users, Groups, and Quotas (+Demo) | [Slides][users-groups-slides] |                                                                                  |
| Reference Data                    | [Slides][ref-genomes-slides]  | [CVMFS Exercise][cvmfs-exercise], [Data Manager Exercise][data-manager-exercise] |
| BioBlend                          | [Slides][bioblend-slides]     | [Exercise][bioblend-exercise]                                                    |


### Wednesday

| **Topic**                                   | **Slides**               | **Exercises**                    |
| --------                                    | ---------                | ---------                        |
| Exploring the Galaxy job configuration file | [Slides][cluster-slides] | [`job_conf.xml`][job-conf-xml]   |
| Connecting Galaxy to a compute cluster      | [Slides][cluster-slides] | [Exercise][cluster-exercise]     |
| Recording Job Metrics                       |                          | [Exercise][job-metrics-exercise] |


### Thursday

| **Topic**                                             | **Slides**                  | **Exercises**                            |
| ---------                                             | ---------                   | -------------                            |
| Pulsar                                                | [Slides][hetero-slides]     | [Exercise][hetero-exercise]              |
| Storage management                                    |                             | [Exercise][storage-exercise]             |
| Monitoring Part 1: DB queries, command line & scripts | [Slides][gxadmin-slides]    | [gxadmin][gxadmin-exercise]              |
| Monitoring Part 2: Telegraf, InfluxDB, Grafana        | [Slides][monitoring-slides] | [Telegraf Exercise][monitoring-exercise] |
| Maintenance, Backup and Restore                       | [Slides][maintenance]       |                                          |

### Friday

Today is a "Choose Your Own Adventure" day. Choose the content you're interested in, and we'll be around to support you.

| **Topic**                                           | **Slides**                         | **Exercises**                                                    |
| ---------                                           | ---------                          | -------------                                                    |
| Monitoring With Reports                             |                                    | [Reports Exercise][monitoring-reports]                           |
| TIaaS                                               |                                    | [TIaaS Exercise][tiaas-exercise]                                 |
| Interactive Tools                                   | [Slides][interactive-tools-slides] | [Exercise][interactive-tools]                                    |
| Jenkins & Automation                                |                                    | [Exercise][jenkins-exercise]                                     |
| Advanced Customisation                              | [Slides][advanced-customisation]   |                                                                  |
| When things go wrong: Galaxy Server Troubleshooting | [Slides][troubleshooting-slides]   |                                                                  |
| What's new in Galaxy                                | [Slides][whats-new]                |                                                                  |
| Python 2 to Python 3!                               | [Docs][py2to3]                     |                                                                  |
| Tool Development                                    | [Slides][tool-dev-slides]          | [Exercise][planemo]                                              |
| Dataset collections                                 |                                    | [DCs][dc], [Rule based][rb]                                      |
| Developing your own Training                        |                                    | [Setting up][training-jekyll], [Exercise][training-new-tutorial] |
| Securing your Galaxy                                |  TBA                               |                                                                  |



[welcome-slides]:           https://galaxyproject.github.io/admin-training/2020-barcelona/00-intro/intro.html
[deployment-slides]:        https://training.galaxyproject.org/training-material/topics/admin/slides/introduction.html
[ansible-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/slides.html
[ansible-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[ansible-galaxy-slides]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/slides.html
[ansible-galaxy]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[db-slides]:                https://training.galaxyproject.org/training-material/topics/admin/tutorials/database/slides.html
[production-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/production/slides.html
[uwsgi-slides]:             https://training.galaxyproject.org/training-material/topics/admin/tutorials/uwsgi/slides.html
[systemd-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/systemd-supervisor/slides.html
[toolshed-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/toolshed/slides.html
[ephemeris-slides]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/slides.html
[ephemeris-exercise]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/tutorial.html
[users-groups-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/users-groups-quotas/slides.html
[ref-genomes-slides]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/slides.html
[cvmfs-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/tutorial.html
[data-manager-exercise]:    https://gist.github.com/natefoo/fba6465c1eccb95ffdcfa67d78d8d6b4
[pam-slides]:               https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/slides.html
[upstream-auth-exercise]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/tutorial.html
[job-conf-xml]:             https://github.com/galaxyproject/galaxy/blob/dev/lib/galaxy/config/sample/job_conf.xml.sample_advanced
[cluster-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cluster-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html
[hetero-slides]:            https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html
[hetero-exercise]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html
[bioblend-slides]:          https://training.galaxyproject.org/training-material/topics/dev/tutorials/bioblend-api/slides.html
[bioblend-exercise]:        https://mybinder.org/v2/gh/nsoranzo/bioblend-tutorial/master?filepath=bioblend_histories.ipynb
[monitoring-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/slides.html
[monitoring-exercise]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[storage-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/tutorial.html
[gxadmin-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[gxadmin-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/slides.html
[monitoring-reports]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/reports/tutorial.html
[advanced-customisation]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/advanced-galaxy-customisation/slides.html
[jenkins-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/jenkins/tutorial.html
[job-metrics-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/job-metrics/tutorial.html
[maintenance]:              https://training.galaxyproject.org/training-material/topics/admin/tutorials/maintenance/slides.html
[interactive-tools-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/slides.html
[interactive-tools]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/tutorial.html
[tool-dev-slides]:          https://training.galaxyproject.org/training-material/topics/dev/tutorials/tool-integration/slides.html
[planemo]:                  https://planemo.readthedocs.io/en/latest/writing_standalone.html
[survey]:                   https://bsc3.typeform.com/to/X5bqFf
[whats-new]:                https://docs.google.com/presentation/d/1LP6BFRc5yxnc5JAkQDlxDN7guPvQPftIsHkNlqQwr-w/edit?usp=sharing
[py2to3]:                   https://docs.galaxyproject.org/en/master/admin/python.html
[training-jekyll]:          https://training.galaxyproject.org/training-material/topics/contributing/tutorials/running-jekyll/tutorial.html
[training-new-tutorial]:    https://training.galaxyproject.org/training-material/topics/contributing/tutorials/create-new-tutorial/tutorial.html
[dc]:                       https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/processing-many-samples-at-once/tutorial.html#20-using-collections
[rb]:                       https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/upload-rules/tutorial.html
[whats-new]:                https://bit.ly/gxwhatsnew2019
[updating-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html#1
[troubleshooting-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/troubleshooting/slides.html
[telegraf-exercise]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[tiaas-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/tiaas/tutorial.html
[upgrade]:                  https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html

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
