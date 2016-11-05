layout: true
class: inverse, top, large

---
class: special
# Connecting Galaxy to a compute cluster

slides by @natefoo

.footnote[\#usegalaxy / @galaxyproject]

---
# Why cluster?

Running jobs on the Galaxy server negatively impacts Galaxy UI performance

Even adding one other host helps

Can restart Galaxy without interrupting jobs

---
# Cluster options

- Slurm
- Condor
- Torque
- PBS Pro
- LSF
- SGE derivatives maybe?
- Any other [DRMAA](https://www.drmaa.org/)-supported DRM

---
class: smaller
# Cluster library stack

```
╔═════════════════════════════════════════════════════╗
║ Galaxy Job Handler (galaxy.jobs.handler)            ║
╠─────────────────────────────────────────────────────╣
║ Galaxy DRMAA Job Runner (galaxy.jobs.runners.drmaa) ║
╠─────────────────────────────────────────────────────╣
║ Pulsar DRMAA Interface (pulsar.managers.util.drmaa) ║
╠═════════════════════════════════════════════════════╣
║ DRMAA Python                                        ║
╠═════════════════════════════════════════════════════╣
║ C DRMAA Library (PSNC, vendor)                      ║
╠═════════════════════════════════════════════════════╣
║ DRM (Slurm, Condor, ...)                            ║
╚═════════════════════════════════════════════════════╝

```

---
class: center
# Cluster library stack

.center[| Galaxy |
| ------------------ |
| Galaxy Job Handler Process |
| Galaxy DRMAA Job Runner (galaxy.jobs.runners.drmaa) |
| Pulsar DRMAA Interface (pulsar.managers.util.drmaa) |


| DRMAA Python |
| ------------ |

| C DRMAA Library (PSNC, vendor) |
| ------------ |

| DRM (Slurm, Condor, ...) |
| ------------ |]

---
# Galaxy job configuration

`config/job_conf.xml`:
- From basic to advanced
- XML format
- Major components:
  - Plugins: Interface to DRMs
  - Destinations: Where to send jobs, and what parameters to run those jobs with
  - Handlers: Which job handler processes should handle the lifecycle of a job
  - Tool to destination/handler mappings: Specify that a tool should be sent to a specific destination
  - Resource selection mappings: Give users job execution options on the tool form
  - Limits: Set job runtime limits such as the max number of concurrent jobs

---
# Plugins

Correspond to job runner plugins in [lib/galaxy/jobs/runners](https://github.com/galaxyproject/galaxy/tree/dev/lib/galaxy/jobs/runners)

Plugins for:
- Slurm (DRMAA subclass)
- DRMAA: SGE, PBS Pro, LSF, Torque
- Condor
- Torque: Using the `pbs_python` library
- Pulsar: Galaxy's own remote job management system
- CLI via SSH
- Kubernetes
- Go-Docker

---
# Plugins

Most job plugins require a **shared filesystem** between the Galaxy server and compute.

The exception is **Pulsar**. More on this in:

**Using Heterogeneous compute resources, 15:40**

---
# Destinations

Define *how* jobs should be run:
- Which plugin?
- In a Docker container? Which one?
- DRM params (queue, cores, memory, walltime)?
- Environment (variables e.g. `$PATH`, source an env file, run a command)?

---
# Handlers

Define which job handler (Galaxy server) processes should handle a job:
- Higher availability pool for small, high throughput jobs
- Work around concurrency limit race conditions

---
# The default job configuration

`config/job_conf.xml.sample_basic`:
```xml
<?xml version="1.0"?>
<job_conf>
    <plugins>
        <plugin id="local" type="runner" load="galaxy.jobs.runners.local:LocalJobRunner" workers="4"/>
    </plugins>
    <handlers>
        <handler id="main"/>
    </handlers>
    <destinations>
        <destination id="local" runner="local"/>
    </destinations>
</job_conf>
```

---
# Exercise

[Running Galaxy jobs with Slurm](https://github.com/martenson/dagobah-training/blob/master/advanced/005-compute-cluster/ex1-slurm.md)

---
# Shared Filesystem

Our simple example works because of two important principles:

1. Some things are located *at the same path* on Galaxy server and node(s)
  - Galaxy application (`/srv/galaxy/server`)<sup>[1]</sup>
  - Tool dependencies<sup>[1]</sup>
2. Some things *are the same* on Galaxy server and node(s)
  - Job working directory
  - Input and output datasets

The first can be worked around with symlinks or Pulsar embedded (later)

The second can be worked around with Pulsar REST/MQ (with a performance/throughput penalty)

.footnote[<sup>[1]</sup> A fix for this has been proposed

<sup>[2]</sup> Except conda dependencies!]

---
# Non-shared Galaxy

If Galaxy server is at `/srv/galaxy/server`, nodes must find it there too. Solutions:
- Node-local Galaxy at same path
- Node-local Galaxy at different path w/ symlink at `/srv/galaxy/server`
- Network filesystem Galaxy w/ symlink (usegalaxy.org uses CVMFS)
  - Can be different network FS server from Galaxy datasets
- Use embedded Pulsar to rewrite paths before job submission

---
# One interesting hybrid solution

Galaxy server as network FS server for application

Other server as network FS for datasets, job dirs, dependencies

Benefits:
- Better UI performance when not running from NFS
- Job IO does not affect Galaxy UI

Drawbacks:
- Slower dataset IO on Galaxy server

---
# Job Config - Tags

Both destinations and handlers can be grouped by **tags**:
- Allows random selection from multiple resources
- Allows concurrency limits on both destination and group level
- Decision-based selection available via dynamic job runner (later)

---
# Job Environment

`<env>` tag in destinations: configure the job exec environment:
- `<env id="NAME">VALUE</env>`: Set `$NAME` to `VALUE`
- `<env file="/path/to/file" />`: Source shell file at `/path/to/file`
- `<env exec="CMD" />`: Execute `CMD`

---
# Limits

Available limits:
- Walltime (if not available with your DRM)
- Output size (if *any* tool output grows larger than this limit)
- Concurrency: Number of "active" (queued or running) jobs

---
# Concurrency Limits

Available limits:
- Number of active jobs per registered user
- Number of active jobs per unregistered user
- Number of active jobs per registered user in a destination or destination tag
- Number of active jobs total in a destination or destination tag

---
# The advanced (full) job configuration

- [Sample advanced job config](https://github.com/martenson/dagobah-training/blob/master/advanced/002a-systemd-supervisor/job_conf.sample_advanced.xml) (copied for syntax highlighting)
- [Sample advanced job config](https://github.com/galaxyproject/galaxy/blob/dev/config/job_conf.xml.sample_advanced) (canonical source from `config/job_conf.xml.sample_advanced`)

---
# Multiprocessing

Some tools can greatly improve performance by using multiple cores

Galaxy automatically sets `$GALAXY_SLOTS` to the CPU/core count you specify when submitting, for example, 4:
- Slurm: `sbatch --ntasks=4`
- SGE: `qsub -pe threads 4`
- Torque/PBS Pro: `qsub -l nodes=1:ppn=4`
- LSF: ??

Tool configs: Consume `\${GALAXY_SLOTS:-4}`

---
# Memory requirements

No generally consumable environment variable. But for Java tools, be sure to set `-Xmx`, e.g.:

```xml
<destination id="foo" ...>
    <env id="_JAVA_OPTIONS">-Xmx4096m</env>
</destination>
```

---
# Run jobs as the "real" user

If your Galaxy users == System users:
- Submit jobs to cluster as the actual user
- Configurable callout scripts before/after job to change ownership
- Probably requires limited sudo for Galaxy user

See: [Cluster documentation](https://wiki.galaxyproject.org/Admin/Config/Performance/Cluster)

---
# Dependency resolvers

Specifies the order in which to attempt to resolve tool dependencies, e.g.:
```xml
<dependency_resolvers>
    <tool_shed_packages />
    <galaxy_packages />
    <galaxy_packages versionless="true" />
    <conda />
    <conda versionless="true" />
    <modules modulecmd="/opt/Modules/3.2.9/bin/modulecmd" />
    <modules modulecmd="/opt/Modules/3.2.9/bin/modulecmd" versionless="true" default_indicator="default" />
</dependency_resolvers>
```

---
# Dependency resolution

Tool XML contains:
```xml
<tool id="foo">
    <requirements>
        <requirement type="package" version="4.2">bar</requirement>
    </requirements>
</tool>
```

---
# Dependency resolution

`<tool_shed_packages />`

Did tool `foo` have a TS dependency providing `bar` 4.2 when installed?
- Yes: Query install DB for `<repo_owner>`, `repo_name`, `changeset_id`, source:
  - `<tool_dependencies_dir>/bar/4.2/<repo_owner>/<repo_name>/<changeset_id>/env.sh`
- No: continue

---
# Dependency resolution

`<galaxy_packages />`

Does `<tool_dependency_dir>/bar/4.2/env.sh` exist?:
- Yes: source it
- No: Does `<tool_dependency_dir>/bar/4.2/bin/` exist?:
  - Yes: prepend it to `$PATH`
  - No: continue

Good for dependencies manually installed by an administrator

---
# Dependency resolution

`<galaxy_packages versionless="true" />`

Does `<tool_dependency_dir>/bar/default/` exist and is it a symlink?:
- Yes: Does `<tool_dependency_dir>/bar/default/env.sh` exist?:
  - Yes: source it
  - No: Does `<tool_dependency_dir>/bar/default/bin/` exist?:
    - Yes: prepend it to `$PATH`
    - No: continue
- No: continue

---
# Dependency resolution

`<conda />`

Does `bar==4.2` exist in Conda?:
- Yes: use `conda create` to create env in job working directory
- No: continue

---
# Dependency resolution

`<conda versionless="true" />`

Does `bar` (any version) exist in Conda?:
- Yes: use `conda create` to create env in job working directory
- No: continue

---
# Dependency resolution

`<modules modulecmd="/opt/Modules/3.2.9/bin/modulecmd" />`

Is `bar/4.2` a registered module?:
- Yes: Load module `bar/4.2`
- No: continue

See: [Environment Modules](http://modules.sourceforge.net/)

---
# Dependency resolution

`<modules modulecmd="/opt/Modules/3.2.9/bin/modulecmd" versionless="true" default_indicator="default" />`

Is `bar/default` a registered module?:
- Yes: Load module `bar/default`
- No: continue

---
# Dependency resolution

Else: Dependency not resolved

Submit the job anyway, maybe it's on `$PATH`

---
# Job Config - Mapping Tools to Destinations

Problem: Tool A uses single core, Tool B uses multiple
- Both submit to the same cluster
- Need different submit parameters (`--ntasks=1` vs. `--ntasks=4` in Slurm)

---
# Job Config - Mapping Tools to Destinations

Solution:
```xml
    <destinations default="single">
        <destination id="single" runner="slurm" />
        <destination id="multi" runner="slurm">
            <param id="nativeSpecification">--ntasks=4</param>
        </destination>
    <tools>
        <tool id="hisat2" destination="multi"/>
    </tools>
```

---
class: special
# The Dynamic Job Runner
For when basic tool-to-destination mapping isn't enough

---
# The Dynamic Job Runner

A special built-in job runner plugin

Map jobs to destinations on more than just tool IDs

Two types:
- Dynamic Tool Destinations
- Python function

See: [Dynamic Destination Mapping](https://wiki.galaxyproject.org/Admin/Config/Jobs#Dynamic_Destination_Mapping)

---
# Dynamic Tool Destinations

Configurable mappings without programming:
- YAML format config file
- Map based on tool ID plus:
  - Input dataset size(s)
  - Input dataset number of records
  - User
- Maps to static destinations defined in job config

---
# Arbitrary Python Functions

Programmable mappings:
- Written as Python fuction
- Map based on:
  - Tool ID
  - User email or username
  - Inputs
  - Tool Parameters
  - Defined "helper" functions based on DB contents
  - Anything else discoverable
    - Cluster queue depth?
    - ...?
- Can dynamically modify destinations in job config (i.e. `sbatch` params)

---
# Exercise

[Advanced Galaxy Job Configurations](https://github.com/martenson/dagobah-training/blob/master/advanced/005-compute-cluster/ex2-advanced-job-configs.md)
