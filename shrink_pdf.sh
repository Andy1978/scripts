#!/bin/bash -e

# shrink PDF inplace for my personal use (screen reading)

# https://unix.stackexchange.com/questions/274428/how-do-i-reduce-the-size-of-a-pdf-file-that-contains-images
# doc for PDFSETTINGS: https://www.ghostscript.com/doc/9.54.0/VectorDevices.htm

if [ "$#" -ne 1 ]; then
  echo "ERROR: $0 needs exactly one filename" > /dev/stderr
  exit -1
fi

if [ -f "$1" ]; then
  out=$(mktemp)
  size_before=$(stat -c "%s" "$1" | numfmt --to=iec)
  gs -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -q -o "$out" "$1"
  mv "$out" "$1"
  size_after=$(stat -c "%s" "$1" | numfmt --to=iec)
  echo "$1 before:$size_before after:$size_after"
else
  echo "ERROR: file '$1' doesn't exist" > /dev/stderr
  exit -1
fi
