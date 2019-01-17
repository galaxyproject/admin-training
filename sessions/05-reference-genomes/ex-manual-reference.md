## Section 1 - \*.loc files 101: Doing it manually!

*Loc* or *location* files are used as a way to provide additional configuration details to a tool without having to manually edit the actual tool XML file. They are often used to store the path (location on disk) of reference data and indices, along with appropriate metadata (display names, dbkeys/genome builds). They need not end in the suffix of ".loc", although they commonly do by convention.

Most importantly they are **Tab delimited** (not *space* delimited) flat files, where each row is an entry in the table. They also should not be accessed directly in a tool. Instead, the Tool Data Tables abstraction layer should be used.

### Exercise 1: Example of typical use of reference data in a Galaxy tool

* Search toolshed for a tool that uses reference data, say the **bwa** tool
  * http://toolshed.g2.bx.psu.edu/view/devteam/bwa
* Click **Repository Actions** button and select **Browse repository tip files**
* Find and click on *bwa_macros.xml* and note the section that uses indexed data, in particular note the XML block beginning with `<macro name="reference_source_conditional">`. These lines in the tool wrapper refer to the `bwa_mem_indexes` table defined in the *tool_data_table_conf.xml* file.

  ``` xml
  <macro name="reference_source_conditional">
    <conditional name="reference_source">
      <param name="reference_source_selector" type="select" label="Will you select a reference genome from your history or use a built-in index?" help="Built-ins were indexed using default options. See `Indexes` section of help below">
        <option value="cached">Use a built-in genome index</option>
        <option value="history">Use a genome from history and build index</option>
      </param>
      <when value="cached">
        <param name="ref_file" type="select" label="Using reference genome" help="Select genome from the list">
          <options from_data_table="bwa_mem_indexes">
            <filter type="sort_by" column="2" />
            <validator type="no_options" message="No indexes are available" />
          </options>
          <validator type="no_options" message="A built-in reference genome is not available for the build associated with the selected input file"/>
        </param>
      </when>
      <when value="history">
        <param name="ref_file" type="data" format="fasta" label="Use the following dataset as the reference sequence" help="You can upload a FASTA sequence to the history and use it as reference" />
        <param name="index_a" type="select" label="Algorithm for constructing the BWT index" help="(-a)">
          <option value="auto">Auto. Let BWA decide the best algorithm to use</option>
          <option value="is">IS linear-time algorithm for constructing suffix array. It requires 5.37N memory where N is the size of the database. IS is moderately fast, but does not work with database larger than 2GB</option>
          <option value="bwtsw">BWT-SW algorithm. This method works also with big genomes</option>
        </param>
      </when>
    </conditional>
  </macro>
  ```

* Now Find and click on *tool_data_table_conf.xml.sample* which defines the
  mapping to the *tool-data/bwa_mem_index.loc* file. Note that column 2 in the
  above tool file under `<options from_data_table="bwa_mem_indexes">` is listed
  here as `name` or the name of the reference sequence (0 indexed list).

  ``` xml
  <tables>
      <table name="bwa_mem_indexes" comment_char="#">
          <columns>value, dbkey, name, path</columns>
          <file path="tool-data/bwa_mem_index.loc" />
      </table>
  </tables>
  ```

* Find and click on *tool-data/bwa_mem_index.loc.sample*. This is a sample .loc
  file for the bwa mapping tool. It contains the names and paths to the actual
  indices.

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
  #
  #and your /depot/data2/galaxy/phiX/base/ directory
  #would contain phiX.fa.* files:
  #
  #-rw-r--r--  1 james    universe 830134 2005-09-13 10:12 phiX.fa.amb
  #-rw-r--r--  1 james    universe 527388 2005-09-13 10:12 phiX.fa.ann
  #-rw-r--r--  1 james    universe 269808 2005-09-13 10:12 phiX.fa.bwt
  #...etc...
  #
  #Your bwa_index.loc file should include an entry per line for each
  #index set you have stored. The "file" in the path does not actually
  #exist, but it is the prefix for the actual index files.  For example:
  #
  #phiX174  phiX    phiX174 /depot/data2/galaxy/phiX/base/phiX.fa
  #hg18canon    hg18    hg18 Canonical  /depot/data2/galaxy/hg18/base/hg18canon.fa
  #hg18full hg18    hg18 Full   /depot/data2/galaxy/hg18/base/hg18full.fa
  #/orig/path/hg19.fa   hg19    hg19    /depot/data2/galaxy/hg19/base/hg19.fa
  #...etc...
  #
  #Note that for backwards compatibility with workflows, the unique ID of
  #an entry must be the path that was in the original loc file, because that
  #is the value stored in the workflow for that parameter. That is why the
  #hg19 entry above looks odd. New genomes can be better-looking.
  #
  ```

**NOTE:** When editing .loc files, your editor **MUST** use **TABS** and not expand them into spaces.
* In **vim** use the command *:set noexpandtab*

### Excercise 2: Manually add a genome to the BWA tool list.

In this exercise we will be adding a reference genome to our Galaxy server by
manually editing all of the required files (use your favourite editor, but
remember to make sure it uses real TABs, not TABs expanded into spaces).

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
  cd /srv/galaxy/config
  grep admin_users galaxy.yml
```
* It should return `admin_users: ` followed by a comma delimited list of user emails. If yours is not there, it needs to be added. Use only commas to delimit different admin users - no spaces!
* If you make any changes to the galaxy.ini file, you need to restart Galaxy before they will take effect.
* For Galaxy running in daemon mode:
``` bash
  sudo -Hu galaxy galaxy --stop-daemon
  sudo -Hu galaxy galaxy --daemon
```
* Watch the Galaxy log file with `tail -f /srv/galaxy/log/uwsgi.log`.
* Test you are an Admin user by logging into your Galaxy server as the username you added to `galaxy.yml`
* You should see an "Admin" menu item at the top of the Galaxy interface.

**Part 2: Install the BWA tool**

Skip this part if BWA is already installed on your Galaxy server!

* From the Galaxy admin page:
  * Click **Search Tool Shed**
  * Click *Galaxy Main Tool Shed*
  * Search for *bwa*
  * Select *bwa* owned by devteam
  * Click **Install to Galaxy**
  * Click **Install**
  * Watch the interface and wait until BWA is installed.

* Check it worked
  * In your terminal window view *config/shed_tool_conf.xml*, it should now
    contain a bwa entry.
  * View *config/shed_tool_data_table_conf.xml*. It should have the contents of
    bwa's *tool_data_table_conf.xml.sample* table entries added (as well as
    Tool Shed repository installation details).
  * There should be a *tool-data/bwa_mem_index.loc* file (copied from
    `bwa_mem_index.loc.sample` if not already created)
* Upload some sample FASTQ datasets:
  ```
  http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/fastq/SRR507778-10k_1.fastqsanger
  http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/fastq/SRR507778-10k_2.fastqsanger
  ```
  * These are paired end datasets created using Illumina technology, obtained from EBI SRA, and decreased to ~10,000 reads.
  * When uploading these datasets set the datatype to "fastqsanger".
  * Click the "Analyze Data" menu item and select the **Map with BWA** tool.
  * Note the choices available under **Using reference genome** hint: this list should be empty (or at least not contain SacCer1).

**Part 3: Add a new reference genome**

We will be adding a new built-in reference dataset, the _sacCer1_ genome build (good old Saccharomyces cerevisiae - beer yeast). We will download the fasta sequence file for it, index it for bwa, and edit all of the appropriate Galaxy `.loc` file.
It it typically better to place these files under a directory external to the Galaxy server code but for the demonstration purposes today, we are going to place it in the default location, under `$GALAXY_HOME/tool-data`.

* Get the reference genome in the FASTA format.
  * As the Galaxy user (e.g. `sudo -Hsu galaxy`):
  ``` bash
  cd /srv/galaxy/server/tool-data/
  mkdir -p sacCer1/seq
  cd sacCer1/seq
  wget http://www.bx.psu.edu/~dan/examples/gcc2014/data_manager_workshop/sacCer1/sacCer1.fa
  ```

**Part 4: Create BWA indexes for the reference genome.**

**NOTE:** This is kind of the hard part. We need to have BWA available on the command line and in the PATH environment variable. We can either install a separate commandline BWA or use the one installed in Galaxy. It's probably better to use the Galaxy one as sometimes tool developers change the format of their index tables. :(

* Put BWA into the PATH.
  * Galaxy uses Conda by default for dependency management so the best way to
    get Conda into the PATH is to activate the relevant Conda environment. We
    can activate the Conda environment that Galaxy uses and look for which
    environment bwa got installed into and activate it:
    ``` console
    cd /srv/galaxy/dependencies/
    source _conda/bin/activate
    conda info --envs
    source activate mulled-v1-a1698655ddc683fd2767d127c7c583056e87322876f94e167ba3900da02c1fc4
    ```

    We can now run the `bwa` command:
    ``` console
    $ bwa

    Program: bwa (alignment via Burrows-Wheeler transformation)
    Version: 0.7.17-r1188
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

    Note: To use BWA, you need to first index the genome with `bwa index'.
          There are three alignment algorithms in BWA: `mem', `bwasw', and
          `aln/samse/sampe'. If you are not sure which to use, try `bwa mem'
          first. Please `man ./bwa.1' for the manual.
    ```

* Now we can use bwa to build the index! Go back to the sacCer1 directory in `tool-data`. From Galaxy root:

  ``` bash
  $ cd /srv/galaxy/server/tool-data/sacCer1
  $ mkdir bwa_index
  $ cd bwa_index
  $ ln -s ../seq/sacCer1.fa sacCer1.fa
  $ bwa index sacCer1.fa
  $ ls -lh
  total 41576
  lrwxr-xr-x  1 ea  staff    20B Dec 15 15:20 sacCer1.fa -> ../seq/sacCer1.fa
  -rw-r--r--  1 ea  staff    14B Dec 15 15:20 sacCer1.fa.amb
  -rw-r--r--  1 ea  staff   547B Dec 15 15:20 sacCer1.fa.ann
  -rw-r--r--  1 ea  staff    12M Dec 15 15:20 sacCer1.fa.bwt
  -rw-r--r--  1 ea  staff   2.9M Dec 15 15:20 sacCer1.fa.pac
  -rw-r--r--  1 ea  staff   5.8M Dec 15 15:20 sacCer1.fa.sa
  ```
* We must now add it to the `.loc` file. Add the following line to the end of
  the *tool-data/bwa_mem_index.loc* file. Remember to use TABs (*:set noexpandtab* in vim).

  ```
  sacCer1     sacCer1 S. cerevisiae Oct. 2003 (SGD/sacCer1) (sacCer1) /srv/galaxy/server/tool-data/sacCer1/bwa_index/sacCer1/sacCer1.fa
  ```
* Now, all that's left to do is add the `bwa_mem_index` data table to the tool data table config file. Make a copy from the sample and add the new table to the bottom:

  ```console
  cd /srv/galaxy/config
  vi tool_data_table_conf.xml
  ```

  ```xml
      <table name="bwa_mem_indexes" comment_char="#" allow_duplicate_entries="False">
          <columns>value, dbkey, name, path</columns>
          <file path="tool-data/bwa_mem_index.loc" />
      </table>
  ```

**Part 5: Test it all out**

Now we'll check the BWA tool for the new reference entry.

* Restart your galaxy server.
* Check the BWA tool for the new entry in your web browser

**NOTE:** If the your new entry does not appear, did you remember to separate the fields with TAB characters.

* Align your FASTQ reads using the BWA tool to the newly added built-in reference genome data.

Phew, that was a lot of work. Imagine doing that for ~10 genomes and for ~10-20 tools! There has to be a better way. Luckily, there is!

----
