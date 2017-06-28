# Exercise - Tool installation using Ephemeris

We are going to use `afgane/galaxy-tools-playbook` playbook that uses `galaxyproject/ansible-galaxy-tools` role that uses `Ephemeris` library.

```
$ git clone https://github.com/afgane/galaxy-tools-playbook.git
$ cd galaxy-tools-playbook && ansible-galaxy install -f -r requirements_roles.yml -p roles
```

* Change `galaxy_tools_galaxy_instance_url` in `galaxy-tools-playbook/tools.yml` to target your instance's Galaxy

* Modify `files/sample_tool_list.yaml` to contain: 

```
tools:
- install_repository_dependencies: true
  install_resolver_dependencies: true
  install_tool_dependencies: true
  name: bwa
  owner: devteam
  revisions:
  - 051eba708f43
  tool_panel_section_id: bwa
  tool_panel_section_label: bwa
  tool_shed_url: toolshed.g2.bx.psu.edu
```

* Obtain admin API key from your Galaxy and use as `<Admin user API key>` in the command:

```
$ ansible-playbook tools.yml -i "localhost," --extra-vars galaxy_tools_api_key=<Admin user API key>
```
