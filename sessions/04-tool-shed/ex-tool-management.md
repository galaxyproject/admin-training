![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

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
*We want to use Conda package manager for our HPC sw deployment.*

* Enable Conda in your Galaxy instance.

Hint: One way is to enable `conda_auto_init` in config and restart Galaxy.

---
## Task 9

* Install latest seqtk and install _only_ Conda dependencies for it.

Hint: By default Galaxy installs packages from both TS and Conda if available.

---
## Task 10

* Find where the dependencies are present on the filesystem.

Hint: The information is in the config.
