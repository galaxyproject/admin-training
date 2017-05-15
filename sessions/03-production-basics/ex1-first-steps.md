![gatc2017_logo.png](../../docs/shared-images/gatc2017_logo.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Production Server First Steps - Exercise.

#### Authors: Nate Coraor. 2016

## Section 0 - Convenience

**Part 1 - Set up your environment**

- `$EDITOR` is a standard environment variable used to determine what editor to invoke when a program needs to start one (including the `sudo -e` command).
- `$PATH` is the list of directories that will be searched for commands on the command line.

First, set the variables on the command line. If you aren't familiar with UNIX editors, use the example here (`nano`):

```console
export EDITOR=nano
export PATH="/srv/galaxy/bin:$PATH"
```

And then in `~/.bashrc`, at the bottom with e.g. `$EDITOR ~/.bashrc`:

```sh
export EDITOR=nano
export PATH="/srv/galaxy/bin:$PATH"
```

**Part 2 - Configure sudo**

`sudo` allows you to run programs as the `root` (admin) user. We will do this a lot during the training, so to make life easier, we want to ensure we can use sudo without a password. This should already be done on your training instances, which you can verify with:

```console
$ sudo -l
Matching Defaults entries for ubuntu on server-f5d67052-36ac-40f5-abf7-14939e479df2.novalocal:
    env_reset, !requiretty, mail_badpass, secure_path=/usr/local/sbin\:/usr/local/bin\:/usr/sbin\:/usr/bin\:/sbin\:/bin\:/snap/bin

User ubuntu may run the following commands on server-f5d67052-36ac-40f5-abf7-14939e479df2.novalocal:
    (ALL : ALL) ALL
    (ALL) NOPASSWD: ALL
```

Your output should include the `(ALL) NOPASSWD: ALL` line.

Regardless, we will also want to disable sudo's environment resetting option. **NOTE:** Disabling `env_reset` and `secure_path` on a real system is not a safe thing to do - it is done here for convenience. Edit the file with `visudo`:

```console
$ sudo -E visudo
```

Comment the `env_reset` and `secure_path` lines thusly:

```
#Defaults   env_reset
#Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
```

If for some reason you do not have passwordless sudo enabled, add the following line:

```
ubuntu      ALL=(ALL) NOPASSWD:ALL
```

Then, save the file and quit the editor.

## Section 1 - User, directories, and files

**Part 1 - Create a Galaxy user**

Add a new user named `galaxy`:

```console
sudo useradd -d /srv/galaxy -m -r -s /bin/bash galaxy
```

**Part 2 - Set up directories**

`useradd` has created /srv/galaxy for you with the correct ownership. We now need to create directories for the Galaxy server, our config files, data, etc.

```console
$ sudo -u galaxy git clone -b release_16.10 https://github.com/galaxyproject/galaxy.git /srv/galaxy/server
$ sudo -u galaxy mkdir /srv/galaxy/{bin,config,data,log}
```

**Part 3 - Set up files**

Galaxy assumes that everything is located under the server directory. To separate things out, we'll create a small script to control the Galaxy server with that sets the location of Galaxy's primary config file:

```console
$ sudo -u galaxy -e /srv/galaxy/bin/galaxy
```

And insert the following:

```sh
#!/bin/sh

export GALAXY_CONFIG_FILE='/srv/galaxy/config/galaxy.ini'
export GALAXY_VIRTUAL_ENV='/srv/galaxy/venv'

case $1 in
    --daemon)
        log="--log-file=/srv/galaxy/log/paster.log"
        ;;
    *)
        log=""
        ;;
esac

/bin/sh /srv/galaxy/server/run.sh $log "$@"
```

Then, save and quit the editor. This file should be executable, make it so with `sudo chmod`:

```console
$ sudo -u galaxy chmod +x /srv/galaxy/bin/galaxy
```

Next, we'll create some Galaxy config files, starting from the samples:

```console
$ for f in galaxy.ini tool_conf.xml shed_tool_conf.xml tool_data_table_conf.xml \
           shed_tool_data_table_conf.xml data_manager_conf.xml shed_data_manager_conf.xml; do
    sudo -u galaxy cp /srv/galaxy/server/config/${f}.sample /srv/galaxy/config/${f}
done
```

Next, edit Galaxy's primary configuration file, `galaxy.ini`:

```console
$ sudo -u galaxy -e /srv/galaxy/config/galaxy.ini
```

Let's set a few config variables that will be useful for this and upcoming sessions:

```ini
file_path = /srv/galaxy/data
tool_config_file = /srv/galaxy/config/tool_conf.xml,/srv/galaxy/config/shed_tool_conf.xml
tool_dependency_dir = /srv/galaxy/dependencies
tool_data_table_config = /srv/galaxy/config/tool_data_table_conf.xml
shed_tool_data_table_config = /srv/galaxy/config/shed_tool_data_table_conf.xml
admin_users = your@ema.il
data_manager_config_file = /srv/galaxy/config/data_manager_conf.xml
shed_data_manager_config_file = /srv/galaxy/config/shed_data_manager_conf.xml
galaxy_data_manager_data_path = /srv/galaxy/tool-data
```

Then save and quit your editor.

Next, we need to define where tools that we install from the Galaxy Tool Shed will be installed. We do this in `shed_tool_conf.xml`, the file which controls which Tool Shed-installed tools are loaded into Galaxy at startup time:

```console
$ sudo -u galaxy -e /srv/galaxy/config/shed_tool_conf.xml
```

Change the `tool_path` attribute of the `<toolbox>` path to an absolute path, e.g.:

```xml
<toolbox tool_path="/srv/galaxy/shed_tools">
```

Then save and quit your editor.

In a production server we'd set some additional paths to prevent writing to the code directory (`/srv/galaxy/server`, especially the `database` subdirectory). The full list of options that we set for usegalaxy.org can be found in the [usegalaxy Ansible playbook](https://github.com/galaxyproject/usegalaxy-playbook/blob/7bd0ad190d148494f9430b23b1f9ab68e9936524/production/group_vars/galaxyservers.yml#L93).

## Section 2 - Start your new Galaxy

Unlike before, you'll now use the `galaxy` script we created to start and stop Galaxy. However, it takes the same arguments as `run.sh` (most notably `--daemon` and `--stop-daemon`). Remember that we need to start the Galaxy server as the new `galaxy` user:

```console
$ sudo -Hu galaxy galaxy
```

As before, Galaxy should now be accessible at [http://localhost:8080](http://localhost:8080)
