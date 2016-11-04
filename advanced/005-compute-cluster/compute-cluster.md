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
# Exercise

[Running Galaxy jobs with Slurm](https://)
