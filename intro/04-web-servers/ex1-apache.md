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

**Part 2 - Basic configuration**

Now have a look at the configuration files in `/etc/apache2`. Debian (and Ubuntu) lay out Apache and nginx's configuration directories in consistent ways:

- `apache2.conf`: Main Apache config file. Note the `IncludeOptional` directories
- `conf-available/*`: Repository of available config includes
- `mods-available/*`: Repository of available module load and config directives
- `sites-available/*`: Repository of available sites
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
$ ls -lrt mods-enabled/ | tail -1
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

Next, we need to create a config for the Galaxy "site". Create the file `sites-available/000-galaxy.conf`. This should contain `RewriteRule`s to proxy Galaxy and serve its static content:

```apache
RewriteEngine on
RewriteRule ^(.*) http://localhost:8080$1 [P]
```

Before we can enable the new "Galaxy" site we need to disable the default site with `a2dissite`. Then we can enable the Galaxy site with `a2ensite`:

```bash
$ sudo a2dissite 000-default
Site 000-default disabled.
To activate the new configuration, you need to run:
  service apache2 reload
$ sudo a2ensite 000-galaxy
Enabling site 000-galaxy.
To activate the new configuration, you need to run:
  service apache2 reload
$
```

As with the module directories, this has removed and created symlinks in `sites-enabled/`. Before `a2dissite`, it looks like this:

```bash
$ ls -l sites-enabled/
total 4
lrwxrwxrwx 1 root root 35 Nov  3 14:07 000-default.conf -> ../sites-available/000-default.conf
```

And afterward it should look like this:

Finally, after these config changes, Apache must be restarted using `apache2ctl` (alternative methods include the `service` or `systemctl` commands):

```bash
$ sudo apache2ctl restart
$
```

Your Galaxy server should now be visible at http://yourhost/

## Section 2 - Performance improvements

**Part 1 - Static serving, compression, and caching**

Apache can be configured to serve the static content (such as Javascript and CSS), which reduces load on the Galaxy server process. It can also compress and instruct clients to cache these assets, which improves page load times.

Compression is enabled with `mod_deflate`, this can be loaded with `a2enmod deflate`. In Ubuntu 16.04, it should already be loaded (but `a2enmod` will harmlessly warn you if this is the case).

Caching is enabled with `mod_expires`. As you can probably guess, this can be loaded with `a2enmod expires`. It is not enabled by default in Ubuntu 16.04.

Galaxy is located in `/home/user/galaxy`, but by default, Apache is configured to only allow access to `/var/www`, `/usr/share`, and `~/public_html`. To allow Apache to serve static content from `/home/user/galaxy/static` we need to create `conf-available/galaxy.conf`. Additionally, Galaxy serves some content with the `application/json` content type, which is not compressed by `mod_deflate`'s default configuration, so we add that type:

```apache
<Directory "/home/user/galaxy/static">
    AllowOverride None
    Require all granted
</Directory>

AddOutputFilterByType DEFLATE application/json
```

And enable it with `a2enconf`:

```bash
$ sudo a2enconf galaxy
Enabling conf galaxy.
To activate the new configuration, you need to run:
  service apache2 reload
$ ls -lrt conf-enabled | tail -1
lrwxrwxrwx 1 root root 29 Nov  3 14:02 galaxy.conf -> ../conf-available/galaxy.conf
$ 
```

Next, we modify the previously created `sites-available/000-galaxy.conf` to include directives allowing Apache to serve static content, and instructing clients to cache it for 24 hours:

```apache
RewriteEngine on
RewriteRule ^/static/style/(.*) /home/user/galaxy/static/style/blue/$1 [L]
RewriteRule ^/static/scripts/(.*) /home/user/galaxy/static/scripts/$1 [L]
RewriteRule ^/static/(.*) /home/user/galaxy/static/$1 [L]
RewriteRule ^/favicon.ico /home/user/galaxy/static/favicon.ico [L]
RewriteRule ^/robots.txt /home/user/galaxy/static/robots.txt [L]
RewriteRule ^(.*) http://localhost:8080$1 [P]

<Location "/static">
    ExpiresActive On
    ExpiresDefault "access plus 24 hours"
</Location>
```

And restart the server with `sudo apache2ctl restart`.

**Part 2 - Serve Galaxy datasets with Apache**

The performance of your Galaxy server can be improved by configuring Apache to handle Galaxy dataset downloads as opposed to serving them directly from Galaxy. Apache first checks with Galaxy to ensure that the client has permission to access the file, and upon receiving an affirmative response and a path to the file on disk in the `X-Sendfile` header set in the response, directly serves the file to the client. The Apache module that does this is a third-party module named `mod_xsendfile`.

`mod_xsendfile` is available in Ubuntu as the package `libapache2-mod-xsendfile`. Installing it automatically enables it:

```bash
$ sudo apt-get install libapache2-mod-xsendfile
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  libapache2-mod-xsendfile
0 upgraded, 1 newly installed, 0 to remove and 31 not upgraded.
Need to get 13.4 kB of archives.
After this operation, 86.0 kB of additional disk space will be used.
Get:1 http://archive.ubuntu.com/ubuntu xenial/universe amd64 libapache2-mod-xsendfile amd64 0.12-2 [13.4 kB]
Fetched 13.4 kB in 0s (47.4 kB/s)                    
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libapache2-mod-xsendfile.
(Reading database ... 16899 files and directories currently installed.)
Preparing to unpack .../libapache2-mod-xsendfile_0.12-2_amd64.deb ...
Unpacking libapache2-mod-xsendfile (0.12-2) ...
Setting up libapache2-mod-xsendfile (0.12-2) ...
apache2_invoke: Enable module xsendfile
$
```

Next, modify `sites-available/000-galaxy.conf` to include the following *new* directive block at the top **top**:

```apache
<Location "/">
     XSendFile on
     XSendFilePath /
</Location>
```

In `/home/user/galaxy/config/galaxy.ini` (copy `galaxy.ini.sample` to `galaxy.ini` if you have not already done so), uncomment `#apache_xsendfile = False` and change it to `apache_xsendfile = True`.

Finally, (re)start your Galaxy server and Apache using `sudo apache2ctl restart`

You can verify that Galaxy is setting `X-Sendfile` and suppressing the dataset contents in the body of the request using `curl` directly on the Galaxy server, bypassing Apache:

```bash
$ curl -D- 'http://localhost:8080/datasets/f2db41e1fa331b3e/display?to_ext=txt'
HTTP/1.0 200 OK
Server: PasteWSGIServer/0.5 Python/2.7.12
Date: Thu, 03 Nov 2016 15:13:18 GMT
content-length: 13
x-content-type-options: nosniff
content-disposition: attachment; filename="Galaxy1-[Pasted_Entry].txt"
x-frame-options: SAMEORIGIN
content-type: application/octet-stream
x-sendfile: /home/user/galaxy/database/files/000/dataset_1.dat
Set-Cookie: galaxysession=c6ca0ddb55be603a151b0873219c10c7d08bb7dcedfebab34f379912ee51df3ae4688ac00316f62b; expires=Wed, 01-Feb-2017 15:13:17 GMT; httponly; Max-Age=7776000; Path=/; Version=1

curl: (18) transfer closed with 13 bytes remaining to read
```

## So, what did we learn?

- Apache's configuration structure and usage under Debian/Ubuntu
- Many "best practices" for setting up a proxy server for a production Galaxy server

## Further reading

Galaxy's [Apache proxy documentation](https://wiki.galaxyproject.org/Admin/Config/ApacheProxy) covers additional common tasks such as serving Galaxy from a subdirectory (like http://example.org/galaxy), HTTPS, and basic load balancing.
