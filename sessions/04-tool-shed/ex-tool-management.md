![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Tool Management Exercise

by @martenson, @mvdbeek

\#usegalaxy \#GAT2018 @galaxyproject

---
## Task 1
*Your users want to use bedtools on the instance you administer.*
* Find what Tool Shed repository has bedtools tools in it.

Hint: You can use search in https://toolshed.g2.bx.psu.edu/.

---
## Task 2
* Install [`iuc/bedtools`](https://toolshed.g2.bx.psu.edu/view/iuc/bedtools/) from MTS in revision `10:c78cf6fe3018` (2016-10-03) into new section 'BEDtools' using TS dependencies.

Hints:
- Note the revision, it is NOT the latest.
- If you did not set `tool_config_file` and `tool_dependency_dir` in the production basics session, you'll need to do it now.

---
## Task 3
*New bedtools revision has been uploaded to the MTS.*

* Install [`iuc/bedtools`](https://toolshed.g2.bx.psu.edu/view/iuc/bedtools/) from MTS in revision `13:fadebae7e69b` into section 'New BEDtools'.

---
## Task 4
*Now you have two sections with two versions of bedtools. Confusing. You could uninstall it but you want users to be able to re-run jobs with old bedtools though.*

* Hide the BEDtools section (with the older tool) from the tool panel without uninstalling it.

Hint: You need to modify `shed_tool_conf.xml` in order to do this.

---
## Task 5
*You want to show both versions of bedtools and allow users to switch versions on the tool form*

* Move bedtools revision `10:c78cf6fe3018` into 'New BEDtools' section and display it.

Hint: tools with the same ID and different version in the same section will 'collapse' into one and offer the switch button.

---
## Task 6
*Now there is only one section we might not want to call it 'New'.*

* Rename the 'New BEDtools' section to just 'BEDtools'.

Hints:
- You can rename sections using configuration file(s).
- When renaming you need to be consistent across the configs.

---
## Task 7
*The old bedtools version is no longer useful*

* Uninstall the revision `10:c78cf6fe3018` of bedtools.

---
## Task 8
*We want to use Conda package manager to satisfy tool dependencies*

* Verify Conda is installed

Hint: Conda will be installed automatically if you use run.sh.
The default location is <tool_dependency_dir>/_conda.

---
## Task 9
*Check the version of Conda*

Hint: `conda --version` will show the version

---
## Task 10
*Check which channels Conda is going to use*

Hint: You can find this information in galaxy.ini

---
## Task 11

*Install latest seqtk and install _only_ Conda dependencies for it*

Hints:
- By default Galaxy installs packages from both TS and Conda if available.
- You can follow the installation process by looking at galaxy's log file(s).

---
## Task 12

*Find where the dependencies are present on the filesystem*

Hint: The information is in the config.

---
## Task 13

*Uninstall the TS package and verify that the Conda package will be used*

Hints:
- To uninstall a package find the package in the `Manage Tools` section of the admin panel.
- You can see which dependency will be used in the `Manage dependencies` section.

---
## Task 14

*We want to use ephemeris to automate tool installation*

* Let's install ephemeris

Hint: You can install ephemeris by running `pip install ephemeris`

---
## Task 15

*Create a list of tool to install*

* Ephemeris requires a yaml file with the following syntax:

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

* Create the tool list for [devteam/fastqc](https://toolshed.g2.bx.psu.edu/view/devteam/fastqc) versions 0.68 and 0.69

Hints:
  - You can supply as many installable revisions as you would like, they will all be installed
  - If no revision is given the latest revision will be installed.

---
## Task 16

*Install fastqc using ephemeris into the section "FastQC"*

* The syntax for installing tools using a yaml file is:
```
shed-install install -t <tool_list.yml> -a <api_key> -g <galaxy_url>
```

---
## Task 17

*Verify that fastqc is correctly installed*

Hint: You can see the installation status in the admin panel

---
## Task 18

*Update all installed repositories of a galaxy instance*

The command is:
```
shed-tools update -g <galaxy_url> -a <api_key>
```
