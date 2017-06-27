![GATC Logo](../../docs/shared-images/gcc2017_logo_black_2in.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GCC - 2017 - Montpellier, France

# Reference Genomes - Exercise.

#### Authors: Dan Blankenberg, Jim Johnson and Simon Gladman. 2014 - 2017

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of the way in which Galaxy stores and uses reference data
2. Be able to add a reference genome and its pre-calculated indices into the Galaxy reference data system
3. Be able to download and use data managers to automate the process described in 2.

## Introduction

A slideshow presentation on this subject can be found [here](https://gvlproject.github.io/dagobah-training/06-reference-genomes/reference_genomes.html#1)

Reference genomes such as the **human, mouse, arabidopsis** etc. are all quite large. They are used extensively in bioinformatic analyses and therefore need to be widely available in analysis systems. These genomes can take up quite a bit of disk space to store especially if every user has their own copy. A lot of bioinformatic tools need to index these large genomes before they can use them. Tools such as short read mappers like **BWA** or **Bowtie** calculate indices of the genome sequences to significantly speed up their processing of short reads. However, these indices take a long time to build and it would be impractical to build them every time you want to do a read mapping.

Therefore, Galaxy has a system for storing reference sequences and pre-calculating the indices for each tool. They are all only stored once per Galaxy server and shared for every user. They are available for direct use in tools to save time. In this tutorial, we will be adding a new genome sequence to our Galaxy server, building it's indices for various tools and making them available for tool wrappers via the abstraction layer.

We will not be doing hte manual steps required to get data into Galaxy but rather we will use the Data Manager tools.

*fig 1. A schematic layout of the of Interplay between Built-in Data and Galaxy Tools*

![schematic](../../docs/05-reference-genomes/images/data_managers_schematic_overview.png)


## Section 1 - Data managers 101: Fully Auto

**The problem**

The Galaxy server administrator needed to know how to update each type of reference data. Know how to run the index builds. Know where to get the data from!

**Data managers to the rescue**

Data Managers are a special class of Galaxy tool which allows for the download and/or creation of data that is stored within Tool Data Tables and their underlying flat (e.g. .loc) files. These tools handle the creation of indices and the addition of entries/lines to the data table / .loc file via the Galaxy admin interface.

Data Managers can be defined locally or installed through the Tool Shed.

They are a flexible framework for adding reference data to Galaxy (not just genomic data). They are workflow compatible and can run via the Galaxy API.

More detailed background information on data managers can be found at: [https://wiki.galaxyproject.org/Admin/Tools/DataManagers/](https://wiki.galaxyproject.org/Admin/Tools/DataManagers/) (A summary of which appears below.)

Details on how to define a data manager for a tool can be found here: [https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define](https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define)

**Using Data Managers**

Data Managers are composed of two components:

* Data Manager configuration (e.g. data_manager_conf.xml)
* Data Manager Tool

**Data Manager Configuration**

We need to tell Galaxy where to find the Data Managers and their configuration.

In your *galaxy.ini* file the following settings exist in the [app:main] section:

```
shed_tool_data_table_config = /srv/galaxy/config/shed_tool_data_table_conf.xml
# Data manager configuration options
enable_data_manager_user_view = True
data_manager_config_file = /srv/galaxy/config/data_manager_conf.xml
shed_data_manager_config_file = /srv/galaxy/config/shed_data_manager_conf.xml
galaxy_data_manager_data_path = /srv/galaxy/tool-data
```

Where:
  * *enable_data_manager_user_view* allows non-admin users to view the available data that has been managed.
  * *data_manager_config_file* defines the local xml file to use for loading the configurations of locally defined data managers.
  * *shed_data_manager_config_file* defines the local xml file to use for saving and loading the configurations of locally defined data managers.
  * *galaxy_data_manager_data_path* defines the location to use for storing the files created by Data Managers. When not configured it defaults to the value of tool_data_path.

Details on Data Manager Tools and their definition can be found at: [https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define](https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define)

### Exercise 1: Install a DataManager from the ToolShed

In this exercise we will install a data manager that can fetch the various genome sequences from multiple sources, as well as the bwa index data manager from the Galaxy toolshed.

**Part 1: Install a data manager to download reference genome sequences**

Make sure you are logged in as an Admin user on your Galaxy server. Then, from the Galaxy Admin page:

* Install data_manager_fetch_genome_all_fasta from Galaxy main tool shed
  * Click **Search Tool Shed**
  * Search for "fetch"
  * Install the fetch genome all fasta data manager.

This data manager will fetch reference genome sequences for us.

**Part 2: Download and install a reference genome sequence**

Use the Galaxy Admin page and the data_manager_fetch_genome_all_fasta to install some reference data. We will grab sacCer2 (version 2 of the Saccharomyces cerevisiae genome.)

From the Galaxy Admin page:

* Click on **Local data**

You should see something like this:

![nearly empty data manager tool list](../../docs/05-reference-genomes/images/nearly_empty_data_manager_tool_list.png)

* Click on **all_fasta** under *View Tool Data Table Entries*

You should see the current contents of tool-data/all_fasta.loc

* Under **Run Data Manager Tools**, click **Reference Genome - fetching**. The Reference Genome tool form from data_manager_fetch_genome_all_fasta is displayed. NOTE: If you receive the error "Uncaught exception in exposed API method:", you will need to restart Galaxy first.
  * From the **DBKEY to assign to data:** list choose: *sacCer2*
  * Click **Execute**

If you look at your history there will be a "Reference Genome" job. When the job has finished, go back to the Data Manager view on the Galaxy Admin page. (Click **Local Data**)

* Click on **all_fasta** under *View Tool Data Table Entries*

You should see that sacCer2 has been added to all_fasta.

![all_fasta.png](../../docs/05-reference-genomes/images/all_fasta.png)

**Part 3: Download and install the BWA data manager**

In this part we will repeat the process from part 1 except that we will install the bwa data manager this time.

* You should already have the BWA tool installed from an earlier part of this workshop. If not, install it now.
* Install the bwa data manager from the toolshed.
  * From the Admin page, click **Search Toolsheds** and then search for bwa.
  * Install the *data_manager_bwa_mem_index_builder* by the devteam. (This is the newer version of the BWA index builder.)

**Part 4: Build the BWA index for sacCer2**

In this part we will actually build the BWA index for sacCer2. It will automatically be added to our list of available reference genomes in the BWA tool.

* From the Galaxy Admin page, click **Local data**
* Click on **BWA-MEM index builder** under *Run Data Manager Tools*
  * Select *S. cerevisiae sacCer2* for Source Fasta Sequence
  * Put sacCer2 into the other two blank fields.
  * Click **Execute**. NOTE: If oyu receive the error "Parameter all_fasta_source requires a value, but has no legal values defined.", you will need to restart Galaxy first.

The new BWA index for sacCer2 will now be built and the .loc file will be filled in.

To check:
* From the Galaxy Admin page -> Local data, click on the **bwa mem indexes** under *View Tool Data Table Entries*

S. cerevisiae sacCer2 should now appear in the list!

How cool is that? No editing .loc files, no making sure you've got TABS instead of spaces.. Fully auto!

## So, what did we learn?

Hopefully, you now understand:
* how Galaxy stores and uses its reference data,
* how to manually add a reference genome and tool indices if required,
* and how to use data managers to make all of this much much easier.

## Further reading

If you want to know more about data managers including how to write a data manager tool, details can be found at: [https://wiki.galaxyproject.org/Admin/Tools/DataManagers/](https://wiki.galaxyproject.org/Admin/Tools/DataManagers/)

Suggestions and comments are welcome. Please contact:
