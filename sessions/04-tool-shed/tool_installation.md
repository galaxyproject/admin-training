layout: true
class: inverse, middle, large

---
class: special
# Installing Tools into Galaxy
how to get tools into Galaxy

slides by @martenson, @mvdbeek

.footnote[\#usegalaxy / @galaxyproject - Cape Town 2018]

---
class: larger

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
# How to add tools manually

- By default Galaxy loads all tools in `tool_conf.xml.sample` into tool panel.
- To add local tools you need:
  - Make a copy `$ cp tool_conf.xml.sample tool_conf.xml`.
  - Add your tool entries to the `tool_conf.xml`.
  - (Re)start Galaxy.

???
From 16.10 use `<toolbox monitor="true">` to trigger hot reload of tools.

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
 one entry in `config/shed_tool_conf.xml`

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

one entry in `config/integrated_tool_panel.xml`
```xml
<section id="filter" name="Filter and Sort" version="">
    <tool id="testtoolshed.g2.bx.psu.edu/repos/devteam/bamtools_filter/bamFilter/0.0.1" />
```

---
# Tool management with Ephemeris

* [Ephemeris](https://github.com/galaxyproject/ephemeris) uses [Bioblend](https://github.com/galaxyproject/bioblend) to remotely manage Galaxy instances via Galaxy's API.

With ephemeris you can:
 - install (long) lists of tool repositories (i.e all usegalaxy.org tools)
 - keep all tools updated
 - install reference data.

Ephemeris is used in the ansible-galaxy-tools role.
