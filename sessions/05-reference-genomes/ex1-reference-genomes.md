![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Admins Course 2019 - PSU, PA

# Reference Genomes - Exercise

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of the way in which Galaxy stores and uses reference data
2. Be able to add a reference genome and its pre-calculated indices into the Galaxy reference data system using Galaxy Data Managers

## Introduction

A slideshow presentation on this subject can be found [here](https://galaxyproject.github.io/dagobah-training/2019-pennstate/05-reference-genomes/reference_genomes.html#1)

Reference genomes such as the **human, mouse, arabidopsis** etc. are all quite large. They are used extensively in bioinformatic analyses and therefore need to be widely available in analysis systems. These genomes can take up quite a bit of disk space to store especially if every user has their own copy. A lot of bioinformatic tools need to index these large genomes before they can use them. Tools such as short read mappers like **BWA** or **Bowtie** calculate indices of the genome sequences to significantly speed up their processing of short reads. However, these indices take a long time to build and it would be impractical to build them every time you want to do a read mapping.

Therefore, Galaxy has a system for storing reference sequences and pre-calculating the indices for each tool. They are all only stored once per Galaxy server and shared for every user. They are available for direct use in tools to save time. In this tutorial, we will be adding a new genome sequence to our Galaxy server, building it's indices for various tools and making them available for tool wrappers via the abstraction layer.

We will be using using a set of specialized tools - **the data managers** to automate the process of editing the appropriate files.

*fig 1. A schematic layout of the of Interplay between Built-in Data and Galaxy Tools*

![schematic](../../docs/05-reference-genomes/images/data_managers_schematic_overview.png)

## Data managers

**The problem**

The Galaxy server administrator needed to know:

* where to get the data from
* how to run the index builds
* how to update each type of reference data

**Data managers basics**

Data Managers are a special class of admin-only Galaxy tools which allows for the download and/or creation of data that is stored within Tool Data Tables and their underlying flat (e.g. .loc) files. These tools handle the creation of indices and the addition of entries/lines to the data table / .loc file via the Galaxy admin interface.

Data Managers can be defined locally or installed through the Tool Shed.

They are a flexible framework for adding reference data to Galaxy (not just genomic data). They are workflow compatible and can be run via the Galaxy API.

More detailed background information on data managers can be found at: [https://galaxyproject.org/admin/tools/data-managers/](https://galaxyproject.org/admin/tools/data-managers/) (A summary of which appears below.)

Details on how to define a data manager for a tool can be found here: [https://galaxyproject.org/admin/tools/data-managers/how-to/define/](https://galaxyproject.org/admin/tools/data-managers/how-to/define/)

**Using Data Managers**

Data Managers are composed of two components:

* Data Manager configuration (e.g. `data_manager_conf.xml`)
* Data Manager tool

**Data Manager Configuration**

We need to tell Galaxy where to find the Data Managers and their configuration.

In your *galaxy.yml* file the following settings exist in the `galaxy:` section:

```
shed_tool_data_table_config: /srv/galaxy/var/config/shed_tool_data_table_conf.xml
# Data manager configuration options
enable_data_manager_user_view: true
data_manager_config_file: /srv/galaxy/server/config/data_manager_conf.xml.sample
shed_data_manager_config_file: /srv/galaxy/var/config/shed_data_manager_conf.xml
galaxy_data_manager_data_path: /srv/galaxy/var/tool-data
```

Where:
  * *enable_data_manager_user_view* allows non-admin users to view the available data that has been managed.
  * *data_manager_config_file* defines the local xml file to use for loading the configurations of locally defined data managers.
  * *shed_data_manager_config_file* defines the local xml file to use for saving and loading the configurations of locally defined data managers.
  * *galaxy_data_manager_data_path* defines the location to use for storing the files created by Data Managers. When not configured it defaults to the value of `tool_data_path`.

Details on Data Manager Tools and their definition can be found at: [https://galaxyproject.org/admin/tools/data-managers/how-to/define/](https://galaxyproject.org/admin/tools/data-managers/how-to/define/)

### Exercise 1: Install a Data Manager from the ToolShed

In this exercise we will install a data manager that can fetch the various genome sequences from multiple sources, as well as the bwa index data manager from the Galaxy toolshed.

**Part 1: Install a data manager to download reference genome sequences**

Make sure you are logged in as an Admin user on your Galaxy server. Then, from the Galaxy Admin page:

* Install _data_manager_fetch_genome_dbkeys_all_fasta_ from Galaxy main tool shed
  * Click **Search Tool Shed**
  * Search for "fetch"
  * Install the _data_manager_fetch_genome_dbkeys_all_fasta_ data manager.

* View in the file system where the various elements land. Have a look in the configuration files located in config directory.

*/srv/galaxy/var/config/shed_data_manager_conf.xml*

``` xml
<?xml version="1.0"?>
<data_managers>
    <data_manager guid="toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_dbkeys_all_fasta/data_manager/fetch_genome_all_fasta_dbkeys/0.0.1" id="fetch_genome_all_fasta_dbkeys" shed_conf_file="./config/shed_tool_conf.xml">
        <tool file="toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_dbkeys_all_fasta/b1bc53e9bbc5/data_manager_fetch_genome_dbkeys_all_fasta/data_manager/data_manager_fetch_genome_all_fasta_dbkeys.xml" guid="toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_dbkeys_all_fasta/data_manager_fetch_genome_all_fasta_dbkey/0.0.2"><tool_shed>toolshed.g2.bx.psu.edu</tool_shed><repository_name>data_manager_fetch_genome_dbkeys_all_fasta</repository_name><repository_owner>devteam</repository_owner><installed_changeset_revision>b1bc53e9bbc5</installed_changeset_revision><id>toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_dbkeys_all_fasta/data_manager_fetch_genome_all_fasta_dbkey/0.0.2</id><version>0.0.2</version></tool><data_table name="all_fasta">
            <output>
                <column name="value" />
                <column name="dbkey" />
                <column name="name" />
                <column name="path" output_ref="out_file">
                    <move type="file">
                        <source>${path}</source>
                        <target base="${GALAXY_DATA_MANAGER_DATA_PATH}">${dbkey}/seq/${path}</target>
                    </move>
                    <value_translation>${GALAXY_DATA_MANAGER_DATA_PATH}/${dbkey}/seq/${path}</value_translation>
                    <value_translation type="function">abspath</value_translation>
                </column>
            </output>
        </data_table>
        <data_table name="__dbkeys__">
            <output>
                <column name="value" />
                <column name="name" />
                <column name="len_path" output_ref="out_file">
                    <move type="file">
                        <source>${len_path}</source>
                        <target base="${GALAXY_DATA_MANAGER_DATA_PATH}">${value}/len/${len_path}</target>
                    </move>
                    <value_translation>${GALAXY_DATA_MANAGER_DATA_PATH}/${value}/len/${len_path}</value_translation>
                    <value_translation type="function">abspath</value_translation>
                </column>
            </output>
        </data_table>
    </data_manager>


</data_managers>
```

*shed_tool_data_table_conf.xml*

``` xml
<?xml version="1.0"?>
<tables>
<table comment_char="#" name="all_fasta">
        <columns>value, dbkey, name, path</columns>
        <file path="/srv/galaxy/tool-data/toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_dbkeys_all_fasta/b1bc53e9bbc5/all_fasta.loc" />
        <tool_shed_repository>
            <tool_shed>toolshed.g2.bx.psu.edu</tool_shed>
            <repository_name>data_manager_fetch_genome_dbkeys_all_fasta</repository_name>
            <repository_owner>devteam</repository_owner>
            <installed_changeset_revision>b1bc53e9bbc5</installed_changeset_revision>
            </tool_shed_repository>
    </table>
<table comment_char="#" name="__dbkeys__">
        <columns>value, name, len_path</columns>
        <file path="/srv/galaxy/tool-data/toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_dbkeys_all_fasta/b1bc53e9bbc5/dbkeys.loc" />
        <tool_shed_repository>
            <tool_shed>toolshed.g2.bx.psu.edu</tool_shed>
            <repository_name>data_manager_fetch_genome_dbkeys_all_fasta</repository_name>
            <repository_owner>devteam</repository_owner>
            <installed_changeset_revision>b1bc53e9bbc5</installed_changeset_revision>
            </tool_shed_repository>
    </table>
</tables>
```

**Part 2: Download and install a reference genome sequence**

Use the Galaxy Admin page and the _data_manager_fetch_genome_dbkeys_all_fasta_ to install some reference data. We will grab sacCer2 (version 2 of the Saccharomyces cerevisiae genome.)

From the Galaxy Admin page:

* Click on **Local data**

You should see something like this:

![nearly empty data manager tool list](../../docs/05-reference-genomes/images/nearly_empty_data_manager_tool_list.png)

* Click on **all_fasta** under *View Tool Data Table Entries*

You should see the current contents of `tool-data/all_fasta.loc`, which will contain info from the CVMFS repository (more on this later).

* Under **Run Data Manager Tools**, click **Create DBKey and Reference Genome - fetching**. The Reference Genome tool form from _data_manager_fetch_genome_all_fasta_dbkey_ is displayed. NOTE: If you receive the error "Uncaught exception in exposed API method:", you will need to restart Galaxy first.
  * From the **DBKEY to assign to data:** list choose: *sacCer2*
  * Enter _S. cerevisiae June 2008 (SGD/sacCer2) (sacCer2)_ for the _Name of sequence_ field
  * Leave the _ID for sequence_ field empty
  * Click **Execute**

In your history, you will see a new dataset for the data manager run. When the job has finished, go back to the Data Manager view on the Galaxy Admin page (click **Local Data**).

* Click on **all_fasta** under *View Tool Data Table Entries*

You should see that _sacCer2_ has been added to _all_fasta_ list. If you do not, click the refresh button, and if you still do not, you may need to restart your Galaxy server (this is sometimes necessary after adding a new Data Manager).

![all_fasta.png](../../docs/05-reference-genomes/images/all_fasta.png)

**Part 3: Download and install the BWA data manager**

In this part we will repeat the process from part 1 except that we will install the bwa data manager this time.

* Install the bwa data manager from the toolshed.
  * From the Admin page, click **Search Toolsheds** and then search for bwa.
  * Install the *data_manager_bwa_mem_index_builder* by the devteam.

**Part 4: Build the BWA index for sacCer2**

In this part we will actually build the BWA index for sacCer2. It will automatically be added to our list of available reference genomes in the BWA tool.

* From the Galaxy Admin page, click **Local data**
* Click on **BWA-MEM index - builder** under *Run Data Manager Tools*
  * Select *sacCer2* for Source Fasta Sequence
  * Put sacCer2 into the other two blank fields.
  * Click **Execute**. NOTE: If you receive the error "Parameter all_fasta_source requires a value, but has no legal values defined.", you will need to restart Galaxy first.

The new BWA index for sacCer2 will now be built and the .loc file will be filled in.

To check:
* From the Galaxy Admin page -> Local data, click on the **bwa mem indexes** under *View Tool Data Table Entries*

S. cerevisiae sacCer2 should now appear in the list!

**Part 5: Run BWA with the new reference data!**

Now we will run the BWA tool and check to see if the reference data is listed and the tool works with it!

* Upload the following 2 fastqsanger files to Galaxy:

http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/fastq/SRR507778-10k_1.fastqsanger http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/fastq/SRR507778-10k_2.fastqsanger

* Run the BWA tool with these 2 fastq files, using sacCer2 as the reference.

How cool is that? No editing `.loc` files, no making sure you've got TABs instead of spaces. Fully auto!

## So, what did we learn?

Hopefully, you now understand:
* how Galaxy stores and uses its reference data
* how to use data managers to make all of this much much easier

## Further reading

If you want to know more about data managers including how to write a data manager tool, details can be found at: [https://galaxyproject.org/admin/tools/data-managers/](https://galaxyproject.org/admin/tools/data-managers/)

Suggestions and comments are welcome.
