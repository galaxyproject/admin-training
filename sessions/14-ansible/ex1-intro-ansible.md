![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Oslo2018

# Introduction to Ansible - Exercise I.

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of how Ansible roles are structured
2. Be able to write a simple role in Ansible to install a list of tools into Galaxy
3. Understand how to use a role in a playbook.

## Introduction

Occasionally as a Galaxy administrator, you will be asked to install a whole suite of tools. You could use the Galaxy Admin UI to install all of the tools but this gets old pretty quickly. We need a more *"sys-admin"* way of doing it.

This is a perfect example of what Ansible is useful for! In this exercise we will write an Ansible role to:

* Take a list of tools in YAML format
* Create an administrator user for your Galaxy server
* Get the admin user's API key
* Restart the Galaxy server
* Use a python library Ephemeris to install the tools

We will use a number of Ansible structures and modules including:

* variables
* handlers
* templates
* tasks
* files

## Preparation - Setup simple Galaxy.

We have new VMs today, so you won't have a working Galaxy installation on your Virtual Machine yet. So, we will be doing a minimal quick install of Galaxy to get up and running.

We will be cloning Galaxy from its Github repo into the home directory and then starting it up so it automatically downloads all of it its extra requirements.

* Login to your VM as the *ubuntu* user with tunneling enabled: `ssh -L 8080:localhost:8080 -i galaxy-ws.pem ubuntu@<IP>`

Once you've logged in, from your home directory, we'll need to install Python 2.7 as well as clone the Galaxy git repo:

```
sudo apt install -y python2.7 pip ansible
sudo ln -s `which python2.7` /usr/local/bin/python
git clone -b release_17.09 https://github.com/galaxyproject/galaxy.git
```

We'll need to change the name of the **galaxy.ini.sample** and **shed_tool_conf.xml.samle** files in *galaxy/config* to **galaxy.ini** and **shed_tool_conf.xml**. Then edit **galaxy.ini** using an editor. We need to uncomment the line `#host = 127.0.0.1` and set the ip to `0.0.0.0` so that the Galaxy server is available over the internet.

Once, that is complete let's start Galaxy to test it.

* Start the server with `sh ./run.sh --daemon`

If you want you can tail the log file and watch everything unfold. Once the server has finished configuring itself, try and connect to it in a web browser on port 8080 (`localhost:8080`)

If you see a Galaxy interface, everything worked! Now you can move on with learning about Ansible.

## Section 1 - Build the structure, copy some files, set some variables.

**Part 1 - Create the Ansible script directory tree**

The first thing we need to do is build the structure for the ansible role and playbook.

* From a terminal on your **remote** machine (in a suitable location such as
  home directory), run:

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

These directories represent a typical structure of an Ansible role. Note that
we will not use all of these in this exercise but they are just included as an
example. More info about the individual directories in this structure can be
found here http://docs.ansible.com/ansible/latest/playbooks_reuse_roles.html#role-directory-structure

**Part 2 - Obtain tool list file**

To instal the tools, we need a list of tools. This is typically something you
will compose yourself or extract from an existing server. There's a nice
utility script within the Ephemeris library that can help with that:
https://ephemeris.readthedocs.io/en/latest/commands/get-tool-list.html

The format of this file is as follows:

```yaml
- name: tool_name
  owner: tool_owner
  tool_panel_section_label: "Galaxy tool section name"
  revisions:
    - xxxxxxxxxx
    - yyyyyyyyyy # Can specify multiple revisions
```

For this part of the tutorial, we will download a sample list file from here
https://raw.githubusercontent.com/galaxyproject/ansible-galaxy-tools/master/files/tool_list.yaml.sample

Place that file under `roles/galaxy-tool-install/files/tool_list.yaml`.

Note that you can also use the *tool_panel_section_id* (instead of `_label`) but
note that in that case the tool section must already exist on the server or
Galaxy will install the tool outside any section. If using
`tool_panel_section_name`, Galaxy will create the necessary section if not
already there.

**Part 3 - Create some default variables.**

* Now we need to create a file in *roles/galaxy-tool-install/defaults/* called **main.yml**

This file will contain a bunch of variables that we will call upon during the rest of our role. It will contain things like:

* Path to the Galaxy server.
* Config file locations
* Name of the tool file
* Admin user name (if one already exists)

The contents of the file need to look something like this:

``` yaml
--- # This tells ansible that we have a yaml file.

# A user for the Galaxy bootstrap user
tools_admin_email: tool_install@tools.com
tools_admin_username: tools
tools_admin_password: CoolToolInstaller
galaxy_tools_api_key: adminApiKey

#The system user for Galaxy
galaxy_user: ubuntu  # Set this to whatever system user has write access to all of the Galaxy files.

galaxy_server_url: http://localhost:8080/

galaxy_server_dir: /home/ubuntu/galaxy  # Path to the Galaxy root here

# A system path where a virtualenv for Galaxy is installed
galaxy_venv_dir: "{{ galaxy_server_dir }}/.venv"

# A system path for Galaxy's configuration files
galaxy_config_file: "{{ galaxy_server_dir }}/config/galaxy.ini"
tool_conf: "{{ galaxy_server_dir }}/config/shed_tool_conf.xml"
```

## Section 2 - Build the tasks

Ansible tasks are run in order. So we just need to think about what we need to
do and when. Once we have figured that out, we create an ansible task for each
step. For this tutorial, all of our steps will reside in a single file. Note
that this does not need to be the case.

* Create a new file called **main.yml** in *roles/galaxy-tool-install/tasks/*.
  This will be our tasks list file.

The first thing we need to get our script to do is copy the tool list file on
the remote machine. We use Ansible's *copy* module for that.

Put the following into the `main.yml` file.

``` yaml
---

- name: Copy tool list file to the remote machine
  copy:
    src: tool_list.yaml
    dest: "{{ galaxy_server_dir }}/tools/"
```

Done. We've written our first ansible task. Before proceeding, let's make sure
this runs.

## Section 3 - Create a playbook and run it

Before we can run the created task, we need to write the playbook to call the
role we've created. The playbook contains a list of hosts to run on and a list
of roles to run. Ours will be simple.

* In the root directory of our Ansible playbook (i.e., `~/galaxy-tool-ansible/`), 
create a file called *playbook.yml* and add the following contents:

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
  become: yes
  become_user: "{{ galaxy_user }}"
  roles:
    - role: galaxy-tool-install
```

This playbook runs on the localhost and so the script needs to actually be on
the target machine. By adding some private/public key information and an IP
address here, we can also run this role to target a remote machine. We'll get 
to that later.

* From the root of the playbook directory, run the playbook:

  ```
  ansible-playbook -vv playbook.yml
  ```

The `-vv` here just means two levels of verbosity. It shows us what is going on.
There are 4 levels of verbosity from none to extremely verbose.

## Section 4 - Add more tasks

Now, to start installing some tools, we need to add a bunch of other tasks:

1. Obtain a script that will create a bootstrap use
1. Create the bootstrap admin user and record their api key
1. Add the bootstrap user to the *admin_users=* line in `galaxy.ini`
1. Restart Galaxy
1. Run Ephemeris *shed-tools install* command with the list of tools to install
1. Remove the bootstrap user from the *galaxy.ini* file
1. Finally, restart Galaxy again for the change to take effect

To complete these tasks we will be using various ansible modules. This is by no
means the only or best way to complete these steps but this tutorial is meant to
serve of an example of a simple ansible script.

Append the following to the tasks in the role's *main.yml*:

```yaml

- name: Download a script for creating a bootstrap user
  get_url:
    url: https://raw.githubusercontent.com/galaxyproject/ansible-galaxy-tools/master/files/manage_bootstrap_user.py
    dest: "{{ galaxy_server_dir }}/scripts/"
    mode: a+x

- name: Create a Galaxy user
  command: "{{ galaxy_venv_dir }}/bin/python scripts/manage_bootstrap_user.py -c '{{ galaxy_config_file }}' create -u '{{ tools_admin_username }}' -e '{{ tools_admin_email }}' -p '{{ tools_admin_password }}' --preset_api_key '{{ galaxy_tools_api_key }}'"
  args:
    chdir: "{{ galaxy_server_dir }}"

- name: Install Ephemeris
  pip:
    name: ephemeris

# Add the admin user to galaxy.ini (check to see if the admin users line already exists)
- name: Check/Set bootstrap user as Galaxy Admin if admin_users tag is already in the config file
  replace:
    dest: "{{ galaxy_config_file }}"
    regexp: "^[ ]*admin_users[ ]*=[ ]*"
    replace: "admin_users = {{ tools_admin_email }},"
  register: admin_users_found

- name: Set bootstrap user as Galaxy Admin
  lineinfile:
    dest: "{{ galaxy_config_file }}"
    state: present
    insertafter: "app:main"
    line: "admin_users = {{ tools_admin_email }}"
  when: admin_users_found.msg == ""

- name: Restart Galaxy
  shell: "sh ./run.sh --stop-daemon && sh ./run.sh --daemon"
  args:
    chdir: "{{ galaxy_server_dir }}"

- name: Wait for Galaxy to start
  wait_for:
    port: 8080
    delay: 5
    state: started
    timeout: 600

- name: Install the toolshed tools
  command: shed-tools install --toolsfile "{{ galaxy_server_dir }}/tools/tool_list.yaml" --api_key "{{ galaxy_tools_api_key }}"
  ignore_errors: true

- name: Remove admin bootstrap user
  replace:
    dest: "{{ galaxy_config_file }}"
    regexp: "{{ tools_admin_email}}[,]?"
    replace: ""

- name: Restart Galaxy
  shell: "sh ./run.sh --stop-daemon && sh ./run.sh --daemon"
  args:
    chdir: "{{ galaxy_server_dir }}"

- name: Wait for Galaxy to start
  wait_for:
    port: 8080
    delay: 5
    state: started
    timeout: 600
```

Phew. Done. Now we have our tasks to be completed.

Note that we have repeated some code to restart Galaxy. We should either make this a handler or a separate task file and replace it in this file with include statements...

## Section 3 - Run the playbook

We can reuse the playbook we created to test our initial task and run all
the tasks now. Before running the playbook, make sure your Galaxy instance
is running in _daemon_ mode.

```
ansible-playbook playbook.yml
```

**Remote running**

To run this playbook on a remote machine, you'll need to have a public/private ssh key setup on the remote. You then need to make an inventory or hosts file. This is quite simple and looks something like this:

``` ini
[my_hosts]
<instance_ip>
<instance_ip>

[vars]
ansible_ssh_user=ubuntu
ansible_ssh_private_key_file=<path_to_your_private_ssh_key>

```

You then need to modify the playbook slightly to use *[my_hosts]*. Change the
`- hosts: localhost` line to `- hosts: my_hosts` and remove the
`connection: local` line.

Then you can run the playbook on the hosts with the *-i hosts_file* switch:
`ansible-playbook -i hosts_file playbook.yml`

As mentioned in the slides, you can have groups of different machine types etc.
You can operate on more than one remote machine at once. For example, if you're
running a course for students and have 40 machines to add tools and/or data to,
just list all the IP addresses in the hosts file and you're set to go!

## So, what did we learn?

Hopefully, you now:
* Understand how Ansible roles are structured
* Are able to to write a simple role in Ansible to install a list of tool into Galaxy
* Understand how to use a role in a playbook.

## Further reading

If you want to know more about Ansible, details can be found at [www.ansible.com](https://www.ansible.com)

More information on the galaxy ansible scripts can be found at [github.com/galaxyproject](http://github.com/galaxyproject) and searching for key word: ansible

Suggestions and comments are welcome.
