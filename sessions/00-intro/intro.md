layout: true
class: inverse, middle, large

---
class: special, center

# Welcome

Monday March 2nd - Friday March 6th

\#usegalaxy / @galaxyproject
---
# Your Instructors

* **Helena Rasche** @hexylena
    - Galaxy Project Europe
* **Nate Coraor** @natefoo
    - Galaxy Project, Penn State University, USA
* **Saskia Hiltemann** @shiltemann
    - ELIXIR Galaxy WG, CINECA, Erasmus MC, Rotterdam
* **Marius van den Beek** @mariusvdbeek
    - Galaxy Project, Penn State University
* **Nicola Soranzo** @NicolaSoranzo
    - Earlham Insitute

.footnote[\#usegalaxy / @galaxyproject]

---
# Training Home

**https://gxy.io/gat**

* The homepage of this training is a repository at GitHub reachable by the link above.
* Most materials are written in Markdown and we appreciate Pull Requests (even during the training!).

---
# On Session Times

Day begin and end times are relatively fixed.

Sessions may not keep precisely to the times in the schedule. We will break whenever the food and coffee is here.

---
# Communication channels

* Web browser based chat at **https://gxy.io/gatchat**

---
# Computing resources

The computing resources for this training have been provided by **de.NBI**

Find the IP address for your instance at **https://gxy.io/gatmachines** [here](https://docs.google.com/spreadsheets/d/11nQKJmHHf7GWR_C36rdu2dVOHZZ0cXpv09b84txm_3A/edit?usp=sharing). Put it somewhere easy to copy/paste.

---
class: center

# Training philosophy and new methodology

---
# Lessons learned

...from past trainings

Galaxy has many options, configuration possibilities, and deployment paradigms. Our trainings used to cover multiple paths which made past trainings longer, less focused, and prone to errors.

We often taught the *least complex* method over the *best practice* method.

It was sometimes difficult for students to catch up once behind.

---
# Training philosophy

We have now moved to teaching the *one true path*™ - which is usually the one we use for **usegalaxy.* servers** - the most tested and stable path.

Galaxy has all the options and possibilities as before, but unless you are opinionated/locked in we recommend staying on the *one true path*™. For other paths, Galaxy comes with documentation and a friendly community to help.

---
# New methodology

For this training, materials have been reworked to utilize **Ansible** much more heavily *from the beginning*.

We consider the use of config management tools (such as Ansible) to be essential to good system administration.

---
# On Ansible

Use of Ansible to install/admin Galaxy is in no way required, and some prefer other tools (e.g. Puppet, Chef, etc.).

What we teach in Ansible can be used as the knowledge/reference base for implementation in your preferred config management system.<sup>[1]</sup>

When using Ansible in this course, we will inspect the changes made after each step, to ensure a good understanding of what is taking place behind the magic.

.footnote[<sup>[1]</sup> Bonus: We have written an enormous amount of Ansible roles for community consumption. If you do not have a preference, Ansible is a good choice (at least for deploying Galaxy) for this reason.]

---
# Documentation

Galaxy documentation and admin training materials are spread out. We are working on consolidating.

* https://docs.galaxyproject.org/
    - Official Galaxy (software) documentation, *release-specific*
* https://galaxyproject.org/admin/
    - Older<sup>[2]</sup> and non-Galaxy-software (e.g. Cloud, CVMFS) documentation
* https://training.galaxyproject.org/
    - Galaxy Training, includes some admin training materials
* https://github.com/galaxyproject/dagobah-training/tree/2019-pennstate/
    - Training materials for *this course*, static after the end of the course

.footnote[<sup>[2]</sup> Previously in the Galaxy Wiki, Galaxy-software-specific docs are migrating to docs.galaxyproject.org]

---
# Community support

After the training

* https://gitter.im/galaxyproject/admins
    - Galaxy admin-specific chat
* https://gitter.im/galaxyproject/Lobby
    - General Galaxy community chat
* https://help.galaxyproject.org/
    - Galaxy Help (Discourse)

---
# Essential links (again)

* **https://gxy.io/gat**
    - Itinerary and landing page for this course
* **https://gxy.io/gatmachines**
    - Spreadsheet for choosing your training VM
* **https://gxy.io/gatchat**
    - Chat for this course

---
# BCC 2020

Date: **18-21 July 2020**

Location: Toronto, Canada

https://bcc2020.github.io/
