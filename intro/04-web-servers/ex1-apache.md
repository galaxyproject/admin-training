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
