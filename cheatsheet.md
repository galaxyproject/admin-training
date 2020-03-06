## Vocabulary

Term         | Definition
---          | ---
Repository   | version controlled directory of files
Tool Shed    | repository for tools used by Galaxy. [Main Tool Shed](https://toolshed.g2.bx.psu.edu/)
Suite        | a single repository that 'depends' on many others
Data Manager | [allows for the creation](https://wiki.galaxyproject.org/Admin/Tools/DataManagers) of built-in (reference) data
galaxy.yml   | [the main Galaxy configuration file](https://github.com/galaxyproject/galaxy/blob/dev/config/galaxy.yml.sample)
data library | A folder like structure of data that can be used for sharing data amongst many Galaxy users easily
Job handler  | (JobHandler) watches the job and transitions job's state - common startup and finishing
Job mapper   | (JobRunnerMapper) decides the "destination" for a job
Job runner   | (e.g. DrammaJobRunner) actual runs the job and provides an interface for checking status
Destinations | how jobs should be run
Handlers     | Define which job handler (Galaxy server) processes should handle a job
Object Store | A way of utilising multiple storage pools transparently within a single Galaxy instance

And some important acronyms:

Term  | Definition
---   | ---
MVC   | [Model view controller](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
WSGI  | [Web server gateway interface](https://wsgi.readthedocs.io/en/latest/what.html)
API   | [Application programming interface](https://en.wikipedia.org/wiki/Application_programming_interface)
ORM   | [Object relational mapping](https://en.wikipedia.org/wiki/Object-relational_mapping)
GIL   | [Global Interpreter Lock; prevents multiple Python threads from running at once](https://wiki.python.org/moin/GlobalInterpreterLock)
LDAP  | [Lightweight Directory Access Protocol](https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol)
DRMAA | [Distributed Resource Management Application API](https://www.drmaa.org/)
SSH   | [Secure SHell, how you've been connecting to the server all week](https://en.wikipedia.org/wiki/Secure_Shell)

## Deployment and Platform Options

- [SQLite](https://sqlite.org/): Default database format used by Galaxy, data is stored in a single file. Useful during testing and development.
- [PostgreSQL](https://www.postgresql.org/): Database format suggested for large-scale & production usage.
 - [Exercise: Connecting Galaxy to PostgreSQL](https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html#postgresql)
- [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/): Web/application/WSGI server.
- [nginx](https://www.nginx.com/resources/wiki/): Web server (recommended).
 - [Exercise: nginx as a Reverse Proxy for Galaxy](https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html#nginx)
- [Ansible](https://www.ansible.com/): Automation tool for configuring and managing computers.
 - Playbook > Plays > Roles > Tasks
 - [Exercise: Introduction to Ansible](https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible/tutorial.html)
 - [Exercise: Setup a production Galaxy with Ansible](https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html)
- [SQLAlchemy](http://www.sqlalchemy.org/): Database abstraction layer, allows for different databases to be plugged in.
- [pip](https://pip.pypa.io/en/stable/): Package manager for Python
- [conda](http://conda.pydata.org/docs/intro.html): Multi-language package manager
- [virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/): Python virtual environment. Isolates project dependencies, stores packages in a folder often called `venv` or similar
- [paste](https://en.wikipedia.org/wiki/Python_Paste): Basic Python based web-server.
- [ProFTPD](http://www.proftpd.org/): FTP server
 - [Exercise: Configuring FTP](https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html#proftpd)
- [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol): Simple Mail Transfer Protocol, lets Galaxy send emails to users.
- [OpenID](http://openid.net/): User account platform
- [Planemo](http://planemo.readthedocs.io/en/latest/): Program to help wrap tools for Galaxy
 - [Exercise: Tool Wrapping with Planemo](http://planemo.readthedocs.io/en/latest/writing_standalone.html)
- [CloudMan](https://github.com/galaxyproject/cloudman): A web application which manages a Galaxy cluster in the cloud.
- [CloudLaunch](https://github.com/galaxyproject/cloudlaunch): A web application to make it wasy to launch images on a cloud, drives, etc.
 - https://launch.usegalaxy.org
- [Pulsar](github.com/galaxyproject/pulsar): Distributed job execution engine for Galaxy.
- [Nagios](https://www.nagios.org/): General purpose tool for monitoring systems and services
- [Running Galaxy in a production environment](https://wiki.galaxyproject.org/Admin/Config/Performance/ProductionServer)
- [systemd](https://www.freedesktop.org/wiki/Software/systemd/): Linux system and service manager
- [Supervisor](http://supervisord.org/): A process manager written in Python; `supervisorctl`
 - [Exercise: Managing Multiprocess Galaxy with Supervisor](https://galaxyproject.github.io/training-material/topics/admin/tutorials/ansible-galaxy/tutorial.html#supervisord)
- [Kerberos](http://web.mit.edu/kerberos/): a network authentication protocol
- [PAM stack](http://www.tuxradar.com/content/how-pam-works): Pluggable Authentication Modules
 - [Exercise: PAM Authentication in Galaxy](https://galaxyproject.github.io/training-material/topics/admin/tutorials/upstream-auth/tutorial.html)
- [Slurm](http://slurm.schedmd.com/): Cluster workload manager
 - [Exercise: Running Galaxy Jobs with Slurm](https://galaxyproject.github.io/training-material/topics/admin/tutorials/connect-to-compute-cluster/tutorial.html)


## Ansible Playbooks

https://galaxy.ansible.com/galaxyproject/
https://galaxy.ansible.com/natefoo/postgresql_objects/

## Important Files

Configuration File                         | Purpose
---                                        | ---
`config/galaxy.yml`                        | Main Galaxy config file
`tool_sheds_conf.xml`                      | list of available tool sheds
`tool_conf.xml.sample`                     | tools to be added to side panel in Galaxy
`mutable-config/integrated_tool_panel.xml` | manages tool panel appearance
`config/dependency_resolvers_conf.xml`     | resolves dependencies
`config/tool_data_table_conf.xml`          |
`config/tool_destinations.yml`             | DTD Destinations configuration
`config/job_resource_params_conf.xml`      | Job resource parameter selector (User selection of cpus/cluster/etc.)
`config/openid_conf.xml.sample`            | OpenID config file

## Handy Commands

```
# check process status
$ sudo systemctl status galaxy

# restart Galaxy
$ sudo systemctl restart galaxy

# switch to Galaxy user
$ sudo -iu galaxy
```

## Repositories

- [Galaxy](https://github.com/galaxyproject/galaxy)
- [Docker Galaxy](https://github.com/bgruening/docker-galaxy-stable)
- [Galaxy Tools](https://github.com/galaxyproject/tools-iuc)
- [Starforge: Galaxy dependencies](https://github.com/galaxyproject/starforge)
- [Planemo: Galaxy tool development swiss knife](https://github.com/galaxyproject/planemo)
- [Planemo Machine: Monitor and build docker images for dependencies](https://github.com/galaxyproject/planemo-machine)
- [Bioblend: Galaxy API client library](https://github.com/galaxyproject/bioblend)
- [ansible-galaxy: Install Galaxy with Ansible](https://github.com/galaxyproject/ansible-galaxy)

## Other Resources

- [Official Toolshed](https://toolshed.g2.bx.psu.edu/)
- [Gitter: Training course messaging platform](https://gitter.im/dagobah-training/Lobby)
- [Main public Galaxy website](https://usegalaxy.org/)
- [CloudMan](https://launch.usegalaxy.org/launch)
- [Documentation for Galaxy](https://docs.galaxyproject.org/en/master/index.html)
- [Tool installation automation](https://github.com/galaxyproject/ephemeris)
- [Galaxy Admin Wiki](https://wiki.galaxyproject.org/Admin/)
- [Wiki: Support](https://wiki.galaxyproject.org/Support)
- [IRC: #galaxyproject on Freenode](https://wiki.galaxyproject.org/Support/IRC)
- [galaxy-dev Mailing list](http://dev.list.galaxyproject.org/)
- [Contribution guidelines](http://bit.ly/gx-CONTRIBUTING-md)

GitHub: github.com/galaxyproject
Twitter:: #usegalaxy, @galaxyproject
