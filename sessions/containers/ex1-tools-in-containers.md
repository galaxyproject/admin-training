# Running tools in Containers

## 1. Install a tool

We need to install a tool with a simple external requirement. A good example of this is the [jq tool](https://toolshed.g2.bx.psu.edu/view/iuc/jq/5ff75eb1a893), which only depends on [jq](https://stedolan.github.io/jq/) (version 1.5 at time of writing).

1. Log in as an administrator
1. Click "Admin" in the Galaxy masthead
1. Choose **Install new tools** from under the **Tool Management** section of the left panel menu
1. Click the **Galaxy Main Tool Shed** button
1. In the search box, enter `jq` and hit return
1. Click the `jq` tool (by owner **iuc**) and in the popup menu, click **Preview and install**
1. Click **Install to Galaxy**
1. Disable installation with Conda by clicking the **Display Details** button and *unchecking* **When available, install Conda managed tool dependencies?**
1. Under the **Select existing tool panel section:** selector, choose **Text Manipulation**
1. Click **Install**

## 2. Configure Galaxy

The GalaxyKickStart install of Galaxy has already installed Docker and configured Galaxy to be able to run tools in docker. We simply need to configure Galaxy to run the `jq` tool in Docker:

1. Edit the job configuration file with `sudo -u galaxy vim /srv/galaxy/config/job_conf.xml`
1. Add the following section **immediately before the `</job_conf>` tag**, then save and exit:
    ```xml
        <tools>
            <tool id="jq" destination="local_docker"/>
        </tools>
    ```
1. Edit the Galaxy configuration file with `sudo -u galaxy vim /srv/galaxy/config/galaxy.yml` and add the following option to the `galaxy` section:
    ```yaml
    galaxy:
        enable_beta_mulled_containers: true
    ```
1. Restart Galaxy with `sudo supervisorctl restart galaxy:`
1. Begin following the log file with `tail -f /srv/galaxy/log/uwsgi.log`

## 3. Test!

We'll need some json data in Galaxy. We can grab some from the GitHub API.

1. Click the **upload icon** at the top of the Galaxy tool panel
1. Click **Paste/Fetch data**
1. In the new box, enter the URL `http://api.github.com/users/galaxyproject/repos`
1. Click **Start**

When the upload job completes, Run the JQ tool:

1. Click **Text Manipulation** in the tool panel, and within that section, click **JQ**
1. Ensure that the `http://api.github.com/users/galaxyproject/repos` dataset is selected as the tool input
1. In the **jq filter** field, enter `.[0]`
1. Click **Execute**

In the log, you should see a command line generated like:

```
rm -rf working; mkdir -p working; cd working; docker inspect quay.io/biocontainers/jq:1.5--4 > /dev/null 2>&1
[ $? -ne 0 ] && docker pull quay.io/biocontainers/jq:1.5--4 > /dev/null 2>&1

docker run -e "GALAXY_SLOTS=$GALAXY_SLOTS" -v /srv/galaxy/server:/srv/galaxy/server:ro -v /srv/galaxy/shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/jq/5ff75eb1a893/jq:/srv/galaxy/shed_tools/toolshed.g2.bx.psu.edu/repos/iuc/jq/5ff75eb1
a893/jq:ro -v /home/galaxy/galaxy/jobs/000/6:/home/galaxy/galaxy/jobs/000/6:ro -v /home/galaxy/galaxy/jobs/000/6/working:/home/galaxy/galaxy/jobs/000/6/working:rw -v /home/galaxy/galaxy/datasets:/home/galaxy/galaxy/datasets:rw -w /h
ome/galaxy/galaxy/jobs/000/6/working --net none --rm --user 1450:1450 quay.io/biocontainers/jq:1.5--4 /home/galaxy/galaxy/jobs/000/6/tool_script.sh; return_code=$?; cd '/home/galaxy/galaxy/jobs/000/6';
```

Stop following the log with `CTRL+C` and verify that the `quay.io/biocontainers/jq:1.5--4` image has been pulled:

```console
$ sudo docker images
REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
quay.io/biocontainers/jq   1.5--4              1fe0f3d31487        7 weeks ago         15.6MB
```

# References

- [@jmchilton's Containers Resolver Slides](http://schd.ws/hosted_files/gcc2017/99/S1_T2_biocontainers.pdf)
- [BioContainers](https://github.com/BioContainers/mulled)
- [quay.io BioContainers](https://quay.io/organization/biocontainers)
