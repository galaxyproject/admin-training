# Location of virtualenv used for development.
VENV?=../galaxy/.venv
IN_VENV=if [ -f $(VENV)/bin/activate ]; then . $(VENV)/bin/activate; fi;

generate-slides:
	rm -f docs/index.html
	echo "<html><head></head><body>" > docs/index.html

# Monday
	$(IN_VENV) python slideshow/build_slideshow.py 'Welcome and Introduction' sessions/00-intro/intro.md 00-intro
	$(IN_VENV) python slideshow/build_slideshow.py 'Introduction to Ansible' sessions/14-ansible/ansible-introduction.md 14-ansible
	$(IN_VENV) python slideshow/build_slideshow.py 'Galactic Database' sessions/03-production-basics/databases.md 03-production-basics
	$(IN_VENV) python slideshow/build_slideshow.py 'Gearing towards production' sessions/03-production-basics/production.md 03-production-basics
	$(IN_VENV) python slideshow/build_slideshow.py 'Web Server NGINX' sessions/03-production-basics/webservers.md 03-production-basics
	$(IN_VENV) python slideshow/build_slideshow.py 'Defining and importing genomes, Data Managers' sessions/05-reference-genomes/reference_genomes.md 05-reference-genomes

# Tuesday
	$(IN_VENV) python slideshow/build_slideshow.py 'Ephemeris' sessions/24-ephemeris/ephemeris.md 24-ephemeris

	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Shed' sessions/04-tool-shed/shed_intro.md 04-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Installation' sessions/04-tool-shed/tool_installation.md 04-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Tool Basics' sessions/x01-tool-basics/tool-basics.md x01-tool-basics

	$(IN_VENV) python slideshow/build_slideshow.py 'uWSGI' sessions/10-uwsgi/uwsgi.md 10-uwsgi
	$(IN_VENV) python slideshow/build_slideshow.py 'Systemd and Supervisor' sessions/11-systemd-supervisor/systemd-supervisor.md 11-systemd-supervisor
	$(IN_VENV) python slideshow/build_slideshow.py 'External Authentication' sessions/13-external-auth/external-auth.md 13-external-auth

# Wednesday
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Job Configuration' sessions/15-job-conf/job_conf.md 15-job-conf
	$(IN_VENV) python slideshow/build_slideshow.py 'Storage Management' sessions/19-storage/storage.md 19-storage
	$(IN_VENV) python slideshow/build_slideshow.py 'Heterogeneous Resources' sessions/17-heterogenous/heterogeneous.md 17-heterogenous

# Thursday

# Friday
	$(IN_VENV) python slideshow/build_slideshow.py 'Upgrading to a new Galaxy release' sessions/08-upgrading-release/upgrading.md 08-upgrading-release
	$(IN_VENV) python slideshow/build_slideshow.py 'Basic Troubleshooting' sessions/22-troubleshooting/troubleshooting.md 22-troubleshooting
	$(IN_VENV) python slideshow/build_slideshow.py 'Complex Galaxy Server Examples' sessions/x03-main-galaxy/usegalaxy.md x03-main-galaxy

	# $(IN_VENV) python slideshow/build_slideshow.py 'Clouds' sessions/18-clouds/clouds.md 18-clouds
	# $(IN_VENV) python slideshow/build_slideshow.py 'Advanced Tool Wrapping' sessions/x02-tools-advanced/tools-advanced.md x02-tools-advanced

	echo "</body></html>" >> docs/index.html
