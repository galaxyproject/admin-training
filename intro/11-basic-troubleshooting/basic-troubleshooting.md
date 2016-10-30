layout: true
class: inverse, middle, large

---
class: special
# Basic Galaxy Troubleshooting

slides by @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!

We like your questions.

---
# Database migration

In case you see database migration errors during startup you can:

* Check DB table `migrate_version` column `version`.
* Check folder `lib/galaxy/model/migrate/versions/` - the latest migration should match the DB.
* Clean the `*.pyc` files to make sure there is no remnant from other code revisions.
  * Something like `$ find . -name "*.pyc" -delete` should work.

---
# Mako templates

In case you see page inconsistencies or template errors in logs.

* Clean the `*.pyc` files to make sure there is no remnant from other code revisions.
  * Something like `$ find . -name "*.pyc" -delete`.

---
# Client build

In case your javascript/css local changes are not visible.

* JavaScript files are located in `client/galaxy/scripts`.
* CSS files are in `client/galaxy/style/`.
* Check `client/README.md` for details regarding client build.
* Run `$ make client` from root folder.
  * You can also check the `Makefile` in root for other useful targets.

???
* This should only matter when you modify some of the Galaxy's static assets.
* Does not affect javascript or style in mako templates.

---
class: normal
# Missing tools

* Restart Galaxy and watch the log for
```
Loaded tool id: toolshed.g2.bx.psu.edu/repos/iuc/sickle/sickle/1.33, version: 1.33 into tool panel....
```

* Check `integrated_tool_panel.xml` for
```xml
<tool id="toolshed.g2.bx.psu.edu/repos/iuc/sickle/sickle/1.33" />
```

* If it is TS tool check `config/shed_tool_conf.xml` for
```xml
<tool file="toolshed.g2.bx.psu.edu/repos/iuc/sickle/43e081d32f90/sickle/sickle.xml" guid="toolshed.g2.bx.psu.edu/repos/iuc/sickle/sickle/1.33">
...
</tool>
```

---
