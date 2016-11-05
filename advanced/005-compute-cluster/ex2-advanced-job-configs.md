![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Advanced Galaxy Job Configurations - Exercise

#### Authors: Nate Coraor. 2016

## Learning Outcomes

By the end of this tutorial, you should:

1. Have a strong understanding of Galaxy job destinations
2. Know how to map tools to job destinations
3. Be able to use the dynamic job runner to make arbitrary destination mappings
4. Understand the job resource selector config and dynamic rule creation

## Introduction

The tools that are added to Galaxy can have a wide variance in the compute resources that they require and work efficiently on. To account for this, Galaxy's job configuration needs to be tuned to run these tools properly. In addition, site-specific variables must be taken into consideration when choosing where to run jobs and what parameters to run them with.

## Section 1 - Statically map a tool to a job destination

**Part 1 - Create a tool**

We don't want to overload our training VMs trying to run real tools, so to demonstrate how to map a multicore tool to a multicore destination, we'll create a fake tool. Since most of these operations are performed as the `galaxy` user it's probably easiest to open a shell as that user before starting:

```console
galaxyguest$ sudo -su galaxy
galaxy$
```

If you prefer (as I do) to do less user switching, you can open a second shell to your VM to do this.

Now, open a new file at `/srv/galaxy/server/tools/multi.xml` and add the contents:

```xml
<tool id="multi" name="Multicore Tool">
    <command>
        echo "Running with '\${GALAXY_SLOTS:-1}' threads" &gt; "$output1"
    </command>
    <inputs>
        <param name="time" type="text" label="Seconds to sleep"/>
    </inputs>
    <outputs>
        <data name="output1" format="txt" />
    </outputs>
</tool>
```

Of course, this tool doesn't actually *use* the allocated number of cores. In a real tool, you would call the tools's underlying command with whatever flag that tool provides to control the number of threads or processes it starts, such as `foobar -t \${GALAXY_SLOTS:-1} ...`.

Up until now we've been using the default tool panel config file, located at `/srv/galaxy/server/config/tool_conf.xml.sample`. Copy this to `tool_conf.xml` in the same directory as the sample and open it up with an editor. We need to add the entry for our new tool. This can go anywhere, but I suggest putting it at the very top, between the opening `<toolbox>` and first `<section>`, so that it appears right at the top of the toolbox. The tag to add is:

```xml
  <tool file="multi.xml"/>
```

Finally, Galaxy needs to be instructed to read `tool_conf.xml` instead of `tool_conf.xml.sample`. Normally it does this automatically if `tool_conf.xml` exists, but the Ansible role we used to install Galaxy explicitly instructed Galaxy to load `tool_conf.xml.sample`.

Edit `/srv/galaxy/server/galaxy.ini` and modify the value of `tool_config_file` to remove the `.sample`.

Finally, in order to read the toolbox changes, Galaxy should be restarted. You'll need to return to the `galaxyguest` user to do this (since the `galaxy` user does not have `sudo` privileges). It is, as usual, `sudo supervisorctl restart all`.

Reload Galaxy in your browser and the new tool should now appear in the tool panel. Click the tool, then click Execute. When your job completes, the output should be:

```
Running with '1' threads
```

**Part 2 - Create a destination and map the tool**

We want our tool to run with more than one core. To do this, we need to instruct Slurm to allocate more cores for this job. This is done in the job configuration file.

As the `galaxy` user, open up `/srv/galaxy/server/job_conf.xml` and add the following new destination:

```xml
        <destination id="slurm-2c" runner="slurm">
            <param id="nativeSpecification">--nodes=1 --ntasks=2</param>
        </destination>
```

Then, map the new tool to the new destination using the tool ID (`<tool id="multi">`) and destination id (`<destination id="slurm-2c">`) by adding a new section to the job config, `<tools>`:

```xml
    <tools>
        <tool id="multi" destination="slurm-2c"/>
    </tools>
```

And finally, restart Galaxy with `sudo supervisorctl restart all` (as the `galaxyguest` user).

Now, click the rerun button on the last history item, or click **Multicore Tool** in the tool panel, and then click the tool's Execute button. If successful, your tool's output should now be:

```
Running with '2' threads
```

## Section 2 - Dynamically map a tool to a job destination

DTD

## Section 3 - Implement a job resource selector

job resource + Python

## So, what did we learn?

Hopefully, you now understand:
-

## Further Reading

## Notes

<sup>1.</sup>
