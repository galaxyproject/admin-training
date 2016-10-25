![GATC Logo](images/AdminTraining2016-100.png) ![galaxy logo](images/GalaxyLogoHighRes.png)

### GATC - 2016 - Salt Lake City

# Reference Genomes - Exercise.

#### Authors: Dan Blankenberg, Jim Johnson and Simon Gladman. 2014 - 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Have an understanding of the way in which Galaxy stores and uses reference data
2. Be able to add a reference genome and it's pre-calculated indices into the Galaxy reference data system
3. Be able to download and use data managers to automate the process described in 2.

## Introduction

Reference genomes such as the **human, mouse, arabidopsis** etc are all quite large. They are used extensively in bioinformatic analyses and therefore need to be widely available in analysis systems. These genomes can take up quite a bit of disk space to store especially if every user has their own copy. A lot of bioinformatic tools need to index these large genomes before they can use them. Tools such as short read mappers like **BWA** or **Bowtie** calculate indices of the genomes sequences to significantly speed up their processing of short reads. However, these indices take a long time to build and it would be impractical to build them every time you want to do a read mapping.

Therefore, Galaxy has a system for storing reference sequences and pre-calculating the indices for each tool. They are all only stored once per Galaxy server and shared for every user. They are available for direct use in tools to save time. In this tutorial, we will be adding a new genome sequence to our Galaxy server, building it's indices for various tools and making them available for tool wrappers via the abstraction layer.

We will be using two different methods.
  1. A manual method by editing all of the appropriate files
  2. Using a set of **data managers** to automate the process

*fig 1. A schematic layout of the of Interplay between Built-in Data and Galaxy Tools*

![schematic](images/data_managers_schematic_overview.png)

## Section 1 - \*.loc files 101: Doing it manually!

*Loc* or *location* files are used as a way to provide additional configuration details to a tool without having to manually edit the actual tool XML file. They are often used to store the path (location on disk) of reference data and indices, along with appropriate metadata (display names, dbkeys/genome builds). They need not end in the suffix of ".loc", although they commonly do by convention. 

Most importantly they are **Tab delimited** (not *space* delimited) flat files, where each row is an entry in the table. They also should not be accessed directly in a tool. Instead, the Tool Data Tables abstraction layer should be used. 

### Exercise 1: Example of typical use of reference data in a Galaxy tool

* Search toolshed for a tool that uses reference data, say the **BWA** tool
  * http://toolshed.g2.bx.psu.edu/view/devteam/bwa_wrappers
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


16:00-16:10 Introduction to DataManagers

The problem 
Administrator needed to know how to update each type of reference data 
Data Managers to the rescue 
Allows for the creation of built-in (reference) data 
underlying data 
*.loc files 
data tables 
Specialized Galaxy tools that can only be accessed by an admin 
Defined locally or installed from the Tool Shed 
Flexible Framework 
not just Genomic data 
Interactively Run Data Managers through UI 
Workflow compatible 
Can Run via Galaxy API 
How this operates within galaxy 
https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define
configuration
universe_wsgi.ini 
data_manager_conf.xml 
shed_data_manager_conf.xml 
16:10-16:30 Install a DataManager from the ToolShed

https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define
configure your galaxy server to use Data Managers 
In your "universe_wsgi.ini" file these settings exist in the [app:main] section: 

Toggle line numbers
   1 # Data manager configuration options
   2 enable_data_manager_user_view = True
   3 data_manager_config_file = data_manager_conf.xml 
   4 shed_data_manager_config_file = shed_data_manager_conf.xml 
   5 galaxy_data_manager_data_path = tool-data
Where enable_data_manager_user_view allows non-admin users to view the available data that has been managed.
Where data_manager_config_file defines the local xml file to use for loading the configurations of locally defined data managers.
Where shed_data_manager_config_file defines the local xml file to use for saving and loading the configurations of locally defined data managers. 
Where galaxy_data_manager_data_path defines the location to use for storing the files created by Data Managers. When not configured it defaults to the value of tool_data_path. 
From the Galaxy admin page: 
install data_manager_fetch_genome_all_fasta from Galaxy main tool shed 
view in galaxy file system where the various elements land 
shed_data_manager_conf.xml 
shed_tool_data_table_conf.xml 
from galaxy admin panel use data_manager_fetch_genome_all_fasta to install data
Click on "Manage local data" 
Run Data Manager Tools
Reference Genome - fetching
View Data Manager Jobs
Reference Genome - fetching
View Tool Data Table Entries
all_fasta 
Click on "all_fasta" under "View Tool Data Table Entries"
You should see the current contents of tool-data/all_fasta.loc 
Click on "Reference Genome" under "Run Data Manager Tools" 
The Reference Genome tool form from data_manager_fetch_genome_all_fasta is displayed 
From the DBKEY to assign to data: list choose: sacCer2
Click Execute
Under the "User" menu select "Saved Histories"
Select history: "Data Manager History (automatically created)" 
You should see your "Reference Genome" job in the history 
Go back to the Data Manager view by click on "Manage local data" 
Click on "all_fasta" under "View Tool Data Table Entries"
You should see sacCer2 added to all_fasta 
16:30-17:10 Create a DataManager

Create a local data manager to generate BWA indexes
https://wiki.galaxyproject.org/Admin/Tools/DataManagers/HowTo/Define
We will need to: 
Create the Data Manager Galaxy tool 
Configure Galaxy to use this Data Manager tool 
Create the Data Manager Galaxy tool 
hint1: The Bowtie2 data manager is almost identical 
https://testtoolshed.g2.bx.psu.edu/view/jjohnson/data_manager_bowtie2_index_builder
hint2: Dan has already done a bwa data manger 
http://toolshed.g2.bx.psu.edu/view/devteam/data_manager_bwa_index_builder
highlight extra requirements/tags/attributes vs regular galaxy tool 
== Data Manager Tool == 
A Data Manager Tool is a special class of Galaxy Tool. Data Manager Tools do not appear in the standard Tool Panel and can only be accessed by a Galaxy Administrator. Additionally, the initial content of a Data Manager's output file contains a JSON dictionary with a listing of the Tool parameters and Job settings (i.e. they are a type of OutputParameterJSONTool, this is also available for DataSourceTools). There is no requirement for the underlying Data Manager tool to make use of these contents, but they are provided as a handy way to transfer all of the tool and job parameters without requiring a different command-line argument for each necessary piece of information. The primary difference between a standard Galaxy Tool and a Data Manager Tool is that the primary output dataset of a Data Manager Tool must be a file containing a JSON description of the new entries to add to a Tool Data Table. The on-disk content to be referenced by the Data Manager Tool, if any, is stored within the extra_files_path of the output dataset created by the tool. 
The tool tag must have the attribute: tool_type="manage_data"
Toggle line numbers
   1 <tool id="data_manager_fetch_genome_all_fasta" name="Reference Genome" version="0.0.1" tool_type="manage_data">
The tool output must have format="data_manager_json"
Toggle line numbers
   1     <outputs>
   2         <data name="out_file" format="data_manager_json"/>
   3     </outputs>
create tools/data_manager/bwa_index_builder.xml
http://toolshed.g2.bx.psu.edu/repos/devteam/data_manager_bwa_index_builder/file/367878cb3698/data_manager/bwa_index_builder.xml
Needs requirements tag for bwa application 
input params: 
a select param with options from_data_table="all_fasta" 
a sequence_name text param
a sequence_id text param
outputs data param must be format 
transcribe the xml manually 
or you can download the file from: http://toolshed.g2.bx.psu.edu/repos/devteam/data_manager_bwa_index_builder/raw-file/367878cb3698/data_manager/bwa_index_builder.xml
create tools/data_manager/bwa_index_builder.py
http://toolshed.g2.bx.psu.edu/repos/devteam/data_manager_bwa_index_builder/file/367878cb3698/data_manager/bwa_index_builder.py
Configure Galaxy to use this Data Manager tool 
add a data_manager entry inside data_managers tag in data_mananger_conf.xml
Toggle line numbers
   1     <data_manager tool_file="data_manager/bwa_index_builder.xml" id="bwa_index_builder" version="0.0.1">
   2         <data_table name="bwa_indexes">
   3             <output>
   4                 <column name="value" />
   5                 <column name="dbkey" />
   6                 <column name="name" />
   7                 <column name="path" output_ref="out_file" >
   8                     <move type="directory" relativize_symlinks="True">
   9                         <!-- <source>${path}</source>--> <!-- out_file.extra_files_path is used as base by default --> <!-- if no source, eg for type=directory, then refers to base -->
  10                         <target base="${GALAXY_DATA_MANAGER_DATA_PATH}">${dbkey}/bwa_index/${value}</target>
  11                     </move>
  12                     <value_translation>${GALAXY_DATA_MANAGER_DATA_PATH}/${dbkey}/bwa_index/${value}/${path}</value_translation>
  13                     <value_translation type="function">abspath</value_translation>
  14                 </column>
  15             </output>
  16         </data_table>
  17     </data_manager>
run installer data_manager to build bwa indexes for sacCer2 
did it work?
why not?
add the missing bwa dependency 
see Admin/Config/ToolDependencies
mkdir /home/galaxy/Desktop/Data_Managers/galaxy/tool_dependencies/bwa/0.5.9/bin
mv /home/galaxy/Desktop/Data_Managers/galaxy/galaxy-central/tool-data/sacCer1/bwa_index/sacCer1/bwa /home/galaxy/Desktop/Data_Managers/galaxy/tool_dependencies/bwa/0.5.9/bin/
rerun the Data Manager and confirm that it is working 
17:10-17:30 Put the DataManager in the Toolshed

review toolshed best practices 
separate repository for required applications ( tool_dependencies.xml ) 
separate repository for required custom datatypes ( repository_dependencies.xml )
Run your own ToolShed. 
Add an administrator to tool_shed_wsgi.ini using the same process as before. 
For your public username, use devteam. 
Open a new terminal 
type sh run_tool_shed.sh
Access the ToolShed at http://localhost:9009
Using the Admin interface, create 2 new categories: "Data Managers" and "Tool Dependency Packages" 
BWA Dependency from Main toolshed: 
Cross ToolShed dependencies are not currently supported, so we will use the import/export feature. 
Export the 'package_bwa_0_5_9' package from http://toolshed.g2.bx.psu.edu. 
This will create a 'capsule_toolshed.g2.bx.psu.edu_package_bwa_0_5_9_devteam_ec2595e4d313.tar.gz' file that can be imported into another ToolShed. 
In your local ToolShed, import your freshly exported ToolShed capsule. 
Prepare your Data Manager Toolshed Package.
There are several ways to populate ToolShed repositories. We will be using mercurial to add files. Uploading tarballs is also possible and a very common way to do this. 
Login in to the toolshed 
"Click Create new repository" 
Add Create Repository fields: 
Name: data_manager_bwa_index_builder 
Synopsis: Data Manager that builds BWA indexes
Detailed description: Index a FASTA file using the Burrows-Wheeler algorithm and populate the bwa_index.loc file. 
Categories: "Data Managers" 
Click "Save" 
Copy the clone link: "http://devteam@tool_shed/repos/devteam/data_manager_bwa_index_builder" 
In Eclipse: 
File --> New --> Project 
Clone Existing Mercurial Repository 
Click Next 
Paste the clone link 
Enter your password 
Click Next 
Click Next 
Click Finish 
Populate the repository 
Required files: 
data_manager/bwa_index_builder.py 
data_manager/bwa_index_builder.xml 
data_manager_conf.xml 
tool_data_table_conf.xml.sample 
tool-data/all_fasta.loc.sample 
tool-data/bwa_index.loc.sample 
tool_dependencies.xml 
Toggle line numbers
   1 <?xml version="1.0"?>
   2 <tool_dependency>
   3     <package name="bwa" version="0.5.9">
   4         <repository name="package_bwa_0_5_9" owner="devteam" changeset_revision="f8687dc2392c" toolshed="http://localhost:9009"/>
   5     </package>
   6 </tool_dependency>
Be sure to change the changeset_revision to the proper value.
Use mercurial 
hg add 
hg ci -m "Populate data manager tool" 
hg push 
Remove your locally installed Data Manager from "data_manager_conf.xml". 
Install new data_manager into your galaxy from the toolshed 
Build a bwa index for C. brenneri Feb. 2008 (WUGSC 6.0.1/caePb2) 
17:30-18:00 Other Example data managers

SnpEff - http://snpeff.sourceforge.net/SnpEff.html

SnpEff is a variant annotation and effect prediction tool. It annotates and predicts the effects of variants on genes (such as amino acid changes). 
Key Points
A Galaxy tool should guide the user to make valid parameter choices 
The reference data can either be in a history dataset or as reference data from tool-data 
The Galaxy Data Manager framework is flexible 
The SnpEff data manager populates multiple .loc files 
The data_manager_snpEff_databases.xml populates data_table "snpeff_databases" which provides the options for data_manager_snpEff_download.xml 
Initial Challenges
SnpEff used a config file to specify the path to genome references, defaulted to user home directory
Not compatible with galaxy structure for toolshed install and data manager operation 
Need downloaded genome version for SnpEff tool tests 
The available genome versions are dynamic, so the options shouldn't be hardcoded into a Galaxy Select Parameter 
SnpEff galaxy tool has extra params that depend upon the reference data 
Every genome reference has file: snpEffectPredictor.bin
Some genome references may include regulation, motif, and nextProt annotations 
# Prevotella bryantii B14 has only the genome reference
$ ls tool-data/snpEff/data/ADWO01
snpEffectPredictor.bin
# Mouse build also has some regulation annotations
$ ls tool-data/snpEff/data/GRCm38.75/
regulation_ES.bin       regulation_MEF.bin      regulation_NPC.bin
regulation_ESHyb.bin    regulation_MEL.bin      snpEffectPredictor.bin
# Human build also has more regulation annotations and motif and nextProt annotations
$ ls tool-data/snpEff/data/GRCh37.75
motif.bin               regulation_GM06990.bin  regulation_HSMM.bin     regulation_IMR90.bin    regulation_NHEK.bin
nextProt.bin            regulation_GM12878.bin  regulation_HUVEC.bin    regulation_K562.bin     snpEffectPredictor.bin
pwms.bin                regulation_H1ESC.bin    regulation_HeLa-S3.bin  regulation_K562b.bin
regulation_CD4.bin      regulation_HMEC.bin     regulation_HepG2.bin    regulation_NH-A.bin
Solutions
Discussed Galaxy requirements with application developer Pablo Cingolani who graciously added:
command line option "-dataDir path" to specify the path to genome reference data 
download genome on demand functionality in SnpEff application, which allowed test cases to run without a preinstalled genome reference 
Developed 3 options in the SnpEff tool for getting the genome reference data 
Download on demand 
great for tests, but a lot of overhead for large genomes, and no way to capture genome specific annotations 
Toggle line numbers
   1 <tool id="snpEff" name="SnpEff" version="3.6">
   2     <description>Variant effect and annotation</description>
   3     <inputs>
   4         <conditional name="snpDb">
   5             <param name="genomeSrc" type="select" label="Genome source">
   6                 <option value="named">Named on demand</option>
   7             </param>
   8             <when value="named">
   9                 <param name="genome_version" type="text" value="GRCh37.68" label="Snpff Version Name"/>
  10             </when>
  11         </conditional>
  12     </inputs>
  13 </tool> 
Data manager 
most efficient for multiuser or multi history use 
data_manager_snpEff_download.py inspects the downloaded genome files searching for added regulation and annotation files: 
def download_database(data_manager_dict, target_directory, jar_path,config,genome_version,organism):
    data_dir = target_directory
    (snpEff_dir,snpEff_jar) = os.path.split(jar_path)
    args = [ 'java','-jar' ]
    args.append( jar_path )
    args.append( 'download' )
    args.append( '-c' )
    args.append( config )
    args.append( '-dataDir' )
    args.append( data_dir )
    args.append( '-v' )
    args.append( genome_version )
    proc = subprocess.Popen( args=args, shell=False, cwd=snpEff_dir )
    return_code = proc.wait()
    if return_code:
        sys.exit( return_code )
    ## search data_dir/genome_version for files
    regulation_pattern = 'regulation_(.+).bin'
    #  annotation files that are included in snpEff by a flag
    annotations_dict = {'nextProt.bin' : '-nextprot','motif.bin': '-motif'}
    genome_path = os.path.join(data_dir,genome_version)
    if os.path.isdir(genome_path):
        for root, dirs, files in os.walk(genome_path):
            for fname in files:
                if fname.startswith('snpEffectPredictor'):
                    # if snpEffectPredictor.bin download succeeded
                    name = genome_version + (' : ' + organism if organism else '')
                    data_table_entry = dict(value=genome_version, name=name, path=data_dir)
                    _add_data_table_entry( data_manager_dict, 'snpeff_genomedb', data_table_entry )
                else:
                    m = re.match(regulation_pattern,fname)
                    if m:
                        name = m.groups()[0]
                        data_table_entry = dict(genome=genome_version,value=name, name=name)
                        _add_data_table_entry( data_manager_dict, 'snpeff_regulationdb', data_table_entry )
                    elif fname in annotations_dict:
                        value = annotations_dict[fname]
                        name = value.lstrip('-')
                        data_table_entry = dict(genome=genome_version,value=value, name=name)
                        _add_data_table_entry( data_manager_dict, 'snpeff_annotations', data_table_entry )
    return data_manager_dict

def _add_data_table_entry( data_manager_dict, data_table, data_table_entry ):
    data_manager_dict['data_tables'] = data_manager_dict.get( 'data_tables', {} )
    data_manager_dict['data_tables'][data_table] = data_manager_dict['data_tables'].get( data_table, [] )
    data_manager_dict['data_tables'][data_table].append( data_table_entry )
    return data_manager_dict
SnpEff uses from_data_table to get options for params: regulation and extra_annotations 
Toggle line numbers
   1 <tool id="snpEff" name="SnpEff" version="3.6">
   2     <description>Variant effect and annotation</description>
   3     <inputs>
   4         <conditional name="snpDb">
   5             <param name="genomeSrc" type="select" label="Genome source">
   6                 <option value="cached">Locally installed reference genome</option>
   7             </param>
   8             <when value="cached">
   9                 <param name="genomeVersion" type="select" label="Genome">
  10                     <!--GENOME    DESCRIPTION-->
  11                     <options from_data_table="snpeff_genomedb">
  12                            <filter type="unique_value" column="0" />
  13                     </options>
  14                 </param>
  15                 <param name="extra_annotations" type="select" display="checkboxes" multiple="true" label="Additional Annotations">
  16                        <help>These are available for only a few genomes</help>
  17                        <options from_data_table="snpeff_annotations">
  18                            <filter type="param_value" ref="genomeVersion" key="genome" column="0" />
  19                            <filter type="unique_value" column="1" />
  20                        </options>
  21                 </param>
  22                 <param name="regulation" type="select" display="checkboxes" multiple="true" label="Non-coding and regulatory Annotation">
  23                        <help>These are available for only a few genomes</help>
  24                        <options from_data_table="snpeff_regulationdb">
  25                            <filter type="param_value" ref="genomeVersion" key="genome" column="0" />
  26                            <filter type="unique_value" column="1" />
  27                        </options>
  28                 </param>
  29             </when>
  30         </conditional>
  31     </inputs>
  32 </tool> 
From history 
SnpEff Download tool allows users to proceed without the Galaxy admin 
The genome specific options are captured in metadata of the custom dataytpe: "snpeffdb" 
Toggle line numbers
   1 $ cat snpeff_datatypes/datatypes_conf.xml 
   2 <?xml version="1.0"?>
   3 <datatypes>
   4     <datatype_files>
   5         <datatype_file name="snpeff.py"/>
   6     </datatype_files>
   7     <registration>
   8         <datatype extension="snpeffdb" type="galaxy.datatypes.snpeff:SnpEffDb" display_in_upload="True"/>
   9     </registration>
  10 </datatypes>
Toggle line numbers
   1 $ cat snpeff_datatypes/lib/galaxy/datatypes/snpeff.py 
   2 """
   3 SnpEff datatypes
   4 """
   5 import os,os.path,re,sys,gzip,logging
   6 import galaxy.datatypes.data
   7 from galaxy.datatypes.data import Text
   8 from galaxy.datatypes.metadata import MetadataElement
   9 
  10 log = logging.getLogger(__name__)
  11 
  12 class SnpEffDb( Text ):
  13     """Class describing a SnpEff genome build"""
  14     file_ext = "snpeffdb"
  15     MetadataElement( name="genome_version", default=None, desc="Genome Version", readonly=True, visible=True, no_value=None )
  16     MetadataElement( name="regulation", default=[], desc="Regulation Names", readonly=True, visible=True, no_value=[], optional=True)
  17     MetadataElement( name="annotation", default=[], desc="Annotation Names", readonly=True, visible=True, no_value=[], optional=True)
  18 
  19     def __init__( self, **kwd ):
  20         Text.__init__( self, **kwd )
  21 
  22     def set_meta( self, dataset, **kwd ):
  23         Text.set_meta(self, dataset, **kwd )
  24         data_dir = dataset.extra_files_path
  25         ## search data_dir/genome_version for files
  26         regulation_pattern = 'regulation_(.+).bin'
  27         #  annotation files that are included in snpEff by a flag
  28         annotations_dict = {'nextProt.bin' : '-nextprot','motif.bin': '-motif'}
  29         regulations = []
  30         annotations = []
  31         if data_dir and os.path.isdir(data_dir):
  32             for root, dirs, files in os.walk(data_dir):
  33                 for fname in files:
  34                     if fname.startswith('snpEffectPredictor'):
  35                         # if snpEffectPredictor.bin download succeeded
  36                         genome_version = os.path.basename(root)
  37                         dataset.metadata.genome_version = genome_version
  38                     else:
  39                         m = re.match(regulation_pattern,fname)
  40                         if m:
  41                             name = m.groups()[0]
  42                             regulations.append(name)
  43                         elif fname in annotations_dict:
  44                             value = annotations_dict[fname]
  45                             name = value.lstrip('-')
  46                             annotations.append(name)
  47             dataset.metadata.regulation = regulations
  48             dataset.metadata.annotation = annotations
  49             try:
  50                 fh = file(dataset.file_name,'w')
  51                 fh.write("%s\n" % genome_version)
  52                 if annotations:
  53                     fh.write("annotations: %s\n" % ','.join(annotations))
  54                 if regulations:
  55                     fh.write("regulations: %s\n" % ','.join(regulations))
  56                 fh.close()
  57             except:
  58                 pass
SnpEff tool gets options for params: regulation and extra_annotations from the "snpeffdb" metadata:
Toggle line numbers
   1 <tool id="snpEff" name="SnpEff" version="3.6">
   2     <description>Variant effect and annotation</description>
   3     <inputs>
   4         <conditional name="snpDb">
   5             <param name="genomeSrc" type="select" label="Genome source">
   6                 <option value="history">Reference genome from your history</option>
   7             </param>
   8             <when value="history">
   9                 <param format="snpeffdb" name="snpeff_db" type="data" label="SnpEff Genome Version Data"/>
  10                 <!-- From metadata -->
  11                 <param name="extra_annotations" type="select" display="checkboxes" multiple="true" label="Additional Annotations">
  12                     <help>These are available for only a few genomes</help>
  13                     <options>
  14                         <filter type="data_meta" ref="snpeff_db" key="annotation" />
  15                     </options>
  16                 </param>
  17                 <param name="regulation" type="select" display="checkboxes" multiple="true" label="Non-coding and regulatory Annotation">
  18                     <help>These are available for only a few genomes</help>
  19                     <options>
  20                         <filter type="data_meta" ref="snpeff_db" key="regulation" />
  21                     </options>
  22                 </param>
  23             </when>
  24         </conditional>
  25     </inputs>
  26 </tool> 
Toolshed repositories
package_snpeff_3_6 - Installs the SnpEff application as a tool_dependency 
https://testtoolshed.g2.bx.psu.edu/view/jjohnson/package_snpeff_3_6
$ find package_snpeff_3_6/* -type f
package_snpeff_3_6/tool_dependencies.xml
snpeff_datatypes - defines custom datatypes 
https://testtoolshed.g2.bx.psu.edu/view/jjohnson/snpeff_datatypes
$ find snpeff_datatypes/* -type f
snpeff_datatypes/datatypes_conf.xml
snpeff_datatypes/lib/galaxy/datatypes/snpeff.py
snpeff - Galaxy user tools 
https://testtoolshed.g2.bx.psu.edu/view/jjohnson/snpeff
$ find snpeff/* -type f
snpeff/readme.rst
snpeff/repository_dependencies.xml
snpeff/snpEff.xml
snpeff/snpEff_download.xml
snpeff/snpEff_macros.xml
snpeff/test-data/vcf_homhet.vcf
snpeff/tool-data/snpeff_annotations.loc.sample
snpeff/tool-data/snpeff_databases.loc.sample
snpeff/tool-data/snpeff_genomedb.loc.sample
snpeff/tool-data/snpeff_regulationdb.loc.sample
snpeff/tool_data_table_conf.xml.sample
snpeff/tool_dependencies.xml
data_manager_snpeff - manages SnpEff reference data 
https://testtoolshed.g2.bx.psu.edu/view/jjohnson/data_manager_snpeff
$ find data_manager_snpeff/* -type f
data_manager_snpeff/data_manager/data_manager_snpEff_databases.py
data_manager_snpeff/data_manager/data_manager_snpEff_databases.xml
data_manager_snpeff/data_manager/data_manager_snpEff_download.py
data_manager_snpeff/data_manager/data_manager_snpEff_download.xml
data_manager_snpeff/data_manager_conf.xml
data_manager_snpeff/repository_dependencies.xml
data_manager_snpeff/tool-data/snpeff_annotations.loc.sample
data_manager_snpeff/tool-data/snpeff_databases.loc.sample
data_manager_snpeff/tool-data/snpeff_genomedb.loc.sample
data_manager_snpeff/tool-data/snpeff_regulationdb.loc.sample
data_manager_snpeff/tool_data_table_conf.xml.sample
data_manager_snpeff/tool_dependencies.xml