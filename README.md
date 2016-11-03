# Galaxy Administrators Course

dagobah - The Solar System for Galaxy Training
> "The planet shown in Dagobah, in the Sluis sector, is a world of murky swamps, steaming bayous, and petrified forests."

---
**Salt Lake City - 7th to 11th November 2016**

jump to [Monday](#monday) | [Tuesday](#tuesday) | [Wednesday](#wednesday) | [Thursday](#thursday) | [Friday](#friday)

Built slides have [an index](https://martenson.github.io/dagobah-training/).

### Instructors

* (N)ate Coraor - Galaxy Project, BMB, Penn State University, USA
* (S)imon Gladman - VLSCI, University of Melbourne, Australia
* (D)an Blankenberg - Galaxy Project, BMB, Penn State University, USA
* (M)artin Čech - Galaxy Project, BMB, Penn State University, USA
* Dave (C)lements - Galaxy Project, Department of Biology, Johns Hopkins University, USA

## Timetable
### Basic Sessions
#### Monday
**7th November** - [Salt Lake City Library - Conference Room Level 4](http://www.slcpl.org/rooms/)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:15 | Check-in |  |  |
| 09:30 | Welcome and Introduction |  | All |
| 09:45 | Deployment and Platform Options | [slides](https://martenson.github.io/dagobah-training/01-deployment-platforms/choices.html) | (N) |
| 10:15 | Get a Basic Galaxy Server Up and Running | [slides](https://martenson.github.io/dagobah-training/02-basic-server/get-galaxy.html) | (N + M) |
| 11:00 | **Morning Break** | | |
| 11:20 | Database choices and configuration. Introduction to PostgreSQL | [slides](https://martenson.github.io/dagobah-training/03-databases/databases.html) | (N + M) |
| 12:20 | **Lunch**, *catered* | | |
| 13:20 | Web server choices and configuration. Introduction to Apache and NGINX. | [slides](https://martenson.github.io/dagobah-training/04-web-servers/webservers.html), [exercise 1](https://github.com/martenson/dagobah-training/blob/master/intro/04-web-servers/ex1-apache.md), [exercise 2](https://github.com/martenson/dagobah-training/blob/master/intro/04-web-servers/ex2-nginx.md) | (N) |
| 14:20 | Introduction to the Galaxy Tool Shed: Identifying and installing well-defined tools | [shed slides](https://martenson.github.io/dagobah-training/05-tool-shed/shed_intro.html), [tool slides](https://martenson.github.io/dagobah-training/05-tool-shed/tool_installation.html) & [exercise](https://martenson.github.io/dagobah-training/05-tool-shed/ex-tool-management.html)| (M) |
| 15:30 | **Afternoon Break** | | |
| 15:50 | Defining and importing genomes, Data Managers | [slides](https://martenson.github.io/dagobah-training/06-reference-genomes/reference_genomes.html) & [exercise](intro/06-reference-genomes/ex06_reference_genomes.md) | (S) |
| 17:40 | **Dinner**, *on your own* |  |  |
| 19:00 | Discussion, troubleshooting, ad hoc support |  | All |
| 20:30 | Close Day 1 | | All |

#### Tuesday
**8th November** - [Salt Lake City Library - Conference Room Level 4](http://www.slcpl.org/rooms/)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 09:15 | Check-in |  |  |
| 09:30 | Welcome and Questions |  | All |
| 09:45 | Extending your installation: FTP, SMTP, and more|  | (D) |
| 11:00 | **Morning Break** | | |
| 11:20 | Users, Groups, and Quotas |  | (D) |
| 12:20 | **Lunch**, *catered* | | |
| 13:20 | Anatomy of a Tool Definition, Planemo, Publishing | [slides](https://martenson.github.io/dagobah-training/09-tool-basics/tool-basics.html) | (S + M) |
| 14:50 | Updating tools and supporting multiple versions of tools | [exercise](https://martenson.github.io/dagobah-training/05-tool-shed/ex-advanced-tool-management.html) | (S + M) |
| 15:20 | **Afternoon Break** | | |
| 15:40 | Upgrading to a new Galaxy release | [slides](https://martenson.github.io/dagobah-training/10-upgrading-release/upgrading.html) | (N + M) |
| 16:50 | When things go wrong: Basic Galaxy server troubleshooting | [slides](https://martenson.github.io/dagobah-training/11-basic-troubleshooting/basic-troubleshooting.html) | (N + M) |
| 17:40 | **Dinner**, *catered* |  |  |
| 19:00 | Introduction to Galaxy Architecture (Joint session with the Advanced Topics session) | [slides](https://martenson.github.io/dagobah-training/12-architecture/galaxy_architecture.html) | All |
| 20:20 | Wrap up and close | | All |

### Advanced Sessions

#### Wednesday
**9th November** - [Commander's house - North & South Parlor and Sun Room](http://www.universityguesthouse.com/Commanders-House/map#tab_2)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 08:30 | Check-in  |  |  |
| 09:00 | Welcome and Introduction/Questions |  | All |
| 09:20 | Configuration management choices: Introduction to Ansible | [Slides](https://martenson.github.io/dagobah-training/001-ansible/ansible-introduction.html), [Exercise](https://github.com/martenson/dagobah-training/blob/master/advanced/001-ansible/ex1-intro-ansible.md) | (S) |
| 09:50 | Using Ansible to deploy Galaxy I |  [Exercise](https://github.com/martenson/dagobah-training/blob/master/advanced/001-ansible/ex2-galaxy-ansible.md)| (S) |
| 10:30 | **Morning Break** | | |
| 10:50 | Using Ansible to deploy Galaxy II |  | (S + N) |
| 12:20 | **Lunch**, *catered* | | |
| 13:20 | Server monitoring and maintenance: Admin UI, Log files, Direct database queries, Command line & scripts, What to backup and how |  | (S + N) |
| 15:20 | **Afternoon Break** | | |
| 15:40 | Controlling Galaxy with systemd and supervisor |  | (N) |
| 16:10 | Advanced tool definition, tool failures, tool debugging |  | (M) |
| 17:40 | **Dinner**, *on your own* |  |  |
| 19:00 | Discussion, troubleshooting, ad hoc support |  | All |
| 20:30 | Close day 1 | | All |

#### Thursday
**10th November** - [Commander's house - North & South Parlor and Sun Room](http://www.universityguesthouse.com/Commanders-House/map#tab_2)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 08:30 | Check-in |  |  |
| 09:00 | Welcome and Introduction/Questions |  | All |
| 09:20 | Using and configuring external authentication services | [Slides](https://martenson.github.io/dagobah-training/004-external-auth/external-auth.html) | (M) |
| 10:30 | **Morning Break** | | |
| 10:50 | Connecting Galaxy to a compute cluster I |  | (N) |
| 12:20 | **Lunch**, *catered* | | |
| 13:20 | Connecting Galaxy to a compute cluster II |  | (N) |
| 15:20 | **Afternoon Break** | | |
| 15:40 | Using Heterogeneous compute resources |  | (N) |
| 17:40 | **Dinner**, *on your own* |  |  |
| 19:00 | Using public and private cloud compute resources | [Slides](https://martenson.github.io/dagobah-training/006-clouds/clouds.html) | (S) |
| 20:30 | Close day 2 | | All |

#### Friday
**11th November** - [Commander's house - North & South Parlor and Sun Room](http://www.universityguesthouse.com/Commanders-House/map#tab_2)

| **Time** | **Topic** | **Links** | **Instructor** |
| -------- | --------- | --------- | ----------- |
| 08:30 | Check-in |  |  |
| 09:00 | Welcome and Introduction/Questions |  | All |
| 09:20 | Storage management and using heterogeneous storage services | [Slides](https://github.com/martenson/dagobah-training/blob/master/docs/007-storage/storage.html) | (N + M) |
| 10:30 | **Morning Break** | | |
| 10:50 | Complex Galaxy servers examples: usegalaxy.org, GVL |  | (N + S) |
| 12:20 | **Lunch**, *on your own* | | |
| 13:20 | When things go REALLY wrong: Advanced Galaxy server troubleshooting |  | (N) |
| 15:20 | **Afternoon Break** | | |
| 15:50 | Participant selected topics |  | All |
| 17:30 | **Dinner**, *catered* |  |  |
| 18:50 | Discussion and open questions |  | All |
| 20:30 | Wrap up and close | | All |
