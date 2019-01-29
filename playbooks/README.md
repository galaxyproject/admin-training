Ansible
=======

Ansible is preinstalled on your VM. To run from your laptop, create a virtualenv:

1. `virtualenv ansible` If you don't have the `virtualenv` command, you can use `python3 -m venv ansible`. If you don't
   have Python 3:

    1. Download the `.tar.gz` file from https://pypi.org/project/virtualenv/#files
    2. Untar the file (e.g. with `tar zxvf virtualenv-16.3.0.tar.gz`)
    3. `python ./virtualenv-16.3.0/virtualenv.py ansible`

2. `. ./ansible/bin/activate`

3. `pip install ansible`

4. Comment `localhost` in `hosts`, uncomment `jan-2019-...`  and change the `NN` to your instance number.

If you encounter an SSL error on macOS with Brew installed when running `ansible-galaxy`, run `brew upgrade python@2
openssl`, remove your `ansible` virtualenv, and recreate it using `virtualenv -p /usr/local/bin/python ansible`
