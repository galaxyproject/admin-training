all: id_rsa
	ansible-playbook playbook.yml -f 20

id_rsa:
	ssh-keygen -t rsa -f id_rsa -N ''

run-workshop: id_rsa
	ansible-playbook playbook.yml -l workshop-instances -f 20

run-pulsar: id_rsa
	ansible-playbook playbook.yml -l pulsar-instances -f 20
