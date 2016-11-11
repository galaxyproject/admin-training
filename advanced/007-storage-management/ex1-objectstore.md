![GATC Logo](../../docs/shared-images/AdminTraining2016-100.png) ![galaxy logo](../../docs/shared-images/galaxy_logo_25percent_transparent.png)

### GATC - 2016 - Salt Lake City

# Expanding File Space - (A very short) Exercise

#### Authors: Nate Coraor. 2016

## Introduction

You may find that your Galaxy files directory has run out of space, but you don't want to move all of the files from one place to another. One solution to this problem is to use Galaxy's hierarchical object store to add an additional file space for Galaxy.

## Exercise

First, note that your Galaxy datasets have been created thus far in the directory `/srv/galaxy/server/database/files`. This is because of the setting `file_path` in `galaxy.ini`. We can instruct Galaxy to place new datasets in a different place, but still look in `database/files` for old datasets.

Create a new Galaxy config file: `/srv/galaxy/server/config/object_store_conf.xml`:

```xml
<?xml version="1.0"?>
<object_store type="hierarchical">
    <backends>
        <backend id="newdatasets" type="disk" order="0">
            <files_dir path="database/newdatasets"/>
            <extra_dir type="job_work" path="database/newjobs"/>
        </backend>
        <backend id="olddatasets" type="disk" order="1">
            <files_dir path="database/datasets"/>
            <extra_dir type="job_work" path="database/jobs"/>
        </backend>
    </backends>
</object_store>
```

Then restart your Galaxy server with `sudo supervisorctl restart gx:*`.

Create new jobs and you'll find that they are created in the folder `/srv/galaxy/server/database/newdatasets`. However, older datasets in `/srv/galaxy/server/database/datasets` are still accessible.
