layout: true
class: inverse, middle, large

---
class: special
# Installing Tools into Galaxy
how to get tools into Galaxy

slides by @martenson, @mvdbeek

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!

Happy to answer your questions.

---

Tool Shed is to Galaxy as App Store is to iPhone.

It is a free service that hosts repositories containing Galaxy Tools.
Installing from the Tool Shed takes care of
  - dependencies
  - reference data tables
  - configuration files

---
Main Tool Shed (MTS) runs at http://toolshed.g2.bx.psu.edu and serves all Galaxies worldwide.

Everybody can create a repository.

Every repository is public including the whole history.

Local sheds can be run e.g. for private or custom-licensed tools.

???
We discourage running local TS.

---
# Galaxy Vocabulary

* `tool` - XML file that describes to Galaxy how the underlying software works.
* `repository` - Versioned code archive in Tool Shed containing Galaxy tool(s).

---
# Ways to add tools

You can add tools to Galaxy either
* Manually - Trivial for trivial tools and useful for tool development.
* Using Tool Shed
  * Through admin UI in Galaxy
  * Using scripts

---
# How to install a tool from Tool Shed

* Be an admin.
* Find the repository you want to install.
* (Connect Your Galaxy to the Tool Shed.)
* From Galaxy's admin UI find the repo in the connected TS.
* Install the repo into Galaxy.

.footnote[Step by step tutorial with screenshots [on wiki](https://galaxyproject.org/admin/tools/add-tool-from-toolshed-tutorial/)]

---
# Installation options

* Select/create section for the tool.
* If dependencies are needed you can select whether to install using TS packages or Conda.
  * More about dependency resolution is covered in a separate deck.

---
# What happened?

* Repository was downloaded.
* If needed Galaxy downloaded and compiled the needed dependencies.
* Galaxy created an entry for the tool in the DB.
* Galaxy added the tool to one of the tool configs (`shed_tool_conf.xml`).

---
# Example config entry
 one entry in `shed_tool_conf.xml`

```xml
<section id="filter" name="Filter and Sort" version="">
  <tool file="testtoolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/23a1c1f66b47/bamtools_filter/bamtools-filter.xml" guid="testtoolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/0.0.1">
      <tool_shed>testtoolshed.g2.bx.psu.edu</tool_shed>
        <repository_name>bamtools_filter</repository_name>
        <repository_owner>devteam</repository_owner>
        <installed_changeset_revision>23a1c1f66b47</installed_changeset_revision>
        <id>testtoolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/0.0.1</id>
        <version>0.0.1</version>
    </tool>
</section>
```

---
# Example config entry

one entry in `integrated_tool_panel.xml`
```xml
<section id="filter" name="Filter and Sort" version="">
    <tool id="testtoolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/0.0.1" />
```

---
# Suites - more repos in one

* To install multiple repositories some authors offer suites.
* Suite is a single repository that 'depends' on many other.
* If you install the suite all 'dependency repositories' will be installed too.

---
# Toolpanel management

* How the toolpanel looks like is decided in a file called `integrated_tool_panel.xml`.
* By default it resides in Galaxy's root folder.
* If missing it is generated from all other tool config files during startup.
* Modify it if you want to reorder tools or move section.

---
# Toolpanel search configuration

Tool panel search is done on pre-built index. However you can tweak toolpanel
searching by configuring the boosts in `galaxy.ini`.

```
tool_name_boost = 9
tool_section_boost = 3
tool_description_boost = 2
tool_label_boost = 1
tool_stub_boost = 5
tool_help_boost = 0.5
```

You can also manipulate the searchlimit with `tool_search_limit = 20` which will
display more/less results of the search.
