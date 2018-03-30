![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Africa 2018 - Cape Town

# Running Galaxy Jobs with Slurm - Exercise

#### Authors: Nate Coraor 2017, Enis Afgan 2018

## Learning Outcomes

By the end of this tutorial, you should:

1. Have a strong understanding of Galaxy job destinations
2. Know how to map tools to job destinations
3. Be able to use the dynamic job runner to make arbitrary destination mappings
4. Understand the job resource selector config and dynamic rule creation

## Introduction

The tools that are added to Galaxy can have a wide variance in the compute resources that they require and work efficiently on. To account for this, Galaxy's job configuration needs to be tuned to run these tools properly. In addition, site-specific variables must be taken into consideration when choosing where to run jobs and what parameters to run them with.

## Statically map a tool to a job destination

**Part 1 - Create a tool**

We don't want to overload our training VMs trying to run real tools, so to demonstrate how to map a multicore tool to a multicore destination, we'll create a fake tool. Since most of these operations are performed as the `galaxy` user it's probably easiest to open a shell as that user before starting:

```console
ubuntu$ sudo -su galaxy
galaxy$
```

If you prefer (as I do) to do less user switching, you can open a second shell to your VM to do this.

Now, open a new file at `/srv/galaxy/server/tools/multi.xml` and add the contents:

```xml
<tool id="multi" name="Multicore Tool">
    <command>
        sleep 5; echo "Running with '\${GALAXY_SLOTS:-1}' threads" &gt; "$output1"
    </command>
    <inputs>
        <param name="input1" type="data" format="txt" label="Input Dataset"/>
    </inputs>
    <outputs>
        <data name="output1" format="txt" />
    </outputs>
</tool>
```

Of course, this tool doesn't actually *use* the allocated number of cores. In a real tool, you would call the tools's underlying command with whatever flag that tool provides to control the number of threads or processes it starts, such as `foobar -t \${GALAXY_SLOTS:-1} ...`.

Up until now we've been using the default tool panel config file, located at `/srv/galaxy/server/config/tool_conf.xml.sample`. Copy this to `/srv/galaxy/config/tool_conf.xml` in the same directory as the sample and open it up with an editor. We need to add the entry for our new tool. This can go anywhere, but I suggest putting it at the very top, between the opening `<toolbox>` and first `<section>`, so that it appears right at the top of the toolbox.

```console
cp /srv/galaxy/server/config/tool_conf.xml.sample /srv/galaxy/config/tool_conf.xml
vim /srv/galaxy/config/tool_conf.xml
```

The tag to add is:

```xml
  <tool file="multi.xml"/>
```

Galaxy needs to be instructed to read `tool_conf.xml` instead of `tool_conf.xml.sample`. Normally it does this automatically if `tool_conf.xml` exists, but the Ansible role we used to install Galaxy explicitly instructed Galaxy to load `tool_conf.xml.sample`.

Edit `/srv/galaxy/config/galaxy.ini` and modify the value of `tool_config_file` accordingly:

```ini
tool_config_file = /srv/galaxy/config/tool_conf.xml,/srv/galaxy/config/shed_tool_conf.xml
```

Finally, in order to read the toolbox changes, Galaxy should be restarted.
You'll need to return to the `ubuntu` user to do this (since the `galaxy` user
does not have `sudo` privileges) and use command `sudo supervisorctl restart
galaxy:`.

Reload Galaxy in your browser and the new tool should now appear in the tool
panel. If you have not already created a dataset in your history, upload a
random text dataset. Once you have a dataset, click the tool's name in the tool
panel, then click Execute. When your job completes, the output should be:

```
Running with '1' threads
```

**Part 2 - Map a tool to a new destination**

GalaxyKickStart playbook has already setup a Slurm cluster even on our single
host. Let's edit the job destinations configuration to add a new job destination
that requests 2 cores from Slurm. Do so by adding a new destination under the
exiting `<destinations>` block in `/srv/galaxy/config/job_conf.xml`:

```xml
        <destination id="slurm-2c" runner="slurm">
            <env file="/srv/galaxy/venv/bin/activate"/>
            <param id="nativeSpecification">--ntasks=2</param>
        </destination>
```

Continue to edit the same file to add a new specification for our tool,
configuring it to run using the new destination:

```xml
    <tools>
        <tool id="multi" destination="slurm-2c" />
    </tools>
```

For these changes to take effect, we need to restart Galaxy again with
`sudo supervisorctl restart galaxy:` (remember to do this as `ubuntu` user).
If we run our multi tool now, the output will say

```
Running with '2' threads
```

## So, what did we learn?

Hopefully, you now understand:
- how to add new job destinations to Galaxy
- how to map specific tools to destinations

## Further Reading

- [Dynamically mapping jobs to destinations](https://github.com/galaxyproject/dagobah-training/blob/2018-cape-town/sessions/16-compute-cluster/ex2-advanced-job-configs.md#section-2---dynamically-map-a-tool-to-a-job-destination)
- The [sample dynamic tool destination config file](https://github.com/galaxyproject/galaxy/blob/dev/config/tool_destinations.yml.sample) fully describes the configuration language
- [Dynamic destination documentation](https://docs.galaxyproject.org/en/latest/admin/jobs.html#dynamic-destination-mapping)
- Job resource parameters are not as well documented as they could be, but the [sample configuration file](https://github.com/galaxyproject/usegalaxy-playbook/blob/master/env/test/files/galaxy/config/job_resource_params_conf.xml) shows some of the possibilities.
- [usegalaxy.org's job_conf.xml](https://github.com/galaxyproject/usegalaxy-playbook/blob/master/env/main/files/galaxy/config/job_resource_params_conf.xml) is available for reference.
