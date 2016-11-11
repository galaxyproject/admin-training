## Vocabulary
wrapper or tool definition file
repository
revision vs installable revision
metadata
tool shed
tool
suite: a single repository that 'depends' on many others
[data managers](https://wiki.galaxyproject.org/Admin/Tools/DataManagers): allows for the creation of built-in (reference) data
Data Library

## Deployment and Platform Options

- [SQLite](https://sqlite.org/): Default database format used by Galaxy, data is stored in a single file. 
- [PostgreSQL](https://www.postgresql.org/): Database format suggested for large-scale & production usage. 
 - [Exercise: Connecting Galaxy to PostgreSQL](https://github.com/martenson/dagobah-training/blob/master/intro/03-databases/ex1-postgres.md)
- [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/): Web server.
- [nginx](https://www.nginx.com/resources/wiki/): Web server (recommended). 
 - [Exercise: nginx as a Reverse Proxy for Galaxy](https://github.com/martenson/dagobah-training/blob/master/intro/04-web-servers/ex2-nginx.md)
- [Apache](https://httpd.apache.org/): Web server. 
 - [Exercise: Apache as a Reverse Proxy for Galaxy](https://github.com/martenson/dagobah-training/blob/master/intro/04-web-servers/ex1-apache.md)
- [Ansible](https://www.ansible.com/): 
- [SQLAlchemy](http://www.sqlalchemy.org/): Database abstraction layer, allows for different databases to be plugged in.
- [pip](https://pip.pypa.io/en/stable/): Package manager for Python
- [conda](http://conda.pydata.org/docs/intro.html): Multi-language package manager
- [virtualenv](http://docs.python-guide.org/en/latest/dev/virtualenvs/): Python virtual environment. Isolates project dependencies, stores packages in a folder often called `venv` or similar
- [paste](https://en.wikipedia.org/wiki/Python_Paste): Basic Python based web-server.
- [ProFTPD](http://www.proftpd.org/): FTP server
 - [Exercise: Configuring FTP](https://wiki.galaxyproject.org/Admin/Config/UploadviaFTP)
- [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol): Simple Mail Transfer Protocol, lets Galaxy send emails to users.

- [Exercise: Tool Management](https://github.com/martenson/dagobah-training/blob/master/intro/05-tool-shed/ex-tool-management.md)
- [Exercise: Reference Genomes](https://github.com/martenson/dagobah-training/blob/master/intro/06-reference-genomes/ex06_reference_genomes.md)

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
```

## Handy Commands

```
# log into a remote server with port forwarding
$ ssh -L 8080:localhost:8080 username@server.edu
# -L local_socket:host:hostport

# get a specific version of Galaxy
$ git clone -b release_16.07 https://github.com/galaxyproject/galaxy.git

sh run.sh --stop-daemon
sh run.sh --daemon
tail -f paster.log
```

## Repositories
https://github.com/galaxyproject/galaxy.git  
https://github.com/bgruening/docker-galaxy-stable

## Other Resources
[Official Toolshed](https://toolshed.g2.bx.psu.edu/)  
[Gitter: Training course messaging platform](https://gitter.im/dagobah-training/Lobby)  
[Main public Galaxy website](https://usegalaxy.org/)  
https://launch.usegalaxy.org/launch  
[Documentation for Galaxy](https://docs.galaxyproject.org/en/master/index.html)  
[Tool installation automation](https://github.com/galaxyproject/ephemeris)  
[Galaxy Admin Wiki](https://wiki.galaxyproject.org/Admin/)  
[Biostars Galaxy](https://biostar.usegalaxy.org/)
