layout: true
class: inverse
---
class: special, center
![GATC Logo](../shared-images/AdminTraining2016-250.png)

# Ansible and Galaxy - Part 1


**Slides: @afgane, @nuwang, @Slugger70**


.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---

layout: true
class: left, inverse

---
class: left, middle, center
![GATC Logo](../shared-images/AdminTraining2016-100.png)

## Please interrupt



*We are here to answer questions!*

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Overview
.large[
* What is Ansible
* Galaxy and Ansible

Later in Part 2
* Detail on Galaxy playbooks
* Extending and customising Galaxy with Ansible
]

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Overview
.large[
* **What is Ansible**
* Galaxy and Ansible

Later in Part 2
* Detail on Galaxy playbooks
* Extending and customising Galaxy with Ansible
]

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  What is Ansible
.large[
* Automation tool for configuring and managing computers. (c.f. Puppet, Chef etc.)
* Initial release: Feb. 2012
* Multi-node software deployment, Ad-hoc task execution, Configuration management
]
![ansible-vanilla.png](images/ansible-vanilla.png)

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Why?
.large[
* Avoid forgetting what you did to install and configure some piece of software
* Codify knowledge about a system
* Make process replicable
* Make it programmable - “Infrastructure as Code”
]
.right[![ansible-logo](images/ansible-logo.png)]
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Features of Ansible
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
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  But wait! There's more
.large[
* Supports push or pull
  * Push by default but use cron job to make it pull
* Rolling updates
  * Useful for continuous deployment/zero downtime deployment
* Inventory management
  * Dynamic inventory from external data sources
  * Execute tasks against host patterns
* Ansible Vault for encrypted data
* Ad-hoc commands
  * When you just need to execute a one-off command against your inventory
]
`ansible -i inventory_file -u ubuntu -m shell -a "reboot"`

---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Ansible structure
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
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Ansible playbook layout


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

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png) Yet Another Markup Language
.large[
* But YAML is a structured language with a defined syntax (like JSON or XML)
]

```
this_is_a_variable: this_is_its_value
dict:
  foo: bar
  spam: eggs
list:
  - baz
  - 42
  - true
  - yes
```

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Ansible inventory
* An ini file.
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
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Ansible Variables
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

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Ansible Tasks
.large[
* Peform a task on the inventory
]
* These two tasks do the same thing!
* YAML-style:
  
    ```
    - name: Install nginx
      apt:
        pkg: nginx-full
        status: latest
      when: "{{ ansible_os_family }} == 'Debian'"
    ```
* Argument-style:

    ```
    - name: Install nginx
      apt: pkg=nginx-full status=latest
      when: "{{ ansible_os_family }} == 'Debian'"
    ```
    
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Ansible Tasks
.large[
* A more complex task:
]
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
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Ansible Handlers
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
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Roles contain tasks

![ansible-roles-tasks.png](images/ansible-roles-tasks.png)

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Plays
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
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Plays and Tags

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


.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  How Ansible works

![how-ansible-works.png](images/how-ansible-works.png)

.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  What's available
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
  * ansible-artimed
]
]
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Example role
.large[
* Galaxy project's role to install a Galaxy server.
* Can be used in a playbook
* Has nice documentation!

[https://github.com/galaxyproject/ansible-galaxy](https://github.com/galaxyproject/ansible-galaxy)
]
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
class: left
## ![GATC Logo](../shared-images/AdminTraining2016-100.png)  Exercise Time!
.large[
In this exercise, we will:
* Write an ansible script/role
* Task will be to install tools into Galaxy
* Will use existing scripts (bioblend)

[http://martenson.github.io/dagobah-training](http://martenson.github.io/dagobah-training)
]
.footnote[\#usegalaxy \#GATC2016 / @galaxyproject]
---
