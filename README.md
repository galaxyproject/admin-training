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

## Location, Logistics

This training is offered Online, January 25-29, and is mostly asynchronous. Throughout the week you will always have access to trainers that are ready to help you with tasks or understanding. However the bulk of the work consist of **you working at your own pace** through the materials we prepared for you.

For the duration of this training (and a week after) you'll be granted access to a virtual machine (VM) that will be exclusive to you. You will connect to it using `ssh ubuntu@address-of-your-machine` and perform all of training's tasks inside. The machine is configured in a way to allow trainers connect to your machine and see exactly what you see. For this it uses software called `byobu` that has many convenient features for working in terminal - you can check out its [cheat sheet](https://gist.github.com/devhero/7b9a7281db0ac4ba683f).

## Important Links

- [Slack for this workshop](https://join.slack.com/t/galaxyadmintraining/shared_invite/zt-kswf6j39-cgllk4JdyT6Vg98DH63lzw) - Chat & Call here. Use proper channels.
- [gxy.io/gatmachines](https://gxy.io/gatmachines) - The addresses and passwords for VMs. Find the one assigned to you.
- [gxy.io/gat-questions](https://gxy.io/gat-questions) - Document continuously filled with questions and answers that we all encounter and solve.

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

### Monday

This day covers getting a Galaxy server setup with Ansible, a server you will develop for the rest of the week.

| **Topic**                   | **Video**                                       | **Slides / Materials**            | **Slack Channel**            |
| --------------------------- | ----------------------------------------------- | --------------------------------- | ---------------------------- |
| Welcome and introduction    | [Video](#)                                      |                                   | [link][slack-general]        |
| Intro to Ansible            | [Video](https://youtu.be/KFpbfmN0OTE)           | [Slides][ansible-slides]          | [link][slack-ansible]        |
| Ansible                     | [Video](https://youtu.be/2KdT0sYKUeE)           | [Tutorial][ansible-exercise]      | [link][slack-ansible]        |
| Galaxy Ansible Introduction | [Video](https://youtu.be/JN-C5UbHthY)           | [Slides][ansible-galaxy-slides]   | [link][slack-ansible-galaxy] |
| Part 0: Playbook Overview   | [Video](https://youtu.be/FVrgzP4F4Nw)\*         | [Tutorial part 0][ansible-galaxy] | [link][slack-ansible-galaxy] |
| Part 1: Basic Installation  | [Video](https://youtu.be/FVrgzP4F4Nw&t=544s)\*  | [Tutorial part 1][ansible-galaxy] | [link][slack-ansible-galaxy] |
| Database                    | [Video](https://youtu.be/FVrgzP4F4Nw&t=954s)\*  | [Slides][db-slides]               | [link][slack-ansible-galaxy] |
| SystemD                     | [Video](https://youtu.be/FVrgzP4F4Nw&t=3409s)\* | [Slides][systemd-slides]          | [link][slack-ansible-galaxy] |
| Part 2: Towards Production  | [Video](https://youtu.be/FVrgzP4F4Nw&t=3750s)\* | [Tutorial part 2][ansible-galaxy] | [link][slack-ansible-galaxy] |
| Production                  | [Video](https://youtu.be/FVrgzP4F4Nw&t=4151s)\* | [Production][production-slides]   | [link][slack-ansible-galaxy] |
| Part 3: Advanced Install    | [Video](https://youtu.be/FVrgzP4F4Nw&t=4552s)\* | [Tutorial part 3][ansible-galaxy] | [link][slack-ansible-galaxy] |
| uWSGI                       |                                                 | [Slides][uwsgi-slides]            | [link][slack-ansible-galaxy] |

\*: these are all specific timepoints within the same video.

### Tuesday


| **Topic**                   | **Video**                                     | **Slides / Materials**           | Slack Channel           |
| --------------------------- | --------------------------------------------- | -------------------------------- | ----------------------- |
| Running jobs in Singularity | [Video](https://youtu.be/airzg4-ETEs)         | [Tutorial][singularity-exercise] | [link][slack-general]   |
| Ephemeris (Intro)           | [Video](https://youtu.be/7Qqwrzn--YI&t=0s)    | [Slides][ephemeris-slides]       | [link][slack-ephemeris] |
| Ephemeris                   | [Video](https://youtu.be/7Qqwrzn--YI&t=1122s) | [Tutorial][ephemeris-exercise]   | [link][slack-ephemeris] |
| Users, Groups, and Quotas   | [Video](https://youtu.be/crywu31L8qg)         | [Slides][users-groups-slides]    | [link][slack-general]   |
| Reference Data (Intro)      | [Video](https://youtu.be/g_cavAO-fBM)         | [Slides][ref-genomes-slides]     | [link][slack-cvmfs]     |
| Reference Data              | [Video](https://youtu.be/X3iFMZP_fQ8)         | [Tutorial][cvmfs-exercise]       | [link][slack-cvmfs]     |
| BioBlend (Intro)            | [Video](https://youtu.be/bOv5yNRc2hc)         | [Slides][bioblend-slides]        | [link][slack-bioblend]  |
| BioBlend                    |                                               | [Tutorial][bioblend-exercise]    | [link][slack-bioblend]  |



### Wednesday

| **Topic**                              | **Video**                                    | **Slides / Materials**           | Slack Channel                 |
| -------------------------------------- | -------------------------------------------- | -------------------------------- | ----------------------------- |
| Galaxy Cluster Computing (Intro)       | [Video](https://youtu.be/R0NbHscL3jA&t=0s)   | [Slides][cluster-slides]         | [link][slack-compute-cluster] |
| Connecting Galaxy to a compute cluster | [Video](https://youtu.be/R0NbHscL3jA&t=940s) | [Tutorial][cluster-exercise]     | [link][slack-compute-cluster] |
| Mapping Jobs to Destinations           | [Video](https://youtu.be/qX8GjTJwnAk)        | [Tutorial][job-mapping-exercise] | [link][slack-compute-cluster] |
| Recording Job Metrics                  | [Video](https://youtu.be/7CYI5yw9MN8)        | [Tutorial][job-metrics-exercise] | [link][slack-compute-cluster] |


### Thursday

| **Topic**                               | **Video**                             | **Slides / Materials**                   | Slack Channel            |
| --------------------------------------- | ------------------------------------- | ---------------------------------------- | ------------------------ |
| Pulsar  (Intro)                         | [Video](https://youtu.be/M1-Z_2tuQPI) | [Slides][hetero-slides]                  | [link][slack-pulsar]     |
| Pulsar                                  | [Video](https://youtu.be/a7fKJT4Fs9k) | [Exercise][hetero-exercise]              | [link][slack-pulsar]     |
| Storage management                      | TBA                                   | [Exercise][storage-exercise]             | [link][slack-storage]    |
| DB Query (Intro)                        | [Video](https://youtu.be/QFwOgDyFSSA) | [Slides][gxadmin-slides]                 | [link][slack-storage]    |
| DB queries, command line & scripts      | TBA                                   | [Exercise][gxadmin-exercise]             | [link][slack-storage]    |
| Monitoring (Intro)                      | [Video](https://youtu.be/qcp9lEUxCGI) | [Slides][monitoring-slides]              | [link][slack-monitoring] |
| Monitoring: Telegraf, InfluxDB, Grafana | TBA                                   | [Telegraf Exercise][monitoring-exercise] | [link][slack-monitoring] |
| Maintenance, Backup and Restore         | [Video](https://youtu.be/41_3WHXZA-o) | [Slides][maintenance]                    | [link][slack-monitoring] |

### Friday

Today is a "Choose Your Own Adventure" day. Choose the content you're interested in, and we'll be around to support you.

| **Topic**                                           | **Video**                             | **Slides / Materials**                                       | Slack Channel            |
| --------------------------------------------------- | ------------------------------------- | ------------------------------------------------------------ | ------------------------ |
| What's new in Galaxy                                |                                       | Slides: [2019][whats-new-2019], [2020][whats-new-2020]       | [link][slack-general]    |
| Training Infrastructure as a Service (TIaaS)        |                                       | [TIaaS Exercise][tiaas-exercise]                             | [link][slack-general]    |
| Monitoring With Reports                             |                                       | [Reports Exercise][monitoring-reports]                       | [link][slack-monitoring] |
| Interactive Tools                                   | [Video](https://youtu.be/lACsIhnbTbE) | [Slides][interactive-tools-slides], [Exercise][interactive-tools] | [link][slack-general]    |
| Jenkins & Automation                                |                                       | [Exercise][jenkins-exercise]                                 | [link][slack-general]    |
| Advanced Customisation                              |                                       | [Slides][advanced-customisation]                             | [link][slack-general]    |
| When things go wrong: Galaxy Server Troubleshooting |                                       | [Slides][troubleshooting-slides]                             | [link][slack-general]    |
| Python 2 to Python 3!                               |                                       | [Docs][py2to3]                                               | [link][slack-general]    |
| Tool Development                                    |                                       | [Slides][tool-dev-slides], [Exercise][planemo]               | [link][slack-general]    |
| Dataset Collections                                 |                                       | [DCs][dc], [Rule based][rb]                                  | [link][slack-general]    |
| Developing your own Training                        |                                       | [Setting up][training-jekyll], [Exercise][training-new-tutorial] | [link][slack-general]    |
| Securing your Galaxy                                | [Video](https://youtu.be/CQLUap74DVA) | Their team is not releasing these until February 2.          | [link][slack-general]    |



[welcome-slides]:           https://galaxyproject.github.io/admin-training/2020-barcelona/00-intro/intro.html
[advanced-customisation]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/advanced-galaxy-customisation/slides.html
[ansible-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/tutorial.html#your-first-playbook-and-first-role
[ansible-galaxy-slides]:    https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/slides.html
[ansible-galaxy]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html
[ansible-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/ansible/slides.html
[bioblend-exercise]:        https://mybinder.org/v2/gh/nsoranzo/bioblend-tutorial/master?filepath=bioblend_histories.ipynb
[bioblend-slides]:          https://training.galaxyproject.org/training-material/topics/dev/tutorials/bioblend-api/slides.html
[cluster-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html
[cluster-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/connect-to-compute-cluster/slides.html
[cvmfs-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/tutorial.html
[data-manager-exercise]:    https://gist.github.com/natefoo/fba6465c1eccb95ffdcfa67d78d8d6b4
[db-slides]:                https://training.galaxyproject.org/training-material/topics/admin/tutorials/database/slides.html
[dc]:                       https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/processing-many-samples-at-once/tutorial.html#20-using-collections
[deployment-slides]:        https://training.galaxyproject.org/training-material/topics/admin/slides/introduction.html
[ephemeris-exercise]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/tutorial.html
[ephemeris-slides]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/tool-management/slides.html
[gxadmin-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/tutorial.html
[gxadmin-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/gxadmin/slides.html
[hetero-exercise]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/tutorial.html
[hetero-slides]:            https://training.galaxyproject.org/training-material/topics/admin/tutorials/heterogeneous-compute/slides.html
[interactive-tools-slides]: https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/slides.html
[interactive-tools]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/interactive-tools/tutorial.html
[jenkins-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/jenkins/tutorial.html
[job-conf-xml]:             https://github.com/galaxyproject/galaxy/blob/dev/lib/galaxy/config/sample/job_conf.xml.sample_advanced
[job-mapping-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/job-destinations/tutorial.html
[job-metrics-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/job-metrics/tutorial.html
[maintenance]:              https://training.galaxyproject.org/training-material/topics/admin/tutorials/maintenance/slides.html
[monitoring-exercise]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[monitoring-reports]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/reports/tutorial.html
[monitoring-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/slides.html
[pam-slides]:               https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/slides.html
[planemo]:                  https://planemo.readthedocs.io/en/latest/writing_standalone.html
[production-slides]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/production/slides.html
[py2to3]:                   https://docs.galaxyproject.org/en/master/admin/python.html
[rb]:                       https://training.galaxyproject.org/training-material/topics/galaxy-data-manipulation/tutorials/upload-rules/tutorial.html
[ref-genomes-slides]:       https://training.galaxyproject.org/training-material/topics/admin/tutorials/cvmfs/slides.html
[singularity-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/singularity/tutorial.html
[singularity-exercise]:     https://training.galaxyproject.org/training-material/topics/admin/tutorials/singularity/tutorial.html
[storage-exercise]:         https://training.galaxyproject.org/training-material/topics/admin/tutorials/object-store/tutorial.html
[systemd-slides]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/systemd-supervisor/slides.html
[telegraf-exercise]:        https://training.galaxyproject.org/training-material/topics/admin/tutorials/monitoring/tutorial.html
[tiaas-exercise]:           https://training.galaxyproject.org/training-material/topics/admin/tutorials/tiaas/tutorial.html
[tool-dev-slides]:          https://training.galaxyproject.org/training-material/topics/dev/tutorials/tool-integration/slides.html
[toolshed-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/toolshed/slides.html
[training-jekyll]:          https://training.galaxyproject.org/training-material/topics/contributing/tutorials/running-jekyll/tutorial.html
[training-new-tutorial]:    https://training.galaxyproject.org/training-material/topics/contributing/tutorials/create-new-tutorial/tutorial.html
[troubleshooting-slides]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/troubleshooting/slides.html
[updating-slides]:          https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html#1
[upgrade]:                  https://training.galaxyproject.org/training-material/topics/admin/tutorials/upgrading/slides.html
[upstream-auth-exercise]:   https://training.galaxyproject.org/training-material/topics/admin/tutorials/external-auth/tutorial.html
[users-groups-slides]:      https://training.galaxyproject.org/training-material/topics/admin/tutorials/users-groups-quotas/slides.html
[uwsgi-slides]:             https://training.galaxyproject.org/training-material/topics/admin/tutorials/uwsgi/slides.html
[whats-new-2019]:           https://bit.ly/gxwhatsnew2019
[whats-new-2020]:           https://docs.google.com/presentation/d/1LP6BFRc5yxnc5JAkQDlxDN7guPvQPftIsHkNlqQwr-w/edit?usp=sharing
[slack-general]:              https://galaxyadmintraining.slack.com/archives/C01EYFM13DX
[slack-ansible]:            https://galaxyadmintraining.slack.com/archives/C01ED8Y8DV4
[slack-ansible-galaxy]:     https://galaxyadmintraining.slack.com/archives/C01F9RU197S
[slack-ephemeris]:          https://galaxyadmintraining.slack.com/archives/C01EGTWAUQM
[slack-cvmfs]:              https://galaxyadmintraining.slack.com/archives/C01EYKNTVMF
[slack-bioblend]:           https://galaxyadmintraining.slack.com/archives/C01ES5Z7VE0
[slack-compute-cluster]:    https://galaxyadmintraining.slack.com/archives/C01EL17JWP4
[slack-pulsar]:             https://galaxyadmintraining.slack.com/archives/C01EL7BHW03
[slack-storage]:            https://galaxyadmintraining.slack.com/archives/C01EL195VB4
[slack-monitoring]:         https://galaxyadmintraining.slack.com/archives/C01ED96FKFG


### Instructors

Name | Country | Affiliation(s)
--- | --- | ---
Helena Rasche | Netherlands | [Erasmus MC Bioinformatics Group](https://erasmusmc-bioinformatics.github.io/), [ATGM, Avans Hogeschool Breda](https://www.avans.nl)
Nicola Soranzo | UK | [Earlham Institute](https://www.earlham.ac.uk)
Martin Čech | CZ | [Elixir Czech Republic](https://www.elixir-czech.cz/), [RECETOX](https://www.recetox.muni.cz/en)
Anthony Bretaudeau | FR | [GenOuest](https://www.genouest.org/), [BIPAA](https://bipaa.genouest.org/)
Estelle Ancelet | FR | [INRAE](https://www.inrae.fr/en)

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

Galaxy training instances are be bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises later using a VM, Docker image, etc.

## Sponsors

The 2021 Galaxy Admin Training is sponsored by a wide variety of organisations

### EOSC Life

This course has received funding from EOSC-Life Second Training Open Call. EOSC-Life has received funding from the European Union’s Horizon 2020 programme under grant agreement number 824087

[![EOSC Life logo](eosclogo.png)](https://www.eosc-life.eu/)

### Galaxy Australia & Australian BioCommons

Virtual Machines were provided by Galaxy Australia

[![Australian BioCommons](https://images.squarespace-cdn.com/content/5d3a4213cf4f5b00014ea1db/1566885344365-8BAMFYV0071E8F8XLWI5/Australian-Biocommons-Logo-Horizontal-144dpi-Transparent.png?content-type=image%2Fpng)](https://www.biocommons.org.au/galaxy-australia)

### de.NBI

Virtual Machines were provided by the German Federal Ministry of Education and Research BMBF grant 031 A538A de.NBI-RBC.

[![de.NBI Logo](https://usegalaxy-eu.github.io/assets/media/deNBI_Logo_rgb.png)](https://cloud.denbi.de/)
