There is makefile in the root, if you run 'make generate-slides' it should
build the slides from markdown into the remarkised HTML and copy to the `/docs` directory
which is connected to the github page at https://martenson.github.io/dagobah-training/.

However the makefile needs to be modified to add more slide decks as it does not scan folders,
it calls it one by one. Also you need to have some deps installed, should work if you are in Galaxy's venv.
