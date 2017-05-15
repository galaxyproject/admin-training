![GATC Logo](../../docs/shared-images/gatc2017_logo_150.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2017 - Melbourne

# Expanding File Space - (A very short) Exercise

#### Authors: Nate Coraor. 2017

## Introduction

You may find that your Galaxy files directory has run out of space, but you don't want to move all of the files from one filesystem to another. One solution to this problem is to use Galaxy's hierarchical object store to add an additional file space for Galaxy.

Alternatively, you may wish to write new datasets to more than one filesystem. For this, you can use Galaxy's distributed object store.

## Section 1 - Hierarchical Object Store

First, note that your Galaxy datasets have been created thus far in the directory `/srv/galaxy/data`. This is because of the setting `file_path` in `galaxy.ini`. We can instruct Galaxy to place new datasets in a different place, but still look in `/srv/galaxy/data` for old datasets.

Configure Galaxy to recognize an object store configuration file by editing `galaxy.ini` as usual:

```console
$ sudo -u galaxy -e /srv/galaxy/config/galaxy.ini
```

And add the option:

```ini
object_store_config_file = /srv/galaxy/config/object_store_conf.xml
```

Next, create the new config file: `/srv/galaxy/config/object_store_conf.xml`:

```xml
<?xml version="1.0"?>
<object_store type="hierarchical">
    <backends>
        <backend id="newdata" type="disk" order="0">
            <files_dir path="/srv/galaxy/newdata"/>
            <extra_dir type="job_work" path="/srv/galaxy/server/database/newjobs"/>
        </backend>
        <backend id="olddata" type="disk" order="1">
            <files_dir path="/srv/galaxy/data"/>
            <extra_dir type="job_work" path="/srv/galaxy/server/database/jobs"/>
        </backend>
    </backends>
</object_store>
```

Then restart your Galaxy server with `sudo supervisorctl restart gx:*`.

Create new jobs and you'll find that they are created in the folder `/srv/galaxy/newdata`. However, older datasets in `/srv/galaxy/data` are still accessible:

```console
$ cat /srv/galaxy/newdata/000/dataset_19.dat
Running with '2' threads
```

## Section 2 - Distributed Object Store

Rather than searching a hierarchy of object stores until the dataset is found, Galaxy can store the ID (in the database) of the object store in which a dataset is located when the dataset is created. This allows Galaxy to write to more than one object store for new datasets.

Create a new Galaxy config file: `/srv/galaxy/config/object_store_conf.xml`:

```xml
<?xml version="1.0"?>
<object_store type="distributed" maxpctfull="90">
    <backends>
        <backend id="newnewdata" type="disk" weight="3">
            <files_dir path="/srv/galaxy/newnewdata"/>
            <extra_dir type="job_work" path="/srv/galaxy/server/database/newnewjobs"/>
        </backend>
        <backend id="newdata" type="disk" weight="1">
            <files_dir path="/srv/galaxy/newdata"/>
            <extra_dir type="job_work" path="/srv/galaxy/server/database/newjobs"/>
        </backend>
        <backend id="data" type="disk" weight="0">
            <files_dir path="/srv/galaxy/data"/>
            <extra_dir type="job_work" path="/srv/galaxy/database/jobs"/>
        </backend>
    </backends>
</object_store>
```

Move any new datasets you created with the hierarchical object store to the old object store, and set the object store ID in the database:

```console
$ sudo -u galaxy mv /srv/galaxy/newdata/000/* /srv/galaxy/data/000
$ echo "UPDATE dataset SET object_store_id='data';" | sudo -Hu galaxy psql galaxy
UPDATE 19
```

Then restart your Galaxy server with `sudo supervisorctl restart gx:*`.

Create new jobs and you'll find that they are created in both `/srv/galaxy/newnewdata` and `/srv/galaxy/newdata`, with the former being about 3 times as likely to be selected as the latter. You can see this in the log messages as well (e.g. `tail -f /srv/galaxy/log/*.log`):

```
galaxy.objectstore DEBUG 2017-02-05 03:11:39,335 Selected backend 'newnewdata' for creation of Dataset 20
galaxy.objectstore DEBUG 2017-02-05 03:11:39,795 Using preferred backend 'newnewdata' for creation of Job 20
galaxy.objectstore DEBUG 2017-02-05 03:13:22,614 Selected backend 'newnewdata' for creation of Dataset 21
galaxy.objectstore DEBUG 2017-02-05 03:13:23,162 Using preferred backend 'newnewdata' for creation of Job 21
galaxy.objectstore DEBUG 2017-02-05 03:13:36,262 Selected backend 'newnewdata' for creation of Dataset 22
galaxy.objectstore DEBUG 2017-02-05 03:13:36,506 Using preferred backend 'newnewdata' for creation of Job 22
galaxy.objectstore DEBUG 2017-02-05 03:13:39,494 Selected backend 'newnewdata' for creation of Dataset 23
galaxy.objectstore DEBUG 2017-02-05 03:13:39,774 Using preferred backend 'newnewdata' for creation of Job 23
galaxy.objectstore DEBUG 2017-02-05 03:13:46,094 Selected backend 'newdata' for creation of Dataset 24
galaxy.objectstore DEBUG 2017-02-05 03:13:47,029 Using preferred backend 'newdata' for creation of Job 24
```

## Section 3 - Undo

Let's undo the work we did to simplify our configuration for future sessions:

```console
$ sudo -u galaxy mv /srv/galaxy/config/object_store_conf.xml /srv/galaxy/config/_object_store_conf.xml
$ sudo -u galaxy mv /srv/galaxy/newnewdata/000/* /srv/galaxy/data/000
$ sudo -u galaxy mv /srv/galaxy/newdata/000/* /srv/galaxy/data/000
$ sudo supervisorctl restart gx:*
```
