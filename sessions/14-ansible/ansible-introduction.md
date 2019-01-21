layout: true
class: inverse
---
class: special, center, middle

# Ansible


.footnote[\#usegalaxy / @galaxyproject]
---
class: center, middle

# Please interrupt

*We are here to answer questions!*

.footnote[\#usegalaxy / @galaxyproject]

---
# What is Ansible
.large[
* Automation tool for configuring and managing computers. (c.f. Puppet, Chef etc.)
* Initial release: Feb. 2012
* Multi-node software deployment, Ad-hoc task execution, Configuration management
]
![ansible-vanilla.png](images/ansible-vanilla.png)

.footnote[\#usegalaxy / @galaxyproject]

---
# Why?
.large[
* Avoid forgetting what you did to install and configure some piece of software
* Codify knowledge about a system
* Make process replicable
* Make it programmable - “Infrastructure as Code”
]
.right[![ansible-logo](images/ansible-logo.png)]
.footnote[\#usegalaxy / @galaxyproject]

---
# Core features of Ansible
.large[
* **Easy to learn**
  * Playbooks in YAML, Templates in Jinja2, Inventory in INI file
  * Sequential execution
* **Minimal requirements (Agentless)**
  * No need for centralised management servers/daemons
  * Single command to install (pip install ansible)
  * Uses SSH to connect to target machine
* **Idempotent**
  * Executing N times no different to executing once.
  * Prevents side-effects from re-running scripts
* **Extensible**
  * Write your own modules
]

---
# Ansible structure
.large[
* Ansible scripts are called playbooks
* Scripts written as yaml files
* Can be structured in a folder hierarchy
* Many available modules
  * apt, git, command, shell, postgresql_db
  * file, lineinfile, get_url, curl, homebrew
  * cron, mount etc
]
[http://docs.ansible.com/ansible/modules_by_category.html](http://docs.ansible.com/ansible/modules_by_category.html)
.footnote[\#usegalaxy / @galaxyproject]

---
# Ansible playbook layout

```
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
# Yet Another Markup Language
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

.footnote[\#usegalaxy / @galaxyproject]

---
# Ansible inventory
* An _ini_ file
* List of remote machines to run Ansible on
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
# Ansible Variables
.left-column-equal[
**Group Variables**

e.g. `galaxy_servers.yml`

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

e.g. `galaxy-web-01.tacc.utexas.edu.yml`

```
server_codename: main_w1
galaxy_installer: true
```
]

.footnote[\#usegalaxy / @galaxyproject]

---
# Ansible Tasks

Perform a task on the inventory

```
- name: Install nginx
  apt:
    pkg: nginx-full
    status: latest
  when: "{{ ansible_os_family }} == 'Debian'"
```

.footnote[\#usegalaxy / @galaxyproject]

---
# Roles contain tasks

![ansible-roles-tasks.png](images/ansible-roles-tasks.png)

.footnote[\#usegalaxy / @galaxyproject]

---
# Plays
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
# Plays and Tags

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
# How Ansible works

![how-ansible-works.png](images/how-ansible-works.png)

.footnote[\#usegalaxy / @galaxyproject]

---
# Example role
.large[
* Galaxy project's role to install a Galaxy server.
* Can be used in a playbook
* Has nice documentation!

[https://github.com/galaxyproject/ansible-galaxy](https://github.com/galaxyproject/ansible-galaxy)
]
.footnote[\#usegalaxy / @galaxyproject]

---
# What's available
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
