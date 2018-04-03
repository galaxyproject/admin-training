![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Cape Town 2018

# Tool Management Exercise

by @martenson

\#usegalaxy \#GAT2016 @galaxyproject

---
## Task 1
*Your users want to use bedtools on the instance you administer.*
* Find what Tool Shed repository has bedtools tools in it.

Hint: You can use search in https://toolshed.g2.bx.psu.edu/ or http://toolshed.tools.

---
## Task 2
* Install [`iuc/bedtools`](https://toolshed.g2.bx.psu.edu/view/iuc/bedtools/) from the Main Tool Shed (MTS) in revision `10:c78cf6fe3018` (2016-10-03) into new section 'BEDtools' using TS dependencies.

Hints:
- Note the revision, it is NOT the latest.
- If you did not set `tool_config_file` and `tool_dependency_dir` in the production basics session, you'll need to do it now.

---
## Task 3
*New bedtools revision has been uploaded to the MTS.*

* Install [`iuc/bedtools`](https://toolshed.g2.bx.psu.edu/view/iuc/bedtools/) from MTS in revision `13:fadebae7e69b` into the same section: 'BEDtools'.

---
## Task 4

* Install latest seqtk and install _only_ Conda dependencies for it.

Hint: By default Galaxy installs packages from both TS and Conda if available.

Note that for this to work, Conda dependency resolution needs to be enabled in
`galaxy.ini`, which is done by default by GalaxyKickStart playbook but keep that
in mind if you have a different Galaxy setup. You can enable it in `galaxy.ini`
by setting `conda_auto_init` option and restarting Galaxy.

---
## Task 5

* Find where the dependencies are present on the filesystem.

Hint: The information is in the Galaxy config.

---
## Task 6
Installing tools by hand is OK when we have only a few tools but what happens
if we have dozens or hundreds of tools? We use scripts!

[Ephemeris](https://github.com/galaxyproject/ephemeris) is a tool that helps us
here by automating many frequent steps in Galaxy.

* So let's install ephemeris by running `pip install ephemeris`

Hints for more permanent installation (we'll skip this today to save time):
  - If you don't have virtualenv installed you can install it with `sudo apt-get install -y python-virtualenv`
  - This can be done on your local machine or on the cloud vm.
  - If you don't have a python virtualenv, create and activate one now with `virtualenv ~/.venv && source ~/.venv/bin/activate`


---
## Task 7

*Create a list of tool to install*

* Ephemeris requires a `yaml` file with the following syntax:

```yml
tools:
  - name: <repository_name>
    owner: <repository_owner>
    tool_panel_section_label: <section label>
    tool_shed_url: <tool_shed_url>
    revisions:
      - <revision_1>
      - <revision_2>
```

* Create the tool list file for [devteam/fastqc](https://toolshed.g2.bx.psu.edu/view/devteam/fastqc)

Hints:
  - You can supply as many installable revisions as you would like, they will all be installed
  - If no revision is given the latest revision will be installed (we'll do this today).

---
## Task 8

*Install fastqc using ephemeris into the section "FastQC"*

* Obtain admin API key from your Galaxy (under `User` → `Preferences` → `Manage API key`) and use as `<Admin user API key>` in the command:
* The syntax for installing tools using a yaml file is:
```
shed-tools install -t <tool_list.yml> -a <api_key> -g <galaxy_url>
```

---
## Task 9

*Verify that fastqc is correctly installed*

Hint: You can see the installation status in the admin panel

---
## Task 10 (if time)

*Update all installed repositories of a galaxy instance*

The command is:
```
shed-tools update -g <galaxy_url> -a <api_key>
```

## Task 11 (Homework)
There is an Ansible playbook that can automate this a bit further; it uses
Ephemeris behind the scenes.

Install the playbook with:

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
Then Run the playbook with:
```
$ ansible-playbook tools.yml -i "localhost," --extra-vars galaxy_tools_api_key=<Admin user API key>
```
