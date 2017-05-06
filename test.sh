#!/bin/sh

for time in $(seq 1 2 6)
do
    echo "========================================================================="
    echo ">>> Running a $time seconds test '$1' and '$2' requests on $connection connections!"
    echo "========================================================================="
    for connection in $(seq 50 50 100)
    do
        echo "========================================="
        echo "==> Testing requests on $connection connections!"
        echo "========================================="
        # 5 trials for same connection
        for i in $(seq 1 2)
        do
            echo "------------------------------------------------"
            echo "--> Duration: ${time}s Connections: $connection -> Trial: $i"
            echo "------------------------------------------------"
            ./wrk -t1 -c$connection -d$time -s scripts/$1/$2.lua http://vps334372.ovh.net:8080
        done
    done
done
