layout: true
class: inverse, top

---
class: special
# Connecting Galaxy to a compute cluster

slides by @natefoo and @jmchilton

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
- Container scheduling - Kubernetes, Mesos vis Chronos

---
class: smaller
# Cluster library stack

```
╔═════════════════════════════════════════════════════╗
║ Galaxy Job Handler (galaxy.jobs.handler)            ║
╟─────────────────────────────────────────────────────╢
║ Galaxy DRMAA Job Runner (galaxy.jobs.runners.drmaa) ║
╠─────────────────────────────────────────────────────╢
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

# config/job_conf.xml

A simple job_conf.xml:

```
<job_conf>
    <plugins workers="4"
        <plugin id="local" type="runner"
                load="galaxy.jobs.runners.local:LocalJobRunner" />
    </plugins>
    <handlers>
        <handler id="main"/>
    </handlers>
    <destinations>
        <destination id="local" runner="local"/>
    </destinations>
</job_conf>
```

- Runs all jobs on the same host as Galaxy.
- Jobs will fail when Galaxy is restarted.
- No external dependencies are required.

---

# Using SLURM

```
<job_conf>
    <plugins workers="4">
        <plugin id="slurm" type="runner"
                load="galaxy.jobs.runners.slurm:SlurmJobRunner"/>
    </plugins>
    <handlers>
        <handler id="main"/>
    </handlers>
    <destinations default="slurm">
        <destination id="slurm" runner="slurm"/>
    </destinations>
</job_conf>
```

- Production distributed resource manager.
- Can distribute jobs across different clusters and thousands of nodes.
- Jobs will not fail if Galaxy is restarted.
- SLURM: https://slurm.schedmd.com/
- Configuring SLURM: https://github.com/galaxyproject/dagobah-training/blob/2017-melbourne/sessions/16-compute-cluster/ex1-slurm.md

---

# Shared Filesystem

1. Some things are located *at the same path* on Galaxy server and node(s)
  - Galaxy application (`/srv/galaxy/server`)
  - Tool dependencies
2. Some things *are the same* on Galaxy server and node(s)
  - Job working directory
  - Input and output datasets

The first can be worked around with symlinks or Pulsar embedded (advanced topic)

The second can be worked around with Pulsar REST/MQ (with a performance/throughput penalty)

---
# Multiprocessing

Some tools can greatly improve performance by using multiple cores

Galaxy automatically sets `$GALAXY_SLOTS` to the CPU/core count you specify when submitting, for example, 4:
- Slurm: `sbatch --ntasks=4`
- SGE: `qsub -pe threads 4`
- Torque/PBS Pro: `qsub -l nodes=1:ppn=4`

Tool configs: Consume `\${GALAXY_SLOTS:-4}`

---

```
<job_conf>
    <plugins workers="4">
        <plugin id="slurm" type="runner"
                load="galaxy.jobs.runners.slurm:SlurmJobRunner"/>
    </plugins>
    <handlers>
        <handler id="main"/>
    </handlers>
    <destinations default="slurm-default">
        <destination id="slurm-default" runner="slurm">
           <param id="nativeSpecification">-n 1</param>
        </destination>
        <destination id="slurm-multi" runner="slurm">
           <param id="nativeSpecification">-n 8</param>
        </destination>
    </destinations>
    <tools>
    	<tool id="hisat" destination="slurm-multi" /> 
    </tools>
</job_conf>
```

- Can define many destinations with different walltimes, memory requirements,
  core allocations, etc...
- Can map tools to specific destinations.
- Mapping can be arbitrarily sophisticated - dependent on inputs, users, resources, etc..,
- https://github.com/galaxyproject/dagobah-training/blob/2017-melbourne/sessions/16-compute-cluster/ex2-advanced-job-configs.md 

---
# Memory requirements

No generally consumable environment variable. But for Java tools, be sure to set `-Xmx`, e.g.:

```xml
<destination id="foo" ...>
    <env id="_JAVA_OPTIONS">-Xmx4096m</env>
</destination>
```
---

# More Resources:

- Heterogenous Resources Slides https://galaxyproject.github.io/dagobah-training/2017-melbourne/17-heterogenous/heterogeneous.html#1
- Heterogenous Resources Exercise https://github.com/galaxyproject/dagobah-training/blob/2017-melbourne/sessions/17-heterogenous/ex1-pulsar.md
- Pulsar Docs http://pulsar.readthedocs.io/en/latest/

---
