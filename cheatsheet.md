## Deployment and Platform Options

- [SQLite](https://sqlite.org/): Default database format used by Galaxy, data is stored in a single file. 
- [PostgreSQL](https://www.postgresql.org/): Database format suggested for large-scale & production usage. [Exercise: Connecting Galaxy to PostgreSQL](https://github.com/martenson/dagobah-training/blob/master/intro/03-databases/ex1-postgres.md)
- [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/): 
- [nginx](https://www.nginx.com/resources/wiki/)
- [Apache](https://httpd.apache.org/)
- [Ansible](https://www.ansible.com/): 
- [SQLAlchemy](http://www.sqlalchemy.org/): Database abstraction layer, allows for different databases to be plugged in.
- [pip](https://pip.pypa.io/en/stable/): Package manager for Python
- [conda](http://conda.pydata.org/docs/intro.html): Multi-language package manager

## Ansible Playbooks
https://galaxy.ansible.com/galaxyprojectdotorg/
https://galaxy.ansible.com/natefoo/postgresql_objects/

## Addresses and Locations
http://localhost:8080/api/version
http://localhost:8080/
http://127.0.0.1:8080

default SQLite sqlite:///./database/universe.sqlite?isolation_level=IMMEDIATE
local PostgreSQL postgres://<name>:<password>@localhost:5432/galaxy
production example postgresql:///galaxy?host=/var/run/postgresql


## Important Files
```
galaxy$
database/universe.sqlite
server/galaxy.ini # main Galaxy config file
server/contrib/galaxy_supervisor.conf
server/static/welcome.html.sample
server/run.sh
```

## Repositories
https://github.com/galaxyproject/galaxy.git
https://github.com/bgruening/docker-galaxy-stable

## Other Resources
https://usegalaxy.org/
https://launch.usegalaxy.org/launch

