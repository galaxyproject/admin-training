![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GCC BOSC 2018

# Setup a production Galaxy with Ansible - Exercise.

## Learning Outcomes

By the end of this section, you should:

1. Have an understanding of how Galaxy's Ansible roles are structured and interact with one another;
2. Be able to use an Ansible playbook to install different flavors of Galaxy for different purposes;
3. Be able to write a playbook to suit your own purposes.

## Introduction

We will be making use a number of pre-written Ansible roles and will look at
how they are combined in a project, in the form of an Ansible playbook.

In this exercise we will:

1. Download an Ansible playbook and associated roles;
1. Walk through the various parts of the playbook;
1. Discuss the group vars file;
1. Go through the Ansible "Galaxy" - an unfortunate name... (It's Ansible's ToolShed.)

## Section 1 - The playbook used for the tutorial: GalaxyKickStart

Over the years, the Galaxy project and the broader community have developed a
number of (reusable) Ansible roles for managing various aspects of the Galaxy
runtime environment. These roles can be mixed and matched to obtain the desired
result and one example of such role composition is the GalaxyKickStart playbook.
GalaxyKickStart (GKS) is a community-led project that automates the setup of a
typical, production Galaxy server. Much of the documentation about the
project is available at https://artbio.github.io/GalaxyKickStart/.

One thing to keep in mind here is the a pre-built playbook such as the GKS is
very _opinionated_ - meaning that much of the layout of the system is determined
by the playbook itself, hence imposing that structure automatically onto the
user. For the purposes of this training, and often the real world, this is
desirable because it captures and builds on the knowledge and experience of the
people that built the playbook.

On the other hand, individual roles frequently have quite the opposite goal -
making smaller and highly configurable tasks reusable. Roles are often written
to accommodate multiple target operating systems and can be controlled via
numerous variables. When maximum flexibility is desired, feel free to use
existing playbooks, such as the GKS, as examples but it is likely you will want
to write your own by composing and parameterizing available roles.

To use the GKS playbook, we need to get a local copy by cloning the repository.
Go to your home directory on your Galaxy server, clone the GitHub repository,
and use `ansible-galaxy` command to install all the dependent roles:

```
  sudo pip install ansible
  git clone https://github.com/ARTbio/GalaxyKickStart
  cd GalaxyKickStart
  ansible-galaxy install -r requirements_roles.yml -p roles --force
```

The last command will install all the dependent roles the playbook uses into the
`roles` subdirectory by downloading them from their respective repositories.
When you want to update your local copy of the roles, just rerun that command
(note that the `--force` flag, which will cause local copies of the roles to be
overwritten).

**Part 1 - Examine the playbook**

Have a look at the *galaxy.yml* file. You'll notice that it contains quite a
number of roles. The order in which the roles are referenced is important
because the playbook executes sequentially. This playbook does the following:

1. Performs some system tasks (installs Python if missing, checks Ansible version, etc.)
1. Installs base operating system requirements for running Galaxy
1. Configures PostgreSQL
1. Installs and configures Galaxy
1. Installs and configures Supervisor
1. Sets up Galaxy for production use
1. Sets up Trackster and installs tools

Take note of the fact that the playbook combines the individual roles to give
us the desired outcome.

**Part 2 - Ansible galaxy**

Where do the roles come from? Ansible has a "ToolShed"-like system called **Ansible Galaxy** - d'oh.

Open the *requirements_roles.yml* file. You'll see a series of repositories that
point to the various roles from their respective GitHub repositories.
The `ansible-galaxy install` fetches those repositories and puts them in the
appropriate place in our scripts file tree.

An alternative to obtaining roles from GitHub is to download them directly from
the Ansible Galaxy hub: https://galaxy.ansible.com/. Instead of using roles
directly from GitHub, roles can be deposited here and then downloaded using the
same `ansible-galaxy install` command. In order to deposit a role there, you'll
have to import it there first from your GitHub account.

There are many roles already available for download for various aspects of
system administration or application setup. They all have some meta data
associated with them which has information on the role's author, keywords,
dependencies, licenses, available platforms etc. For example, take a look at
some of the roles published by the [Galaxy project](https://galaxy.ansible.com/galaxyproject/).

Note that in addition to the roles obtained from Ansible Galaxy, there are a
number of them already included in the source of the GKS playbook.

**Part 3 - Run the playbook**

We are going to run the playbook now and talk about some of the details while it
is running. To run the playbook we will need a Linux instance (we will use
Ubuntu 16.04) with a set public/private keypair, or we need to run the playbook
"locally" (i.e. on the managed host itself).

* Let's create our own set of variables. Keep in mind that we're adding and/or
  overriding variables defined in `group_vars/all` so only the variables we want
  to change need to be set here while the rest will adopt their defaults. Create
  a file *group_vars/gccbosc18.yml* and set the following variables:

``` yaml
galaxy_root_dir: /srv/galaxy
galaxy_server_dir: "{{ galaxy_root_dir }}/server"
galaxy_venv_dir: "{{ galaxy_root_dir }}/venv"
galaxy_mutable_data_dir: "{{ galaxy_data }}"
proftpd_files_dir: "{{ galaxy_data }}/ftp"
galaxy_config_dir: "{{ galaxy_root_dir }}/config"
galaxy_mutable_config_dir: "{{ galaxy_config_dir }}"
galaxy_shed_tools_dir: "{{ galaxy_root_dir }}/shed_tools"
galaxy_tool_dependency_dir: "{{ galaxy_root_dir }}/dependencies"
tool_dependency_dir: "{{ galaxy_tool_dependency_dir }}"
galaxy_job_conf_path: "{{ galaxy_config_dir }}/job_conf.xml"
galaxy_job_metrics_conf_path: "{{ galaxy_config_dir }}/job_metrics_conf.xml"
nginx_upload_store_path: "{{ galaxy_data }}/upload_store"
tool_data_table_config_path: "{{ galaxy_config_dir }}/tool_data_table_conf.xml,/cvmfs/data.galaxyproject.org/managed/location/tool_data_table_conf.xml"
len_file_path: "{{ galaxy_config_dir }}/len"
galaxy_log_dir: "{{ galaxy_root_dir }}/log"
supervisor_slurm_config_dir: "{{ galaxy_log_dir }}"

galaxy_manage_trackster: False
galaxy_extras_config_cvmfs: True
galaxy_restart_handler_enabled: True
galaxy_mule_handlers: True
galaxy_handler_processes: 1

galaxy_config_style: yaml
galaxy_config_file: "{{ galaxy_config_dir }}/galaxy.yml"

galaxy_config:
  galaxy:
    database_connection: "{{ galaxy_db }}"
    file_path: "{{ galaxy_data }}/datasets"
    new_file_path: "{{ galaxy_data }}/tmp"
    galaxy_data_manager_data_path: "{{ galaxy_data }}/tool-data"
    job_config_file: "{{ galaxy_job_conf_path }}"
    ftp_upload_dir: "{{ proftpd_files_dir }}"
    ftp_upload_site: ftp://[server IP address]
    tool_data_table_config_path: "{{ tool_data_table_config_path }}"
    len_file_path: "{{ len_file_path }}"
  uwsgi:
    module: galaxy.webapps.galaxy.buildapp:uwsgi_app()


additional_files_list:
  - { src: "extra-files/galaxy-kickstart/logo.png", dest: "{{ galaxy_server_dir }}/static/images/" }
  - { src: "extra-files/tool_sheds_conf.xml", dest: "{{ galaxy_config_dir }}" }
  - { src: "extra-files/cloud_setup/vimrc", dest: "/etc/vim/" }
```

* Let's add a pre-task to create our desired system galaxy user.
  Add the following at the end of the `pre-tasks` section of the playbook in
  `galaxy.yml`:
``` yaml
    - name: Create galaxy system user
      user:
        name: "galaxy"
        home: "/srv/galaxy"
        skeleton: "/etc/skel"
        shell: "/bin/bash"
        system: yes
      tags:
          - always
```

* Create a new *inventory* file and set its contents to the following:
``` ini
[gccbosc18]
localhost ansible_connection=local
```

If you were targeting a remote machine, your inventory file would look like this
``` ini
[gccbosc18]
158.39.75.18 ansible_user="ubuntu" ansible_ssh_private_key_file=pk.pem
```

Now it's just a matter of running:

```
ansible-playbook -i inventory galaxy.yml --tags "install_galaxy,install_extras"
```

The Ansible script will run and display what it's doing as it does (it's a good
idea to run it in a _screen_ since networks are sometimes flaky). It should take
up to 15 minutes for the playbook to run to completion.

Once the playbook has completed its run, we can then access and use Galaxy on
the machine we installed it on. The playbook has setup the PostgreSQL database,
Nginx proxy server, ProFTPD ftp server, Galaxy, CVMFS for reference data, and
the necessary configurations.

Galaxy is now managed via Supervisord. To list all the programs issue
`sudo supervisorctl status` command. If you need to change any of the settings,
the Galaxy configuration file `` is located in `/srv/galaxy/config`, as per
our variable definition above. After you've made the changes, restart the
Galaxy process with `sudo supervisorctl restart galaxy:`. We can try this by
adding a Galaxy admin user. Let's first register as a new user in the Galaxy
interface and then do the following:
```
$ sudo su galaxy
$ vi /srv/galaxy/config/galaxy.ini
# Add the following line under [app:main] section
admin_users = your@email.address
$ exit  # change back to ubuntu user
$ sudo supervisorctl restart galaxy:
```

Reload your Galaxy page and the _Admin_ tab should appear.

**Part 4 - Browse the roles**

While the playbook is running, let's take a look through a couple of the roles.

Some of the roles used by this playbook are:

| Order run | Role name | Purpose |
| --------- | --------- | ------- |
| 1 | [galaxyproject.galaxy-os](https://galaxy.ansible.com/galaxyproject/galaxy-os/) | Set up the operating system basics |
| 2 | galaxyproject.postgresql | Installs PostgreSQL database server |
| 3 | natefoo.postgresql_objects | Installs PostgreSQL scripts to work with privileges etc. |
| 4 | galaxyproject.galaxy | Installs and configures Galaxy |
| 5 | galaxyproject.galaxy-extras | Installs and configures Galaxy for production use |
| 6 | galaxyproject.trackster | Configures Trackster |
| 7 | galaxyproject.galaxy-tools | Installs tools into Galaxy from the ToolShed |

You'll note that these roles all have pretty good documentation on how to use
them, which variables to set and how, and when they should be used. This makes
it all much easier to understand.

Have a look at any one role, concentrating mainly on the variables (in the
`defaults/main.yml` file and the `vars` directory if present). By modifying
these variables, you can customize things like, where PostgreSQL keeps it's
backups, where Galaxy is installed, and many others.

## Section 2 - Using CVMFS for reference data (time permitting)

One particularly nice aspect of the the system that we built is that is comes
configured with a Cern Virtual Macine File System (CVMFS) for Galaxy's reference
data. This file system represents an additional method for obtaining reference
data for a Galaxy installation and tends to be the simplest for getting a large
amount of data readily available.

So how does it work? The Galaxy community hosts a number of geographically
distributed replicas of the read-only file system that clients can simply
mount locally. CVMFS software then streams and caches the requested data locally
for the tools to use.

Give it a try by navigating to `/cvmfs/data.galaxyproject.org` and exploring
the contents of those folders. You can also install `bwa` tool for example in
Galaxy, upload a _fastqsanger_ file, and observe the list of available built-in
genomes. Pretty cool given we didn't have to set any of it up by hand!

How is it configured though? It's pretty easy to check and get all the details
for the setup by inspecting the set of Ansible tasks used to configure it - an
immediate example of the benefits of using code to manage infrastructure:
https://github.com/galaxyproject/ansible-galaxy-extras/blob/master/tasks/cvmfs_client.yml

## So, what did we learn?

Hopefully, you now understand:
* How Ansible combines roles with a playbook;
* Where to go to get more roles to add to a playbook;
* How to install Galaxy on a machine using Ansible.

## Further reading

If you want to know more about Ansible and Galaxy, see the Galaxy Project GitHub
page: [https://github.com/galaxyproject](https://github.com/galaxyproject) and
search for "ansible".

If you want to know more about Ansible, details can be found at
[www.ansible.com](https://www.ansible.com).
