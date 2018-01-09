layout: true
class: inverse, middle, large

---
class: special
# Galaxy Tool Dependencies

This is a very current topic for Galaxy and you can make your voice heard in the Galaxy repo.


slides by @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!

Questions await quelling.

---
# The Problem

To achieve the level of reproducibility Galaxy aims for it needs to be able to:

> Install any tool at any version with the exact same dependencies at any time.

Linux/MacOS package management is/was:
 - missing the scientific packages
 - avoiding or not maintaining old versions
 - unreliable
 - scattered

---
class: normal
# Brief history of tools

* Local tools only. Admin installs the dependencies manually and makes them available.
  * Low reproducibility. Admin overhead.

--
* Galaxy packages. Admin manually creates `env.sh` file at the given dependency
path that, once sourced, provides the proper binaries.
  * Better reproducibility. Admin overhead.

--
* Tool Shed packages. Admins let Galaxy install dependencies based on TS 'recipes'.
  * Galaxy-only solution.
  * Damn, we are building a package manager...

--
* Experiments with Homebrew package manager.
  * Failed mostly on inability to provide past versions.

--
* Embracing Conda package manager.
  * Galaxy can already resolve dependencies using Conda.
  * In close future Conda will be auto-init during Galaxy startup.
  * Many prime tools already support it.

---
# Approach

* We aim to make Galaxy resolver-independent.
* What resolver is going to be used for the tool dependency is determined at runtime
and prioritised in the config file `dependency_resolvers_conf.xml`.
```xml
<dependency_resolvers>
  <tool_shed_packages />
  <galaxy_packages />
  <conda />
  <galaxy_packages versionless="true" />
  <conda versionless="true" />
<!-- other resolvers
  <tool_shed_tap />
  <homebrew />
-->
</dependency_resolvers>
```
