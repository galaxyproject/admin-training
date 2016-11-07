![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GAT - 2016 - Salt Lake City

# Tool Management Exercise

by @martenson

\#usegalaxy \#GAT2016 @galaxyproject

---
## Task 1
*Your users want to use freebayes software on the instance you administer.*
* Find what Tool Shed repository has freebayes tools in it.

Hint: You can use search in https://toolshed.g2.bx.psu.edu/ or http://toolshed.tools.

---
## Task 2
* Install [`devteam/freebayes`](https://toolshed.g2.bx.psu.edu/view/devteam/freebayes/) from MTS in revision `22:99684adf84de` into new section 'Freebayes' using TS dependencies.

Hint: Note the revision, it is NOT the latest.

---
## Task 3
*New freebayes revision has been uploaded to the MTS.*

* Install [`devteam/freebayes`](https://toolshed.g2.bx.psu.edu/view/devteam/freebayes/) from MTS in revision `24:da6e10dee68b` into section 'New Freebayes'.

---
## Task 4
*Now you have two sections with two versions of freebayes. Confusing. You could uninstall it but you want users to be able to re-run jobs with old freebayes though.*

* Hide the Freebayes section (with the older tool) from the tool panel without uninstalling it.

Hint: You need to modify `shed_tool_conf.xml` in order to do this.

---
## Task 5
*You want to show both versions of freebayes and allow users to switch versions on the tool form*

* Move freebayes revision `24:da6e10dee68b` into 'New Freebayes' section and display it.

Hint: tools with the same ID and different version in the same section will 'collapse' into one and offer the switch button.

---
## Task 6
*Now there is only one section we might not want to call it 'New'.*

* Rename the 'New Freebayes' section to just 'Freebayes'.

Hints:
- You can rename sections using configuration file(s).
- When renaming you need to be consistent across the configs.

---
## Task 7
*The old freebayes version is no longer useful*

* Uninstall the revision `22:99684adf84de` of freebayes.

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
