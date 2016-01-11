#!/bin/bash

# plot "./data/plotdata/eigen2_high.dat" u 1:2 w l title "m4high", \
#     "./data/plotdata/eigen2_low.dat" u 1:2 w l title "m4low", \
#     "./data/plotdata/eigen3_high.dat" u 1:3 w l title "m3high", \
#     "./data/plotdata/eigen3_low.dat" u 1:3 w l title "m3low", \

# plot "./data/plotdata/eigen3_high_LeR.dat" u 1:4 w l title "m2high", \
#     "./data/plotdata/eigen3_low_LeR.dat" u 1:4 w l title "m2low"

gnuplot << EOF

set terminal epslatex size 6,5 standalone color colortext 10
set output "./plots/eigen_all.tex"

set xlabel 'M_{0} [GeV]'
set ylabel 'm [TeV]'
set key top center
plot "./data/plotdata/eigen1_high_LeR.dat" u 1:(\$2/1000) w l title 'm_{T1} upper', \
    "./data/plotdata/eigen1_low_LeR.dat" u 1:(\$2/1000) w l title 'm_{T1} lower', \
    "./data/plotdata/eigen2_high_LeR.dat" u 1:(\$3/1000) w l title 'm_{T2} upper', \
    "./data/plotdata/eigen2_low_LeR.dat" u 1:(\$3/1000) w l title 'm_{T2} lower', \
    "./data/plotdata/eigen3_high_LeR.dat" u 1:(\$4/1000) w l title 'm_{T3} upper', \
    "./data/plotdata/eigen3_low_LeR.dat" u 1:(\$4/1000) w l title 'm_{T3} lower'
EOF

latex "./plots/eigen_all.tex"
dvips -o "eigen_all.ps" "eigen_all.dvi"
rm *.dvi *.aux *.log
rm ./plots/*.tex ./plots/*-inc.eps
ps2pdf -dEPSCrop "eigen_all.ps" "eigen_all.pdf"
mv "eigen_all.pdf" ./plots/
rm "eigen_all.ps"
open "./plots/eigen_all.pdf"