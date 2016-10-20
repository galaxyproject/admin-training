# Tool Management Exercise
The following exercise will flex the basics of tool installation and management.

--
## Task 1
*Your users want to use freebayes software on the instance you administer.*
* Find what Tool Shed repository has freebayes tools in it.

> *you can use search in https://toolshed.g2.bx.psu.edu/ or http://toolshed.tools*

---
## Task 2
* Install [`devteam/freebayes`](https://toolshed.g2.bx.psu.edu/view/devteam/freebayes/) from MTS in revision `22:99684adf84de` into new section 'Freebayes' using TS dependencies.

---
## Task 3
*New revision has been released.*

* Install [`devteam/freebayes`](https://toolshed.g2.bx.psu.edu/view/devteam/freebayes/) from MTS in revision `24:da6e10dee68b` into section 'New Freebayes'.

---
## Task 4
*Now you have two sections with two versions of freebayes. Confusing. You still want users to be able to re-run jobs with old freebayes though.*

* Hide the Freebayes section from the tool panel without uninstalling it.

---
## Task 5
Move freebayes revision `24:da6e10dee68b` into 'New Freebayes' section and display it.

---
## Task 6
Make freebayes to appear only in the 'Freebayes' section of the toolpanel
and offer version switching.

> *you can rename sections using configuration file(s)*

---
## Task 7
*The old freebayes version is no longer useful*

Uninstall the revision `22:99684adf84de` of freebayes.
