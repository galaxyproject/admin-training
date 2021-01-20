# Helper Cheatsheet

Who said they were available now? [Check the timezone heatmap!](https://hexylena.github.io/timezone-heatmap/)

## Organisation

We have three region coordinators. They're responsible for helpers, insuring VMs are working as expected, etc.

Region                      | Abbr | Coordinator
------                      | ---- | -----------
Asia/Pacific, Oceania       | APO  | Catherine Bromhead
Europe, Middle East, Africa | EMEA | Martin Cech
Americas                    | Amer | Sergey Golitsynskiy

## Communications

All communication will occur on slack.

### FAQs

So we've used google doc style FAQs a lot in the past, they work very nicely with distributed events. The idea is:

1. students ask questions (in slack, just like gitter in the past)
2. If we reasonably expect to see this Q again, we copy it to the FAQ as clearer writeups

Students should check there first to see if their question is answered before
asking. The FAQ will be especially valuable for Amer, as APO/EMEA will have
answered most of the common questions.

- [Read only link to provide to students](https://docs.google.com/document/d/e/2PACX-1vRkFTRRDzNdUjPMc4uZot8am94LyczINbAyJ3Lerj7fef0wiUF810SBaDOB2sy31hDc6SHz90qEHAlu/pub)
- [Read-write link for you, the helper](https://docs.google.com/document/d/1mmhZRpV4XQnMB5UoPGDw0qT8I3oF2DIEYPxvPH4tDz0/edit?usp=sharing)

### Ice Breaker

Every day to help encourage students to talk to one another the earliest awake region coordinator (i.e. APO region) will post an ice breaker. Here are some to choose from:

- What is the coolest, most mind blowing fact (nature/people/animal etc.) you know?
- What did you think science was when you were at school?
- How would your 5-year-old self have finished this sentence? “When I grow up, I want to be …”?
- If you could meet one person from the past (before living memory, say the ~1930s or earlier), who would it be?
- If you have to spend 2 months in a basic house on a small island, what 2-3 things would you bring along to take care of your physical and mental health?
- What music/artist/audiobook have you been listening to these days?
- What is your recent favorite tool or app or software?
- Share something from nature that has awed you or brought you peace recently - perhaps a flower, a view, a photo, a scent, a potted plant, a bird that flew past…
- Name a dream vacation location, if you could be anywhere in the world (or outside it?)

We should reply in threads to student messages where possible to help encourage them to use threads.

### Touch Base Telcos

We plan to have one touch-base telco per region, probably mid-afternoon (14[J (Juliett)](https://en.wikipedia.org/wiki/List_of_military_time_zones#cite_ref-Juliet_3-0)). Here we'll let people join a Zoom call and just chat / ask questions / etc. [Touch Base Telco Meeting URL](https://us02web.zoom.us/j/85107038451) (password is `GAT2021`).

### Student Progress Surveying

At regular intervals we'll write a message like "Is everything going without issue for everyone?" and the person posting it should select two reactions (:heavy_check_mark:, :x: (`:heavy_check_mark: :x:`) are probably good options and not so region/language/culture biased.) If people are responding negatively, then in that thread we can ping them and ask what's up.

We should encourage students to write in the chat if they have issues or simply want to celebrate successfully completing a tutorial.

### Handover

At the end of the day in a particular region we'll note that we're switching off to the next region, pinging the person you're handing over to. This should help students in between regions understand what's going on. We have a ~1h gap between APO/EMEA, 3-4h overlap between EMEA/Amer, and 0 hour gap between Amer/APO.

E.g.

> "I'm finishing up for the day in the EMEA region, @Sergey and Americas are online to answer your questions from here"

## VMs

We have VMs provided by three different organisations across the globe, please refer to the appropriate person there if there are issues with the VMs:

Region                      | Abbr | VM Admins
------                      | ---- | -----------
Asia/Pacific, Oceania       | APO  | Simon Gladmann / Catherine Bromhead
Europe, Middle East, Africa | EMEA | Gianmauro Cuccuru
Americas                    | Amer   | Alexandru Mahmoud (via Martin Cech)

One of the region coordinators can run the playbook

1. Clone admin-training/playbook.yml
2. run `make prep-{oz,eu,us}`

### Student-VM Issues

We don't expect issues here but sometimes machines just get completely screwed up. E.g. cannot install any software, linux people don't know what's wrong, etc. In that case we'll:

1. reassign them to a new machine so they can continue working
	1. To reassign them, change [the spreadsheet](https://gxy.io/gatmachines)
	2. contact them on slack.
2. and we'll rebuild spares in the background
