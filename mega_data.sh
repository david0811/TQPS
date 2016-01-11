#!/bin/bash

for i in `seq 500 500 10000`; do 
    python main.py -m$i -w5 -e
done