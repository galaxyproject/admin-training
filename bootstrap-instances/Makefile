help:
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: id_rsa ## Run both workshop + pulsar nodes
	ansible-playbook playbook.yml -f 20

id_rsa: ## Generate an SSH key which will be sent to the machines
	ssh-keygen -t rsa -f id_rsa -N ''

run-workshop: id_rsa ## Run workshop VM playbook
	ansible-playbook playbook.yml -l workshop-instances -f 20

run-pulsar: id_rsa ## Run pulsar VM playbook
	ansible-playbook playbook.yml -l pulsar-instances -f 20

remove-old-ssh-keys: ## Remove old SSH keys in your known hosts file
	bash -c "for i in {0..80}; do ssh-keygen -f ~/.ssh/known_hosts -R gat-\$$i.training.galaxyproject.eu; done;"

reset-passwords: ## Reset passwords for machines that don't have pre-specified ones
	ansible-playbook reset-passwords.yml -f 20
