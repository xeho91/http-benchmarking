#!/bin/sh

#####################################
########### CONFIGURATION ###########
#####################################
# TEST DURATION SEQUENCE (in seconds)
DURATION_SEQUENCE_START=1
DURATION_SEQUENCE=1
DURATION_SEQUENCE_END=2
# CONNECTIONS SEQUENCE
CONNECTION_SEQUENCE_START=1
CONNECTION_SEQUENCE=1
CONNECTION_SEQUENCE_END=2
# TRIALS FOR EACH CONNECTION TEST
TRIALS=2
#####################################
#####################################
#####################################

start_a_test() {
    for duration in $(seq $DURATION_SEQUENCE_START $DURATION_SEQUENCE $DURATION_SEQUENCE_END)
    do
        echo "###################################################################################"
        echo "##> Running a $duration seconds test '$1' and '$2' requests on $connection connections!"
        echo "###################################################################################"
        for connection in $(seq $CONNECTION_SEQUENCE_START $CONNECTION_SEQUENCE $CONNECTION_SEQUENCE_END)
        do
            echo "================================================"
            echo "==> Testing requests on $connection connections!"
            echo "================================================"
            # 5 trials for same connection
            for trial in $(seq 1 $TRIALS)
            do
                echo "------------------------------------------------------------"
                echo "--> Duration: ${duration}s -> Connections: $connection -> Trial: $trial"
                echo "------------------------------------------------------------"
                ./wrk -t1 -c$connection -d$duration -s scripts/$1/$2.lua http://vps334372.ovh.net:8080
            done
        done
    done
}

if [ "$1" = "all" ]
then
    for file in scripts/get/*.lua
        do
            name=${file##*/}
            start_a_test "get" "${name%.lua}"
    done

    for file in scripts/post/*.lua
        do
            name=${file##*/}
            start_a_test "post" "${name%.lua}"
    done
elif [[ "$1" -eq "get" || "$1" -eq "post" ]]
then
    for file in scripts/${1}/*.lua
    do
        name=${file##*/}

        if [ "$2" = "${name%.lua}" ]
        then
            start_a_test "$1" "$2"
            ERROR="false"
        else
            ERROR="true"
        fi
    done

    if [ $ERROR = "true" ]
    then
        echo
        echo "ERROR: This testing object -> ${2} <- doesn't exist in the 'script/${1}' directory!!!"
        echo
    fi
else
    echo
    echo "Available arguments:"
    echo "* 'all' - running test on all files in 'script/get' and 'script/post' directories"
    echo "* <METHOD> <TESTING_OBJECT>"
    echo
    echo "<METHOD> can be a 'get' or 'post'"
    echo "<TESTING_OBJECT> can be a any file inside 'get' or 'post' folder,"
    echo "like: 'customers' or 'leads'"
    echo
    echo "Example:"
    echo "$ ./test.sh get customers"
    echo
fi
