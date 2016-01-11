#!/bin/bash

gnuplot << EOF

set terminal epslatex size 6,5 standalone color colortext 10
set output "./plots/${1%.*}_eigen.tex"

set view 60,80
set ylabel 'm_{partner} [TeV]'
set xlabel 'm_t [GeV]'
set key outside right center
plot "./data/$1" u 4:(\$1/1000) w p pt 7 ps 1 title 'm_{T3}', \
     "./data/$1" u 4:(\$2/1000) w p pt 7 ps 1 title 'm_{T2}', \
     "./data/$1" u 4:(\$3/1000) w p pt 7 ps 1 title 'm_{T1}'
EOF

latex "./plots/${1%.*}_eigen.tex"
dvips -o "${1%.*}_eigen.ps" "${1%.*}_eigen.dvi"
rm *.dvi *.aux *.log
rm ./plots/*.tex ./plots/*-inc.eps
ps2pdf -dEPSCrop "${1%.*}_eigen.ps" "${1%.*}_eigen.pdf"
mv "${1%.*}_eigen.pdf" ./plots/
rm "${1%.*}_eigen.ps"