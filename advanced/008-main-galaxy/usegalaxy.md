layout: true
class: inverse, top, large

---
class: special
# Complex Galaxy Server Example: usegalaxy.org

slides by @natefoo

.footnote[\#usegalaxy / @galaxyproject]

---
# usegalaxy.org Technologies

- CentOS 6/7
- Galaxy server infrastructure @ TACC
  - VMWare VMs
  - Corral NFS
- CVMFS (CernVM-FS) @ distributed
  - read-only HTTP-based FS for distribution
- Compute
  - Bare metal cluster @ TACC
  - Jetstream @ IU, TACC
  - Bridges @ PSC
  - Stampede @ TACC
  - Docker for Interactive Environments @ PSU
- Deployed with Ansible .smaller[Ansiblificate all the things!]

---
# usegalaxy.org Technologies

- PostgreSQL
- RabbitMQ
- Slurm
  - Multicluster w/ Jetstream @ TACC, IU
- Sentry
- Grafana
- 

---
# usegalaxy.org Limits

- 250 GB Quota
- Concurrent job limits
  - 6 overall
  - 2 multicore on TACC metal
  - 4 multicore on Jetstream

---
# Multicluster Slurm

Demo

---
# Diagrams

[Pretty pictures](https://docs.google.com/presentation/d/1BIpB7n5etN8EDgv7Hl6UcP2u4_m0Lz1cfNFHc0goUiY/edit?usp=sharing)

---
# CVMFS update procedure

Use Ansible to:
- Open CVMFS transaction on Stratum 0 server
- Run Docker container to git pull, fetch wheels, etc.
- Publish CVMFS transaction
- Snapshot `main.galaxyproject.org` on Stratum 1 servers
- Flush cache on clients `web-{01..03}`
- Upgrade DB
- Restart Galaxy
  - `HUP` uWSGI to block clients during restart
  - Restart job handlers

---
# CVMFS tool/dependency update procedure

[Gist](https://gist.github.com/natefoo/411c54420689bd861872f845d7ece5b1)

Then use Ansible to run update procedure from *snapshot*

---
# Galaxy web servers

- `web-{01,02}`
  - Serves regular client-facing requests
- `web-{03,04}`
  - Serves file staging to/from Pulsar on remote compute
