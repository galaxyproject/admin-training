Training instance initial setup
===============================

This Ansible playbook was used to perform the basic installation on the workshop cloud instances. To perform the exercises on your own virtual machine or cloud instance, you can perform the following steps:

1. Install Ubuntu 16.04 with an admin user named `ubuntu`
2. Log in to your new system
3. Install Ansible: `sudo apt-get install ansible`
4. Fetch `playbook.yml`, e.g.: `curl -LO https://raw.githubusercontent.com/galaxyproject/dagobah-training/2017-montpellier/GATC-ansible/playbook.yml`
5. Create an inventory file named `inventory` in the same directory as `playbook.yml` with the contents:
```ini
[workshop-instances]
localhost ansible_connection=local ansible_become=yes
```
6. Run Ansible: `ansible-playbook -i inventory playbook.yml`

**Note: The playbook will change your ubuntu user's password to `gcc2017training`**
