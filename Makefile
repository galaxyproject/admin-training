# Location of virtualenv used for development.
VENV?=../galaxy/.venv
IN_VENV=if [ -f $(VENV)/bin/activate ]; then . $(VENV)/bin/activate; fi;

generate-slides:
	rm docs/index.html
	echo "<html><head></head><body>" > docs/index.html
	$(IN_VENV) python slideshow/build_slideshow.py 'Get Galaxy' intro/02-basic-server/get-galaxy.md 02-basic-server
	$(IN_VENV) python slideshow/build_slideshow.py 'Galactic Database' intro/03-databases/databases.md 03-databases
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Shed' intro/05-tool-shed/shed_intro.md 05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Installation' intro/05-tool-shed/tool_installation.md 05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Exercise Tool Management' intro/05-tool-shed/ex-tool-management.md 05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Exercise Advanced Tool Management' intro/05-tool-shed/ex-advanced-tool-management.md 05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Reference Genomes' intro/06-reference-genomes/reference_genomes.md 06-reference-genomes
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Tool Basics' intro/09-tool-basics/tool-basics.md 09-tool-basics
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Architecture' intro/12-architecture/galaxy_architecture.md 12-architecture
	$(IN_VENV) python slideshow/build_slideshow.py 'Ansible and Galaxy - Part 1' advanced/001-ansible/ansible-introduction.md 001-ansible
	echo "</body></html>" >> docs/index.html
