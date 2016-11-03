![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Apache as a Reverse Proxy for Galaxy - Exercise.

#### Authors: Nate Coraor. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Be able to install and configure Apache to:
  - Serve static content
  - Serve Galaxy datasets
1. Access Galaxy through the proxy
1. Download Galaxy datasets directly from the proxy

## Introduction

Creating a reverse proxy from Apache to Galaxy provides a number of features not available in Galaxy's built-in [Paste](http://pythonpaste.org/) HTTP server, including:

- Serve static content
- Compress content
- Serve over HTTPS
- Serve byte range requests
- Serve other sites from the same server
- Can provide authentication

## Section 1 - Installation and basic configuration

**Part 1 - Install Apache**

Install Apache from apt:

```bash
$ sudo apt-get install apache2
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  ...
Suggested packages:
  ...
The following NEW packages will be installed:
  ...
0 upgraded, 57 newly installed, 0 to remove and 11 not upgraded.
Need to get 22.6 MB of archives.
After this operation, 102 MB of additional disk space will be used.
Do you want to continue? [Y/n] 
Get:1 http://archive.ubuntu.com/ubuntu xenial/main amd64 libatm1 amd64 1:2.5.1-1.5 [24.2 kB]
  ...
Get:57 http://archive.ubuntu.com/ubuntu xenial/main amd64 ssl-cert all 1.0.37 [16.9 kB]
Fetched 22.6 MB in 2s (9714 kB/s)      
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libatm1:amd64.
(Reading database ... 7256 files and directories currently installed.)
Preparing to unpack .../libatm1_1%3a2.5.1-1.5_amd64.deb ...
Unpacking libatm1:amd64 (1:2.5.1-1.5) ...
  ...
Setting up ssl-cert (1.0.37) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
debconf: falling back to frontend: Readline
Processing triggers for libc-bin (2.23-0ubuntu3) ...
Processing triggers for systemd (229-4ubuntu10) ...
Processing triggers for sgml-base (1.26+nmu4ubuntu1) ...
$ 
```

Visit http://yourhost/ and you should see the Ubuntu Apache default page.

**Part 2 - Baseic configuration**

Now have a look at the configuration files in `/etc/apache2`. Debian (and Ubuntu) lay out Apache and nginx's configuration directories in consistent ways:

- `apache2.conf`: Main Apache config file. Note the `IncludeOptional` directories
- `conf-available/*`: Repository of available config includes
- `mods-available/*`: Repository of available module load and config directives
- `sites-available/*`: Repository of available virtualhosts
- `conf-enabled/*.conf`: Symlinks to `conf-available/` files
- `mods-enabled/*.{load,conf}`: Symlinks to `mods-available/` files
- `sites-enabled/*.conf`: Symlinks to `sites-available/` files

To make Apache serve as a reverse proxy, we will need to enable the modules:

- `mod_rewrite`
- `mod_proxy`
- `mod_proxy_http`

These are enabled using the `a2enmod` command:

```bash
$ sudo a2enmod rewrite
Enabling module rewrite.
To activate the new configuration, you need to run:
  service apache2 restart
$
```

All this has really done is created a symbolic link (symlink) in `mods-enabled/`:

```bash
$ ls -lrt /etc/apache2/mods-enabled/ | tail -1
lrwxrwxrwx 1 root root 30 Nov  3 03:50 rewrite.load -> ../mods-available/rewrite.load
```

`a2enmod` ensure that module dependencies are enabled. We can enable both `mod_proxy` and `mod_proxy_http` like so:

```bash
$ sudo a2enmod proxy_http
Considering dependency proxy for proxy_http:
Enabling module proxy.
Enabling module proxy_http.
To activate the new configuration, you need to run:
  service apache2 restart
$
```
