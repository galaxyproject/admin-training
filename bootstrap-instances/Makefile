help:
	@egrep '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: id_rsa ## Prepare all nodes.
	ansible-playbook playbook.yml -f 20

id_rsa: ## Generate an SSH key which will be sent to the machines
	ssh-keygen -t rsa -f id_rsa -N ''

check-ansible: ## Check ansible tutorial
	ansible -a 'gat status-ansible' workshop_instances -f 80 | grep  -i basic

check-galaxy: ## Check galaxy tutorial
	ansible -a 'gat status-galaxy' workshop_instances -f 80 | grep nginx -i


remove-old-ssh-keys: ## Remove old SSH keys in your known hosts file
	bash -c "for i in {0..80}; do ssh-keygen -f ~/.ssh/known_hosts -R gat-\$$i.training.galaxyproject.eu; done;"
