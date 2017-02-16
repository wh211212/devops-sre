#!/bin/bash
for i in `seq 1 10`; do
        echo $RANDOM
done | sort -n
