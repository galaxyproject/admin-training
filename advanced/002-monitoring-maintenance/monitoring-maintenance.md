layout: true
class: inverse, larger

---
class: special, middle
# Server Monitoring and Maintenance

slides by @natefoo, @Slugger70

.footnote[\#usegalaxy / @galaxyproject]

---
# Admin UI

---
# Log Files

---
# DB Shell

A programmer's interface to the database

Interact with the database using Galaxy's model

---
# Database Queries

Sometimes it's the best way to get the exact data you need

Can be very useful for:
- Debugging
- Reporting
- Analytics

---
# Database Queries

"Can you send me the number of jobs per day/state from Main in September and October?"

```sql
SELECT
  date_trunc('month', j.create_time) AS month,
  j.state,
  COUNT(j.state) AS job_count
FROM job j
LEFT OUTER JOIN galaxy_user u
  ON j.user_id = u.id
WHERE u.email != 'monitor@bx.psu.edu'
GROUP BY month,
         j.state
HAVING date_trunc('month', j.create_time) >= '2016-09-01'
AND date_trunc('month', j.create_time) < '2016-11-01'
ORDER BY month, j.state;
```

---
# Database Queries

```
        month        |  state  | job_count
---------------------+---------+-----------
 2016-09-01 00:00:00 | deleted |     11369
 2016-09-01 00:00:00 | error   |     15375
 2016-09-01 00:00:00 | new     |      1179
 2016-09-01 00:00:00 | ok      |    165963
 2016-09-01 00:00:00 | paused  |       933
 2016-09-01 00:00:00 | waiting |         9
 2016-10-01 00:00:00 | deleted |     13190
 2016-10-01 00:00:00 | error   |     12539
 2016-10-01 00:00:00 | new     |      1183
 2016-10-01 00:00:00 | ok      |    167547
 2016-10-01 00:00:00 | paused  |       645
 2016-10-01 00:00:00 | queued  |        75
 2016-10-01 00:00:00 | running |        36
 2016-10-01 00:00:00 | waiting |        17
(14 rows)
```

---
# Database Queries

"I need a list of current main toolshed users and a number of their repos"

```sql
SELECT
  u.username,
  COUNT(r.id) AS r_count
FROM galaxy_user u
JOIN repository r
  ON u.id = r.user_id
WHERE NOT r.deleted
GROUP BY u.id
ORDER BY r_count DESC
LIMIT 12;
```

---
# Database Queries

```
                 username                 | r_count
------------------------------------------+---------
 iuc                                      |     571
 devteam                                  |     366
 bgruening                                |      95
 galaxyp                                  |      87
 jjohnson                                 |      46
 xuebing                                  |      40
 peterjc                                  |      39
 rnateam                                  |      33
 anton                                    |      32
 nml                                      |      32
 yhoogstrate                              |      31
 iracooke                                 |      30
(12 rows)
```

---
# Analytics

Can we make better walltime decisions?

`scripts/runtime_stats.py`: Database-driven job runtime statistics

---
# Job Metrics

Galaxy can collect metrics on each job through configurable plugins in `job_metrics_conf.xml`.

Some plugins:
- `core`: Captures Galaxy slots, start and end of job, runtime
- `cpuinfo`: processor count for each job
- `env`: dump environment for each job
- `collectl`: monitor a wide array of system performance data

---
# Runaway Jobs

Tips:
- Set job output size limit in `job_conf.xml`
- Set job concurrency limits in `job_conf.xml`
- Public servers
  - Require email verification
  - Watch for duplicates 

---
# Runaway Storage

Tips:
- Set quotas
- `tmpwatch` your job working directory
  - `cleanup_job` in `galaxy.ini` (defaults to `always` though)
- Set up dataset cleanup

---
# Dataset Cleanup 

- `scripts/cleanup_datasets/pgcleanup.py`: PostgreSQL-optimized fast cleanup script
- `scripts/cleanup_datasets/cleanup_datasets.py`: General cleanup script

---
# Dataset Cleanup Lifecycle

Mark deleted all "anonymous" histories not used within the last `$days` days:

`python ./scripts/cleanup_datasets/pgcleanup.py -o $days -s delete_userless_histories`

Remove all history exports older than `$days` days:

`python ./scripts/cleanup_datasets/pgcleanup.py -o $days -s delete_exported_histories`

Mark purged HDAs in histories deleted `$days` or more days ago (not user-recoverable):

`python ./scripts/cleanup_datasets/pgcleanup.py -o $days -s purge_deleted_histories`

---
# Dataset Cleanup Lifecycle

Mark purged individual HDAs deleted `$days` or more days ago (not user-recoverable):

`python ./scripts/cleanup_datasets/pgcleanup.py -o $days -s purge_deleted_hdas`

Mark datasets with all purged HDAs last updated `$days` or more days ago deleted:

`python ./scripts/cleanup_datasets/pgcleanup.py -o $days -s delete_datasets`

Mark purged all datasets last updated `$days` or more days ago **and remove from disk**:

`python ./scripts/cleanup_datasets/pgcleanup.py -o $days -s purge_datasets`

---
# Nagios

General purpose tool for monitoring systems and services

Galaxy-specific check in `contrib/nagios/`: Runs Galaxy jobs

Example: Galaxy project infrastructure Nagios servers [duvel](https://duvel.galaxyproject.org/nagios/), [chouffe](https://chouffe.galaxyproject.org/nagios/)

---
# Backups

What to back up:
- Configs
- Database
- Installed shed tools and dependencies
- Datasets (if you can...)

What not to back up:
- Anything in `database/` not mentioned above
- Job working directories
