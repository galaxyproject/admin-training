![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Reference Genomes - Exercise.

#### Authors: Simon Gladman. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of how Ansible roles are structured
2. Be able to to write a simple role in Ansible to install a list of tool into Galaxy
3. Understand how to use a role in a playbook.

## Introduction

Occasionally as a Galaxy administrator, you will be asked to install a whole suite of tools. You could use the Galaxy Admin UI to install all of the tools but this gets old pretty quickly.. We need a more *"sys-admin"* way of doing it. 

This is a perfect example of what Ansible is useful for! In this exercise we will write an Ansible role to:

* Take a list of tools in YAML format
* Create an administrator user for your Galaxy server
* Get the admin user's API key
* Use a python bioblend script to install the tools
* Restart the Galaxy server!

We will use a number of Ansible structures and modules including:

* variables
* handlers
* templates
* tasks
* files

## Section 1 - Build the structure, copy some files, set some variables.

**Part 1 - Create the ansible script directory tree**

The first thing we need to do is build the structure for the ansible role and playbook.

* From a terminal on your **remote** machine (in a suitable place..)

``` bash
mkdir galaxy-tool-ansible
cd galaxy-tool-ansible

mkdir -p roles/galaxy-tool-install/defaults
mkdir -p roles/galaxy-tool-install/files
mkdir -p roles/galaxy-tool-install/tasks
mkdir -p roles/galaxy-tool-install/handlers
mkdir -p roles/galaxy-tool-install/templates
mkdir -p roles/galaxy-tool-install/meta

```

**Part 2 - Copy some needed files**

For this tutorial we will need a few files. A couple of python scripts that will be run on the remote machine and a list of tools to install. They are located in a swift container in Australia. We need to download the tarball and extract it.

* From the same terminal, in the files directory. Use wget to download the files. They are located at: *https://swift.rc.nectar.org.au:8888/v1/AUTH_377/public/Ansible_files/files_for_tool_ansible.tgz*

* Untar them! (`tar -xvf files_for_tool_ansible.tgz`)

You will now have 3 files in your directory. They are:

* **install_tool_shed_tools.py**. This is a python script that will take a list of tools in yaml format and install them into a Galaxy server given an admin user's api key.
* **manage_bootstrap_user.py**. This is a python script that will create an admin user by directly editing the Galaxy database. When run in create mode, it returns the admin user's api key
* **tool_list.yaml**. This is a list of tools to install. The format is as follows:

```yaml
- name: tool_name
  owner: tool_owner
  tool_shed_url: https://toolshed.g2.bx.psu.edu #e.g.
  tool_panel_section: section_name
  revisions:
    - xxxxxxxxxx
    - yyyyyyyyyy #can specify multiple revisions.
```

Note that the *section_name* has to exist prior to running the script! Therefore, we will need to add a couple of sections to our *shed_tool_conf.xml* file in the tasks..

**Part 3 - Create some default variables.**

* Now we need to create a file in *roles/galaxy-tool-install/defaults/* called **main.yml**

This file will contain a bunch of variables that we will call upon during in the rest of our role. It will contain things like:

* Path to the Galaxy server.
* Config file locations
* Name of the tool file
* Admin user name (if one already exists)

The contents of the file need to look something like this:

``` yaml
#The system user for Galaxy
galaxy_user: ubuntu #Set this to whatever system user has write access to all of the Galaxy files.

galaxy_server_url: http://localhost:8080/

# Blank variable to make sure it's defined
galaxy_tools_api_key: ''

# A user for the Galaxy bootstrap user
tools_admin_email: tool_install@tools.com
tools_admin_username: tools
tools_admin_password: CoolToolInstaller

galaxy_server_dir: /srv/galaxy #Put the actual path to your Galaxy root here

# A system path where a virtualend for Galaxy is installed
galaxy_venv_dir: "{{ galaxy_server_dir }}/.venv"

# A system path for Galaxy's main configuration file
galaxy_config_file: "{{ galaxy_server_dir }}/config/galaxy.ini"

#The Galaxy pid and log file names.
galaxy_pid_file: main.pid
galaxy_log_file: main.log

tool_conf: "{{ galaxy_server_dir}}/config/shed_tool_conf.xml"
```

## Section 2 - Build the tasks

Ansible tasks are run in order. So we just need to think about what we need to do and when. Once we have figured that out, we create an ansible task for each step. For this tutorial, all of our steps will reside in a single file. Note that this does not need to be the case.

* Create a new file called **main.yml** in *roles/galaxy-tool-install/tasks/*. This will be our tasks list file.

The first thing we need to get our script to do is copy the python scripts we need to use into the correct place in the Galaxy file tree on the remote machine. We use the *copy* ansible module for that.

Put the following into the main.yml file.

``` yaml
--- #this tells ansible that we have a yaml file.. 

- name: Copy files to remote machine.
  copy: src="{{ item }}" dest="{{ galaxy_server_dir }}/scripts/{{ item }}" owner="{{ galaxy_user }}" mode="u+rwx"
  become: yes
  become_user: "{{ galaxy_user }}"
  with_items:
    - install_tool_shed_tools.py
    - manage_bootstrap_user.py

```

Done. We've written our first ansible task. This one is using a list of items to copy...

Now we need to add a bunch of other tasks. We need to:

1. Create the bootstrap admin user and record their api key
1. Add the bootstrap user to the *admin_users=* line in galaxy.ini
1. Restart Galaxy
1. Run *install_tool_shed_tools.py* with the list of tools to install and the api key.
1. Remove the bootstrap user from the *galaxy.ini* file and the Galaxy database.
1. Finally, we probably should restart Galaxy for good measure.

To complete these tasks we will be using various ansible modules. This is by no means the only or best way to complete this task but this tutorial is meant to serve of an example of a simple ansible script.

Add the following to your tasks *main.yml*

```yaml

- name: Create the bootstrap user
  command: chdir="{{ galaxy_server_dir }}" .venv/bin/python scripts/manage_bootstrap_user.py -c "{{ galaxy_config_file }}" create -u "{{ tools_admin_username }}" -e "{{ tools_admin_email }}" -p "{{ tools_admin_password }}"
  register: api_key
  become: yes
  become_user: "{{ galaxy_user }}"

- debug: var=api_key

#set the api key for irida to the one that was returned
- set_fact: galaxy_tools_api_key="{{ api_key.stdout_lines[0] }}"

#Add the admin user to galaxy.ini (check to see if the admin users line already exists)
- name: Check/Set bootstrap user as Galaxy Admin if admin_users tag is already in the config file
  replace: dest="{{ galaxy_config_file }}" regexp="^[ ]*admin_users[ ]*=[ ]*" replace="admin_users = {{ tools_admin_email }},"  #"
  register: admin_users_found
  become: yes
  become_user: "{{ galaxy_user }}"

- name: Set bootstrap user as Galaxy Admin
  lineinfile: dest="{{ galaxy_config_file }}" state=present insertafter="app:main" line="admin_users = {{ tools_admin_email }}"  #"
  when: admin_users_found.msg == ""
  become: yes
  become_user: "{{ galaxy_user }}"

#Copy the tool list to galaxy_server_dir
- name: Copy the tool list to galaxy_server_dir
  copy: src="tool_list.yaml" dest="{{ galaxy_server_dir }}/tool_list.yaml"
  become: yes
  become_user: "{{ galaxy_user }}"

# Add some required sections to the shed_tool_conf.xml file
- name: Insert some sections into the tool panel file
  lineinfile: dest="{{ tool_conf }}" insertbefore="^</toolbox>" line="{{ item }}" state=present
  with_items:
    - "<section id='peak_calling' name='Peak Calling'>"
    - "</section> #peak_calling"
    - "<section id='cshl_library_information' name='CSHL Library Information'>"
    - "</section> #cshl_library_information"
  become: yes
  become_user: "{{ galaxy_user }}"

#restart Galaxy
- name: stop Galaxy
  command: sh "{{ galaxy_server_dir }}"/run.sh --pid-file "{{ galaxy_pid_file }}" --log-file "{{ galaxy_log_file }}" --stop-daemon
  become: yes
  become_user: "{{ galaxy_user }}"

- name: Wait for Galaxy to stop
  wait_for: port=8080 delay=5 state=stopped timeout=300

- name: Start Galaxy
  command: sh "{{ galaxy_server_dir }}/run.sh" --pid-file "{{ galaxy_pid_file }}" --log-file "{{ galaxy_log_file }}" --daemon
  become: yes
  become_user: "{{ galaxy_user }}"

- name: Wait for Galaxy to start
  wait_for: port=8080 delay=5 state=started timeout=600

#Install the tools!
- name: Install the toolshed tools!
  command: chdir="{{ galaxy_server_dir }}" "{{ galaxy_venv_dir }}/bin/python" "{{ galaxy_server_dir }}"/scripts/install_tool_shed_tools.py -g "{{ galaxy_server_url }}" -a "{{ galaxy_tools_api_key }}" -t tool_list.yaml
  become: yes
  become_user: "{{ galaxy_user }}"
  ignore_errors: true

#Now de admin the bootstrap user..
- name: De-admin the bootstrap user
  replace: dest="{{ galaxy_config_file }}" regexp="{{ tools_admin_email}}[,]?" replace=""
  become: yes
  become_user: "{{ galaxy_user }}"

#Finally, restart Galaxy for good measure..
- name: stop Galaxy
  command: sh "{{ galaxy_server_dir }}/run.sh" --pid-file "{{ galaxy_pid_file }}" --log-file "{{ galaxy_log_file }}" --stop-daemon
  become: yes
  become_user: "{{ galaxy_user }}"

- name: Wait for Galaxy to stop
  wait_for: port=8080 delay=5 state=stopped timeout=300

- name: Start Galaxy
  command: sh "{{ galaxy_server_dir }}/run.sh" --pid-file "{{ galaxy_pid_file }}" --log-file "{{ galaxy_log_file }}" --daemon
  become: yes
  become_user: "{{ galaxy_user }}"

- name: Wait for Galaxy to start
  wait_for: port=8080 delay=5 state=started timeout=600
```

Phew. Done. Now we have our tasks to be completed.

Note that we have repeated some code to restart Galaxy. We should either make this a handler or a separate task file and replace it in this file with include statements...

## Section 3 - Write the playbook

Now we need to write the playbook to call the role we've created. The playbook contains a list of hosts to run on and a list of roles to run. Ours will be simple..

* In the root directory of our Ansible script, create a file called *playbook.yml* and add the following contents:

``` yaml
---
# file: playbook.yml
#   Use this file to run the galaxy-tool-install script

# Use this role via the following command:
#
#   % ansible-playbook playbook.yml
#
- hosts: localhost
  connection: local
  sudo: yes
  roles:
    - role: galaxy-tool-install
```

This playbook runs on the localhost and so the script needs to actually be on the target machine. By adding some private/public key information and an ip address here, we can also run this role on a remote machine.


## Section 4 - Run the playbook!

Now we can run the playbook on our Galaxy instance! (The entire script directory tree needs to be present on the target machine as we are running it using localhost...)

* From the root of the script directory: `ansible-playbook -vv playbook.yml`

The -vv here just means two levels of verbosity.. It shows us what is going on. There are 4 levels of verbosity from none to extremely verbose...

## So, what did we learn?

Hopefully, you now:
* Understand how Ansible roles are structured
* Are able to to write a simple role in Ansible to install a list of tool into Galaxy
* Understand how to use a role in a playbook.

## Further reading

If you want to know more about Ansible, details can be found at [www.ansible.com](https://www.ansible.com)

More information on the galaxy ansible scripts can be found at [github.com/galaxyproject](http://github.com/galaxyproject) and searching for key word: ansible

Suggestions and comments are welcome. Please contact:
