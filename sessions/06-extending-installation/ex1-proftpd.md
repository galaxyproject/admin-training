![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Allow users to upload data via FTP - Exercise.

#### Author: Nate Coraor (2017), Abdulrahman Azab (2018)

## Introduction

Loading large data into Galaxy can be difficult, especially since browser uploads do not easily support resuming transfers. You can use the venerable FTP (or preferably its secured counterpart, FTPS, or even SFTP) to allow users to upload data via an FTP client with more robust file transfer features.

## Section 1 - Install ProFTPD

For this example, we'll use ProFTPD. It's highly configurable and has a few important features we rely on, such as the ability to query users from a database, and PBKDF2 password support.

Install ProFTPD from the system package manager:

```console
$ sudo apt install proftpd-basic proftpd-mod-pgsql
Reading package lists... Done
Building dependency tree
Reading state information... Done
proftpd-basic is already the newest version (1.3.5a-1build1).
The following NEW packages will be installed:
  proftpd-mod-pgsql
0 to upgrade, 1 to newly install, 0 to remove and 61 not to upgrade.
Need to get 12.6 kB of archives.
After this operation, 503 kB of additional disk space will be used.
Do you want to continue? [Y/n]
Get:1 http://au.archive.ubuntu.com/ubuntu xenial/universe amd64 proftpd-mod-pgsql amd64 1.3.5a-1build1 [12.6 kB]
Fetched 12.6 kB in 0s (34.1 kB/s)
Selecting previously unselected package proftpd-mod-pgsql.
(Reading database ... 89076 files and directories currently installed.)
Preparing to unpack .../proftpd-mod-pgsql_1.3.5a-1build1_amd64.deb ...
Unpacking proftpd-mod-pgsql (1.3.5a-1build1) ...
Setting up proftpd-mod-pgsql (1.3.5a-1build1) ...
```

In our training instance, `proftpd-basic` is already installed. `proftpd-mod-pgsql` additionally provides PostgreSQL support.

## Section 2 - Configure ProFTPD

First, we need to instruct ProFTPD to load the `mod_sql` (SQL), `mod_sql_postgres` (PostgreSQL), and `mod_sql_passwd` (password hashing algorithms) modules. ProFTPD's config files can be found in `/etc/proftpd` and modules are loaded in `modules.conf`

```
$ cd /etc/proftpd
$ sudo -e modules.conf
```

Locate the lines for the modules we need and uncomment them:

```apache
LoadModule mod_sql.c
LoadModule mod_sql_postgres.c
LoadModule mod_sql_passwd.c
```

Then, save and quit your editor.

Next, get your Galaxy user's UID and GID. You'll need this for the next config file:

```console
$ id galaxy
uid=999(galaxy) gid=999(galaxy) groups=999(galaxy)
```

The main configuration file, `proftpd.conf`, will automatically include files matching `/etc/proftpd/conf.d/*.conf`. However, there are two options in the main configuration file we need to modify. Edit it:

```console
$ sudo -e proftpd.conf
```

Comment out the User and Group options. We'll set these to the Galaxy user and group later:

```apache
#User                           proftpd
#Group                          nogroup
```

Create a new config at `conf.d/galaxy.conf`:

```console
$ sudo -e conf.d/galaxy.conf
```

And add the following contents:

```apache
# Basics, some site-specific
Umask                           077

# This User & Group should be set to the actual user and group name which matches the UID & GID you will specify later in the SQLNamedQuery.
User                            galaxy
Group                           galaxy

# Cause every FTP user to be "jailed" (chrooted) into their home directory
DefaultRoot                     ~

# Automatically create home directory if it doesn't exist
CreateHome                      on dirmode 700

# Allow users to overwrite their files
AllowOverwrite                  on

# Allow users to resume interrupted uploads
AllowStoreRestart               on

# Bar use of SITE CHMOD
<Limit SITE_CHMOD>
    DenyAll
</Limit>

# Bar use of RETR (download) since this is not a public file drop
<Limit RETR>
    DenyAll
</Limit>

# Do not authenticate against real (system) users
<IfModule mod_auth_pam.c>
AuthPAM                         off
</IfModule>

# Common SQL authentication options
SQLEngine                       on
SQLPasswordEngine               on
SQLBackend                      postgres
SQLConnectInfo                  galaxy@/var/run/postgresql
SQLAuthenticate                 users

# Configuration that handles PBKDF2 encryption
# Set up mod_sql to authenticate against the Galaxy database
SQLAuthTypes                    PBKDF2
SQLPasswordPBKDF2               SHA256 10000 24
SQLPasswordEncoding             base64

# For PBKDF2 authentication
# See http://dev.list.galaxyproject.org/ProFTPD-integration-with-Galaxy-td4660295.html
SQLPasswordUserSalt             sql:/GetUserSalt

# Define a custom query for lookup that returns a passwd-like entry. Replace '999' with the UID and GID of the user running the Galaxy server
SQLUserInfo                     custom:/LookupGalaxyUser
SQLNamedQuery                   LookupGalaxyUser SELECT "email, (CASE WHEN substring(password from 1 for 6) = 'PBKDF2' THEN substring(password from 38 for 69) ELSE password END) AS password2,999,999,'/srv/galaxy/ftp/%U','/bin/bash' FROM galaxy_user WHERE email='%U'"

# Define custom query to fetch the password salt
SQLNamedQuery                   GetUserSalt SELECT "(CASE WHEN SUBSTRING (password from 1 for 6) = 'PBKDF2' THEN SUBSTRING (password from 21 for 16) END) AS salt FROM galaxy_user WHERE email='%U'"
```

If your UID and GID were not 999, be sure to update the `SQLNamedQuery LookupGalaxyUser` accordingly. Thne, save and quit your editor.

Finally, restart ProFTPD:

```console
$ sudo systemctl restart proftpd
$ systemctl status proftpd
● proftpd.service - LSB: Starts ProFTPD daemon
   Loaded: loaded (/etc/init.d/proftpd; bad; vendor preset: enabled)
   Active: active (running) since Wed 2017-02-01 04:34:42 UTC; 11s ago
```
If you get a unrecognized server error, edit `/etc/hosts` and add your hostname and IP address

## Section 3 - Configure Galaxy

We need to set a few Galaxy config options. First, the diretory where files will by uploaded to (we set it in the ProFTPD config as `/srv/galaxy/ftp`). Second is the address that users connect to - this is only used for display purposes in the Galaxy UI:

```console
$ sudo -u -e /srv/galaxy/config/galaxy.ini
```

Locate and set `ftp_*` accordingly:

```ini
ftp_upload_dir = /srv/galaxy/ftp
ftp_upload_site = galaxy.example.org
```

Then, save and quit your editor, and restart Galaxy with `CTRL+C` followed by `sudo -Hu galaxy galaxy` or `sudo -Hu galaxy galaxy --stop-daemon && sudo -Hu galaxy galaxy --daemon`

## Section 4 - Test FTP

First of all you create an FTP directory for each Galaxy user that will use FTP

```console
sudo -u galaxy mkdir /srv/galaxy/ftp/<galaxy-user-email>
```

If you have an FTP client on your system you can try it out now. Your username is the email address you registered in Galaxy with. If you don't, you can use the command line `ftp` client on your training instance. You can find a sample BED format file at `/srv/galaxy/server/test-data/1.bed`

```console
$ ftp localhost
Connected to localhost.
220 ProFTPD 1.3.5a Server (Debian) [::1]
Name (localhost:ubuntu): nate@bx.psu.edu
331 Password required for nate@bx.psu.edu
Password:
230 User nate@bx.psu.edu logged in
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> lcd /srv/galaxy/server/test-data
Local directory now /srv/galaxy/server/test-data
ftp> put 1.bed
local: 1.bed remote: 1.bed
200 EPRT command successful
150 Opening BINARY mode data connection for 1.bed
226 Transfer complete
4202 bytes sent in 0.00 secs (48.2812 MB/s)
ftp> quit
221 Goodbye.
```

Now, in the Galaxy UI, click the upload button at the top of the tool panel, then click the "Choose FTP file" button. You should see, and be able to choose the file you uploaded from the dialog that opens. Once selected, clicking "Start" adds the file to your history.

## Further reading

- [ProFTPD docs](http://www.proftpd.org/docs/)
- [Galaxy FTP docs](https://wiki.galaxyproject.org/Admin/Config/UploadviaFTP)
