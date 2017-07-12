Training instance initial setup
===============================

This Ansible playbook was used to perform the basic setup on the
workshop cloud instances.

**Note: By default, the playbook will change your `ubuntu` user's password to
`ismbtutorial`**
To change that, run `openssl passwd -1` and update `Set the ubuntu user password`
task in the playbook.

## Setup a remote host

To setup a host that's not the local machine, do the following:

1. Get access to a Ubuntu 16.04 with an admin user named `ubuntu`
2. Update inventory file `hosts` to include the host address under the
`[workshop-instances]` header
3. Run Ansible: `ansible-playbook -i hosts playbook.yml`

## Setup a local host

To perform the exercises on the local machine, perform the following steps:

1. Install Ubuntu 16.04 with an admin user named `ubuntu`
2. Log in to your new system
3. Install Ansible: `sudo apt-get install ansible`
4. Fetch `playbook.yml`, e.g.: `curl -LO https://raw.githubusercontent.com/galaxyproject/dagobah-training/2017-ismb/GATC-ansible/playbook.yml`
5. Create an inventory file named `inventory` in the same directory as `playbook.yml` with the contents:
```ini
[workshop-instances]
localhost ansible_connection=local ansible_become=yes
```
6. Run Ansible: `ansible-playbook -i inventory playbook.yml`

