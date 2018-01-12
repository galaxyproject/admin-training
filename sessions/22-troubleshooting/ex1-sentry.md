# Why Sentry ?

Sentry is a nice way to look at logs, be notified of errors
and to prioritize solving issues.

# If we're still on dev we will downgrade to 17.09 again

```
sudo -Hsu galaxy
cd /srv/galaxy/server
GALAXY_VIRTUAL_ENV=/srv/galaxy/venv sh manage_db.sh -c /srv/galaxy/config/galaxy.ini downgrade 135
find lib -name \*.pyc -delete
git stash
git checkout release_17.09
GALAXY_VIRTUAL_ENV=/srv/galaxy/venv GALAXY_CONFIG_FILE=/srv/galaxy/config/galaxy.ini source scripts/common_startup.sh
```

While preparing this tutorial we noticed a small bug,
so we need to apply a small patch (still as the galaxy user):
```
git remote add mvdbeek https://github.com/mvdbeek/galaxy
git fetch mvdbeek
git cherry-pick a847dbd
```

Now we restart galaxy (as the ubuntu user):
```
sudo supervisorctl restart galaxy:
```

# Setting up a local sentry instance

We will use a docker compose template that will
setup a basic sentry instance that Galaxy can connect to.

We first have to install docker-compose:

```bash
sudo apt-get install docker-compose
```

We clone the template repository as the ubuntu user:
```bash
git clone https://github.com/getsentry/onpremise
cd onpremise/
```

We need to generate a secret key:
```
sudo docker-compose run web config generate-secret-key
```
We need to add the output of this command to docker-compose.yml,
so that the environment section looks like this:
```
...
    environment:
      # Run `docker-compose run web config generate-secret-key`
      # to get the SENTRY_SECRET_KEY value.
      SENTRY_SECRET_KEY: '<secret key we generated in the last command>'
      SENTRY_MEMCACHED_HOST: memcached
...
```

We have to create the persistent directories:

```
mkdir -p data/{sentry,postgres}
```

We have to do some database migrations:
```
sudo docker-compose run --rm web upgrade
```
Now we can start the sentry instance, which should be available at
http://localhost:9000/
```
sudo docker-compose up -d
```

To connect to the instance we have to tunnel port 9000.
On your laptop do:
```
ssh -L 9000:127.0.0.1:9000 ubuntu@<your_ip_addresses>
```
If you are using putty you need to forward port 9000 there.

Go with your browser to http://localhost:9000/ you will have to enter a few details. The root URL is `http://localhost:9000/`.

# Connecting sentry with Galaxy

We need to create a new project in sentry.
Click on "New Project" and enter "Galaxy" as Project name.

Then click on "Get your DSN" and copy the long string.

We need to add this to the galaxy config (sudo -u galaxy -e /srv/galaxy/config/galaxy.ini), as `sentry_dsn = <our_dsn>`.

Using sentry requires a conditional python dependency, which we can install with
```
sudo -Hsu galaxy
cd /srv/galaxy/server
GALAXY_VIRTUAL_ENV=/srv/galaxy/venv GALAXY_CONFIG_FILE=/srv/galaxy/config/galaxy.ini source scripts/common_startup.sh
```

Now restart Galaxy (`sudo supervisorctl restart galaxy:`) and observe the incoming logs in your Sentry Project!
