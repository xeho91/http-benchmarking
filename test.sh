#!/bin/bash
#####################################
########### CONFIGURATION ###########
#####################################
# URL
URL="http://vps334372.ovh.net:8080"
# DATE FORMAT
DATE=`date +%Y-%m-%d:%H:%M:%S`
# THREADS SEQUENCE
THREAD_SEQUENCE_START=1
THREAD_SEQUENCE_END=1
# CONNECTIONS SEQUENCE
CONNECTION_SEQUENCE_START=1
CONNECTION_SEQUENCE=1
CONNECTION_SEQUENCE_END=2
# TEST DURATION SEQUENCE (in seconds)
DURATION_SEQUENCE_START=1
DURATION_SEQUENCE=1
DURATION_SEQUENCE_END=2
# TRIALS FOR EACH CONNECTION TEST
TRIALS=2
#####################################
#####################################
#####################################
start_a_test() {
    echo
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "~~> Running a wrk http benchmark tests"
    echo "METHOD: '$1'"
    echo "TESTING OBJECT: '$2'"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo

    # THREADS
    for thread in $(seq $THREAD_SEQUENCE_START $THREAD_SEQUENCE_END)
        do
            echo
            echo "================= THREADS ================="
            echo "==> Testing requests on $thread threads"
            echo "==========================================="
            echo

            # CONNECTIONS
            for connection in $(seq $CONNECTION_SEQUENCE_START $CONNECTION_SEQUENCE $CONNECTION_SEQUENCE_END)
                do
                    echo
                    echo "----------------- CONNECTIONS -----------------"
                    echo "--> Testing requests on $connection connections"
                    echo "-----------------------------------------------"
                    echo

                    # DURATION
                    for duration in $(seq $DURATION_SEQUENCE_START $DURATION_SEQUENCE $DURATION_SEQUENCE_END)
                        do
                            echo
                            echo "+++++++++++++++++ DURATION +++++++++++++++++"
                            echo "++> Testing requests for $duration seconds"
                            echo "++++++++++++++++++++++++++++++++++++++++++++"
                            echo

                            # TRIALS
                            for trial in $(seq 1 $TRIALS)
                                do
                                    echo
                                    echo "--------------------------------------------"
                                    echo "--> Threads: $thread"
                                    echo "--> Connections: $connection"
                                    echo "--> Duration: ${duration}s"
                                    echo "--> Trial: $trial"
                                    echo

                                    # Printing additional general info from bash at start of every line of test before results from Lua
                                    printf ${DATE},${thread},${connection},${duration},${trial}, >> results/$1/${2}.csv

                                    # Running wrk with parameters
                                    ./wrk -t$thread -c$connection -d$duration -s scripts/$1/$2.lua $URL

                                    echo
                                    echo "Results saved to 'results/$1/${2}.csv'!"
                                    echo "--------------------------------------------"
                                    echo
                            done
                    done
            done
    done
}
# COMMANDS
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
    echo "* '<METHOD>' '<TESTING_OBJECT>'"
    echo
    echo "Where:"
    echo "* '<METHOD>' can be a 'get' or 'post'"
    echo "* '<TESTING_OBJECT>' can be a any file inside 'get' or 'post' folder,"
    echo "like: 'customers' or 'leads'"
    echo
    echo "Example:"
    echo "$ ./test.sh get customers"
    echo
fi
