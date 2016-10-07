# Location of virtualenv used for development.
VENV?=../galaxy/.venv
# Source virtualenv to execute command (flake8, sphinx, twine, etc...)
IN_VENV=if [ -f $(VENV)/bin/activate ]; then . $(VENV)/bin/activate; fi;

docs-slides-ready:
	$(IN_VENV) python slideshow/build_slideshow.py 'Shed Intro' intro/05-tool-shed/shed_intro.md build
