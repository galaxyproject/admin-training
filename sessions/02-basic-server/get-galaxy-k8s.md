layout: true
class: inverse, middle, large

---
class: special
# How to get Galaxy

slides by @nuwang

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!
Your questions will be answered.

---
class: normal
# Reasons to Install Your Own Galaxy

You only need to download Galaxy if you plan to:

- Run a local production Galaxy because you want to
  - Install and use tools unavailable on public Galaxies
  - Use sensitive data (e.g. clinical)
  - Process large datasets that are too big for public Galaxies
  - Plug-in new datasources
- Develop Galaxy tools
- Develop Galaxy itself

Even when you plan any of the above sometimes you can leverage pre-configured
[Docker image](https://github.com/bgruening/docker-galaxy-stable)
or use [Cloudlaunch](https://launch.usegalaxy.org).

---
# Get logged in to your VM

For OS X/Linux/Windows w/ Linux Subsystem or OpenSSH:
```console
$ ssh ubuntu@`<your_ip>`
```

For [PuTTY](http://www.putty.org/) on Windows:
- Create a session
- See [instructions here](https://mediatemple.net/community/products/dv/204404604/using-ssh-in-putty-).
- User: ubuntu
- Host Name: `<your_ip>`

---
# Requirements (Linux)

- Docker
- At least 8GB of RAM

Run:
```shell
$ sudo wget https://raw.githubusercontent.com/CloudVE/cloudman-boot/master/scripts/cm_boot_linux.sh
$ sudo sh cm_boot_linux.sh `<your_ip>`

```

---
# Requirements (Mac)

- Docker
- At least 8GB of RAM

Run:
```shell
$ sudo wget https://raw.githubusercontent.com/CloudVE/cloudman-boot/master/scripts/cm_boot_mac.sh
$ sudo sh cm_boot_linux.sh `<your_ip>`

```

---
# Requirements (Windows)

- Docker
- Experimental
- May need 8GB-12GB of free RAM

1. Launch a command prompt
2. Run:
```shell
 docker run -v /var/run/docker.sock:/var/run/docker.sock -e "RANCHER_SERVER=127.0.0.1" --net=host galaxy/cloudman-boot
```

---
# Exercise: Deploy Galaxy - Step 1 (ssh)

1. Visit: [http://bit.ly/icter19vms](http://bit.ly/icter19vms)
2. Reserve your machine by typing your (unique) name in the 'Claimed By' column
3. SSH into the IP corresponding to your machine (If on Windows, use Putty as described previously)
4. IP: `<your_ip>`
5. user: ubuntu
6. password: check spreadsheet

---
# Exercise: Deploy Galaxy - Step 2 (run install script)

1. From within the ssh shell execute:
```shell
sudo wget https://raw.githubusercontent.com/CloudVE/cloudman-boot/master/scripts/cm_boot_linux.sh
sudo sh cm_boot_linux.sh --use-public-ip
```
2. Note down the password that is printed at the end.
![cloudman-password](images/cloudman-password.png)

.footnote[Step 3 could take 10-15 minutes.]

---

# Exercise: Deploy Galaxy - Step 3 (login to CloudMan)

1. visit `https://<your_ip>`
2. Login with credentials:
3. Username: admin
4. Password: `<password from previous step>`
5. Click on the Galaxy link to access it

---
# What happened?

* The script create a Kubernetes cluster on the machine
* It then started several docker containers.
* These containers include a database, galaxy server, auth server etc.
* Once all the containers are running, Kubernetes makes the services available.
* The Galaxy service is bound to port `80` on the machine.

.footnote[All of the above can be configured.]

---
# Exercise: Test Drive

* Create a user account using the Galaxy UI (Login or Register -> Register) 
* Try uploading a file to Galaxy

---
# Production configuration

- Galaxy works out of the box with production grade settings.
- You can change Galaxy configuration files etc. through CloudMan
- Settings can be changed with zero-downtime 

---

# Exercise: Change Galaxy Config Step 1

* Click the edit icon next to Galaxy
![cm-edit-galaxy-config](images/cm-edit-galaxy-config.png)
* Add the following entry: admin_users: `<your_username>`
![cm-change-admin-user](images/cm-change-admin-user.png)
* Save changes and wait for Galaxy to restart <sup>[1]</sup>

.footnote[<sup>[1]</sup> Registering in the UI *before* setting `admin_users` is not strictly necessary, but is the best security practice]

---
# Exercise: Change Galaxy Config Step 2

- Visit the Galaxy home page again 
- You should now see the admin tab <sup>[1]</sup>
![galaxy-admin-tab](images/galaxy-admin-tab.png)

.footnote[<sup>[1]</sup> It can take a minute or two for the admin tab to appear.]

