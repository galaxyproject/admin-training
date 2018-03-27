![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# nginx as a Reverse Proxy for Galaxy - Exercise.

#### Authors: Nate Coraor (2016), Nicola Soranzo (2017)

## Learning Outcomes

By the end of this tutorial, you should:

1. Be able to install and configure nginx to:
   - Serve static content
   - Serve Galaxy datasets
1. Access Galaxy through the proxy
1. Download Galaxy datasets directly from the proxy
1. Upload new datasets directly to the proxy

## Introduction

Creating a reverse proxy from nginx to Galaxy provides a number of features not available in Galaxy's built-in [Paste](http://pythonpaste.org/) HTTP server, including:

- Serve static content
- Compress content
- Serve over HTTPS
- Serve byte range requests
- Serve other sites from the same server
- Can provide authentication

## Section 0 - Before you begin

If you completed the Apache exercise, it will bound to port 80, which will prevent nginx from doing the same. You can stop Apache with either `apache2ctl stop` or `systemctl stop apache2` and then prevent it from starting automatically with `systemctl disable apache2`.

## Section 1 - Installation and basic configuration

**Part 1 - Install nginx**

Install nginx from apt. We will use the `nginx-extras` flavor from Galaxy's Ubuntu Personal Package Archive (PPA) because this includes the upload module that we will use later. Begin by enabling the PPA:

```console
$ sudo apt-add-repository -y ppa:galaxyproject/nginx
gpg: keyring `/tmp/tmpjrtiq373/secring.gpg' created
gpg: keyring `/tmp/tmpjrtiq373/pubring.gpg' created
gpg: requesting key 9735427B from hkp server keyserver.ubuntu.com
gpg: /tmp/tmpjrtiq373/trustdb.gpg: trustdb created
gpg: key 9735427B: public key "Launchpad PPA for Galaxy Project" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
OK
$ sudo apt-get update
Hit:1 http://au.archive.ubuntu.com/ubuntu xenial InRelease
Hit:2 http://au.archive.ubuntu.com/ubuntu xenial-updates InRelease
Hit:3 http://au.archive.ubuntu.com/ubuntu xenial-backports InRelease
Hit:4 http://au.archive.ubuntu.com/ubuntu xenial-security InRelease
Get:5 http://ppa.launchpad.net/galaxyproject/nginx/ubuntu xenial InRelease [18.1 kB]
Hit:6 http://ppa.launchpad.net/webupd8team/java/ubuntu xenial InRelease
Get:7 http://ppa.launchpad.net/galaxyproject/nginx/ubuntu xenial/main amd64 Packages [2,468 B]
Get:8 http://ppa.launchpad.net/galaxyproject/nginx/ubuntu xenial/main i386 Packages [2,480 B]
Get:9 http://ppa.launchpad.net/galaxyproject/nginx/ubuntu xenial/main Translation-en [1,660 B]
Fetched 24.7 kB in 2s (11.7 kB/s)
Reading package lists... Done
$
```

Then install nginx:

```console
$ sudo apt-get install nginx-extras
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  nginx-common
Suggested packages:
  fcgiwrap nginx-doc
The following NEW packages will be installed:
  nginx-common nginx-extras
0 to upgrade, 2 to newly install, 0 to remove and 60 not to upgrade.
Need to get 479 kB of archives.
After this operation, 1,510 kB of additional disk space will be used.
Do you want to continue? [Y/n]
Get:1 http://ppa.launchpad.net/galaxyproject/nginx/ubuntu xenial/main amd64 nginx-common all 1.10.0-0ubuntu0.16.04.4ppa1 [47.4 kB]
Get:2 http://ppa.launchpad.net/galaxyproject/nginx/ubuntu xenial/main amd64 nginx-extras amd64 1.10.0-0ubuntu0.16.04.4ppa1 [662 kB]
Fetched 479 kB in 0s (543 kB/s)
Preconfiguring packages ...
Selecting previously unselected package nginx-common.
(Reading database ... 88615 files and directories currently installed.)
Preparing to unpack .../nginx-common_1.10.0-0ubuntu0.16.04.4_all.deb ...
Unpacking nginx-common (1.10.0-0ubuntu0.16.04.4) ...
Selecting previously unselected package nginx-extras.
Preparing to unpack .../nginx-extras.10.0-0ubuntu0.16.04.4_amd64.deb ...
Unpacking nginx-extras (1.10.0-0ubuntu0.16.04.4) ...
Processing triggers for ufw (0.35-0ubuntu2) ...
Processing triggers for ureadahead (0.100.0-19) ...
Processing triggers for systemd (229-4ubuntu13) ...
Processing triggers for man-db (2.7.5-1) ...
Setting up nginx-common (1.10.0-0ubuntu0.16.04.4) ...
Setting up nginx-extras (1.10.0-0ubuntu0.16.04.4) ...
Processing triggers for systemd (229-4ubuntu13) ...
Processing triggers for ureadahead (0.100.0-19) ...
Processing triggers for ufw (0.35-0ubuntu2) ...
$
```

Visit `http://<your_ip>/` (not localhost) and you should see the Ubuntu nginx default page.

**Part 2 - Basic configuration**

Now have a look at the configuration files in `/etc/nginx`. Debian (and Ubuntu) lay out nginx and Apache's configuration directories in consistent ways:

- `nginx.conf`: Main nginx config file. Note the `include` directives
- `conf.d/*.conf`: Included config files
- `sites-available/*`: Repository of available sites
- `sites-enabled/*.conf`: Symlinks to `sites-available/` files

nginx comes with everything needed to make it serve as a reverse proxy right out of the box, no additional modules need to be installed or enabled.

We need to create a config for the Galaxy "site". Create the file `sites-available/galaxy` as the `root` user (e.g. with `sudo -e /etc/nginx/sites-available/galaxy`). Unlike Apache, nginx does not have a "default" virtualhost, you have to create one using the `server { ... }` block:

```nginx
upstream galaxy {
    server localhost:8080;
}

server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;

    client_max_body_size 10G; # max upload size that can be handled by POST requests through nginx

    location / {
        proxy_pass          http://galaxy;
        proxy_set_header    X-Forwarded-Host $host;
        proxy_set_header    X-Forwarded-For  $proxy_add_x_forwarded_for;
    }
}
```

The `_` value of `server_name` is an invalid domain name used on purpose as a catch-all because it never intersects with any real server name. This works because when nginx decides which server should process a request, it checks the header field "Host" to determine which server the request should be routed to. If its value does not match any server name, then nginx will route the request to the default server for this port, which by default is the first one.

The X-Forwarded-Host and X-Forwarded-For HTTP headers are de-facto standard headers used by proxy servers for identifying respectively the original host requested by the client in the Host HTTP request header and the originating IP address of the client.

Ubuntu's Apache packages come with "enable" and "disable" commands for enabling and disable sites and modules. In reality, these simply create symlinks from the `sites-enabled/` directory to the `sites-available/` directory. With nginx you have to create/remove the symbolic links yourself. We want to disable the "default" site and enable the Galaxy site we just created:

```console
$ cd /etc/nginx/
$ sudo rm sites-enabled/default
$ sudo ln -s ../sites-available/galaxy sites-enabled/galaxy
```

After these config changes, nginx must be restarted. Again, unlike Apache, nginx does not have its own command to control the nginx server. It can be restarted with systemd's `systemctl` command: `sudo systemctl restart nginx`. It can also be instructed to reread its configs with `sudo nginx -s reload` (or `sudo systemctl reload nginx`), but beware: it will not reload if there is a config mistake (these refusals to reload can be discovered in `/var/log/nginx/error.log`). Config can be validated with `sudo nginx -t`.


```console
$ sudo systemctl restart nginx
$
```

Your Galaxy server should now be visible at `http://<your_ip>/` (if you receive a page with the message "502 Bad Gateway", ensure that your Galaxy server is running.

## Section 2 - Performance improvements

**Part 1 - Static serving, compression, and caching**

nginx can be configured to serve the static content (such as Javascript and CSS), which reduces load on the Galaxy server process. It can also compress and instruct clients to cache these assets, which improves page load times.

nginx on Ubuntu 16.04 enables gzip compression by default, but it needs some additional tuning to compress *all* compressable Galaxy elements. We now create a file, `conf.d/galaxy.conf` with the following contents to address this:

```nginx
gzip_vary on;
gzip_types text/plain text/css application/x-javascript text/xml application/xml application/xml+rss text/javascript application/json application/javascript;
gzip_http_version 1.1;
gzip_comp_level 6;
gzip_buffers 16 8k;
gzip_proxied any;
```

Next, we modify the previously created `sites-available/galaxy` to include directives allowing nginx to serve static content, and instructing clients to cache it for 24 hours. Modify the previous `server { ... }` block to place these additions after the `location / { ... }` block, just inside the `server { ... }` block's closing brace:

```nginx
    # use a variable for convenience
    set $galaxy_root /srv/galaxy/server/;
    
    location /static {
        alias $galaxy_root/static;
        expires 24h;
    }

    location /static/style {
        alias $galaxy_root/static/style/blue;
        expires 24h;
    }

    # serve vis/IE plugin static content
    location ~ ^/plugins/(?<plug_type>.+?)/(?<vis_name>.+?)/static/(?<static_file>.*?)$ {
        alias $galaxy_root/config/plugins/$plug_type/$vis_name/static/$static_file;
    }

    location /robots.txt {
        alias $galaxy_root/static/robots.txt;
    }

    location /favicon.ico {
        alias $galaxy_root/static/favicon.ico;
    }
```

And reload the nginx configuration with `sudo systemctl reload nginx`.

**Part 2 - Serve Galaxy datasets with nginx**

The performance of your Galaxy server can be improved by configuring nginx to handle Galaxy dataset downloads as opposed to serving them directly from Galaxy. nginx first checks with Galaxy to ensure that the client has permission to access the file, and upon receiving an affirmative response and a path to the file on disk in the `X-Accel-Redirect` header set in the response, directly serves the file to the client.

To begin, modify `sites-available/galaxy` to include this additional block at the end, just inside the `server { ... }` block's closing brace:

```nginx
    location /_x_accel_redirect/ {
        internal;
        alias /;
    }
```

In `/srv/galaxy/config/galaxy.ini`, uncomment `#nginx_x_accel_redirect_base = False` and change it to `nginx_x_accel_redirect_base = /_x_accel_redirect`. Remember, this file is owned by the **galaxy** user so be sure to use `sudo -u galaxy` when editing it.

Finally, (re)start:
- your Galaxy server (`CTRL+C` followed by `sudo -Hu galaxy galaxy` or `sudo -Hu galaxy galaxy --stop-daemon && sudo -Hu galaxy galaxy --daemon` if running as a daemon)
- nginx using `sudo systemctl restart nginx`

**Part 3 - Verify**

We can verify that our settings have taken effect, beginning with the compression and caching options. We will use `curl` with the `-D-` option to dump the HTTP headers to standard output.

```console
$ curl -D- -o /dev/null -s 'http://localhost/static/style/base.css' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Cache-Control: max-age=0' --compressed
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
- The `Cache-Control` header is set to `86400` seconds, i.e. 24 hours
- The `Content-Encoding` header is set to `gzip`

We can also verify that `X-Accel-Redirect` is working properly. Begin by uploading a simple 1-line text dataset to Galaxy (you can skip ahead to the verification step if you already did this for the Apache example):

1. Click the upload button at the top of the tool panel (on the left side of the Galaxy UI).
2. In the resulting modal dialog, click the "Paste/Fetch data" button.
3. Type some random characters into the text field that has just appeared.
4. Click "Start" and then "Close"

The path portion of the URL to the first dataset should be `/datasets/f2db41e1fa331b3e/display?to_ext=txt`. If you have already created another dataset, you can get the correct path by inspecting the link target of the history item's "floppy" icon. (For the curious, the constant string `f2db41e1fa331b3e` comes from hashing the number `1` using the default value of `id_secret` in `galaxy.ini` - this is why changing `id_secret` is important).

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
x-accel-redirect: /_x_accel_redirect/srv/galaxy/data/000/dataset_1.dat
x-frame-options: SAMEORIGIN
content-type: application/octet-stream
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

## Section 3 - Upload Galaxy datasets to nginx

**Part 1 - Add the upload store**

The performance of your Galaxy server can be further improved by configuring nginx to handle Galaxy dataset uploads directly. nginx intercepts the upload, writes it to disk, and then passes a `POST` request on to Galaxy with the file contents replaced with the path to the file.

To begin, modify `sites-available/galaxy` to include this additional block at the end, just inside the `server { ... }` block's closing brace:

```nginx
    location /_upload {
        upload_store /srv/galaxy/upload_store;
        upload_store_access user:rw group:rw;
        upload_pass_form_field "";
        upload_set_form_field "__${upload_field_name}__is_composite" "true";
        upload_set_form_field "__${upload_field_name}__keys" "name path";
        upload_set_form_field "${upload_field_name}_name" "$upload_file_name";
        upload_set_form_field "${upload_field_name}_path" "$upload_tmp_path";
        upload_pass_args on;
        upload_pass /_upload_done;
    }

    location /_upload_done {
        set $dst /api/tools;
        if ($args ~ nginx_redir=([^&]+)) {
            set $dst $1;
        }
        rewrite "" $dst;
    }
```

Note that the directory `/srv/galaxy/upload_store` is where the nginx upload module will store uploaded datasets. nginx runs as the `www-data` user, so we need to ensure that Galaxy can read and remove files from this directory. To do this, we make `www-data` a member of the `galaxy` group, create the directory, set its set group ID (setgid) attribute (2) and its permissions to `rwxrwx---` (770), and change its user and group ownership to `www-data` and `galaxy` respectively:

```console
$ sudo usermod -a -G galaxy www-data
$ sudo mkdir /srv/galaxy/upload_store
$ sudo chmod 2770 /srv/galaxy/upload_store
$ sudo chown www-data:galaxy /srv/galaxy/upload_store
```

In `/srv/galaxy/config/galaxy.ini`, uncomment `nginx_upload_store` and `nginx_upload_path` and set them:

```ini
nginx_upload_store = /srv/galaxy/upload_store
nginx_upload_path = /_upload
```

Finally, (re)start both Galaxy and nginx.

**Part 2 - Verify**

Watch nginx's access log with `sudo tail -f /var/log/nginx/access.log`

Create a small text file on your computer, and then upload it to Galaxy:

1. Click the upload button at the top of the tool panel (on the left side of the Galaxy UI).
2. Click the "Choose local file" button and select your text file
4. Click "Start" and then "Close"

If you see a line such as:

```
aaa.bbb.ccc.ddd - - [27/Jan/2017:21:04:28 +0000] "POST /_upload HTTP/1.1" 200 508 "http://eee.fff.ggg.hhh/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"
```

It means that the upload module successfully intercepted the upload. If the upload job completes successfully, then everything has worked correctly.

## So, what did we learn?

- nginx's configuration structure and usage under Debian/Ubuntu
- Many "best practices" for setting up a proxy server for a production Galaxy server

## Further reading

Galaxy's [nginx proxy documentation](https://docs.galaxyproject.org/en/master/admin/special_topics/nginx.html) covers additional common tasks such as serving Galaxy from a subdirectory (like http://example.org/galaxy), HTTPS, and basic load balancing.
