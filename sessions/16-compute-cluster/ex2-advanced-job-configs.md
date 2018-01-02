![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### Galaxy Administrators Course

# Running Galaxy Jobs with Slurm - Exercise

#### Authors: Nate Coraor. 2017

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
ubuntu$ sudo -su galaxy
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
$ cp /srv/galaxy/server/config/tool_conf.xml.sample /srv/galaxy/config/tool_conf.xml
$ vim /srv/galaxy/config/tool_conf.xml
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

Finally, in order to read the toolbox changes, Galaxy should be restarted. You'll need to return to the `ubuntu` user to do this (since the `galaxy` user does not have `sudo` privileges). It is, as usual, `sudo supervisorctl restart all`.

Reload Galaxy in your browser and the new tool should now appear in the tool panel. If you have not already created a dataset in your history, upload a random text dataset. Once you have a dataset, click the tool's name in the tool panel, then click Execute. When your job completes, the output should be:

```
Running with '1' threads
```

**Part 2 - Create a destination and map the tool**

We want our tool to run with more than one core. To do this, we need to instruct Slurm to allocate more cores for this job. This is done in the job configuration file.

As the `galaxy` user, open up `/srv/galaxy/config/job_conf.xml` and add the following new destination:

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

And finally, restart Galaxy with `sudo supervisorctl restart all` (as the `ubuntu` user).

Now, click the rerun button on the last history item, or click **Multicore Tool** in the tool panel, and then click the tool's Execute button. If successful, your tool's output should now be:

```
Running with '2' threads
```

## Section 2 - Dynamically map a tool to a job destination

**Part 1 - Write a Dynamic Tool Destination**

Dynamic tool destinations utilize the dynamic job runner to provide dynamic job mapping functionality without having to explicitly write code to perform the mapping. The mapping functionality is mostly limited to input sizes, but often input size is the most important factor in deciding what resources to allocate for a job.

Dynamic tool destinations are configured via a YAML file at `/srv/galaxy/config/tool_destinations.yml`. As before, we'll use a fake example. Create the file with the following contents:

```yaml
---
tools:
  multi:
    rules:
      - rule_type: file_size
        lower_bound: 16
        upper_bound: Infinity
        destination: slurm-2c
    default_destination: slurm
default_destination: local
verbose: True
```

The rule says:
- If the tool has ID `multi`:
  - If the input dataset is >=16 bytes, run on the destination `slurm-2c`
  - If the input dataset is <16 bytes, run on the destination `slurm`
- Else, run on the destination `local`

We also need to inform Galaxy of the path to the file we've just created, which is done using the `tool_destinations_config_file` in `galaxy.ini`:

```ini
tool_destinations_config_file = /srv/galaxy/config/tool_destinations.yml
```

Once the dynamic tool definition has been written, we need to update Galaxy's job configuration to use this rule. Open `/srv/galaxy/job_conf.xml` and add a DTD destination:

```xml
        <destination id="dtd" runner="dynamic">
            <param id="type">dtd</param>
        </destination>
```

Also, comment out the previous `<tool>` definition for the `multi` tool, and replace it with a mapping to the dtd destination like so:

```xml
    <tools>
<!--
        <tool id="multi" destination="slurm-2c"/>
-->
        <tool id="multi" destination="dtd"/>
    </tools>
```

Then, restart Galaxy with `sudo supervisorctl restart all`.

**Part 2 - Verify**

Our rule specified that any invocation of the `multi` tool with an input dataset with size <16 bytes would run on the 1 core destination, whereas any with >= 16 bytes would run on the 2 core destination. To verify, create a dataset using the upload paste tool of just a few (<16) characters, and another with >16 characters and run the Multicore Tool on each. The former will run "with '1' thread" whereas the latter will run "with '2' threads".

## Section 3 - Implement a job resource selector

**Part 1 - Define the resource selector**

You may find that certain tools can benefit from having form elements added to them to allow for controlling certain job parameters, so that users can select based on their own knowledge. For example, a user might know that a particular set of parameters and inputs to a certain tool needs a larger memory allocation than the standard amount for a given tool. This of course assumes that your users are well behaved enough not to choose the maximum whenever available, although such concerns can be mitigated somewhat by the use of concurrency limits on larger memory destinations.

Such form elements can be added to tools without modifying each tool's configuration file through the use of the **job resource parameters configuration file**, `/srv/galaxy/config/job_resource_params_conf.xml`. Create this file and add the following contents:

```xml
<parameters>
    <param label="Cores" name="cores" type="select" help="Number of cores to run job on.">
        <option value="1">1 (default)</option>
        <option value="2">2</option>
    </param>
  <param label="Time" name="time" type="integer" size="3" min="1" max="24" value="1" help="Maximum job time in hours, 'walltime' value (1-24). Leave blank to use default value." />
</parameters>
```

This defines two resource fields, a select box where users can choose between 1 and 2 cores, and a text entry field where users can input an integer value from 1-24 to set the walltime for a job.

As usual, we need to instruct Galaxy of where to find this file in `galaxy.ini` using the `job_resource_params_file` option:

```ini
job_resource_params_file = /srv/galaxy/config/job_resource_params_conf.xml
```

**Part 2 - Configure Galaxy to use the resource selector**

Next, we define a new section in `job_conf.xml`: `<resources>`. This groups together parameters that should appear together on a tool form. Add the following section to `/srv/galaxy/server/job_conf.xml`:

```xml
    <resources>
        <group id="multi_resources">cores,time</group>
    </resources>
```

The group ID will be used to map a tool to job resource parameters, and the text value of the `<group>` tag is a comma-separated list of `name`s from `job_resource_params_conf.xml` to include on the form of any tool that is mapped to the defined `<group>`.

Finally, in `job_conf.xml`, move the previous `<tool>` definition for the `multi` tool into the comment and define a new `<tool>` that defines the `resources` for the tool:

```xml
    <tools>
<!--
        <tool id="multi" destination="slurm-2c"/>
        <tool id="multi" destination="dtd"/>
-->
        <tool id="multi" destination="dynamic_cores_time" resources="multi_resources"/>
    </tools>
```

We have assigned the `multi` tool to a new destination: `dynamic_cores_time`, but this destination does not exist. We need to create it. Add the following destination:

```xml
        <destination id="dynamic_cores_time" runner="dynamic">
            <param id="type">python</param>
            <param id="function">dynamic_cores_time</param>
        </destination>
```

This is a **Python function dynamic destination**. Galaxy will load a function from `/srv/galaxy/server/lib/galaxy/jobs/rules/*.py` named `dynamic_cores_time` and that function will determine the job destination for this tool.

**Part 3 - Python function dynamic rule**

Lastly, we need to write the rule that will read the value of the job resource parameter form fields and decide how to submit the job. But first, let's see the fruits of our labor thus far. Restart Galaxy with `sudo supervisorctl restart all`, then click the **Multicore Tool**. You should see that a "Job Resource Parameters" select box has been added to the bottom of the tool form. If this is switched to "**Specify job resource parameters**", the fields that were defined in `job_resource_params_conf.xml` are displayed.

We need to write a Python function that will process these rules. Such rules live, by default, in `/srv/galaxy/server/lib/galaxy/jobs/rules/*.py` (although this can be configured). Create a new file, `/srv/galaxy/server/lib/galaxy/jobs/rules/cores_time.py`. This file should contains the function that we named in `job_conf.xml`: `dynamic_cores_time`:

```python
import logging
from galaxy.jobs.mapper import JobMappingException

log = logging.getLogger(__name__)

DESTINATION_IDS = {
    1 : 'slurm',
    2 : 'slurm-2c'
}
FAILURE_MESSAGE = 'This tool could not be run because of a misconfiguration in the Galaxy job running system, please report this error'


def dynamic_cores_time(app, tool, job, user_email):
    destination = None
    destination_id = 'slurm'

    # build the param dictionary
    param_dict = dict( [ ( p.name, p.value ) for p in job.parameters ] )
    param_dict = tool.params_from_strings( param_dict, app )

    # handle job resource parameters
    if '__job_resource' in param_dict:
        if param_dict['__job_resource']['__job_resource__select'] == 'yes':
            try:
                # validate params
                cores = int(param_dict['__job_resource']['cores'])
                time = int(param_dict['__job_resource']['time'])
                assert cores in (1, 2), "Invalid value for core selector"
                assert time in range(1, 25), "Invalid value for time selector"
            except (TypeError, AssertionError) as exc:
                log.exception(exc)
                log.error('(%s) param_dict was: %s', job.id, param_dict)
                raise JobMappingException( FAILURE_MESSAGE )
            # params validated
            destination_id = DESTINATION_IDS[cores]
            destination = app.job_config.get_destination(destination_id)
            # set walltime
            if 'nativeSpecification' not in destination.params:
                destination.params['nativeSpecification'] = ''
            destination.params['nativeSpecification'] += ' --time=%s:00:00' % time
        elif param_dict['__job_resource']['__job_resource__select'] != 'no':
            # someone's up to some shennanigans
            log.error('(%s) resource selector not yes/no, param_dict was: %s', job.id, param_dict)
            raise JobMappingException( FAILURE_MESSAGE )
    else:
        # resource param selector not sent with tool form, job_conf.xml misconfigured
        log.warning('(%s) did not receive the __job_resource param, keys were: %s', job.id, param_dict.keys())
        raise JobMappingException( FAILURE_MESSAGE )

    if destination is not None and 'nativeSpecification' in destination.params:
        log.info("native specification: %s", destination.params['nativeSpecification'])
    log.info('returning destination: %s', destination_id)
    return destination or destination_id
```

It is important to note that **you are responsible for parameter validation, including the job resource selector**. This function only handles the job resource parameter fields, but it could do many other things - examine inputs, job queues, other tool paramters, etc.

Once written, restart Galaxy with `sudo supervisorctl restart all`.

**Part 4 - Verify***

Run the **Multicore Tool* with various resource parameter selections:
- Use default job resource parameters
- Specify job resource parameters:
  - 1 core
  - 2 cores
  - Some value for walltime from 1-24

The cores parameter can be verified from the output of the tool. The walltime can be verified with `scontrol`:

```console
$ scontrol show job 24
JobId=24 JobName=g24_multi_anonymous_10_0_2_2
   UserId=galaxy(999) GroupId=galaxy(999)
   Priority=4294901747 Nice=0 Account=(null) QOS=(null)
   JobState=COMPLETED Reason=None Dependency=(null)
   Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0
   RunTime=00:00:05 TimeLimit=12:00:00 TimeMin=N/A
   SubmitTime=2016-11-05T22:01:09 EligibleTime=2016-11-05T22:01:09
   StartTime=2016-11-05T22:01:09 EndTime=2016-11-05T22:01:14
   PreemptTime=None SuspendTime=None SecsPreSuspend=0
   Partition=debug AllocNode:Sid=gat2016:1860
   ReqNodeList=(null) ExcNodeList=(null)
   NodeList=localhost
   BatchHost=localhost
   NumNodes=1 NumCPUs=1 CPUs/Task=1 ReqB:S:C:T=0:0:*:*
   TRES=cpu=1,node=1
   Socks/Node=* NtasksPerN:B:S:C=0:0:*:* CoreSpec=*
   MinCPUsNode=1 MinMemoryNode=0 MinTmpDiskNode=0
   Features=(null) Gres=(null) Reservation=(null)
   Shared=OK Contiguous=0 Licenses=(null) Network=(null)
   Command=(null)
   WorkDir=/srv/galaxy/server/database/jobs/000/24
   StdErr=/srv/galaxy/server/database/jobs/000/24/galaxy_24.e
   StdIn=StdIn=/dev/null
   StdOut=/srv/galaxy/server/database/jobs/000/24/galaxy_24.o
   Power= SICP=0
```

Note that the `TimeLimit` for this job (which I gave a 12 hour time limit) was set to `12:00:00`.

## So, what did we learn?

Hopefully, you now understand:
- The various ways in which tools can be mapped to destinations, both statically and dynamically
- How to write a dynamic tool destination (DTD)
- How to write a dynamic python function destination
- How to use the job resource parameter selection feature

## Further Reading

- The [sample dynamic tool destination config file](https://github.com/galaxyproject/galaxy/blob/dev/config/tool_destinations.yml.sample) fully describes the configuration language
- [Dynamic destination documentation](https://wiki.galaxyproject.org/Admin/Config/Jobs#Dynamic_Destination_Mapping)
- Job resource parameters are not as well documented as they could be, but the [sample configuration file](https://github.com/galaxyproject/usegalaxy-playbook/blob/master/files/galaxy/test.galaxyproject.org/config/job_resource_params_conf.xml) shows some of the possibilities.
- [usegalaxy.org's job_conf.xml](https://github.com/galaxyproject/usegalaxy-playbook/blob/master/templates/galaxy/usegalaxy.org/config/job_conf.xml.j2) is publicly available for reference.
