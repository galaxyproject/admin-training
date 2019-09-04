# Location of virtualenv used for development.
VENV?=../galaxy/.venv
IN_VENV=if [ -f $(VENV)/bin/activate ]; then . $(VENV)/bin/activate; fi;

generate-slides:
	rm -f docs/index.html
	echo "<html><head></head><body>" > docs/index.html

# Thursday
	$(IN_VENV) python slideshow/build_slideshow.py 'Welcome and Introduction' sessions/00-intro/intro-k8s.md 00-intro
	$(IN_VENV) python slideshow/build_slideshow.py 'Deployment Options' sessions/01-deployment-options/deployment-k8s.md 01-deployment-options
	$(IN_VENV) python slideshow/build_slideshow.py 'Install Galaxy' sessions/02-basic-server/get-galaxy-k8s.md 02-basic-server
	$(IN_VENV) python slideshow/build_slideshow.py 'Admin options' sessions/03-production-basics/production.md 03-production-basics
	$(IN_VENV) python slideshow/build_slideshow.py 'Tools' sessions/04-tool-shed/tool_installation.md 04-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Tool Shed' sessions/04-tool-shed/shed_intro.md 04-tool-shed
	$(IN_VENV) python slideshow/build_slideshow.py 'Galaxy Job Configuration' sessions/15-job-conf/job_conf.md 15-job-conf
	$(IN_VENV) python slideshow/build_slideshow.py 'Storage Management' sessions/19-storage/storage.md 19-storage

	echo "</body></html>" >> docs/index.html
