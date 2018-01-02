![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Exercise - Running the Jupyter Galaxy Interactive Environment (GIE)

#### Authors: Nate Coraor. 2017

## Introduction

Galaxy Interactive Environments provide an interface between containerized interactive analysis tools and the Galaxy analysis environment (history). There are a number of GIEs available, but the most frequently used (and easiest to configure) is the Jupyter GIE. A proxy server written in Node.js connects the client (browser) to the Dockerized Jupyter notebook.

## Section 1 - Install Components

Begin by installing Docker and Node.js

```console
$ sudo apt install docker.io npm nodejs-legacy
```

Next, allow the `galaxy` user to use Docker without requiring sudo by adding it to the `docker` group:

```
$ sudo usermod -a -G docker galaxy
```

While not explicitly necessary, it's best to pull the Docker image we'll use first. Otherwise, this occurs the first time the Jupyter GIE is called from the Galaxy UI. Because this takes a long time, attempts to use Jupyter in the UI will time out until the image has been downloaded.

```console
$ sudo -u galaxy docker pull bgruening/docker-jupyter-notebook:16.01.1
```

## Section 2 - Configure Node.js proxy

**Part 1 - Configure proxy**

In a separate terminal window, open a shell as the `galaxy` user and run:

```console
$ sudo -Hsu galaxy
$ cd /srv/galaxy/server/lib/galaxy/web/proxy/js
$ npm install
$ cd /srv/galaxy/server/config/plugins/interactive_environments/jupyter/config
$ cp jupyter.ini.sample jupyter.ini
$ cp allowed_images.yml.sample allowed_images.yml
```

Have a look in the config files you have just created. Edit `allowed_images.yml` and change the `image`:

```yaml
    image: bgruening/docker-jupyter-notebook:16.01.1
```

Next, edit `/srv/galaxy/config/galaxy.ini` and add the following:

```ini
interactive_environment_plugins_directory = /srv/galaxy/server/config/plugins/interactive_environments
dynamic_proxy_external_proxy = True
dynamic_proxy_manage = False
dynamic_proxy_bind_port = 8800
dynamic_proxy_debug = True
dynamic_proxy_session_map = /srv/galaxy/config/gie_proxy_session_map.sqlite
dynamic_proxy_prefix = gie_proxy
dynamic_proxy_bind_ip = 127.0.0.1
```

Once saved, exit your `galaxy` user shell and return to the `ubuntu` user. Then, restart Galaxy:

```console
$ sudo supervisorctl restart gx:galaxy
```

**Part 2 - Configure nginx**

We'll now proxy the Node.js proxy with nginx. This is done by adding to `/etc/nginx/sites-available/galaxy`. Inside the `server { ... }` block, add:

```nginx
    # Global GIE configuration
    location /gie_proxy {
        proxy_pass http://localhost:8800/gie_proxy;
        proxy_redirect off;
    }

    # Project Jupyter / IPython specific. Other IEs may require their own routes.
    location ~ ^/gie_proxy/jupyter/(?<nbtype>[^/]+)/api/kernels(?<rest>.*?)$ {
        proxy_pass http://localhost:8800/gie_proxy/jupyter/$nbtype/api/kernels$rest;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
```

Once saved, restart nginx to reread the config:

```console
$ sudo systemctl restart nginx
```

**Part 3 - Configure proxy to start with supervisor**

All that remains is to start the proxy, which we'll do with supervisor. Add to `/etc/supervisor/conf.d/galaxy.conf`:

```ini
[program:gie_proxy]
command         = node /srv/galaxy/server/lib/galaxy/web/proxy/js/lib/main.js --ip 127.0.0.1 --port 8800 --sessions /srv/galaxy/config/gie_proxy_session_map.sqlite --cookie galaxysession --verbose
directory       = /srv/galaxy/server/lib/galaxy/web/proxy
umask           = 022
autostart       = true
autorestart     = true
startsecs       = 5
user            = galaxy
numprocs        = 1
stdout_logfile  = /srv/galaxy/log/gie_proxy.log
redirect_stderr = true
```

Once saved, start the proxy by updating supervisor:

```console
$ sudo supervisorctl update
```

## Section 3 - Test

Reload the Galaxy UI and choose **Interactive Environments** from the **Visualization** menu in the masthead. Alternatively, you can click the bar graph icon on any dataset in your history and choose the **Jupyter** option from the popup menu. You should see a spinner icon and eventually the Jupyter interface will load. You can see that the container is running using `docker ps`:

```console
$ sudo docker ps
CONTAINER ID        IMAGE                                               COMMAND                  CREATED             STATUS              PORTS                     NAMES
2e65f3ef0c53        quay.io/bgruening/docker-jupyter-notebook:16.01.1   "tini -- /bin/sh -c /"   11 seconds ago      Up 9 seconds        0.0.0.0:32768->8888/tcp   agitated_liskov
```

In addition to arbitrary Python, you can use the `get()` and `put()` commands (`get()` takes a single argument - an integer id of a dataset in your current history) to interact with your history.
