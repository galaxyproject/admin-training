![Galaxy Admin Training logo: GTN star over center of a galaxy background with the text Galaxy Admin Training](./logos/gat.png)

logo based on a [Hubble Image](https://hubblesite.org/contents/media/images/2018/48/4280-Image.html)

# Galaxy Administration Training


- [Timetable](#timetable)
	- [Monday](#monday)
	- [Tuesday](#tuesday)
	- [Wednesday](#wednesday)
	- [Thursday](#thursday)
	- [Friday](#friday)
- [Admin Training Materials](https://training.galaxyproject.org/training-material/topics/admin/)

## Location, Logistics

This training is offered Online, January 25-29, and is mostly asynchronous. Throughout the week you will always have access to trainers that are ready to help you with tasks or understanding. However the bulk of the work consist of **you working at your own pace** through the materials we prepared for you.

For the duration of this training (and a week after) you'll be granted access to a virtual machine (VM) that will be exclusive to you. You will connect to it using `ssh ubuntu@address-of-your-machine` and perform all of training's tasks inside. The machine is configured in a way to allow trainers connect to your machine and see exactly what you see. For this it uses software called `byobu` that has many convenient features for working in terminal - you can check out our [byobu help](byobu.md) page.

## Important Links

- [Slack for this workshop](https://join.slack.com/t/galaxyadmintraining/shared_invite/zt-kswf6j39-cgllk4JdyT6Vg98DH63lzw) - Chat & Call here. Use proper channels.
- [gxy.io/gatmachines](https://gxy.io/gatmachines) - The addresses and passwords for VMs. Find the one assigned to you.
- [gxy.io/gat-questions](https://docs.google.com/document/d/e/2PACX-1vRkFTRRDzNdUjPMc4uZot8am94LyczINbAyJ3Lerj7fef0wiUF810SBaDOB2sy31hDc6SHz90qEHAlu/pub) - Document continuously filled with questions and answers that we all encounter and solve.

## Timetable

The course is a mix of:

1. video recorded by our instructor community
2. video auto-generated from our slides
3. tutorials without videos.

We've done this to balance the significant effort required to produce videos
for materials that are regularly updated with the potential benefits they will
have for you, the students. As a result you'll find more videos for the
extremely important, foundational topics where we wanted things to be
completely clear for you.

*If you do not like videos*: The videos are strictly supplementary to the
training material and will show instructors going through the lessons. If you
prefer video content, you can watch those. If you dislike video training, you
can choose to just read the training materials for each topic.

The schedule for each day is a suggestion of what we believe is approximately 5 hours of work.
- If you're done with a day and want to do more, please feel free to continue!
- If you can't complete everything at the same pace, that's also fine! The VMs will be available for a week after the event.

### CoC

Everyone is expected to abide by the [Galaxy Code of Conduct (CoC)](https://github.com/galaxyproject/galaxy/blob/dev/CODE_OF_CONDUCT.md). We want this to be a welcoming and friendly environment for everyone! Please see the CoC for more information and the point of contact for any issues.

### Monday

This day covers getting a Galaxy server setup with Ansible, a server you will develop for the rest of the week.

**Start** today by introducing yourself in the [#general][slack-general] channel in Slack! Tell us where you're from, and and one thing about your surroundings (e.g. it's snowing outside, there's a squirrel on my porch, my cat is on my keyboard)

| **Topic**                      | **Video**                                        | **Slides / Materials**            | **Slack Channel**                          |
| ---------------------------    | -----------------------------------------------  | --------------------------------- | ----------------------------               |
| Welcome and introduction       | [Video](https://youtu.be/R-__JqlLCdM)            |                                   | [#general][slack-general]                  |
| Intro to Ansible               | [Video](https://youtu.be/KFpbfmN0OTE)            | [Slides][ansible-slides]          | [#01-ansible][slack-ansible]               |
| Ansible                        | [Video](https://youtu.be/2KdT0sYKUeE)            | [Tutorial][ansible-exercise]      | [#01-ansible][slack-ansible]               |
| Galaxy Ansible Introduction    | [Video](https://youtu.be/JN-C5UbHthY)            | [Slides][ansible-galaxy-slides]   | [#02-ansible-galaxy][slack-ansible-galaxy] |
| Part 0: Playbook Overview      | [Video](https://youtu.be/il83uApg7Hc)[1]         | [Tutorial part 0][ansible-galaxy] | [#02-ansible-galaxy][slack-ansible-galaxy] |
| Part 1: Basic Installation     | [Video](https://youtu.be/il83uApg7Hc&t=544s)[1]  | [Tutorial part 1][ansible-galaxy1] | [#02-ansible-galaxy][slack-ansible-galaxy] |
| Database                       | [Video](https://youtu.be/il83uApg7Hc&t=954s)[1]  | [Slides][db-slides]               | [#02-ansible-galaxy][slack-ansible-galaxy] |
| SystemD                        | [Video](https://youtu.be/il83uApg7Hc&t=3409s)[1] | [Slides][systemd-slides]          | [#02-ansible-galaxy][slack-ansible-galaxy] |
| Part 2: Towards Production     | [Video](https://youtu.be/il83uApg7Hc&t=3750s)[1] | [Tutorial part 2][ansible-galaxy2] | [#02-ansible-galaxy][slack-ansible-galaxy] |
| Production                     | [Video](https://youtu.be/il83uApg7Hc&t=4151s)[1] | [Production][production-slides]   | [#02-ansible-galaxy][slack-ansible-galaxy] |
| Part 3: Advanced Install       | [Video](https://youtu.be/il83uApg7Hc&t=4552s)[1] | [Tutorial part 3][ansible-galaxy3] | [#02-ansible-galaxy][slack-ansible-galaxy] |
| uWSGI                          |                                                  | [Slides][uwsgi-slides]            | [#02-ansible-galaxy][slack-ansible-galaxy] |
| *Touch Base Telco* (See Slack) |                                                  |                                   |                                            |

1. The same videos at different timepoints.

### Tuesday

**Start** today by sharing *how your 5-year-old self would have finished this sentence? “When I grow up, I want to be …”?* in the [#general][slack-general] channel in Slack!

| **Topic**                      | **Video**                                        | **Slides / Materials**           | Slack Channel                              |
| ---------------------------    | ---------------------------------------------    | -------------------------------- | ----------------------------               |
| Running jobs in Singularity    | [Video](https://youtu.be/airzg4-ETEs)            | [Tutorial][singularity-exercise] | [#general][slack-general]                  |
| Ephemeris (Intro)              | [Video](https://youtu.be/7Qqwrzn--YI&t=0s)[1]    | [Slides][ephemeris-slides]       | [#03-ephemeris][slack-ephemeris]           |
| Ephemeris                      | [Video](https://youtu.be/7Qqwrzn--YI&t=1122s)[1] | [Tutorial][ephemeris-exercise]   | [#03-ephemeris][slack-ephemeris]           |
| Users, Groups, and Quotas      | [Video](https://youtu.be/crywu31L8qg)            | [Slides][users-groups-slides]    | [#general][slack-general]                  |
| Reference Data (Intro)         | [Video](https://youtu.be/g_cavAO-fBM)            | [Slides][ref-genomes-slides]     | [#04-cvmfs][slack-cvmfs]                   |
| Reference Data                 | [Video](https://youtu.be/X3iFMZP_fQ8)            | [Tutorial][cvmfs-exercise]       | [#04-cvmfs][slack-cvmfs]                   |
| Data Libraries                 | [Video](https://youtu.be/8jvjTL49yPQ)            | [Tutorial][data-libraries]       | [#05-data-libraries][slack-data-libraries] |
| BioBlend (Intro)               | [Video](https://youtu.be/bOv5yNRc2hc)            | [Slides][bioblend-slides]        | [#06-bioblend][slack-bioblend]             |
| BioBlend                       | [Video](https://vimeo.com/448664925#t=16m0s)[2]  | [Tutorial][bioblend-exercise]    | [#06-bioblend][slack-bioblend]             |
| *Touch Base Telco* (See Slack) |                                                  |                                  |                                            |

1. The same videos at different timepoints.
2. The BioBlend tutorial was recorded during BCC2020. It mentions "Remo" numerous times which was the platform for that conference. You can safely ignore these portions, but the demonstration of the notebooks is still valid and useful.

### Wednesday

**Start** today by sharing *what is your recent favorite tool or app or software* in the [#general][slack-general] channel in Slack.

| **Topic**                              | **Video**                                    | **Slides / Materials**           | Slack Channel                                |
| -------------------------------------- | -------------------------------------------- | -------------------------------- | -----------------------------                |
| Galaxy Cluster Computing (Intro)¶      | [Video](https://youtu.be/R0NbHscL3jA&t=0s)   | [Slides][cluster-slides]         | [#07-compute-cluster][slack-compute-cluster] |
| Connecting Galaxy to a compute cluster | [Video](https://youtu.be/R0NbHscL3jA&t=940s) | [Tutorial][cluster-exercise]     | [#07-compute-cluster][slack-compute-cluster] |
| Mapping Jobs to Destinations           | [Video](https://youtu.be/qX8GjTJwnAk)        | [Tutorial][job-mapping-exercise] | [#07-compute-cluster][slack-compute-cluster] |
| Recording Job Metrics                  | [Video](https://youtu.be/7CYI5yw9MN8)        | [Tutorial][job-metrics-exercise] | [#07-compute-cluster][slack-compute-cluster] |
| *Touch Base Telco* (See Slack)         |                                              |                                  |                                              |


### Thursday

**Start** today by sharing *a dream vacation location, if you could be anywhere in the world (or outside it?)* in the [#general][slack-general] channel in Slack.

| **Topic**                                | **Video**                             | **Slides / Materials**                   | Slack Channel                      |
| ---------------------------------------  | ------------------------------------- | ---------------------------------------- | ------------------------           |
| Pulsar  (Intro)                          | [Video](https://youtu.be/M1-Z_2tuQPI) | [Slides][hetero-slides]                  | [#08-pulsar][slack-pulsar]         |
| Pulsar                                   | [Video](https://youtu.be/a7fKJT4Fs9k) | [Exercise][hetero-exercise]              | [#08-pulsar][slack-pulsar]         |
| Storage management                       | [Video 1][store1], [Video 2][store2]  | [Exercise][storage-exercise]             | [#09-storage][slack-storage]       |
| DB Query (Intro)                         | [Video](https://youtu.be/QFwOgDyFSSA) | [Slides][gxadmin-slides]                 | [#09-storage][slack-storage]       |
| DB queries, command line & scripts       |                                       | [Exercise][gxadmin-exercise]             | [#09-storage][slack-storage]       |
| Monitoring (Intro)                       | [Video](https://youtu.be/qcp9lEUxCGI) | [Slides][monitoring-slides]              | [#10-monitoring][slack-monitoring] |
| Monitoring: Telegraf, InfluxDB, Grafana¶ | [Video](https://youtu.be/drUaYQtMBLY) | [Telegraf Exercise][monitoring-exercise] | [#10-monitoring][slack-monitoring] |
| Maintenance, Backup and Restore          | [Video](https://youtu.be/41_3WHXZA-o) | [Slides][maintenance]                    | [#10-monitoring][slack-monitoring] |
| *Touch Base Telco* (See Slack)           |                                       |                                          |                                    |

[store1]: https://youtu.be/Hv2bvjk5sjE
[store2]: https://youtu.be/UUe2ne0-WNY

### Friday

**Start** today by sharing *What music/artist/audiobook have you been listening to these days?* in the [#general][slack-general] channel in Slack.

Today is a ["Choose Your Own Adventure"](https://en.wikipedia.org/wiki/Choose_Your_Own_Adventure) day. Choose the content you're interested in, and we'll be around to support you.

| **Topic**                                           | **Video**                             | **Slides / Materials**                                            | Slack Channel                      |
| --------------------------------------------------- | ------------------------------------- | ------------------------------------------------------------      | ------------------------           |
| What's new in Galaxy                                |                                       | Slides: [2019][whats-new-2019], [2020][whats-new-2020]            | [#general][slack-general]          |
| Training Infrastructure as a Service (TIaaS)¶       | [Video](https://youtu.be/tz0ZbK_8Vcc) | [TIaaS Exercise][tiaas-exercise]                                  | [#12-tiaas][slack-tiaas]           |
| Monitoring With Reports                             |                                       | [Reports Exercise][monitoring-reports]                            | [#10-monitoring][slack-monitoring] |
| Interactive Tools                                   | [Video](https://youtu.be/lACsIhnbTbE) | [Slides][interactive-tools-slides], [Exercise][interactive-tools] | [#general][slack-general]          |
| Jenkins & Automation                                |                                       | [Exercise][jenkins-exercise]                                      | [#general][slack-general]          |
| Advanced Customisation                              |                                       | [Slides][advanced-customisation]                                  | [#general][slack-general]          |
| When things go wrong: Galaxy Server Troubleshooting |                                       | [Slides][troubleshooting-slides]                                  | [#general][slack-general]          |
| Python 2 to Python 3!                               |                                       | [Docs][py2to3]                                                    | [#general][slack-general]          |
| Tool Development                                    |                                       | [Slides][tool-dev-slides], [Exercise][planemo]                    | [#general][slack-general]          |
| Dataset Collections                                 |                                       | [DCs][dc], [Rule based][rb]                                       | [#general][slack-general]          |
| Developing your own Training                        |                                       | [Setting up][training-jekyll], [Exercise][training-new-tutorial]  | [#general][slack-general]          |
| Securing your Galaxy¶                               | [Video](https://youtu.be/CQLUap74DVA) | Their team is not releasing these until February 2.               | [#general][slack-general]          |
| *Touch Base Telco* (See Slack)                      |                                       |                                                                   |                                    |

¶: These videos do not currently have corrected captions, only automated ones.



[advanced-customisation]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/advanced-galaxy-customisation/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[ansible-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021#your-first-playbook-and-first-role
[ansible-galaxy-slides]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[ansible-galaxy]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[ansible-galaxy1]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021#installing-galaxy
[ansible-galaxy2]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021#systemd
[ansible-galaxy3]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021#nginx
[ansible-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[bioblend-slides]:          https://training.galaxyproject.org/training-material/topics/dev/tutorials/bioblend-api/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[cluster-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[cluster-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[cvmfs-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[db-slides]:                https://training.galaxyproject.org/training-material/topics/admin/tutorials/database/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[dc]:                       https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/processing-many-samples-at-once/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021#20-using-collections
[deployment-slides]:        https://training.galaxyproject.org/training-material/topics/admin/slides/introduction.html
[ephemeris-exercise]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[ephemeris-slides]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[gxadmin-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[gxadmin-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[hetero-exercise]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[data-libraries]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/data-library/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[hetero-slides]:            https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[interactive-tools-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[interactive-tools]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[jenkins-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/jenkins/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[job-mapping-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/job-destinations/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[job-metrics-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/job-metrics/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[maintenance]:              https://training.galaxyproject.org/training-material/topics/admin/tutorials/maintenance/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[monitoring-exercise]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[monitoring-reports]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/reports/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[monitoring-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[pam-slides]:               https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[production-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/production/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[rb]:                       https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/upload-rules/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[ref-genomes-slides]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[singularity-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/singularity/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[storage-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[systemd-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/systemd-supervisor/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[telegraf-exercise]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[tiaas-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/tiaas/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[tool-dev-slides]:          https://training.galaxyproject.org/training-material/topics/dev/tutorials/tool-integration/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[toolshed-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/toolshed/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[training-jekyll]:          https://training.galaxyproject.org/training-material/topics/contributing/tutorials/running-jekyll/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[training-new-tutorial]:    https://training.galaxyproject.org/training-material/topics/contributing/tutorials/create-new-tutorial/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[troubleshooting-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/troubleshooting/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[updating-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021#1
[upgrade]:                  https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[upstream-auth-exercise]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/tutorial.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[users-groups-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/users-groups-quotas/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021
[uwsgi-slides]:             https://training.galaxyproject.org/training-material/topics/admin/tutorials/uwsgi/slides.html?utm_source=gxygat&utm_medium=website&utm_campaign=gat2021

[bioblend-exercise]:        https://mybinder.org/v2/gh/nsoranzo/bioblend-tutorial/master?filepath=bioblend_histories.ipynb
[job-conf-xml]:             https://github.com/galaxyproject/galaxy/blob/dev/lib/galaxy/config/sample/job_conf.xml.sample_advanced
[data-manager-exercise]:    https://gist.github.com/natefoo/fba6465c1eccb95ffdcfa67d78d8d6b4
[planemo]:                  https://planemo.readthedocs.io/en/latest/writing_standalone.html
[py2to3]:                   https://docs.galaxyproject.org/en/master/admin/python.html

[whats-new-2019]: https://bit.ly/gxwhatsnew2019
[whats-new-2020]: https://docs.google.com/presentation/d/1LP6BFRc5yxnc5JAkQDlxDN7guPvQPftIsHkNlqQwr-w/edit?usp=sharing

[slack-general]:         https://galaxyadmintraining.slack.com/archives/C01EYFM13DX
[slack-ansible]:         https://galaxyadmintraining.slack.com/archives/C01ED8Y8DV4
[slack-ansible-galaxy]:  https://galaxyadmintraining.slack.com/archives/C01F9RU197S
[slack-ephemeris]:       https://galaxyadmintraining.slack.com/archives/C01EGTWAUQM
[slack-cvmfs]:           https://galaxyadmintraining.slack.com/archives/C01EYKNTVMF
[slack-bioblend]:        https://galaxyadmintraining.slack.com/archives/C01ES5Z7VE0
[slack-compute-cluster]: https://galaxyadmintraining.slack.com/archives/C01EL17JWP4
[slack-pulsar]:          https://galaxyadmintraining.slack.com/archives/C01EL7BHW03
[slack-storage]:         https://galaxyadmintraining.slack.com/archives/C01EL195VB4
[slack-monitoring]:      https://galaxyadmintraining.slack.com/archives/C01ED96FKFG
[slack-data-libraries]:  https://galaxyadmintraining.slack.com/archives/C01K8NKDV8E
[slack-tiaas]:           https://galaxyadmintraining.slack.com/archives/C01L5M887PA


### Instructors

Name                | Country | Affiliation(s)
---                 | ---     | ---
Helena Rasche       | NL      | [Erasmus MC Bioinformatics Group](https://erasmusmc-bioinformatics.github.io/), [ATGM, Avans Hogeschool Breda](https://www.avans.nl)
Nicola Soranzo      | UK      | [Earlham Institute](https://www.earlham.ac.uk)
Martin Čech         | CZ      | [Elixir Czech Republic](https://www.elixir-czech.cz/), [RECETOX](https://www.recetox.muni.cz/en)
Anthony Bretaudeau  | FR      | [GenOuest](https://www.genouest.org/), [BIPAA](https://bipaa.genouest.org/)
Estelle Ancelet     | FR      | [INRAE](https://www.inrae.fr/en)
Sergey Golitsynskiy | US      | [Johns Hopkins University](https://jhu.edu)
Gianmauro Cuccuru   | DE      | [Albert-Ludwigs-University Freiburg](https://galaxyproject.eu/freiburg/)
Saskia Hiltemann    | NL      | [Erasmus MC Bioinformatics Group](https://erasmusmc-bioinformatics.github.io/)
Gildas Le Corguillé | FR      | [ABiMS](http://abims.sb-roscoff.fr/) - [Sorbonne Université](https://www.sorbonne-universite.fr/en)/[CNRS](https://www.cnrs.fr/en), [IFB/ELIXIR-FR](https://www.france-bioinformatique.fr/)
Simon Gladman       | AU      | [Melbourne Bioinformatics](https://melbournebioinformatics.org.au) - [Galaxy Australia](https://usegalaxy.org.au)
Catherine Bromhead  | AU      | [Melbourne Bioinformatics](https://melbournebioinformatics.org.au) - [Galaxy Australia](https://usegalaxy.org.au)
David Morais        | CA      | [GenAP](https://www.genap.ca/) & [Compute Canada](https://www.computecanada.ca/)
Aaron Petkau        | CA      | [PHAC](https://www.canada.ca/en/public-health.html) & [University of Manitoba](https://umanitoba.ca/)


(others coming soon.)

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

## Training VM instances

Galaxy training instances are bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises later using a VM, Docker image, etc.

## Sponsors

The 2021 Galaxy Admin Training is sponsored by a wide variety of organisations

### EOSC Life

This course has received funding from EOSC-Life Second Training Open Call. EOSC-Life has received funding from the European Union’s Horizon 2020 programme under grant agreement number 824087

[![EOSC Life logo](./logos/eosc.png)](https://www.eosc-life.eu/)

### Jetstream

We are grateful to Jetstream and the Galaxy Team for providing VMs from their allocation `TG-CCR160022` for this event.

[![Jetstream logo, it's dark red lettering with a teal green wave in an affront to good design](./logos/jetstream.png)](https://jetstream-cloud.org/)

### Galaxy Australia & Australian BioCommons

A significant portion of our infrastructure was graciously provided by Galaxy Australia

[![Australian BioCommons](logos/biocommons.png)](https://www.biocommons.org.au/galaxy-australia)

### de.NBI

Virtual Machines were provided by the German Federal Ministry of Education and Research BMBF grant 031 A538A de.NBI-RBC.

[![de.NBI Logo](./logos/denbi.png)](https://cloud.denbi.de/)
