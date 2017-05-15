![GATC Logo](../../docs/shared-images/gatc2017_logo_150.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2017 - Melbourne

# Setup a production Galaxy with Ansible - Exercise.

#### Authors: Nate Coraor, Enis Afgan, Nuwan Goonasekera, Simon Gladman. 2017

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of how Galaxy's Ansible roles are structured and interact with one another.
2. Be able to use an ansible playbook to install different flavours of Galaxy for different purposes.
3. Be able to write a playbook to suit your own purposes.

## Introduction

In exercise 1 we wrote a role called "galaxy-tool-install" which we then ran to install a few tools to our Galaxy server. In this exercise, we will look at how to combine multiple roles into install a complete production Galaxy server.

Luckily for us, the staff of the Galaxy project have thought about this quite a bit and have written roles for *all the things!* We will be making use of the Galaxy projects pre-written roles and will look at how they are combined in a project.

In this exercise we will:

1. Download an ansible playbook and associated roles.
1. Walk through the various parts including the roles and the playbook.
1. Discuss the group vars file
1. Go through the Ansible "galaxy" - an unfortunate name... (It's Ansible's toolshed.)

## Section 0 - Undo what we've done so far.

In the next section, we'll do with Ansible in a few minutes what we've done by hand over the last couple of days. To start, let's save what we've done:

```console
$ sudo supervisorctl shutdown
$ sudo systemctl stop nginx postgresql proftpd
$ for d in /srv/galaxy /etc/nginx /etc/supervisor /etc/proftpd /var/lib/postgresql
do
    sudo mv $d ${d}.old
done
$ sudo apt remove --purge nginx-extras postgresql postgresql-9.5 proftpd-basic proftpd-mod-pgsql uwsgi uwsgi-plugin-python supervisor
$ sudo apt autoremove --purge
$ sudo userdel galaxy
$ sudo groupdel galaxy
```

## Section 1 - The tutorial script source files.

Go to somewhere sensible on either your local machine or on your Galaxy server (/home/<your_username> would be sensible..)

* Grab the following with wget or curl etc and then untar it.

  `https://swift.rc.nectar.org.au:8888/v1/AUTH_377/public/Ansible_files/gat2017-ansible.tar.gz`

This will copy the entire playbook and associated roles to somewhere we can look at it.

**Part 1 - Examine the playbook**

Have a look at the *playbook.yml* file. You'll notice that it contains quite a number of plays each of which reference a different role/s. The order in which the roles are referenced is important. This playbook does the following:

1. Performs some system tasks (system packages, creates a galaxy user etc.)
1. Installs postgres and nginx
1. Configures postgres
1. Installs and configures Galaxy
1. Installs and configures ProFTPD
1. Installs and configures supervisor

Take note of the fact that the playbook combines the individual roles to give us the desired outcome.

**Part 2 - Ansible galaxy**

Where do the roles come from? Ansible has a "toolshed" like system called **Ansible Galaxy** - d'oh.

Open the *commands.txt* file. You'll see a command to run the playbook followed by a series of commands that download the various roles from the Ansible galaxy and put them in an appropriate place in our scripts file tree.. e.g. `ansible-galaxy install -p roles galaxyprojectdotorg.postgresql`

There are many roles available for download. They all have some meta data associated with them which has information on the role's author, keywords, dependencies, licenses, available platforms etc. All of the roles in our script have that information. Checkout the *main.yml* in any of our role's *meta* directory.

The Ansible Galaxy can be browsed at: [http://galaxy.ansible.com/](http://galaxy.ansible.com/)

**Part 3 - Browse the roles**

The demonstrator will now work through a couple of the roles and will run the playbook on a machine for us.

The roles that this playbook use are:

| Order run | Role name | Purpose | Variables to consider |
| --------- | --------- | ------- | --------------------- |
| 0 | global_vars | Set some variables for the entire playbook | galaxy_server_dir, galaxy_changeset_id |
| 1 | galaxyprojectdotorg.postgresql | Installs postgreSQL database server.| postgresql_backup_local_dir |
| 2 | galaxyprojectdotorg.nginx | Installs and configures nginx (web server) |  |
| 3 | natefoo.postgresql_objects | Installs postgreSQL scripts to work with privileges etc. |  |
| 4 | galaxyprojectdotorg.galaxy | Installs and configures Galaxy | galaxy_server_dir, galaxy_vcs (git or hg) |
| 5 | supervisor | Installs supervisor configs for Galaxy | . |
| 6 | proftpd | Installs ProFTPD configs for Galaxy | . |

You'll note that these roles all have pretty good documentation on how to use them, which variables to set and how, and when they should be used. This makes it all much easier to understand.

Have a look at each of the roles in turn, concentrating mainly on the variables (in the defaults/main.yml files and the vars directory if present.) By modifying these variables, you can customise things like, where postgrSQL keeps it's backups, where Galaxy is installed and many others.

**Part 4 - Run the playbook**

To run the role we will need a Linux instance (we will use ubuntu 16.04) with a set public/private keypair, or we need to run the playbook "locally" (i.e. on the managed host itself). We will also need to know it's ip address.

* Set all the variables in *group_vars/galaxyservers.yml* as follows:

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
galaxy_changeset_id: release_16.10

galaxy_config:
  "app:main":
    database_connection: postgresql:///galaxy?host=/var/run/postgresql
    file_path: "{{ galaxy_root_dir }}/data"
    tool_dependency_dir: "{{ galaxy_root_dir }}/dependencies"
    admin_users: your@ema.il 											# <---- Put your user email here
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

* There's an addition to the files we've downloaded: `job_conf.xml`

Our Ansible-driven configuration replaces Galaxy's built-in Paste webserver with uWSGI. However, uWSGI Galaxy processes aren't suitable for running jobs. `job_conf.xml` controls Galaxy's job running system, we need to create a version that will prevent the uWSGI process from handling jobs. Save this file in a new directory `files/galaxy` in the script root directory.:

``` xml
<?xml version="1.0"?>
<job_conf>
    <plugins>
        <plugin id="local" type="runner" load="galaxy.jobs.runners.local:LocalJobRunner" workers="4"/>
    </plugins>
    <handlers default="handlers">
        <handler id="handler0" tags="handlers"/>
        <handler id="handler1" tags="handlers"/>
    </handlers>
    <destinations>
        <destination id="local" runner="local"/>
    </destinations>
</job_conf>
```

If you scroll up a bit you'll see that this file is referenced in `group_vars/galaxyservers.yml` (also additions from the version of `galaxyservers.yml` in the tarball).

Now it's just a matter of running:

`ansible-playbook -i inventory -vv playbook.yml`

Once again, the `-vv` switch indicates that we want the 2nd level of verbosity.. It is a handy one to have if you want to see what is going on. Another thing I regularly do is tee the screen output to a log file so I can keep a record of how the Ansible ran.

To do this, use the following command:

`script -q -c "ansible-playbook -i inventory -vv playbook.yml" /dev/null | tee ansible-build.log`

Use `less -R` to view the file with the colours set.

The Ansible script will run and display what it's doing as it does. (Always a good idea to run it in a screen or something since networks are sometimes flaky!)

**Part 5 - Upgrade Galaxy**

This playbook was originally written for the 2016 Galaxy Community Conference. At the time, the stable release of Galaxy was 16.04. For the 2016 Galaxy Admin Training in Utah, we updated it to 16.10. With our Ansible setup, it's trivial to upgrade. To do this, open up `group_vars/galaxyservers.yml`, locate the definition of `galaxy_changeset_id`, and update it:

```yaml
galaxy_changeset_id: release_17.01
```

Then run the same `ansible-playbook` command:

```console
ansible-playbook -i inventory -vv playbook.yml
```


## So, what did we learn?

Hopefully, you now understand:
* How Ansible combines roles with a playbook
* Where to go to get more roles to add to a playbook
* How to install Galaxy on a machine using Ansible.

## Further reading

If you want to know more about Ansible and Galaxy, see the Galaxy Project Github page:  [https://github.com/galaxyproject](https://github.com/galaxyproject) and search for "ansible".

If you want to know more about Ansible, details can be found at [www.ansible.com](https://www.ansible.com)

Suggestions and comments are welcome. Please contact:
