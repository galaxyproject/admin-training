# Location of virtualenv used for development.
VENV?=../galaxy/.venv
IN_VENV=if [ -f $(VENV)/bin/activate ]; then . $(VENV)/bin/activate; fi;

generate-slides:
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Shed Intro' intro/05-tool-shed/shed_intro.md docs/05-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Architecture' intro/12-architecture/galaxy_architecture.md docs/12-architecture
