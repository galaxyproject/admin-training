THREADS := 20

help:
	@egrep '^[a-zA-Z_%-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: id_rsa ## Prepare all nodes.
	ansible-playbook playbook.yml -f $(THREADS)

tag-%: id_rsa ## Run a specific tag (e.g. tag-gat-cli)
	ansible-playbook playbook.yml -f $(THREADS) -t $(@:tag-%=%)

prep-%: id_rsa ## Prepare a region (prep-eu/oz/us/...)
	ansible-playbook playbook.yml -f $(THREADS) --limit workshop_$(@:prep-%=%),workshop_$(@:prep-%=%)_pulsar

obtain-passwords: ## Obtain passwords from machines
	# This is easier tbh
	# for i in {0..54}; do pwgen -H <( echo "gat-$i.$region.training.galaxyproject.eu") 12 1 >> sdf; done;
	ansible-playbook playbook.yml -t password -f 80 |grep password: | grep -o gat.* | sed 's/"//g;s/ /\t/'

id_rsa: ## Generate an SSH key which will be sent to the machines
	ssh-keygen -t rsa -f id_rsa -N ''

status: ## Check overall progress everywhere
	@ansible -a 'gat status' galaxy_only -f $(THREADS) | grep --line-buffered --color=never "	"

status-raw:
	@ansible -a 'gat status-raw' galaxy_only -f $(THREADS) | grep --line-buffered --color=never "	"

status-sum:
	@ansible -a 'gat status-sum' galaxy_only -f $(THREADS) | grep --line-buffered --color=never "	"

status-%: ## Check overall progress in region
	@ansible -a 'gat status' workshop_$(@:status-%=%) -f $(THREADS) | grep --line-buffered --color=never "	"

check-ansible-%: ## Check ansible tutorial (check-ansible-eu/oz/us/...)
	@ansible -a 'gat status-ansible' workshop_$(@:check-ansible-%=%) -f $(THREADS) | grep --color=never -i basic

check-galaxy-%: ## Check galaxy tutorial (check-galaxy-eu/oz/us/...)
	@ansible -a 'gat status-galaxy' workshop_$(@:check-galaxy-%=%) -f $(THREADS) | grep --color=never -i nginx

check-cvmfs-%: ## Check cvmfs tutorial (check-cvmfs-eu/oz/us/...)
	@ansible -a 'gat status-cvmfs' workshop_$(@:check-cvmfs-%=%) -f $(THREADS) | grep --color=never -i reqs

check-pulsar-%: ## Check pulsar tutorial (check-pulsar-eu/oz/us/...)
	@ansible -a 'gat status-pulsar' workshop_$(@:check-pulsar-%=%) -f $(THREADS) | grep --color=never -i reqs

remove-old-ssh-keys: ## Remove old SSH keys in your known hosts file
	bash -c "for i in {0..80}; do ssh-keygen -f ~/.ssh/known_hosts -R gat-\$$i.training.galaxyproject.eu; done;"


.PHONY: all help catchup remove-old-ssh-keys
