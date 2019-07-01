layout: true
class: inverse, middle, large

---
class: special, center

# Welcome

\#usegalaxy / @galaxyproject

---
# Your Instructors

* **Simon Gladman** @SimonGladman1
    - VLSCI, University of Melbourne, Australia
* **Helena Rasche**
    - ELIXIR Galaxy WG, Elixir Germany, de.NBI, University of Freiburg, Germany
* **Nate Coraor** @natefoo
    - Galaxy Project, Penn State University, USA
* **John Chilton** @jmchilton
    - Galaxy Project, Penn State University, USA
* **Martin Čech** @martenson
    - Galaxy Project, Penn State University, USA
* **Enis Afgan** @EnisAfgan
    - Galaxy Project, Johns Hopkins University, Baltimore, USA
* **Marius van den Beek** @mariusvdbeek
    - Institut Curie, 26 rue d’Ulm, F-75248 Paris, France

.footnote[\#usegalaxy / @galaxyproject]

---
# Training Home

**http://bit.ly/galaxyadmin**

* The homepage of this training is a repository at GitHub reachable by the link above.
* Most materials are written in Markdown and we appreciate Pull Requests and creating Issues (even during the training!).

---
# On Session Times

We did our best to plan the session times for the expected content, and to build the content for the session time, but there may be sessions that are too long or short.

---
# Communication channels

* Web browser based chat at **http://bit.ly/gadminchat**

---
# Computing resources

The computing resources for this training have been provided by **de.NBI** and **XSEDE JetStream**

Find the IP address, username and password for ssh access for your instance at [http://bit.ly/gcc19vms](http://bit.ly/gcc19vms). Put it somewhere easy to copy/paste.

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

We adapted our training to follow the *one true path*(c) - which is usually the one we use for **usegalaxy.* servers** - the most tested and stable path in our opinion.

Galaxy has all the options and possibilities as before, but unless you are opinionated/locked in we recommend staying on the *one true path*(c). For other paths, Galaxy comes with documentation and a friendly community to help.

---
# Methodology

We consider the use of config management tools (such as Ansible) to be essential to good system administration. We utilize **Ansible** from the beginning.

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
    - Galaxy Training, includes the majority of admin training materials
* https://github.com/galaxyproject/dagobah-training/tree/2019-gcc/
    - Index for *this course*, static after the end of the course

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

* http://bit.ly/galaxyadmin
    - Itinerary and landing page for this course
* http://bit.ly/gcc19vms
    - Spreadsheet for choosing your training VM
* http://bit.ly/gadminchat
    - Chat for this course

---
# Thanks

- **Björn Grüning**
- **Dave Clements**
- **Alex Mahmoud**
