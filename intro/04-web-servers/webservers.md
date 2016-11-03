layout: true
class: inverse, middle, large

---
class: special
# (Proxy) Web Server Choices and Configuration

Introduction to Apache and NGINX

slides by @natefoo

.footnote[\#usegalaxy / @galaxyproject]

---
class: special
# Reverse Proxy Web Server

---
# Reverse Proxy

What is a reverse proxy?
- Sits between the client and Galaxy

Extra features:
- Serve static content
- Compress selected content
- Serve over HTTPS
- Serve byte range requests
- Serve other sites from the same server
- Can provide authentication
  - Covered in: Thursday, 9:20: Using and configuring external authentication services

Some of these features are available directly in uWSGI (covered Wednesday)

---
# Apache

- The most popular web server
- Many authentication plugins written for Apache
- Can offload file downloads

---
# Exercise: Apache

[Apache as a Reverse Proxy for Galaxy - Exercise](https://github.com/martenson/dagobah-training/blob/master/intro/04-web-servers/ex1-apache.md)

---
# nginx

- Designed specifically to be a load balancing reverse proxy
- Widely used by large sites (third most popular web server)
- Can offload both uploads and downloads

I recommend nginx unless you have a specific need for Apache

---
# nginx "flavors"

nginx plugins must be compiled in (no dynamic shared objects)

Debian/Ubuntu provide multiple nginx "flavors":
- `nginx-light`: minimal set of core modules
- `nginx-full`: full set of core modules
- `nginx-extras`: full set of core modules and extras (3rd party modules)

There is also a "Galaxy" flavor<sup>[1]</sup> (includes [upload module](https://github.com/vkholodkov/nginx-upload-module)):
- [RHEL](https://depot.galaxyproject.org/yum/) (derived from EPEL nginx)
- [Ubuntu PPA](https://launchpad.net/~galaxyproject/+archive/ubuntu/nginx)

.footnote[<sup>[1]</sup> Still working on the automation to keep this up to date, though]

---
# Additional Tips and Resources

[Google's PageSpeed Tools](https://developers.google.com/speed/pagespeed/insights/) can identify any compression or caching improvements you can make.

If configuring SSL (out of scope for this training), out-of-the-box SSL settings are often insecure!

Use the [Qualys SSL Server Test](https://www.ssllabs.com/ssltest/analyze.html) to check

---
# uWSGI

Galaxy comes with a pure-python web server, [Paste](http://pythonpaste.org/)

Why switch to uWSGI?
- Built in multiprocess (avoid the GIL)
- Built in load balancing
- Better performance
- Greater scalability
- Hundreds of other features (see [docs](http://uwsgi-docs.readthedocs.io/en/latest/))

uWSGI will become the default: Watch [Pull Request #2802](https://github.com/galaxyproject/galaxy/pull/2802)
