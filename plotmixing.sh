#!/bin/bash

gnuplot << EOF

set terminal epslatex size 6,5 standalone color colortext 10
set output "./plots/${1%.*}_4d.tex"

f(x) = atan(x/10000.0)*(360/(2*pi))
g(x,y) = atan(x/(y+10000.0/(4*pi)))*(360/(2*pi))

set xlabel 
set key right center

plot "./data/$1" u (\$7):(f(\$5)) title "left mixing angle", \
     "./data/$1" u (\$7):(g((\$6), (\$7))) title "right mixing angle"
EOF

latex "./plots/${1%.*}_mixing.tex"
dvips -o "${1%.*}_mixing.ps" "${1%.*}_mixing.dvi"
rm *.dvi *.aux *.log
rm ./plots/*.tex ./plots/*-inc.eps
ps2pdf -dEPSCrop "${1%.*}_mixing.ps" "${1%.*}_mixing.pdf"
mv "${1%.*}_mixing.pdf" ./plots/
rm "${1%.*}_mixing.ps"
open "./plots/${1%.*}_mixing.pdf"