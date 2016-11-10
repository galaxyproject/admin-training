![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# PAM Authentication in Galaxy - Exercise

#### Authors: Nate Coraor. 2016

## Learning Outcomes

1. By the end of this session you should be familiar with Galaxy's Pluggable Authentication System and its configuration
2. Have basic familiarity with the Linux PAM subsystem
3. Be able to log in to your Galaxy server with a system user

## Introduction

## Section 1 - Install dependencies

**Part 1 - Install python-pam**

We need to install `python-pam` into Galaxy's virtualenv, now located at `/srv/galaxy/server/.venv`. To do this, run:

```console
$ sudo -H -u galaxy /srv/galaxy/server/.venv/bin/pip install python-pam
Collecting python-pam
  Downloading python-pam-1.8.2.tar.gz
Building wheels for collected packages: python-pam
  Running setup.py bdist_wheel for python-pam ... done
  Stored in directory: /home/galaxy/.cache/pip/wheels/2a/37/e1/75c8e26b429857d73aeabd1fe39365c72a969706c30d9e6572
Successfully built python-pam
Installing collected packages: python-pam
Successfully installed python-pam-1.8.2
You are using pip version 8.1.2, however version 9.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```

## Section 2 - Update system

We don't want to grant the `galaxyguest` user access to Galaxy or else we'd be sending our VM admin user passwords in the clear. Instead, we'll create a new system user, `galaxyuser`, to log in with. If you were connecting Galaxy to your institution's authentication system, you wouldn't perform the steps in this section. Creating users in that system would be done via whatever mechanisms are appropriate for that system.

Create the user `galaxyuser` and set a nontrivial password that is not the same as `galaxyguest`'s:

```console
$ sudo useradd -d /home/galaxyuser -m -s /bin/bash galaxyuser
$ sudo passwd galaxyuser
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
```

You should now be able to see the new user with e.g. `getent`:

```console
$ getent passwd galaxyuser
galaxyuser:x:1001:1001::/home/galaxyuser:/bin/bash
```

One final system change needs to be made - again, only because we are using local user accounts for authentication (ones in `/etc/passwd` and `/etc/shadow`. The Galaxy server user needs to have access to the `/etc/shadow` file where hashed passwords are stored. This is not something you should normally do as it is a small security risk (if a security flaw in Galaxy allowed reading arbitrary files, attackers could use it to read `/etc/shadow`).

This change adds the `galaxy` user to the `shadow` group, which allows it to read `/etc/shadow`, which has group ownership `shadow`:

```console
$ sudo usermod -a -G shadow galaxy
```

## Section 3 - Update configurations and Galaxy

**Part 1 - Create an authentication config**

Create a new config file, `/srv/galaxy/server/conf/auth_conf.xml`. To open as the `galaxy` user, you can use `sudo -H -u galaxy $EDITOR /srv/galaxy/server/config/auth_conf.xml`:

```xml
<?xml version="1.0"?>
<auth>
<authenticator>
  <type>PAM</type>
  <options>
          <auto-register>True</auto-register>
          <maildomain>example.com</maildomain>
          <login-use-email>True</login-use-email>
          <pam-service>sshd</pam-service>
  </options>
</authenticator>
</auth>
```

Let's take a look at the `sshd` PAM service in `/etc/pam.d/sshd` and discover how it works.

Finally, restart Galaxy:

```console
$ sudo supervisorctl restart all
gx:handler0: stopped
gx:handler1: stopped
gx:galaxy: stopped
gx:handler0: started
gx:handler1: started
gx:galaxy: started
```

**Part 2 - Log in to Galaxy**

Go to http://yourgalaxyhost/ and log in (log out first if necessary) as `galaxyuser@example.com`.

**Part 3 - Optionally disable self registration and require login**

To configure Galaxy in this way, edit the galaxy config file using `sudo -H -u galaxy $EDITOR /srv/galaxy/server/config/galaxy.ini`:

```ini
require_login = True
allow_user_creation = False
```

Restart Galaxy with `sudo supervisorctl restart all`, then visit it in your browser. Log out and log back in again to see the results.

**Part 3 - Undo changes**

We don't want to leave Galaxy this way for the rest of our workshop. Undo the changes by removing `require_login` and `allow_user_creation` from `galaxy.ini`, and moving `auth_conf.xml` using `sudo -u galaxy mv /srv/galaxy/server/config/auth_conf.xml /srv/galaxy/server/config/auth_conf.xml.pam` and restarting Galaxy with `sudo supervisorctl restart all`.
