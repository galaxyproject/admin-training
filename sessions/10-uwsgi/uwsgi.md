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
# The Python GIL

![Python GIL](http://www.tivix.com/api/images/Gb8C-z3zxf_1Fm07mhm-Xjf8O4U=/427/original/Gogophercolor.png)

.footnote[Image credit: [Dariusz Fryta](http://www.tivix.com/blog/lets-go-python/)]

---
# Why uWSGI?

- Python GIL is a severe limitation for multicore servers
- Isolate job functions from web functions
  - Can be done with Paste, but uWSGI does it better/simpler
- Work around the GIL without manually managing multiple Galaxy processes

---
# Why uWSGI?

- Built in load balancing
- Speak native high performance uWSGI protocol to nginx
- Will be the default anyway
- Uninterrupted restarting

---
# Other features

Can do anything you can imagine: [uWSGI configuration options](http://uwsgi-docs.readthedocs.io/en/latest/Options.html)

---
# A note on processes

uWSGI will run and control a configured number of *anonymous processes* to **serve web requests**

These processes **do not** handle jobs. For this, we start *webless* processes called *job handlers*

---
# uWSGI communication

- uWSGI can serve http directly using the `--http` option
- uWSGI speaks a native protocol (which nginx also speaks) using `--socket`

It's best to keep the proxy server, especially if you intend to host more than just a single Galaxy server on this system

---
# uWSGI configuration

There are many potential ways to configure uWSGI, including:

- With command line arguments
- In a uWSGI-specific INI file
- In a uWSGI-specific YAML file
- As a "Paste Deploy" application in an application's ini file
- Many more...

---
# uWSGI configuration

We'll use the "Paste Deploy" configuration method since galaxy.ini is already in Paste Deploy format.

Since we're using nginx, we'll also proxy using the `socket` option (native uWSGI protocol) rather than HTTP.

Instructions for uWSGI-specific INI are in the Galaxy documentation

---
# Direct HTTP

You can serve HTTP directly without a proxy using a config like:

```ini
[uwsgi]
processes = 2
threads = 2
http = 127.0.0.1:8080       # serve http directly
pythonpath = lib
master = True
logto = /srv/galaxy/log/uwsgi.log
# static maps if serving http directly
static-map = /static/style=/srv/galaxy/server/static/style/blue
static-map = /static=/srv/galaxy/server/galaxy/static
```

---
# How to use it

- Install/configure uWSGI
- Configure Galaxy job handlers
- Run uWSGI
- Run job handlers

---
# Exercise

[Run Galaxy with uWSGI - Exercise](https://github.com/gvlproject/dagobah-training/blob/master/sessions/10-uwsgi/ex1-uwsgi.md)

---
# Run job handlers (separately)

In supervisor session
