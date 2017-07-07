layout: true
class: inverse
---
class: special, center

# Ansible and Galaxy


.footnote[\#usegalaxy / @galaxyproject]
---

layout: true
class: left, inverse

---
class: special, center
.large[
## Please interrupt
*We are here to answer questions!*
]

.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Overview
.large[
* What is Ansible? A quick introduction
* Galaxy and Ansible: building a production server
]
.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## What is Ansible?
.large[
* Automation tool for configuring and managing computers. (c.f. Puppet, Chef etc.)
* Initial release: Feb. 2012
* Multi-node software deployment, Ad-hoc task execution, Configuration management
]
![ansible-vanilla.png](images/ansible-vanilla.png)

.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Why?
.large[
* Avoid forgetting what you did to install and configure some piece of software
* Codify knowledge about a system
* Make process replicable
* Make it programmable - “Infrastructure as Code”
]
.right[![ansible-logo](images/ansible-logo.png)]
.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Features of Ansible
.large[
* Easy to learn
  * Playbooks in YAML, Templates in Jinja2, Inventory in INI file
  * Sequential execution
* Minimal requirements (**Agentless**)
  * No need for centralised management servers/daemons
  * Single command to install (pip install ansible)
  * Uses SSH to connect to target machine
* Idempotent:
  * Executing N times no different to executing once.
  * Prevents side-effects from re-running scripts
* Extensible:
  * Write your own modules
]
---
class: left
## Ansible structure
.large[
* Ansible scripts are called playbooks
* Scripts written as simple yaml files
* Can be structured in a simple folder hierarchy
* Many available modules
  * apt, git, command, shell, postgresql_db
  * file, lineinfile, get_url, curl, homebrew
  * cron, mount etc
]
[http://docs.ansible.com/ansible/modules_by_category.html](http://docs.ansible.com/ansible/modules_by_category.html)
.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Ansible playbook layout


``` text
.
├── Variables
│    └── vars
├── Inventory
│    └── inventory.ini
├── Meta
├── Roles
│    ├── Role_1
│    │    ├── files
│    │    ├── tasks
│    │    │    ├── task_1.yml
│    │    │    └── task_2.yml
│    │    └── templates
│    ├── Role_2
│   ...
├── playbook.yml
└── README.md
```

.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Roles contain tasks

![ansible-roles-tasks.png](images/ansible-roles-tasks.png)

.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Ansible inventory
* An INI file.
* List of remote machines to run ansible on
* Can have groups

```
[galaxyservers]
galaxy-web-01.tacc.utexas.edu
galaxy-web-02.tacc.utexas.edu

[galaxydbservers]
galaxy-db-01.tacc.utexas.edu

[pulsarservers]
login5.stampede.tacc.utexas.edu
    ansible_ssh_host=login1.stampede.tacc.utexas.edu ansible_ssh_user=xcgalaxy
jetstream-tacc0.galaxyproject.org
jetstream-iu0.galaxyproject.org
```
.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Ansible Variables
.left-column-equal[
**Group Variables**

e.g. Galaxy_servers.yml

```
galaxy_user: galaxy
galaxy_server_dir: /srv/galaxy
galaxy_config_dir: /srv/galaxy/config
galaxy_env:
    TEMPDIR: /tmp
    LANG: en_AU.UTF-8
deploy_env: production
```
]
.right-column-equal[
**Host Variables**

e.g. galaxy-web-01.tacc.utexas.edu.yml

```
server_codename: main_w1
galaxy_installer: true
```
]

.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Ansible Tasks

* Perform a task on the inventory

    ```
    - name: Install nginx
      apt:
        pkg: nginx-full
        status: latest
    ```
* A more complex task

    ```
    - name: Install packages
      apt:
        pkg: "{{ item }}"
      with_items:
        - nginx-full
        - supervisord
      notify:
        - restart nginx
        - update supervisor
      when: "{{ ansible_os_family }} == 'Debian'"
    ```

.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Ansible Handlers
* Syntax is the same as tasks, but these are only run when triggered by a notify.

* Task:

```
- name: Install pg_hba.conf
  template:
    src: pg_hba.conf.j2
    dest: ”{{ postgresql_data_dir }}/pg_hba.conf”
  notify: restart postgresql
```

* Handler:

```
- name: restart postgresql
  service:
    name: ”postgresql-{{ postgresql_version }}”
    state: restarted
```
.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Plays
.large[
* Contain:
  * What hosts you want to run on
  * What roles you want to run
  * Optional extras: extra variables, remote user etc.
]

```
- name: Manage PostgreSQL users, groups, databases, and permissions
  hosts: galaxydbservers
  remote_user: root
  become: yes
  become_user: postgres
  vars_files:
    - "{{ deploy_env }}/secret_vars/galaxydbservers.yml"
  roles:
    - natefoo.postgresql_objects
```
.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Plays and Tags

* Plays can have tags associated with them

```
- name: Manage PostgreSQL users, groups, databases, and permissions
  hosts: galaxydbservers
  roles:
    - natefoo.postgresql_objects
  tags: database_setup

- name: Manage supervisor and nginx
  hosts: galaxyservers
  roles:
    - galaxyprojectdotorg.nginx
    - supervisor
  tags: galaxy_setup
```

* These can then be run separately

`ansible-playbook -i inv_file playbook.yml --tags galaxy_setup`


.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## How Ansible works

![how-ansible-works.png](images/how-ansible-works.png)

.footnote[\#usegalaxy / @galaxyproject]

---
class: left
## Many reusable roles exist
.large[
.left-column-equal[
* Roles:
  * galaxy-os
  * nginx
  * postgresql
  * postgresql_objects
  * galaxy
  * interactive-environments
  * trackster
  * pulsar
  * galaxy-tools
  * galaxy-extras
]
.right-column-equal[
* Playbooks:
  * usegalaxy-playbook
  * infrastructure-playbook
  * galaxy-cloudman-playbook
  * GalaxyKickStart
]
]
.footnote[\#usegalaxy / @galaxyproject]
---
class: left
## Exercise!
.large[
In this exercise we will:
* Look at how the Galaxy Ansible roles can be combined together to install Galaxy
* We will work through the contents of the scripts
* We will run the roles from a playbook to create a production-ready Galaxy installation

[Installing Galaxy with Ansible](https://github.com/galaxyproject/dagobah-training/blob/2017-montpellier/sessions/14-ansible/ex2-galaxy-ansible.md)

]

.footnote[\#usegalaxy / @galaxyproject]
