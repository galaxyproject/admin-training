import os
import string
import sys


SCRIPTS_DIRECTORY = os.path.dirname(__file__)
TEMPLATE_PATH = os.path.join(SCRIPTS_DIRECTORY, "slideshow_template.html")
TEMPLATE = string.Template(open(TEMPLATE_PATH, "r").read())
BUILD_PATH = 'docs'

def main(argv=None):
    if argv is None:
        argv = sys.argv
    title = argv[1]
    markdown_source = argv[2]
    build_dir = argv[3]
    full_build_dir = os.path.join(BUILD_PATH, build_dir)
    head, tail = os.path.split(markdown_source)
    filename = os.path.splitext(tail)[0] + '.html'
    output = os.path.join(full_build_dir, filename)
    with open(markdown_source, "r") as s:
        content = s.read()
    html = TEMPLATE.safe_substitute(**{
        'title': title,
        'content': content,
    })
    
    if not os.path.exists(full_build_dir):
        os.makedirs(full_build_dir)
    open(output, "w").write(html)

    # Add the the entry to index.html.
    slidepath = build_dir + '/' + filename
    open( BUILD_PATH + '/index.html', "a").write('<a href="'+ slidepath +'">' + slidepath + '</a></br>\n')


if __name__ == "__main__":
    main()
