#!/bin/bash

for i in `seq 2000 500 10000`; do
    for j in {1..3}; do
        sort -k$j -n ./data/m${i}w5ds100LeRy100dm${i}.dat > \
            ./data/1m${i}w5ds100LeRy100dm${i}.dat
        mv ./data/1m${i}w5ds100LeRy100dm${i}.dat \
            ./data/m${i}w5ds100LeRy100dm${i}.dat
        head -1 ./data/m${i}w5ds100LeRy100dm${i}.dat \
            | awk -v i=$i '{print i, $0}' >> \
                ./data/plotdata/eigen${j}_low_LeR.dat
        tail -1 ./data/m${i}w5ds100LeRy100dm${i}.dat \
            | awk -v i=$i '{print i, $0}' >> \
                ./data/plotdata/eigen${j}_high_LeR.dat
    done
done

    # awk -v i=$i '{print i, $0}' ./data/m${i}w5ds100LneRy100dm20000.dat > \
    #         ./data/1m${i}w5ds100LneRy100dm20000.dat
    # mv ./data/1m${i}w5ds100LneRy100dm20000.dat \
    #         ./data/m${i}w5ds100LneRy100dm20000.dat