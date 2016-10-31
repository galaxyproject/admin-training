![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Setup a production Galaxy with Ansible - Exercise.

#### Authors: Nate Coraor, Enis Afgan, Nuwan Goonasekera, Simon Gladman. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of how Galaxy's Ansible roles are structured and interact with one another.
2. Be able to use an ansible playbook to install different flavours of Galaxy for different purposes.
3. Be able to write a playbook to suit your own purposes.

## Introduction

In exercise 1 we wrote a role called "galaxy-tool-install" which we then ran to install a few tools to our Galaxy server. In this exercise, we will look at how to combine multiple roles into install a complete production Galaxy server.

Luckily for us, the staff of the Galaxy project have thought about this quite a bit and have written roles for *all the things!* We will be making use of the Galaxy projects pre-written roles and will look at how they are combined in a project.

In this exercise we will:

1. Download an ansible playbook and associated roles.
1. Walk through the various parts including the roles and the playbook.
1. Discuss the group vars file
1. Go through the Ansible "galaxy" - an unfortunate name... (It's Ansible's toolshed.)

## Section 1 - The tutorial script source files.

Go to somewhere sensible on either your local machine or on your Galaxy server (/home/<your_username> would be sensible..)

* Grab the following with wget or curl etc and then untar it.

  `http://schd.ws/hosted_files/gcc16/e2/gcc2016-ansible.tar.gz`

This will copy the entire playbook and associated roles to somewhere we can look at it.

**Part 1 - Examine the playbook**

Have a look at the *playbook.yml* file. You'll notice that it contains quite a number of plays each of which reference a different role/s. The order in which the roles are referenced is important. This playbook does the following:

1. Performs some system tasks (system packages, creates a galaxy user etc.)
1. Installs postgres and nginx
1. Configures postgres
1. Install Galaxy
1. Installs supervisor

You'll notice another play there called *Install Galaxy tools*. This has "tags" set. You'll also notice that it's host is set to localhost. This play won't get run unless you give the `--tags tools` switch to the `ansible-playbook` command line.

**Part 2 - Ansible galaxy**

Where do the roles come from? Ansible has a "toolshed" like system called **Ansible Galaxy** - d'oh.

Open the *commands.txt* file. You'll see a command to run the playbook followed by a series of commands that download the various roles from the Ansible galaxy and put them in an appropriate place in our scripts file tree.. e.g. `ansible-galaxy install -p roles galaxyprojectdotorg.postgresql`

There are many roles available for download. They all have some meta data associated with them which has information on the role's author, keywords, dependencies, licenses, available platforms etc. All of the roles in our script have that information. Checkout the *main.yml* in any of our role's *meta* directory.

The Ansible Galaxy can be browsed at: [http://galaxy.ansible.com/](http://galaxy.ansible.com/)

** Part 3 - Browse the roles**


