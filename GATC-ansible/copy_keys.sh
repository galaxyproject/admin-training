#!/bin/bash
for ip in `cat list_of_hosts.txt`; do
    ssh-copy-id -i gat-slc galaxyguest@$ip
done
