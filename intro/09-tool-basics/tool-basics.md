layout: true
class: inverse, middle, large

---
class: special
# Intro to Galaxy Tools

slides by @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!
We want and will answer your questions.

---
class: normal
# What is a Galaxy tool?

- Set of resources that describes to Galaxy how to display and execute software.
- Cornerstone of Galaxy tool is a `tool wrapper` written in XML.
- Galaxy loads tools from configuration files (also XML).
  - The basic one is `tool_conf.xml`.
- The `tool_path` in `galaxy.ini` specifies filepath to the tool (defaults to `tools/`).

???
Wrapper can be written in .yml also.

---
class: smaller

# Tool example (hashing tool)

```xml
<tool id="secure_hash_message_digest" name="Secure Hash / Message Digest" version="0.0.1">
    <description>on a dataset</description>
    <command interpreter="python">secure_hash_message_digest.py --input "${input1}" --output "${out_file1}"
        #if $algorithms.value:
            #for $algorithm in str( $algorithms ).split( "," ):
                --algorithm "${algorithm}"
            #end for
        #end if
    </command>
    <inputs>
        <param format="data" name="input1" type="data" label="Text file"/>
        <param name="algorithms" type="select" multiple="True" display="checkboxes" label="Choose the algorithms">
          <option value="md5"/>
          <option value="sha1"/>
          <option value="sha224"/>
          <option value="sha256"/>
          <option value="sha384"/>
          <option value="sha512"/>
          <validator type="no_options" message="You must select at least one algorithm." />
        </param>
    </inputs>
    <outputs>
        <data format="tabular" name="out_file1"/>
    </outputs>
</tool>
```

---
# Tool example (hashing tool)

You need few more things:
- Add the wrapper to the `tools/` folder.
- Add script `secure_hash_message_digest.py` to the same folder.
- Add the following `<tool file="secure_hash_message_digest.xml" />` to the `tool_conf.xml`.
- Restart Galaxy.

???
If you use `<toolbox monitor="true">` you do not have to restart Galaxy for the tool to load.

---
