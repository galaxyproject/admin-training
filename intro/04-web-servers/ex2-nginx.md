![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GAT - 2016 - Salt Lake City

# nginx as a Reverse Proxy for Galaxy - Exercise.

#### Authors: Nate Coraor. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Be able to install and configure nginx to:
  - Serve static content
  - Serve Galaxy datasets
1. Access Galaxy through the proxy
1. Download Galaxy datasets directly from the proxy

## Introduction

Creating a reverse proxy from nginx to Galaxy provides a number of features not available in Galaxy's built-in [Paste](http://pythonpaste.org/) HTTP server, including:

- Serve static content
- Compress content
- Serve over HTTPS
- Serve byte range requests
- Serve other sites from the same server
- Can provide authentication

## Section 0 - Before you begin

If you completed exercise 1 and installed Apache, it will bound to port 80, which will prevent nginx from doing the same. You can stop Apache with either `apache2ctl stop` or `systemctl stop apache2` and then prevent it from starting automatically with `systemctl disable apache2`.

## Section 1 - Installation and basic configuration

**Part 1 - Install nginx**

Install nginx from apt. We'll use the `nginx-full` flavor:

```console
$ sudo apt-get install nginx-full
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core geoip-database libfontconfig1 libfreetype6 libgd3 libgeoip1 libjbig0 libjpeg-turbo8 libjpeg8 libpng12-0 libtiff5 libvpx3 libxpm4 libxslt1.1 nginx-common ucf
Suggested packages:
  libgd-tools geoip-bin fcgiwrap nginx-doc
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core geoip-database libfontconfig1 libfreetype6 libgd3 libgeoip1 libjbig0 libjpeg-turbo8 libjpeg8 libpng12-0 libtiff5 libvpx3 libxpm4 libxslt1.1 nginx-common nginx-full ucf
0 upgraded, 18 newly installed, 0 to remove and 31 not upgraded.
Need to get 5251 kB of archives.
After this operation, 17.0 MB of additional disk space will be used.
Do you want to continue? [Y/n]
Get:1 http://archive.ubuntu.com/ubuntu xenial/main amd64 libjpeg-turbo8 amd64 1.4.2-0ubuntu3 [111 kB]
  ...
Selecting previously unselected package libjpeg-turbo8:amd64.
(Reading database ... 16917 files and directories currently installed.)
Preparing to unpack .../libjpeg-turbo8_1.4.2-0ubuntu3_amd64.deb ...
Unpacking libjpeg-turbo8:amd64 (1.4.2-0ubuntu3) ...
  ...
Setting up nginx-full (1.10.0-0ubuntu0.16.04.4) ...
Processing triggers for libc-bin (2.23-0ubuntu3) ...
Processing triggers for systemd (229-4ubuntu6) ...
$
```

Visit http://yourhost/ and you should see the Ubuntu nginx default page (or the Apache default page if you installed Apache before nginx).

**Part 2 - Basic configuration**

Now have a look at the configuration files in `/etc/nginx`. Debian (and Ubuntu) lay out nginx and Apache's configuration directories in consistent ways:

- `nginx.conf`: Main Apache config file. Note the `include` directories
- `conf.d/*.conf`: Included config files
- `sites-available/*`: Repository of available sites
- `sites-enabled/*.conf`: Symlinks to `sites-available/` files

nginx comes with everything needed to make it serve as a reverse proxy right out of the box, no additional modules need to be installed or enabled.

We need to create a config for the Galaxy "site". Create the file `sites-available/galaxy`. Unlike Apache, nginx does not have a "default" virtualhost, you have to create one using the `server { ... }` block:

```apache
upstream galaxy {
    server localhost:8080;
}

server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;

    client_max_body_size 10G; # aka max upload size, defaults to 1M

    location / {
		proxy_pass          http://galaxy;
		proxy_set_header    X-Forwarded-Host $host;
		proxy_set_header    X-Forwarded-For  $proxy_add_x_forwarded_for;
	}
}
```

Unlike Apache, Ubuntu's nginx packages don't come with "enable" and "disable" commands, so you have to create/remove the symbolic links yourself. We want to disable the "default" site and enable the Galaxy site we just created:

```console
$ sudo rm sites-enabled/default
$ sudo ln -s ../sites-available/galaxy sites-enabled/galaxy
```

After these config changes, nginx must be restarted. Again, unlike Apache, nginx does not have its own command to control the nginx server. It can be restarted with systemd's `systemctl` command: `sudo systemctl restart nginx`. It can also be instructed to reread its configs with a `SIGHUP` (e.g. `sudo pkill -HUP nginx`) but beware: it will not reload if there is a config mistake (these refusals to reload can be discovered in `/var/log/nginx/error.log`).


```console
$ sudo systemctl restart nginx
$
```

Your Galaxy server should now be visible at http://yourhost/

## Section 2 - Performance improvements

**Part 1 - Static serving, compression, and caching**

nginx can be configured to serve the static content (such as Javascript and CSS), which reduces load on the Galaxy server process. It can also compress and instruct clients to cache these assets, which improves page load times.

nginx on Ubuntu 16.04 enables gzip compression by default but it needs some additional tuning to compress *all* compressable Galaxy elements. We'll create a file, `conf.d/galaxy.conf` with the following contents to address this:

```nginx
gzip_vary on;
gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript application/javascript;
gzip_http_version 1.1;
gzip_comp_level 6;
gzip_buffers 16 8k;
gzip_proxied any;
```

Next, we modify the previously created `sites-available/galaxy` to include directives allowing nginx to serve static content, and instructing clients to cache it for 24 hours. Modify the previous `server { ... }` block to place these additions after the `location / { ... }` block, just inside the `server { ... }` block's closing brace:

```nginx
    location /static {
        alias /home/galaxyguest/galaxy/static;
        expires 24h;
    }

    location /static/style {
        alias /home/galaxyguest/galaxy/static/style/blue;
        expires 24h;
    }

    location /static/scripts {
        alias /home/galaxyguest/galaxy/static/scripts;
        expires 24h;
    }

    # serve vis/IE plugin static content
    location ~ ^/plugins/(?<plug_type>.+?)/(?<vis_name>.+?)/static/(?<static_file>.*?)$ {
        alias /home/galaxyguest/galaxy/config/plugins/$plug_type/$vis_name/static/$static_file;
    }

    location /robots.txt {
        alias /home/galaxyguest/galaxy/static/robots.txt;
    }

    location /favicon.ico {
        alias /home/galaxyguest/galaxy/static/favicon.ico;
    }
```

And restart the server with `sudo systemctl restart nginx`.

**Part 2 - Serve Galaxy datasets with nginx**

The performance of your Galaxy server can be improved by configuring nginx to handle Galaxy dataset downloads as opposed to serving them directly from Galaxy. nginx first checks with Galaxy to ensure that the client has permission to access the file, and upon receiving an affirmative response and a path to the file on disk in the `X-Accel-Redirect` header set in the response, directly serves the file to the client.

To begin, modify `sites-available/galaxy` to include this additional block at the end, just inside the `server { ... }` block's closing brace:

```nginx
    location /_x_accel_redirect {
        internal;
        alias /;
    }
```

In `/home/galaxyguest/galaxy/config/galaxy.ini` (copy `galaxy.ini.sample` to `galaxy.ini` if you have not already done so), uncomment `#nginx_x_accel_redirect_base = False` and change it to `nginx_x_accel_redirect_base = /_x_accel_redirect`.

Finally, (re)start your Galaxy server and nginx using `sudo systemctl restart nginx`

**Part 3 - Verify**

We can verify that our settings have taken effect, beginning with the compression and caching options:

```console
$ curl -D- -o null -s 'http://localhost/static/style/base.css' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Cache-Control: max-age=0' --compressed
```
```http
HTTP/1.1 200 OK
Server: nginx/1.10.0 (Ubuntu)
Date: Thu, 03 Nov 2016 18:53:57 GMT
Content-Type: text/css
Last-Modified: Thu, 03 Nov 2016 14:09:06 GMT
Transfer-Encoding: chunked
Connection: keep-alive
Vary: Accept-Encoding
ETag: W/"581b4502-47010"
Expires: Fri, 04 Nov 2016 18:53:57 GMT
Cache-Control: max-age=86400
Content-Encoding: gzip

```

Note that:
- The `Cache-Control` header is set to `86400` (seconds)
- The `Content-Encoding` header is set to `gzip`

We can also verify that `X-Accel-Redirect` is working properly. Begin by uploading a simple 1-line text dataset to Galaxy (you can skip ahead to the verification step if you already did this for the Apache example):

1. Click the upload button at the top of the tool panel (on the left side of the Galaxy UI).
2. In the resulting modal dialog, click the "Paste/Fetch data" button.
3. Type some random characters into the text field that has just appeared.
4. Click "Start" and then "Close"

The path portion of the URL to the first dataset should be `/datasets/f2db41e1fa331b3e/display?to_ext=txt`. If you've already created another dataset, you can get the correct path by inspecting the link target of the history item's "floppy" icon. (For the curious, the constant string `f2db41e1fa331b3e` comes from hashing the number `1` using the default value of `id_secret` in `galaxy.ini` - this is why changing `id_secret` is important).

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
- The `x-accel-redirect` header is set in the response headers
- The connection terminates prematurely because Galaxy itself does not send the file contents in the body

We can now verify that nginx is serving the file by sending the same request to `http://localhost` (with the default port `80`):

```console
$ curl -D- 'http://localhost/datasets/f2db41e1fa331b3e/display?to_ext=txt'
```
```http
HTTP/1.1 200 OK
Server: nginx/1.10.0 (Ubuntu)
Date: Thu, 03 Nov 2016 18:33:51 GMT
Content-Type: application/octet-stream
Content-Length: 13
Last-Modified: Thu, 03 Nov 2016 15:07:12 GMT
Connection: keep-alive
content-disposition: attachment; filename="Galaxy1-[Pasted_Entry].txt"
Set-Cookie: galaxysession=c6ca0ddb55be603aab8856813bfb646872d7222ab305bb1467b0a8d96aaa86ce30d4ac78334de21e; expires=Wed, 01-Feb-2017 18:33:50 GMT; httponly; Max-Age=7776000; Path=/; Version=1
ETag: "581b52a0-d"
Accept-Ranges: bytes

asdfasdfasdf
```

Note that:
- nginx has stripped out the `x-accel-redirect` header.
- nginx returns the file contents

## So, what did we learn?

- nginx's configuration structure and usage under Debian/Ubuntu
- Many "best practices" for setting up a proxy server for a production Galaxy server

## Further reading

Galaxy's [nginx proxy documentation](https://wiki.galaxyproject.org/Admin/Config/nginxProxy) covers additional common tasks such as serving Galaxy from a subdirectory (like http://example.org/galaxy), HTTPS, and basic load balancing.
