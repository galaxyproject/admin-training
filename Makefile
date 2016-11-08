# Location of virtualenv used for development.
VENV?=../galaxy/.venv
IN_VENV=if [ -f $(VENV)/bin/activate ]; then . $(VENV)/bin/activate; fi;

generate-slides:
	rm docs/index.html
	echo "<html><head></head><body>" > docs/index.html
	$(IN_VENV) python slideshow/build_slideshow.py 'Welcome and Introduction' intro/00-intro/intro.md 00-intro
	$(IN_VENV) python slideshow/build_slideshow.py 'Deployment and Platform Options' intro/01-deployment-platforms/choices.md 01-deployment-platforms
	$(IN_VENV) python slideshow/build_slideshow.py 'Get Galaxy' intro/02-basic-server/get-galaxy.md 02-basic-server
	$(IN_VENV) python slideshow/build_slideshow.py 'Galactic Database' intro/03-databases/databases.md 03-databases
	$(IN_VENV) python slideshow/build_slideshow.py 'Galactic Database' intro/04-web-servers/webservers.md 04-web-servers
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Shed' intro/05-tool-shed/shed_intro.md 05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Dependencies' intro/05-tool-shed/tool-dependencies.md 05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Installation' intro/05-tool-shed/tool_installation.md 05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Reference Genomes' intro/06-reference-genomes/reference_genomes.md 06-reference-genomes
	$(IN_VENV) python slideshow/build_slideshow.py 'Extending Installation' intro/07-extending-installation/extending.md 07-extending-installation
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Tool Basics' intro/09-tool-basics/tool-basics.md 09-tool-basics
	$(IN_VENV) python slideshow/build_slideshow.py 'Upgrading & Releases' intro/10-upgrading-release/upgrading.md 10-upgrading-release
	$(IN_VENV) python slideshow/build_slideshow.py 'Basic Troubleshooting' intro/11-basic-troubleshooting/basic-troubleshooting.md 11-basic-troubleshooting
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Architecture' intro/12-architecture/galaxy_architecture.md 12-architecture
	$(IN_VENV) python slideshow/build_slideshow.py 'Ansible and Galaxy - Part 1' advanced/001-ansible/ansible-introduction.md 001-ansible
	$(IN_VENV) python slideshow/build_slideshow.py 'Monitoring and Maintenance' advanced/002-monitoring-maintenance/monitoring-maintenance.md 002-monitoring-maintenance
	$(IN_VENV) python slideshow/build_slideshow.py 'Systetmd and Supervisor' advanced/002a-systemd-supervisor/systemd-supervisor.md 002a-systemd-supervisor
	$(IN_VENV) python slideshow/build_slideshow.py 'External Authentication' advanced/004-external-authentication/external-auth.md 004-external-auth
	$(IN_VENV) python slideshow/build_slideshow.py 'Compute Cluster' advanced/005-compute-cluster/compute-cluster.md 005-compute-cluster
	cp advanced/005-compute-cluster/slurm-wlm-configurator.html docs/005-compute-cluster
	$(IN_VENV) python slideshow/build_slideshow.py 'Heterogeneous Resources' advanced/005-compute-cluster/heterogeneous.md 005-compute-cluster
	$(IN_VENV) python slideshow/build_slideshow.py 'Clouds' advanced/006-cloud/clouds.md 006-clouds
	$(IN_VENV) python slideshow/build_slideshow.py 'Storage Management' advanced/007-storage-management/storage.md 007-storage
	echo "</body></html>" >> docs/index.html
