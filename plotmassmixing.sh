#!/bin/bash

#f(x) = atan(x/10000.0)*(360/(2*pi))
#g(x,y) = atan(x/(y+10000.0/(4*pi)))*(360/(2*pi))
#"./data/$1" u (\$3):(g((\$6), (\$7))) title "right mixing angle"

gnuplot << EOF

set terminal epslatex size 6,5 standalone color colortext 10
set output "./plots/${1%.*}_mixing.tex"

f(x) = x / (((x**2)+(10000.0**2))**0.5)
g(x,y) = x / (((((y*10000.0)/4*pi)**2) + (10000.0**2))**0.5)

set xlabel 'm_{T1} [TeV]'
set ylabel '\sin{\phi}'
set key at graph 0.4, graph 0.85

plot "./data/$1" u (\$3/1000):(f(\$5)) w p pt 7 ps 1 title '\sin{\phi_L}', \
     "./data/$1" u (\$3/1000):(g((\$6), (\$7))) w p pt 7 ps 1 title '\sin{\phi_R}'

EOF

latex "./plots/${1%.*}_mixing.tex"
dvips -o "${1%.*}_mixing.ps" "${1%.*}_mixing.dvi"
rm *.dvi *.aux *.log
rm ./plots/*.tex ./plots/*-inc.eps
ps2pdf -dEPSCrop "${1%.*}_mixing.ps" "${1%.*}_mixing.pdf"
mv "${1%.*}_mixing.pdf" ./plots/
rm "${1%.*}_mixing.ps"
open "./plots/${1%.*}_mixing.pdf"