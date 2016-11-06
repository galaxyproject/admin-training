layout: true
class: inverse, middle, large

---
class: special
# Tool Management Exercise
The following exercise will flex the basics of tool installation and management.

by @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
## Task 1
*Your users want to use freebayes software on the instance you administer.*
* Find what Tool Shed repository has freebayes tools in it.

.hint[You can use search in https://toolshed.g2.bx.psu.edu/ or http://toolshed.tools.]

---
## Task 2
* Install [`devteam/freebayes`](https://toolshed.g2.bx.psu.edu/view/devteam/freebayes/) from MTS in revision `22:99684adf84de` into new section 'Freebayes' using TS dependencies.

.hint[Note the revision, it is NOT the latest.]
---
## Task 3
*New freebayes revision has been uploaded to the MTS.*

* Install [`devteam/freebayes`](https://toolshed.g2.bx.psu.edu/view/devteam/freebayes/) from MTS in revision `24:da6e10dee68b` into section 'New Freebayes'.

---
## Task 4
*Now you have two sections with two versions of freebayes. Confusing. You could uninstall it but you want users to be able to re-run jobs with old freebayes though.*

* Hide the Freebayes section (with the older tool) from the tool panel without uninstalling it.

.hint[You need to modify shed_tool_conf.xml in order to do this.]

---
## Task 5
*You want to show both versions of freebayes and allow users to switch versions on the tool form*
Move freebayes revision `24:da6e10dee68b` into 'New Freebayes' section and display it.

.hint[tools with the same ID and different version in the same section will 'collapse' into one and offer the switch button]

---
## Task 6
*Now there is only one section we might not want to call it 'New'.*

* Rename the 'New Freebayes' section to just 'Freebayes'.

.hint[you can rename sections using configuration file(s)]

???
When renaming you need to be consistent across the configs.

---
## Task 7
*The old freebayes version is no longer useful*

Uninstall the revision `22:99684adf84de` of freebayes.
