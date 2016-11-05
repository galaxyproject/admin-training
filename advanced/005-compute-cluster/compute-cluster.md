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
# The advanced (full) job configuration

- [Sample advanced job config](https://github.com/martenson/dagobah-training/blob/master/advanced/002a-systemd-supervisor/job_conf.sample_advanced.xml) (copied for syntax highlighting)
- [Sample advanced job config](https://github.com/galaxyproject/galaxy/blob/dev/config/job_conf.xml.sample_advanced) (canonical source from `config/job_conf.xml.sample_advanced`)

---
# Exercise

[Running Galaxy jobs with Slurm](https://github.com/martenson/dagobah-training/blob/master/advanced/005-compute-cluster/ex1-slurm.md)

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
# `<env>` and other useful job_conf things

---
# Dependency resolvers esp. modules

---
# Dynamic
