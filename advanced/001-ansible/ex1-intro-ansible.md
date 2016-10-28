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

## Section 1 - Build the structure and set some variables.

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

* Now we need to create a file in *roles/galaxy-tool-install/defaults/* called **main.yml**

This file will contain a bunch of variables that we will call upon during in the rest of our role. It will contain things like:

* Path to the Galaxy server.
* Config file locations
* Name of the tool file
* Admin user name (if one already exists)

The contents of the file need to look something like this:

``` yaml
#The system user for Galaxy
galaxy_user: galaxy #Set this to whatever system user has write access to all of the Galaxy files.

# A list of yml files that list the tools to be installed. See `files/tool_list.yaml.sample`
galaxy_tools_tool_list_files: [ "tool_list.yaml" ]

# should the playbook continue when errors are found
galaxy_tools_ignore_errors: true

# A system path from where this role will be run
galaxy_tools_base_dir: /mnt/galaxy/tmp

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
```

## Section 2 - Start building the tasks

Ansible tasks are run in order. So we just need to think about what we need to do and when. The first thing we need to get our script to do is to create an admin user..

* Create a new file called **main.yml** in *roles/galaxy-tool-install/tasks/*

``` yaml

```