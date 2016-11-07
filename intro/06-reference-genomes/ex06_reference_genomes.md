![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GAT - 2016 - Salt Lake City

# Reference Genomes - Exercise.

#### Authors: Dan Blankenberg, Jim Johnson and Simon Gladman. 2014 - 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of the way in which Galaxy stores and uses reference data
2. Be able to add a reference genome and its pre-calculated indices into the Galaxy reference data system
3. Be able to download and use data managers to automate the process described in 2.

## Introduction

A slideshow presentation on this subject can be found [here](https://martenson.github.io/dagobah-training/06-reference-genomes/reference_genomes.html#1)

Reference genomes such as the **human, mouse, arabidopsis** etc. are all quite large. They are used extensively in bioinformatic analyses and therefore need to be widely available in analysis systems. These genomes can take up quite a bit of disk space to store especially if every user has their own copy. A lot of bioinformatic tools need to index these large genomes before they can use them. Tools such as short read mappers like **BWA** or **Bowtie** calculate indices of the genome sequences to significantly speed up their processing of short reads. However, these indices take a long time to build and it would be impractical to build them every time you want to do a read mapping.

Therefore, Galaxy has a system for storing reference sequences and pre-calculating the indices for each tool. They are all only stored once per Galaxy server and shared for every user. They are available for direct use in tools to save time. In this tutorial, we will be adding a new genome sequence to our Galaxy server, building it's indices for various tools and making them available for tool wrappers via the abstraction layer.

We will be using two different methods.
  1. A manual method by editing all of the appropriate files
  2. Using a set of **data managers** to automate the process

*fig 1. A schematic layout of the of Interplay between Built-in Data and Galaxy Tools*

![schematic](../../docs/06-reference-genomes/images/data_managers_schematic_overview.png)

## Section 1 - \*.loc files 101: Doing it manually!

*Loc* or *location* files are used as a way to provide additional configuration details to a tool without having to manually edit the actual tool XML file. They are often used to store the path (location on disk) of reference data and indices, along with appropriate metadata (display names, dbkeys/genome builds). They need not end in the suffix of ".loc", although they commonly do by convention.

Most importantly they are **Tab delimited** (not *space* delimited) flat files, where each row is an entry in the table. They also should not be accessed directly in a tool. Instead, the Tool Data Tables abstraction layer should be used.

### Exercise 1: Example of typical use of reference data in a Galaxy tool

* Search toolshed for a tool that uses reference data, say the **bwa** tool
  * http://toolshed.g2.bx.psu.edu/view/devteam/bwa
* Click **Repository Actions** button and select **Browse repository tip files**
* Find and click on *bwa_wrapper.xml* and note the section that uses indexed data, in particular note lines 7 - 11. These lines in the tool wrapper refer to the "bwa_indexes" section of the *tool_data_table_conf.xml* file.

  ``` xml
  <conditional name="genomeSource">
    <param name="refGenomeSource" type="select" label="Will you select a reference genome from your history or use a built-in index?">
      <option value="indexed">Use a built-in index</option>
      <option value="history">Use one from the history</option>
    </param>
    <when value="indexed">
      <param name="indices" type="select" label="Select a reference genome">
        <options from_data_table="bwa_indexes">
          <filter type="sort_by" column="2" />
          <validator type="no_options" message="No indexes are available" />
        </options>
      </param>
    </when>
    <when value="history">
      <param name="ownFile" type="data" format="fasta" metadata_name="dbkey" label="Select a reference from history" />
    </when>
  </conditional>
  ```

* Now Find and click on *tool_data_table_conf.xml.sample* which defines the mapping to the *tool-data/bwa_index.loc* file. Note that column two referred to in the above tool file is listed here as "name" or the name of the reference sequence (0 indexed list).

  ``` xml
  <tables>
     <!-- Locations of indexes in the BWA mapper format -->
     <table name="bwa_indexes" comment_char="#">
       <columns>value, dbkey, name, path</columns>
       <file path="tool-data/bwa_index.loc" />
     </table>
  </tables>
  ```

* Find and click on *bwa_index.loc.sample*. This is a sample .loc file for the bwa mapping tool. It contains the names and paths to the actual indices.

  ```
  #This is a sample file distributed with Galaxy that enables tools
  #to use a directory of BWA indexed sequences data files. You will need
  #to create these data files and then create a bwa_index.loc file
  #similar to this one (store it in this directory) that points to
  #the directories in which those files are stored. The bwa_index.loc
  #file has this format (longer white space characters are TAB characters):
  #
  #<unique_build_id>   <dbkey>   <display_name>   <file_path>
  #
  #So, for example, if you had phiX indexed stored in
  #/depot/data2/galaxy/phiX/base/,
  #then the bwa_index.loc entry would look like this:
  #
  #phiX174   phiX   phiX Pretty   /depot/data2/galaxy/phiX/base/phiX.fa
  ```

**NOTE:** When editing .loc files, your editor **MUST** use **TABS** and not expand them into spaces.
* In **vim** use the command *:set noexpandtab*

### Excercise 2: Manually add a genome to the BWA tool list.

In this exercise we will be adding a reference genome to our galaxy server by manually editing all of the required files. (Use your favourite editor, but remember to make sure it uses real tabs not tabs expanded into spaces..)

We will:

1. Add ourselves as admin users to our Galaxy servers(if we haven't already)
2. Install the BWA toolsuite
3. Add a reference genome to our server
4. Index the reference genome for BWA.
5. Test it all out!

If you are already an Admin user on your Galaxy server and it already has BWA installed, start at *Part 3*.

**Part 1: Add admin user**

Skip this part if you are already an admin user of your Galaxy server!

* Login to your Galaxy server
* Check if your username is an admin user:
``` bash
  cd galaxy/config
  grep admin_users galaxy.ini
```
* It should return `admin_users = ` followed by a comma delimited list of user emails. If yours is not there, it needs to be added. Use only commas to delimit different admin users - no spaces!
* If you make any changes to the galaxy.ini file, you need to restart Galaxy before they will take effect.
* For Galaxy running in daemon mode:
``` bash
  cd galaxy
  sh run.sh --stop-daemon
  sh run.sh --daemon
```
* Watch the Galaxy log file with `tail -f paster.log`.
* Test you are an Admin user by logging into your Galaxy server as the username you added to galaxy.ini
* You should see an "Admin" menu item at the top of the Galaxy interface.

**Part 2: Install the BWA tool**

Skip this part if BWA is already installed on your Galaxy server!

* From the Galaxy admin page:
  * Click **Search tool shed**
  * Click *Galaxy Main Tool Shed*
  * Searh for *bwa*
  * Select *bwa_wrappers* owned by devteam
  * Click **Install to Galaxy**
  * Click **Install**
  * Watch the interface and wait until BWA is installed.


* Check it worked
  * In your terminal window view *shed_tool_conf.xml*, it should now contain a bwa_wrapper entry.
  * View *shed_tool_data_table_conf.xml* should have the bwa *tool_data_table_conf.xml.sample* table entries added.
  * There should be a *tool-data/bwa_index.loc* file (copied from "bwa_index.loc.sample" if not already created)
  * Upload some sample FASTQ datasets:
  ```
http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/fastq/SRR507778-10k_1.fastqsanger
http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/fastq/SRR507778-10k_2.fastqsanger
  ```
  * These are paired end datasets created using Illumina technology, obtained from EBI SRA, and decreased to ~10,000 reads.
  * When uploading these datasets set the datatype to "fastqsanger".
  * Click the "Analyze Data" menu item and select the **BWA** tool.
  * Note the choices available under **Select a reference genome:** hint: this list should be empty (or at least not contain SacCer1 )

**Part 3: Add a new reference genome**

We will be adding a new built-in reference dataset, the sacCer1 genome build (good old Saccharomyces cerevisiae - beer yeast). We will download the fasta sequence file for it, index it for bwa and edit all of the appropriate Galaxy .loc file.

* Get the reference genome in the FASTA format.
  * From your Galaxy root:
  ``` bash
  cd tool-data/
  mkdir -p sacCer1/seq
  cd sacCer1/seq
  wget http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/sacCer1/sacCer1.fa
  ```


**Part 4: Create BWA indexes for the reference genome.**

**NOTE:** This is kind of the hard part.. We need to have BWA available on the command line and in the PATH environment variable. We can either install a separate commandline BWA or use the one installed in Galaxy. It's probably better to use the Galaxy one as sometimes tool developers change the format of their index tables.. :(

* Put BWA into the PATH.
  * Use the env.sh file in the Galaxy BWA tool! Then test it works!
  * From your Galaxy root: (Where the "x"s in the semantic version numbers and repo version are replaced with what's actually there!)

  ```

  source ./tools/bwa/x.x.xx/iuc/package_bwa_x_x_xx/xxxxxxxxxx/env.sh
  bwa

  Program: bwa (alignment via Burrows-Wheeler transformation)
  Version: 0.7.12-r1039
  Contact: Heng Li <lh3@sanger.ac.uk>

  Usage:   bwa <command> [options]

  Command: index         index sequences in the FASTA format
           mem           BWA-MEM algorithm
           fastmap       identify super-maximal exact matches
           pemerge       merge overlapping paired ends (EXPERIMENTAL)
           aln           gapped/ungapped alignment
           samse         generate alignment (single ended)
           sampe         generate alignment (paired ended)
           bwasw         BWA-SW for long queries

           shm           manage indices in shared memory
           fa2pac        convert FASTA to PAC format
           pac2bwt       generate BWT from PAC
           pac2bwtgen    alternative algorithm for generating BWT
           bwtupdate     update .bwt to the new format
           bwt2sa        generate SA from BWT and Occ

  Note: To use BWA, you need to first index the genome with 'bwa index'.
        There are three alignment algorithms in BWA: 'mem', 'bwasw', and
        'aln/samse/sampe'. If you are not sure which to use, try 'bwa mem'
        first. Please 'man ./bwa.1' for the manual.

  ```


* Now we can use bwa to build the index! Go back to the sacCer1 directory in tool-data. From Galaxy root:

  ``` bash
  cd tool-data/sacCer1
  mkdir -p bwa_index/sacCer1
  cd bwa_index/sacCer1
  ln -s ../../seq/sacCer1.fa sacCer1.fa
  bwa index sacCer1.fa
  ls -lah
  total 21M
  drwxr-xr-x 2 galaxy users 4.0K Oct  6  2015 .
  drwxr-xr-x 3 galaxy users 4.0K Oct  6  2015 ..
  lrwxrwxrwx 1 galaxy users   20 Oct  6  2015 sacCer1.fa -> ../../seq/sacCer1.fa
  -rw-r--r-- 1 galaxy users   14 Oct  6  2015 sacCer1.fa.amb
  -rw-r--r-- 1 galaxy users  596 Oct  6  2015 sacCer1.fa.ann
  -rw-r--r-- 1 galaxy users  12M Oct  6  2015 sacCer1.fa.bwt
  -rw-r--r-- 1 galaxy users 2.9M Oct  6  2015 sacCer1.fa.pac
  -rw-r--r-- 1 galaxy users 5.8M Oct  6  2015 sacCer1.fa.sa
  ```  
* All that's left is to now add it to the .loc file. Add the following line to the end of the *tool-data/bwa_index.loc* file.
  ```
  sacCer1     sacCer1 S. cerevisiae Oct. 2003 (SGD/sacCer1) (sacCer1) /home/galaxy/Desktop/Data_Managers/galaxy/galaxy-central/tool-data/sacCer1/bwa_index/sacCer1/sacCer1.fa
  ```

**Part 5: Test it all out**

Now we'll check the BWA tool for the new reference entry.

* Restart your galaxy server.
* Check the BWA tool for the new entry in your web browser

**NOTE:** If the your new entry does not appear, did you remember to separate the fields with TAB characters.

* Align your FASTQ reads using the BWA tool to the newly added built-in reference genome data.

Phew, that was a lot of work. Imagine doing that for ~10 genomes and for ~10-20 tools! There has to be a better way. Luckily, there is!

----

## Section 2 - Data managers 101: Fully Auto

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
# Data manager configuration options
enable_data_manager_user_view = True
data_manager_config_file = data_manager_conf.xml
shed_data_manager_config_file = shed_data_manager_conf.xml
galaxy_data_manager_data_path = tool-data
```

Where:
  * *enable_data_manager_user_view* allows non-admin users to view the available data that has been managed.
  * *data_manager_config_file* defines the local xml file to use for loading the configurations of locally defined data managers.
  * *shed_data_manager_config_file* defines the local xml file to use for saving and loading the configurations of locally defined data managers.
  * *galaxy_data_manager_data_path* defines the location to use for storing the files created by Data Managers. When not configured it defaults to the value of tool_data_path.

Details on Data Manager Tools and their definition can be found at: [https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define](https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define)

### Exercise 3: Install a DataManager from the ToolShed

In this exercise we will install a data manager that can fetch the various genome sequences from multiple sources, as well as the bwa index data manager from the Galaxy toolshed.

**Part 1: Install a data manager to download reference genome sequences**

Make sure you are logged in as an Admin user on your Galaxy server. Then, from the Galaxy Admin page:

* Install data_manager_fetch_genome_all_fasta from Galaxy main tool shed
  * Click **Search Tool Shed**
  * Search for "fetch"
  * Install the fetch genome all fasta data manager.


* View in the file system where the various elements land. Have a look in the configuration files located in config directory under Galaxy root.

*shed_data_manager_conf.xml*

``` xml
<?xml version="1.0"?>
<data_managers>
<data_manager guid="toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_all_fasta/data_manager/fetch_genome_all_fasta/0.0.1" id="fetch_genome_all_fasta" shed_conf_file="./config/shed_tool_conf.xml">
        <tool file="toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_all_fasta/fb744a070bee/data_manager_fetch_genome_all_fasta/data_manager/data_manager_fetch_genome_all_fasta.xml" guid="toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_all_fasta/data_manager_fetch_genome_all_fasta/0.0.1"><tool_shed>toolshed.g2.bx.psu.edu</tool_shed><repository_name>data_manager_fetch_genome_all_fasta</repository_name><repository_owner>devteam</repository_owner><installed_changeset_revision>fb744a070bee</installed_changeset_revision><id>toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_all_fasta/data_manager_fetch_genome_all_fasta/0.0.1</id><version>0.0.1</version></tool><data_table name="all_fasta">
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
    </data_manager>


</data_managers>
```

*shed_tool_data_table_conf.xml*

``` xml
<?xml version="1.0"?>
<tables>
<table comment_char="#" name="all_fasta">
        <columns>value, dbkey, name, path</columns>
        <file path="/Users/Simon/code/galaxy_admin_course/galaxy/tool-data/toolshed.g2.bx.psu.edu/repos/devteam/data_manager_fetch_genome_all_fasta/fb744a070bee/all_fasta.loc" />
        <tool_shed_repository>
            <tool_shed>toolshed.g2.bx.psu.edu</tool_shed>
            <repository_name>data_manager_fetch_genome_all_fasta</repository_name>
            <repository_owner>devteam</repository_owner>
            <installed_changeset_revision>fb744a070bee</installed_changeset_revision>
            </tool_shed_repository>
    </table>
</tables>
```

**Part 2: Download and install a reference genome sequence**

Use the Galaxy Admin page and the data_manager_fetch_genome_all_fasta to install some reference data. We will grab sacCer2 (version 2 of the Saccharomyces cerevisiae genome.)

From the Galaxy Admin page:

* Click on **Local data**

You should see something like this:

![nearly empty data manager tool list](../../docs/06-reference-genomes/images/nearly_empty_data_manager_tool_list.png)

* Click on **all_fasta** under *View Tool Data Table Entries*

You should see the current contents of tool-data/all_fasta.loc

* Under **Run Data Manager Tools**, click **Reference Genome - fetching**. The Reference Genome tool form from data_manager_fetch_genome_all_fasta is displayed.
  * From the **DBKEY to assign to data:** list choose: *sacCer2*
  * Click **Execute**

If you look at your "Saved Histories" now, you will see a new history called "Data Manager History (automatically created)." There will be a "Reference Genome" job in the history. When the job has finished, go back to the Data Manager view on the Galaxy Admin page. (Click **Local Data**)

* Click on **all_fasta** under *View Tool Data Table Entries*

You should see that sacCer2 has been added to all_fasta.

![all_fasta.png](../../docs/06-reference-genomes/images/all_fasta.png)

**Part 3: Download and install the BWA data manager**

In this part we will repeat the process from part 1 except that we will install the bwa data manager this time.

* Install the bwa data manager from the toolshed.
  * From the Admin page, click **Search Toolsheds** and then search for bwa.
  * Install the *data_manager_bwa_mem_index_builder* by the devteam. (This is the newer version of the BWA index builder.)

**Part 4: Build the BWA index for sacCer2**

In this part we will actually build the BWA index for sacCer2. It will automatically be added to our list of available reference genomes in the BWA tool.

* From the Galaxy Admin page, click **Local data**
* Click on **BWA-MEM index builder** under *Run Data Manager Tools*
  * Select *S. cerevisiae sacCer2* for Source Fasta Sequence
  * Put sacCer2 into the other two blank fields.
  * Click **Execute**

The new BWA index for sacCer2 will now be built and the .loc file will be filled in.

To check:
* From the Galaxy Admin page -> Local data, click on the **bwa mem indexes** under *View Tool Data Table Entries*

S. cerevisiae sacCer2 should now appear in the list!

**Part 5: Run BWA with the new reference data!**

Now we will run the BWA tool and check to see if the reference data is listed and the tool works with it!

* Run the BWA tool on the 2 fast files we loaded earlier, using sacCer2 as the reference.

How cool is that? No editing .loc files, no making sure you've got TABS instead of spaces.. Fully auto!

## So, what did we learn?

Hopefully, you now understand:
* how Galaxy stores and uses its reference data,
* how to manually add a reference genome and tool indices if required,
* and how to use data managers to make all of this much much easier.

## Further reading

If you want to know more about data managers including how to write a data manager tool, details can be found at: [https://wiki.galaxyproject.org/Admin/Tools/DataManagers/](https://wiki.galaxyproject.org/Admin/Tools/DataManagers/)

Suggestions and comments are welcome. Please contact:
