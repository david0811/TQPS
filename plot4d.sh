#!/bin/bash

gnuplot << EOF

set terminal epslatex size 6,5 standalone color colortext 10
set output "./plots/${1%.*}_4d.tex"

set view 60,80
set xlabel '$\Delta_L'
set ylabel '$\Delta_R'
set zlabel 'm_t [GeV]'
set palette defined (0 "blue", 0.5 "green", 1 "red")
splot "./data/$1" u 5:6:4:7 w p pt 7 ps 1 lt palette notitle

EOF

latex "./plots/${1%.*}_4d.tex"
dvips -o "${1%.*}_4d.ps" "${1%.*}_4d.dvi"
rm *.dvi *.aux *.log
rm ./plots/*.tex ./plots/*-inc.eps
ps2pdf -dEPSCrop "${1%.*}_4d.ps" "${1%.*}_4d.pdf"
mv "${1%.*}_4d.pdf" ./plots/
rm "${1%.*}_4d.ps"