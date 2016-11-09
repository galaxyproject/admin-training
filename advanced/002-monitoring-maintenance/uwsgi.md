layout: true
class: inverse, larger

---
class: special, middle
# uWSGI

slides by @natefoo, @Slugger70

.footnote[\#usegalaxy / @galaxyproject]

---
# What is uWSGI?

Web/application/WSGI server

Replaces `Paste#http` (see `galaxy.ini`)

---
# Why uWSGI?

- Work around the GIL without manually managing multiple Galaxy processes
- Built in load balancing
- Speak native high performance uWSGI protocol to nginx
- Will be the default anyway
- Uninterrupted restarting

---
# Other features

Can do anything you can imagine: [uWSGI configuration options](http://uwsgi-docs.readthedocs.io/en/latest/Options.html)

---
# How to use it

Add to `galaxy.ini`:
```ini
processes = 8
threads = 4
socket = 127.0.0.1:4001     # uwsgi protocol for nginx
http = 127.0.0.1:8080       # serve http directly
pythonpath = lib
master = True
logto = /srv/galaxy/server/uwsgi.log
# static maps if serving http directly
static-map = /static/style=/srv/galaxy/server/static/style/blue
static-map = /static=/srv/galaxy/server/galaxy/static
```

---
# How to use it

Configure *different handlers* in `job_conf.xml`:
```xml
    <handlers default="handlers">
        <handler id="handler0" tags="handlers"/>
        <handler id="handler1" tags="handlers"/>
    </handlers>
```

---
# Install uWSGI: easy mode

---
`cd` to Galaxy root dir and:
```console
$ . ./.venv/bin/activate
$ pip install uwsgi
```

---
# How to use it

`uwsgi --ini-paste galaxy.ini`

---
# Run job handlers (separately)

In supervisor session
