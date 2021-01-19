# Helper Cheatsheet

Who said they were available now? [Check the timezone heatmap!](https://hexylena.github.io/timezone-heatmap/)

## Organisation

We have three region coordinators. They're responsible for helpers, insuring VMs are working as expected, etc.

Region                      | Abbr | Coordinator
------                      | ---- | -----------
Asia/Pacific, Oceania       | APO  | Catherine Bromhead
Europe, Middle East, Africa | EMEA | Martin Cech
Americas                    | Am   | Sergey Golitsynskiy

## Communications

All communication will occur on slack.

### Touch Base Telcos

We plan to have one touch-base telco per region, probably mid-afternoon (14[J (Juliett)](https://en.wikipedia.org/wiki/List_of_military_time_zones#cite_ref-Juliet_3-0)). Here we'll let people join a Zoom call and just chat / ask questions / etc. [Touch Base Telco Meeting URL](https://us02web.zoom.us/j/85107038451) (password is `GAT2021`).

### Student Progress Polling

At regular intervals we'll write a message like "Is everything going OK for everyone?" and the person posting it should select two reactions (:heavy_check_mark:, :x: are probably good options.) If people are responding negatively, then in that thread we can ping them and ask what's up.

### Handover

At the end of the day in a particular region we'll note that we're switching off to the next region, pinging the person you're handing over to. This should help students in between regions understand what's going on. We have a ~1h gap between APO/EMEA, 3-4h overlap between EMEA/Am, and 0 hour gap between Am/APO

## VMs

We have VMs provided by three different organisations across the globe, please refer to the appropriate person there if there are issues with the VMs:

Region                      | Abbr | VM Admins
------                      | ---- | -----------
Asia/Pacific, Oceania       | APO  | Simon Gladmann / Catherine Bromhead
Europe, Middle East, Africa | EMEA | Gianmauro Cuccuru
Americas                    | Am   | Alexandru Mahmoud (via Martin Cech)

One of the region coordinators can run the playbook

1. Clone admin-training/playbook.yml
2. run `make prep-{oz,eu,us}`

### Student-VM Issues

We don't expect issues here but sometimes machines just get completely screwed up. E.g. cannot install any software, linux people don't know what's wrong, etc. In that case we'll:

1. reassign them to a new machine so they can continue working
	1. To reassign them, change [the spreadsheet](https://gxy.io/gatmachines)
	2. contact them on slack.
2. and we'll rebuild spares in the background
