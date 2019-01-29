#!/bin/bash
# freeze requirements.yml versions

# prepend `name:` to any roles that were just bare strings, not dicts
sed -i -f <(grep -v : requirements.yml | awk '{print "s/^- " $NF "$/- name: " $NF "/"}') requirements.yml

# add available role versions to requirements
sed -i -f  <(grep -Eo 'version: [0-9.]+' roles/*/meta/.galaxy_install_info \
    | awk -F/ '{print $2, $NF}' | awk '{print "/ " $1 "$/a \\  version: " $NF}') requirements.yml
