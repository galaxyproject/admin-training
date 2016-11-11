## Vocabulary
repository: version controlled directory of files  
tool shed: repository for tools used by Galaxy  
suite: a single repository that 'depends' on many others  
[data managers](https://wiki.galaxyproject.org/Admin/Tools/DataManagers): allows for the creation of built-in (reference) data  
data library  
[galaxy.ini](https://raw.githubusercontent.com/galaxyproject/galaxy/dev/config/galaxy.ini.sample): main configuration file  
[MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller): Model view controller  
[WSGI](https://wsgi.readthedocs.io/en/latest/what.html): Web server gateway interface  
[API](https://en.wikipedia.org/wiki/Application_programming_interface): Application programming interface  
[ORM](https://en.wikipedia.org/wiki/Object-relational_mapping): Object relational mapping  
[GIL](https://wiki.python.org/moin/GlobalInterpreterLock): Global Interpreter Lock; prevents multiple Python threads from running at once  
[LDAP](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol): Lightweight Directory Access Protocol  
[DRMAA](https://www.drmaa.org/): Distributed Resource Management Application API  
Job handler: (JobHandler) watches the job and transitions job's state - common startup and finishing.    
Job mapper: (JobRunnerMapper) decides the "destination" for a job.  
Job runner (e.g. DrammaJobRunner) actual runs the job and provides an interface for checking status.  
Object Store    
[ssh](https://en.wikipedia.org/wiki/Secure_Shell): how you've been connecting to the server all week  
Destinations: how jobs should be run  
Handlers: Define which job handler (Galaxy server) processes should handle a job

## Deployment and Platform Options

- [SQLite](https://sqlite.org/): Default database format used by Galaxy, data is stored in a single file. 
- [PostgreSQL](https://www.postgresql.org/): Database format suggested for large-scale & production usage. 
 - [Exercise: Connecting Galaxy to PostgreSQL](https://github.com/martenson/dagobah-training/blob/master/intro/03-databases/ex1-postgres.md)
- [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/): Web/application/WSGI server.
- [nginx](https://www.nginx.com/resources/wiki/): Web server (recommended). 
 - [Exercise: nginx as a Reverse Proxy for Galaxy](https://github.com/martenson/dagobah-training/blob/master/intro/04-web-servers/ex2-nginx.md)
- [Apache](https://httpd.apache.org/): Web server. 
 - [Exercise: Apache as a Reverse Proxy for Galaxy](https://github.com/martenson/dagobah-training/blob/master/intro/04-web-servers/ex1-apache.md)
- [Ansible](https://www.ansible.com/): Automation tool for configuring and managing computers.
 - Playbook > Plays > Roles > Tasks
 - [Exercise: Introduction to Ansible](https://github.com/martenson/dagobah-training/blob/master/advanced/001-ansible/ex1-intro-ansible.md)  
 - [Exercise: Setup a production Galaxy with Ansible](https://github.com/martenson/dagobah-training/blob/master/advanced/001-ansible/ex2-galaxy-ansible.md)
- [SQLAlchemy](http://www.sqlalchemy.org/): Database abstraction layer, allows for different databases to be plugged in.
- [pip](https://pip.pypa.io/en/stable/): Package manager for Python
- [conda](http://conda.pydata.org/docs/intro.html): Multi-language package manager
- [virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/): Python virtual environment. Isolates project dependencies, stores packages in a folder often called `venv` or similar
- [paste](https://en.wikipedia.org/wiki/Python_Paste): Basic Python based web-server.
- [ProFTPD](http://www.proftpd.org/): FTP server
 - [Exercise: Configuring FTP](https://wiki.galaxyproject.org/Admin/Config/UploadviaFTP)
- [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol): Simple Mail Transfer Protocol, lets Galaxy send emails to users.
- [OpenID](http://openid.net/): User account platform
- [Planemo](http://planemo.readthedocs.io/en/latest/): Program to help wrap tools for Galaxy
 - [Exercise: Tool Wrapping with Planemo](http://planemo.readthedocs.io/en/latest/writing_standalone.html)
- [CloudMan](https://github.com/galaxyproject/cloudman): A web application which manages a Galaxy cluster in the cloud.
- [CloudLaunch](https://github.com/galaxyproject/cloudlaunch): A web application to make it wasy to launch images on a cloud, drives, etc.
 - https://launch.usegalaxy.org
- [Pulsar](github.com/galaxyproject/pulsar): Distributed job execution engine for Galaxy.
- [mako](http://www.makotemplates.org/): Template library  
- [Nagios](https://www.nagios.org/): General purpose tool for monitoring systems and services 
- [Running Galaxy in a production environment](https://wiki.galaxyproject.org/Admin/Config/Performance/ProductionServer)
- [systemd](https://www.freedesktop.org/wiki/Software/systemd/): Linux system and service manager
- [Supervisor](http://supervisord.org/): A process manager written in Python; `supervisorctl`
 - [Exercise: Managing Multiprocess Galaxy with Supervisor](https://github.com/martenson/dagobah-training/blob/master/advanced/002a-systemd-supervisor/ex1-supervisor.md)
- [Kerberos](http://web.mit.edu/kerberos/): a network authentication protocol
- [PAM stack](http://www.tuxradar.com/content/how-pam-works): Pluggable Authentication Modules
 - [Exercise: PAM Authentication in Galaxy](https://github.com/martenson/dagobah-training/blob/master/advanced/004-external-authentication/ex1-pam-auth.md)
- [Slurm](http://slurm.schedmd.com/): Cluster workload manager
 - [Exercise: Running Galaxy Jobs with Slurm](https://github.com/martenson/dagobah-training/blob/master/advanced/005-compute-cluster/ex1-slurm.md)



## Other Tutorials
- [Exercise: Tool Management](https://github.com/martenson/dagobah-training/blob/master/intro/05-tool-shed/ex-tool-management.md)  
- [Exercise: Reference Genomes](https://github.com/martenson/dagobah-training/blob/master/intro/06-reference-genomes/ex06_reference_genomes.md)  
- [Exercise: Advanced Galaxy Job Configurations](https://github.com/martenson/dagobah-training/blob/master/advanced/005-compute-cluster/ex2-advanced-job-configs.md)


## Ansible Playbooks
https://galaxy.ansible.com/galaxyprojectdotorg/  
https://galaxy.ansible.com/natefoo/postgresql_objects/  

## Addresses and Locations
http://localhost:8080/api/version  
http://localhost:8080/  
http://127.0.0.1:8080  
http://localhost:8080/datasets/f2db41e1fa331b3e/display?to_ext=txt  

default SQLite sqlite:///./database/universe.sqlite?isolation_level=IMMEDIATE  
local PostgreSQL postgres://<name>:<password>@localhost:5432/galaxy  
production example postgresql:///galaxy?host=/var/run/postgresql  


## Important Files
```
# default SQLite database file
database/universe.sqlite 

# main Galaxy config file
server/galaxy.ini 

server/contrib/galaxy_supervisor.conf

# page displayed at the Galaxy home screen
server/static/welcome.html.sample 

# script that starts Galaxy
server/run.sh 

# list of available tool sheds
tool_sheds_conf.xml 

# tools to be added to side panel in Galaxy
tool_conf.xml.sample 

# manages tool panel appearance
integrated_tool_panel.xml 

# resolves dependencies
dependency_resolvers_conf.xml 

config/tool_data_table_conf.xml.sample

config/tool_destinations.yml

config/job_resource_params_conf.xml

# OpenID config file
config/openid_conf.xml.sample
```

## Handy Commands

```
# log into a remote server with port forwarding
$ ssh -L 8080:localhost:8080 username@server.edu
# -L local_socket:host:hostport

# get a specific version of Galaxy
$ git clone -b release_16.07 https://github.com/galaxyproject/galaxy.git

# start the server
sh run.sh --stop-daemon
sh run.sh --daemon
sh ./run.sh --pid-file=paster.pid --log-file=paster.log --daemon
tail -f paster.log

# install a program to the system
sudo apt-get install seqtk

# upgrade your Galaxy release
$ git checkout release_YY.MM && git pull --ff-only origin release_YY.MM

# compare your configurations with the default
diff -u galaxy.ini galaxy.ini.sample

# upgrade your database
$ sh manage_db.sh upgrade

# save changes made to a local Galaxy
$ git stash && git checkout ... && git pull ... && git stash pop

# un-tar a file
tar -xvf files.tgz

# Notify supervisor of changes
$ sudo supervisorctl update

# check supervisor process status
$ sudo supervisorctl status

# restart all processes
$ sudo supervisorctl restart all

```

## Repositories
https://github.com/galaxyproject/galaxy.git  
https://github.com/bgruening/docker-galaxy-stable  
https://github.com/galaxyproject/tools-iuc  
https://github.com/galaxyproject/starforge  
https://github.com/galaxyproject/planemo  
https://github.com/galaxyproject/planemo-machine  
https://github.com/galaxyproject/bioblend  
https://github.com/galaxyproject/ansible-galaxy

## Other Resources
[Official Toolshed](https://toolshed.g2.bx.psu.edu/)  
[Gitter: Training course messaging platform](https://gitter.im/dagobah-training/Lobby)  
[Main public Galaxy website](https://usegalaxy.org/)  
https://launch.usegalaxy.org/launch  
[Documentation for Galaxy](https://docs.galaxyproject.org/en/master/index.html)  
[Tool installation automation](https://github.com/galaxyproject/ephemeris)  
[Galaxy Admin Wiki](https://wiki.galaxyproject.org/Admin/)  
[Biostars Galaxy](https://biostar.usegalaxy.org/)  
[Wiki: Support](https://wiki.galaxyproject.org/Support)  
[IRC: #galaxyproject on Freenode](https://wiki.galaxyproject.org/Support/IRC)  
[galaxy-dev Mailing list](http://dev.list.galaxyproject.org/)  
[Contribution guidelines](http://bit.ly/gx-CONTRIBUTING-md)

IRC: irc.freenode.net#galaxyproject

GitHub: github.com/galaxyproject

Twitter:: #usegalaxy, @galaxyproject

