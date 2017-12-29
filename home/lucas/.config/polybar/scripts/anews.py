#!/usr/bin/python
# Depends on python-feedparser
# Read Arch Linux RSS news;

import feedparser
from subprocess import call
import re
import textwrap

icone = ""

d = feedparser.parse("https://www.archlinux.org/feeds/news/")

for f in range(0,1):
    #print( "%%{F#FFF}icone %%{F-}" d.entries[f].title, )
    print("%%{F#FFF}%s %%{F-}%s" % (icone, d.entries[f].title))
    xy = d.entries[f].title
