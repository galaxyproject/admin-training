THREADS := 20

help:
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: id_rsa ## Prepare all nodes.
	ansible-playbook playbook.yml -f $(THREADS)

prep-%: id_rsa ## Prepare a region (prep-eu/oz/us/...)
	ansible-playbook playbook.yml -f $(THREADS) --limit workshop_$(@:prep-%=%)

catchup: id_rsa ## Provision bare machines as if they've done ansible-galaxy
	ansible-playbook catchup.yml -f $(THREADS)

ketchup: catchup
catsup: catchup

id_rsa: ## Generate an SSH key which will be sent to the machines
	ssh-keygen -t rsa -f id_rsa -N ''

check-ansible-%: ## Check ansible tutorial (check-ansible-eu/oz/us/...)
	@ansible -a 'gat status-ansible' workshop_$(@:check-ansible-%=%) -f $(THREADS) | grep -i basic

check-galaxy-eu: ## [EU] Check galaxy tutorial
	@ansible -a 'gat status-galaxy'  workshop_eu -f $(THREADS) | grep -i nginx

check-galaxy-oz: ## [OZ] Check galaxy tutorial
	@ansible -a 'gat status-galaxy'  workshop_oz -f $(THREADS) | grep -i nginx

check-cvmfs-eu: ## [EU] Check cvmfs tutorial
	@ansible -a 'gat status-cvmfs'   workshop_eu -f $(THREADS) | grep -i reqs

check-cvmfs-oz: ## [OZ] Check cvmfs tutorial
	@ansible -a 'gat status-cvmfs'   workshop_oz -f $(THREADS) | grep -i reqs

check-pulsar-eu: ## [EU] Check pulsar tutorial
	@ansible -a 'gat status-pulsar'  workshop_eu -f $(THREADS) | grep -i reqs

check-pulsar-oz: ## [OZ] Check pulsar tutorial
	@ansible -a 'gat status-pulsar'  workshop_oz -f $(THREADS) | grep -i reqs


remove-old-ssh-keys: ## Remove old SSH keys in your known hosts file
	bash -c "for i in {0..80}; do ssh-keygen -f ~/.ssh/known_hosts -R gat-\$$i.training.galaxyproject.eu; done;"


.PHONY: all help catchup remove-old-ssh-keys
