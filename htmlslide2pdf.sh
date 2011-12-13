#!/bin/sh
#
# * phantomjs
# git clone git://github.com/ariya/phantomjs.git && cd phantomjs
# qmake -spec macx-g++ && make
#
# * sam2p
# http://code.google.com/p/sam2p/
#
# * pdftk
# http://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/
#

URL=$1
NUM=$2

if [ -z $URL ]; then
    echo "usage: $0 <URL> [<number of pages>]"
    exit 1
fi

if [ -z $NUM ]; then
    NUM=0
fi

PAGE="000"
while [ $PAGE -le $NUM ]; do
    phantomjs rasterize.js "$URL#Page$PAGE" "page$PAGE.png" 960 720
    PAGE=$(expr $PAGE + 1)
    while [ ${#PAGE} -ne 3 ]; do
        PAGE=0$PAGE
    done
done

for file in png/page*.png; do
    sam2p $file ${file//png/pdf}
done

pdftk pdf/*.pdf cat output slide.pdf
