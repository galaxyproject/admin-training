There is Makefile in the root, if you run 'make generate-slides' it should
build the slides from markdown into the remarkised HTML and copy to the `/docs` directory.

However the Makefile needs to be modified to add/remove slide decks as it does not scan folders,
it calls it one by one. Also you need to have some deps installed, should work if you are in Galaxy's venv.

More details about how this repo works are available at [README on master branch](https://github.com/galaxyproject/dagobah-training/blob/master/README.md).
