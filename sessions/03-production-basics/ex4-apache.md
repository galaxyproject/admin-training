![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Apache as a Reverse Proxy for Galaxy - Exercise.

#### Authors: Nate Coraor (2016), Nicola Soranzo (2017)

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

## Section 0 - Before you begin

If you completed the nginx exercise, it will bound to port 80, which will prevent Apache from doing the same. You can stop nginx with `systemctl stop nginx` and then prevent it from starting automatically with `systemctl disable nginx`.

## Section 1 - Installation and basic configuration

**Part 1 - Install Apache**

Install Apache from apt:

```console
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

These are enabled using the `a2enmod` command (without the `mod_` prefix):

```console
$ sudo a2enmod rewrite
Enabling module rewrite.
To activate the new configuration, you need to run:
  service apache2 restart
$
```

All this has really done is created a symbolic link (symlink) in `mods-enabled/`:

```console
$ ls -lrt mods-enabled/ | tail -1
lrwxrwxrwx 1 root root 30 Nov  3 03:50 rewrite.load -> ../mods-available/rewrite.load
```

`a2enmod` ensure that module dependencies are enabled. We can enable both `mod_proxy` and `mod_proxy_http` like so:

```console
$ sudo a2enmod proxy_http
Considering dependency proxy for proxy_http:
Enabling module proxy.
Enabling module proxy_http.
To activate the new configuration, you need to run:
  service apache2 restart
$
```

Next, we need to create a config for the Galaxy "site". Create the file `sites-available/000-galaxy.conf`. This should contain `RewriteRule` to proxy Galaxy:

```apache
RewriteEngine on
RewriteRule ^(.*) http://localhost:8080$1 [P]
```

Before we can enable the new "Galaxy" site we need to disable the default site with `a2dissite`. Then we can enable the Galaxy site with `a2ensite`:

```console
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

```console
$ ls -l sites-enabled/
total 4
lrwxrwxrwx 1 root root 35 Nov  3 14:07 000-default.conf -> ../sites-available/000-default.conf
```

And afterward it should look like this:

Finally, after these config changes, Apache must be restarted using `apache2ctl` (alternative methods include the `service` or `systemctl` commands):

```console
$ sudo apache2ctl restart
$
```

Your Galaxy server should now be visible at http://yourhost/

## Section 2 - Performance improvements

**Part 1 - Static serving, compression, and caching**

Apache can be configured to serve the static content (such as Javascript and CSS), which reduces load on the Galaxy server process. It can also compress and instruct clients to cache these assets, which improves page load times.

Compression is enabled with `mod_deflate`, this can be loaded with `a2enmod deflate`. In Ubuntu 16.04, it should already be loaded (but `a2enmod` will harmlessly warn you if this is the case).

Caching is enabled with `mod_expires`. As you can probably guess, this can be loaded with `a2enmod expires`. It is not enabled by default in Ubuntu 16.04.

Galaxy is located in `/home/galaxyguest/galaxy`, but by default, Apache is configured to only allow access to `/var/www`, `/usr/share`, and `~/public_html`. To allow Apache to serve static content from `/home/galaxyguest/galaxy/static` we need to create `conf-available/galaxy.conf`. Additionally, Galaxy serves some content with the `application/json` content type, which is not compressed by `mod_deflate`'s default configuration, so we add that type:

```apache
<Directory "/home/galaxyguest/galaxy/static">
    AllowOverride None
    Require all granted
</Directory>

AddOutputFilterByType DEFLATE application/json
```

And enable it with `a2enconf`:

```console
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
RewriteRule ^/static/style/(.*) /home/galaxyguest/galaxy/static/style/blue/$1 [L]
RewriteRule ^/static/scripts/(.*) /home/galaxyguest/galaxy/static/scripts/$1 [L]
RewriteRule ^/static/(.*) /home/galaxyguest/galaxy/static/$1 [L]
RewriteRule ^/favicon.ico /home/galaxyguest/galaxy/static/favicon.ico [L]
RewriteRule ^/robots.txt /home/galaxyguest/galaxy/static/robots.txt [L]
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

```console
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

Next, modify `sites-available/000-galaxy.conf` to include the following *new* directive block at the **top**:

```apache
<Location "/">
     XSendFile on
     XSendFilePath /
</Location>
```

In `/home/galaxyguest/galaxy/config/galaxy.yml` (copy `galaxy.yml.sample` to `galaxy.yml` if you have not already done so), uncomment `#apache_xsendfile: False` and change it to `apache_xsendfile: True`.

Finally, (re)start:
- your Galaxy server (`CTRL+C` followed by `sudo -Hu galaxy galaxy` or `sudo -Hu galaxy galaxy --stop-daemon && sudo -Hu galaxy galaxy --daemon` if running as a daemon)
- Apache using `sudo apache2ctl restart`

**Part 3 - Verify**

We can verify that our settings have taken effect, beginning with the compression and caching options. We will use `curl` with the `-D-` option to dump the HTTP headers to standard output.

```console
$ curl -D- -o /dev/null -s 'http://localhost/static/style/base.css' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Cache-Control: max-age=0' --compressed
```
```http
HTTP/1.1 200 OK
Date: Thu, 03 Nov 2016 18:57:22 GMT
Server: Apache/2.4.18 (Ubuntu)
Last-Modified: Thu, 03 Nov 2016 14:09:06 GMT
ETag: "47010-5406619bfda53-gzip"
Accept-Ranges: bytes
Vary: Accept-Encoding
Content-Encoding: gzip
Cache-Control: max-age=86400
Expires: Fri, 04 Nov 2016 18:57:22 GMT
Content-Length: 48600
Content-Type: text/css

```

Note that:
- The `Cache-Control` header is set to `86400` seconds, i.e. 24 hours
- The `Content-Encoding` header is set to `gzip`

We can also verify that `X-Sendfile` is working properly. Begin by uploading a simple 1-line text dataset to Galaxy:

1. Click the upload button at the top of the tool panel (on the left side of the Galaxy UI).
2. In the resulting modal dialog, click the "Paste/Fetch data" button.
3. Type some random characters into the text field that has just appeared.
4. Click "Start" and then "Close"

The path portion of the URL to the first dataset should be `/datasets/f2db41e1fa331b3e/display?to_ext=txt`. If you have already created another dataset, you can get the correct path by inspecting the link target of the history item's "floppy" icon. (For the curious, the constant string `f2db41e1fa331b3e` comes from hashing the number `1` using the default value of `id_secret` in `galaxy.yml` - this is why changing `id_secret` is important).

The Galaxy server can be contacted directly at `http://localhost:8080`. Combine this with the path to the dataset and provide it to `curl`:


```console
$ curl -D- 'http://localhost:8080/datasets/f2db41e1fa331b3e/display?to_ext=txt'
```
```http
HTTP/1.0 200 OK
Server: PasteWSGIServer/0.5 Python/2.7.12
Date: Thu, 03 Nov 2016 15:13:18 GMT
content-length: 13
x-content-type-options: nosniff
content-disposition: attachment; filename="Galaxy1-[Pasted_Entry].txt"
x-frame-options: SAMEORIGIN
content-type: application/octet-stream
x-sendfile: /home/galaxyguest/galaxy/database/files/000/dataset_1.dat
Set-Cookie: galaxysession=c6ca0ddb55be603a151b0873219c10c7d08bb7dcedfebab34f379912ee51df3ae4688ac00316f62b; expires=Wed, 01-Feb-2017 15:13:17 GMT; httponly; Max-Age=7776000; Path=/; Version=1

curl: (18) transfer closed with 13 bytes remaining to read
```

Note that:
- The `x-sendfile` header is set in the response headers
- The connection terminates prematurely because Galaxy itself does not send the file contents in the body

We can now verify that Apache is serving the file by sending the same request to `http://localhost` (with the default port `80`):

```console
$ curl -D- 'http://localhost/datasets/f2db41e1fa331b3e/display?to_ext=txt'
```
```http
HTTP/1.1 200 OK
Date: Thu, 03 Nov 2016 19:05:26 GMT
Server: PasteWSGIServer/0.5 Python/2.7.12
x-content-type-options: nosniff
content-disposition: attachment; filename="Galaxy1-[Pasted_Entry].txt"
x-frame-options: SAMEORIGIN
content-type: application/octet-stream
Set-Cookie: galaxysession=c6ca0ddb55be603a51fadea289675f235ed06d9609aeaa96c8a60a7d1f608d5c1f44d5fa14e4125f; expires=Wed, 01-Feb-2017 19:05:26 GMT; httponly; Max-Age=7776000; Path=/; Version=1
Last-Modified: Thu, 03 Nov 2016 15:07:12 GMT
ETag: "54066e984bd41"
Content-Length: 13

asdfasdfasdf
```

Note that:
- Apache has stripped out the `x-sendfile` header.
- Apache returns the file contents

## So, what did we learn?

- Apache's configuration structure and usage under Debian/Ubuntu
- Many "best practices" for setting up a proxy server for a production Galaxy server

## Further reading

Galaxy's [Apache proxy documentation](https://docs.galaxyproject.org/en/master/admin/special_topics/apache.html) covers additional common tasks such as serving Galaxy from a subdirectory (like http://example.org/galaxy), HTTPS, and basic load balancing.
