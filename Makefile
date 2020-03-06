# Location of virtualenv used for development.
VENV?=../galaxy/.venv
IN_VENV=if [ -f $(VENV)/bin/activate ]; then . $(VENV)/bin/activate; fi;

generate-slides:
	rm -f docs/index.html
	echo "<html><head></head><body>" > docs/index.html

	$(IN_VENV) python slideshow/build_slideshow.py 'Welcome and Introduction' sessions/00-intro/intro.md 00-intro
	echo "</body></html>" >> docs/index.html
