#!/bin/bash

pdflatex $1
bibtex $1
pdflatex $1
pdflatex $1

rm $1.aux
rm $1.log
rm $1.bbl
rm $1.blg