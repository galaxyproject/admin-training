import os
import string
import sys


SCRIPTS_DIRECTORY = os.path.dirname(__file__)
TEMPLATE_PATH = os.path.join(SCRIPTS_DIRECTORY, "slideshow_template.html")
TEMPLATE = string.Template(open(TEMPLATE_PATH, "r").read())

def main(argv=None):
    if argv is None:
        argv = sys.argv
    title = argv[1]
    markdown_source = argv[2]
    build_dir = argv[3]
    head, tail = os.path.split(markdown_source)
    output = os.path.join(build_dir, os.path.splitext(tail)[0] + '.html')
    with open(markdown_source, "r") as s:
        content = s.read()
    html = TEMPLATE.safe_substitute(**{
        'title': title,
        'content': content,
    })
    open(output, "w").write(html)

if __name__ == "__main__":
    main()
