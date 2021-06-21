![Galaxy Admin Training logo: GTN star over center of a galaxy background with the text Galaxy Admin Training](./logos/gat.png)

logo based on a [Hubble Image](https://hubblesite.org/contents/media/images/2018/48/4280-Image.html)

# Galaxy Administration Training

During GCC2021 We will be using the [GCC schedule](https://galaxyproject.org/events/gcc2021/training/admin-track) please see that page for all relevant information

## Location, Logistics

This training is offered Online, July28-June2, and is mostly asynchronous. Throughout the week you will always have access to trainers that are ready to help you with tasks or understanding. However the bulk of the work consist of **you working at your own pace** through the materials we prepared for you.

For the duration of this training (and a week after) you'll be granted access to a virtual machine (VM) that will be exclusive to you. You will connect to it using `ssh ubuntu@address-of-your-machine` and perform all of training's tasks inside. The machine is configured in a way to allow trainers connect to your machine and see exactly what you see. For this it uses software called `byobu` that has many convenient features for working in terminal - you can check out our [byobu help](byobu.md) page.

## Important Links

- [Slack for this workshop](https://galaxyadmintraining.slack.com) - Chat & Call here. Use proper channels.
- [gxy.io/gatmachines](https://gxy.io/gatmachines) - The addresses and passwords for VMs. Find the one assigned to you.

## Timetable

The course is a mix of:

1. video recorded by our instructor community
2. video auto-generated from our slides
3. tutorials without videos.

We've done this to balance the significant effort required to produce videos
for materials that are regularly updated with the potential benefits they will
have for you, the students. As a result you'll find more videos for the
extremely important, foundational topics where we wanted things to be
completely clear for you.

*If you do not like videos*: The videos are strictly supplementary to the
training material and will show instructors going through the lessons. If you
prefer video content, you can watch those. If you dislike video training, you
can choose to just read the training materials for each topic.

The schedule for each day is a suggestion of what we believe is approximately 5 hours of work.
- If you're done with a day and want to do more, please feel free to continue!
- If you can't complete everything at the same pace, that's also fine! The VMs will be available for a week after the event.

### CoC

Everyone is expected to abide by the [Galaxy Code of Conduct (CoC)](https://github.com/galaxyproject/galaxy/blob/dev/CODE_OF_CONDUCT.md). We want this to be a welcoming and friendly environment for everyone! Please see the CoC for more information and the point of contact for any issues.

### Schedule

https://galaxyproject.org/events/gcc2021/training/admin-track

### Instructors

Name                | Country | Affiliation(s)
---                 | ---     | ---
Helena Rasche       | NL      | [Erasmus MC Bioinformatics Group](https://erasmusmc-bioinformatics.github.io/), [ATGM, Avans Hogeschool Breda](https://www.avans.nl)
Nicola Soranzo      | UK      | [Earlham Institute](https://www.earlham.ac.uk)
Martin Čech         | CZ      | [Elixir Czech Republic](https://www.elixir-czech.cz/), [RECETOX](https://www.recetox.muni.cz/en)
Anthony Bretaudeau  | FR      | [GenOuest](https://www.genouest.org/), [BIPAA](https://bipaa.genouest.org/)
Estelle Ancelet     | FR      | [INRAE](https://www.inrae.fr/en)
Sergey Golitsynskiy | US      | [Johns Hopkins University](https://jhu.edu)
Gianmauro Cuccuru   | DE      | [Albert-Ludwigs-University Freiburg](https://galaxyproject.eu/freiburg/)
Saskia Hiltemann    | NL      | [Erasmus MC Bioinformatics Group](https://erasmusmc-bioinformatics.github.io/)
Gildas Le Corguillé | FR      | [ABiMS](http://abims.sb-roscoff.fr/) - [Sorbonne Université](https://www.sorbonne-universite.fr/en)/[CNRS](https://www.cnrs.fr/en), [IFB/ELIXIR-FR](https://www.france-bioinformatique.fr/)
Simon Gladman       | AU      | [Melbourne Bioinformatics](https://melbournebioinformatics.org.au) - [Galaxy Australia](https://usegalaxy.org.au)
Catherine Bromhead  | AU      | [Melbourne Bioinformatics](https://melbournebioinformatics.org.au) - [Galaxy Australia](https://usegalaxy.org.au)
David Morais        | CA      | [GenAP](https://www.genap.ca/) & [Compute Canada](https://www.computecanada.ca/)
Aaron Petkau        | CA      | [PHAC](https://www.canada.ca/en/public-health.html) & [University of Manitoba](https://umanitoba.ca/)


(others coming soon.)

# After the Training

Everything you were taught in the past few days can be found in the [Galaxy Admin Training](https://github.com/galaxyproject/admin-training/) repository, which mostly points to the [admin section](https://training.galaxyproject.org/training-material/topics/admin/) of the Galaxy Training Materials.

For those of you who also need to do some Galaxy development, there is a [dev section of training materials](https://training.galaxyproject.org/training-material/topics/dev/) for those topics as well. There you can learn to integrate webhooks and tours, and learn about advanced tool development. For those who need to [teach Galaxy](https://training.galaxyproject.org/training-material/topics/instructors/) or want to [contribute training materials](https://training.galaxyproject.org/training-material/topics/contributing/), we have lots of tutorials for you!

**Community**

Chat with us on Gitter!

 - [Galaxy admins](http://gitter.im/galaxyproject/admins)
 - [Galaxy dev](https://gitter.im/galaxyproject/dev)
 - [General Galaxy topics](http://gitter.im/galaxyproject/Lobby)

**For your Users**

We recommend setting the `helpsite_url` in your Galaxy configuration to point to [https://help.galaxyproject.org/](https://help.galaxyproject.org/) where users can go and chat with each other. It's a great resource to help your users be independent and self-sufficient in their Galaxy learning. Admins are welcome too!

And don't forget that many, many [training materials](https://training.galaxyproject.org/training-material/) already exist covering different areas of \*omics and other research done with Galaxy. This can be a great resource for either giving training courses to your users (join the train-the-trainer session at GCC if you want to learn more) or to just point users to as a self-directed learning resource.

If you're asked to provide training infrastructure for your users, but do not have the capacity to support this, UseGalaxy.eu provides [training infrastructure](https://galaxyproject.eu/tiaas) for free.

**Going Forward**

We are working on updating the training materials with feedback from the training, and looking into the possibility to develop some automated linting of configurations, to help make Galaxy deployment more error-proof.

Let us know if you have any questions or feedback! Chat on Gitter, file issues on GitHub, let us know what features are interesting and important to the admin community.

## Training VM instances

Galaxy training instances are bootstrapped with [a small Ansible playbook](/bootstrap-instances), which you may find useful for repeating the exercises later using a VM, Docker image, etc.

## Sponsors

The GCC 2021 Galaxy Admin Training is sponsored by a wide variety of organisations

### Vlaams Super Computer

Our galaxy VMs were provided by the conference host, [VSC](https://www.vscentrum.be/)

[![VSC Logo](https://static.wixstatic.com/media/5446c2_1c3815668d3645b7af8a7aabca8695af~mv2.png/v1/fill/w_260,h_70,al_c,q_85,usm_0.66_1.00_0.01/VSC%20-%20Combi%20logo-01.webp)](https://www.vscentrum.be/)
### Galaxy Australia & Australian BioCommons

A significant portion of our infrastructure was graciously provided by Galaxy Australia

[![Australian BioCommons](logos/biocommons.png)](https://www.biocommons.org.au/galaxy-australia)
	
