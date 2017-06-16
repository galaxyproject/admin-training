![gcc2017 logo](../../docs/shared-images/gcc2017_logo.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GCC - 2017 - Montpellier

# Setup a production Galaxy with Ansible - Exercise.

## Learning Outcomes

By the end of this section, you should:

1. Have an understanding of how Galaxy's Ansible roles are structured and interact with one another;
2. Be able to use an Ansible playbook to install different flavors of Galaxy for different purposes;
3. Be able to write a playbook to suit your own purposes.

## Introduction

We will be making use of the Galaxy project's pre-written Ansible roles and will look at how they are combined in a project.

In this exercise we will:

1. Download an Ansible playbook and associated roles.
1. Walk through the various parts including the roles and the playbook.
1. Discuss the group vars file
1. Go through the Ansible "galaxy" - an unfortunate name... (It's Ansible's ToolShed.)

## Section 1 - The tutorial script source files.

Go to somewhere sensible on either your local machine or on your Galaxy server (/home/<your_username> would be sensible.)

* Grab the following with `wget` or `curl` and then untar it.

  `https://iu.jetstream-cloud.org:8080/swift/v1/gcc2017/gcc2017-ansible.tar.gz`

This will copy the entire playbook and associated roles to somewhere we can look at it.

**Part 1 - Examine the playbook**

Have a look at the *playbook.yml* file. You'll notice that it contains quite a number of plays each of which reference a different role/s. The order in which the roles are referenced is important. This playbook does the following:

1. Performs some system tasks (system packages, creates a galaxy user, etc.)
1. Installs Postgres and Nginx
1. Configures Postgres
1. Installs and configures Galaxy
1. Installs and configures ProFTPD
1. Installs and configures supervisor

Take note of the fact that the playbook combines the individual roles to give us the desired outcome.

**Part 2 - Ansible galaxy**

Where do the roles come from? Ansible has a "ToolShed"-like system called **Ansible Galaxy** - d'oh.

Open the *commands.txt* file. You'll see a series of commands that download the various roles from the Ansible galaxy and put them in an appropriate place in our scripts file tree (e.g. `ansible-galaxy install -p roles galaxyproject.postgresql`) followed by a command to run the playbook (e.g., `ansible-playbook -i inventory playbook.yml`)

There are many roles available for download for various aspects of system administration or application setup. They all have some meta data associated with them which has information on the role's author, keywords, dependencies, licenses, available platforms etc. All of the roles in our script have that information. The Ansible Galaxy can be browsed at: [https://galaxy.ansible.com/](https://galaxy.ansible.com/). Checkout the *main.yml* in any of [Galaxy project's role's](https://galaxy.ansible.com/galaxyproject/) *meta* directory.

Let's go ahead and download the necessary and available roles. A couple of roles have already been included in the archive we downloaded earlier so let's use Ansible Galaxy to download the rest:

```
ansible-galaxy install -p roles galaxyproject.postgresql
ansible-galaxy install -p roles natefoo.postgresql_objects
ansible-galaxy install -p roles galaxyproject.nginx
ansible-galaxy install -p roles galaxyproject.galaxy
```

**Part 3 - Browse the roles**

The demonstrator will now work through a couple of the roles and will run the playbook on a machine for us.

The roles used by this playbook use are:

| Order run | Role name | Purpose | Variables to consider |
| --------- | --------- | ------- | --------------------- |
| 0 | global_vars | Set some variables for the entire playbook | galaxy_server_dir, galaxy_changeset_id |
| 1 | galaxyproject.postgresql | Installs postgreSQL database server.| postgresql_backup_local_dir |
| 2 | galaxyproject.nginx | Installs and configures nginx (web server) |  |
| 3 | natefoo.postgresql_objects | Installs postgreSQL scripts to work with privileges etc. |  |
| 4 | galaxyproject.galaxy | Installs and configures Galaxy | galaxy_server_dir, galaxy_vcs (git or hg) |
| 5 | supervisor | Installs supervisor configs for Galaxy | . |
| 6 | proftpd | Installs ProFTPD configs for Galaxy | . |

You'll note that these roles all have pretty good documentation on how to use them, which variables to set and how, and when they should be used. This makes it all much easier to understand.

Have a look at any one role, concentrating mainly on the variables (in the `defaults/main.yml` files and the vars directory if present.) By modifying these variables, you can customize things like, where postgreSQL keeps it's backups, where Galaxy is installed, and many others.

**Part 4 - Run the playbook**

To run the role we will need a Linux instance (we will use Ubuntu 16.04) with a set public/private keypair, or we need to run the playbook "locally" (i.e. on the managed host itself). We will also need to know it's IP address.

* Make sure that all the variables in *group_vars/galaxyservers.yml* are set as follows:

``` yaml
galaxy_user: galaxy

postgresql_objects_users:
  - name: galaxy

postgresql_objects_databases:
  - name: galaxy
    owner: galaxy

galaxy_root_dir: /srv/galaxy
galaxy_server_dir: "{{ galaxy_root_dir }}/server"
galaxy_config_dir: "{{ galaxy_root_dir }}/config"
galaxy_mutable_config_dir: "{{ galaxy_root_dir }}/config"
galaxy_venv_dir: "{{ galaxy_root_dir }}/venv"
galaxy_shed_tools_dir: "{{ galaxy_root_dir }}/shed_tools"
galaxy_vcs: git
galaxy_changeset_id: release_17.01

galaxy_config:
  "app:main":
    database_connection: postgresql:///galaxy?host=/var/run/postgresql
    file_path: "{{ galaxy_root_dir }}/data"
    tool_dependency_dir: "{{ galaxy_root_dir }}/dependencies"
    admin_users: your@ema.il                                            # <---- Put your user email here
    galaxy_data_manager_data_path: "{{ galaxy_root_dir }}/tool-data"
    auth_config_file: "{{ galaxy_config_dir }}/auth_conf.xml"
    job_config_file: "{{ galaxy_config_dir }}/job_conf.xml"
    nginx_x_accel_redirect_base: /_x_accel_redirect
    nginx_upload_store: "{{ galaxy_root_dir }}/upload_store"
    nginx_upload_path: /_upload
    ftp_upload_dir: "{{ galaxy_root_dir }}/ftp"
    ftp_upload_site: galaxy.example.org
    conda_auto_init: "True"
  "uwsgi":
    processes: 2
    threads: 2
    socket: 127.0.0.1:4001
    pythonpath: lib
    master: True
    logto: "{{ galaxy_root_dir }}/log/uwsgi.log"
    logfile-chmod: 644

galaxy_config_files:
  - src: files/galaxy/job_conf.xml
    dest: "{{ galaxy_config_dir }}/job_conf.xml"
  - src: files/galaxy/auth_conf.xml
    dest: "{{ galaxy_config_dir }}/auth_conf.xml"

nginx_flavor: extras

nginx_configs:
  - galaxy

supervisor_configs:
  - galaxy

proftpd_configs:
  - galaxy
```

* Set the contents of the *inventory* file appropriately.

``` ini
[galaxyservers]
localhost

[galaxyservers:vars]
ansible_connection=local
ansible_become=yes
```

Now it's just a matter of running:

`ansible-playbook -i inventory -vv playbook.yml`

The `-vv` switch indicates that we want the 2nd level of verbosity - it is a handy one to have if you want to see what is going on.
The Ansible script will run and display what it's doing as it does. (Always a good idea to run it in a screen or something since networks are sometimes flaky!)

Once the playbook has completed its run we can access Galaxy on the machine we installed it on. The playbook has setup the Postgres database, Nginx proxy server, ProFTPD ftp server, Galaxy, and the necessary configurations.

**Part 5 - Upgrade Galaxy**

This playbook uses the stable release of Galaxy 17.01. Let's use our Ansible setup to upgrade it to 17.05. To do this, open up `group_vars/galaxyservers.yml`, locate the definition of `galaxy_changeset_id`, and update it:

```yaml
galaxy_changeset_id: release_17.01
```

Then run the same `ansible-playbook` command:

```console
ansible-playbook -i inventory playbook.yml
```
After it finished, we'll need to restart Galaxy. The playbook configured Supervisor to manage Galaxy so we'll restart Galaxy as follows:
```
$ sudo supervisorctl
supervisor> restart gx:
```

This will restart the job handlers and the Galaxy uWSGI server.

## So, what did we learn?

Hopefully, you now understand:
* How Ansible combines roles with a playbook;
* Where to go to get more roles to add to a playbook;
* How to install Galaxy on a machine using Ansible.

## Further reading

If you want to know more about Ansible and Galaxy, see the Galaxy Project Github page:  [https://github.com/galaxyproject](https://github.com/galaxyproject) and search for "ansible".

If you want to know more about Ansible, details can be found at [www.ansible.com](https://www.ansible.com)
