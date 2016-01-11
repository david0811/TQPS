#!/bin/bash

gnuplot << EOF

set terminal epslatex size 6,5 standalone color colortext 10
set output "./plots/${1%.*}_4d.tex"

set view 60,80
set xlabel '$\Delta_{L,R}'
set ylabel 'y'
set zlabel 'm_t [GeV]'
splot "./data/$1" u 5:7:4 w p pt 13 notitle

EOF

latex "./plots/${1%.*}_4d.tex"
dvips -o "${1%.*}_4d.ps" "${1%.*}_4d.dvi"
rm *.dvi *.aux *.log
rm ./plots/*.tex ./plots/*-inc.eps
ps2pdf -dEPSCrop "${1%.*}_4d.ps" "${1%.*}_4d.pdf"
mv "${1%.*}_4d.pdf" ./plots/