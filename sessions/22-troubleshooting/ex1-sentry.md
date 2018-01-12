# Setting up a local sentry instance

We will use a docker compose template that will
setup a basic sentry instance that Galaxy can connect to.

We first have to install docker-compose:

```bash
sudo apt-get install docker-compose
```

We clone the template repository:
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
