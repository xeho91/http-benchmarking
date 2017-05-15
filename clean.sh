#!/bin/bash
TEMPLATE="results/template.csv"
# COMMANDS
if [ "$1" = "all" ]
    then
        for file in results/*/*.csv
            do
                name=${file#*/}

                cp -fr $TEMPLATE results/${name%}

                echo
                echo "Cleaned results from ${name%}"
        done
elif [[ "$1" -eq "get" || "$1" -eq "post" ]]
    then
        if [ "$2" = "all" ]
            then
                for file in results/${1}/*.csv
                    do
                        name=${file##*/}

                        cp -fr $TEMPLATE results/$1/${name%}

                        echo
                        echo "Cleaned results from ${name%}"
                done
        else
            for file in results/${1}/*.csv
                do
                    name=${file##*/}

                    if [ "$2" = "${name%.csv}" ]
                        then
                            cp -fr $TEMPLATE results/$1/${2}.csv

                            echo
                            echo "Cleaned results from $1/${2}.csv"

                            FOUND="true"
                    fi
            done
        fi

        if [ -z "$FOUND" ]
            then
                echo
                echo "ERROR!"
                echo "File '$2' was not found in 'results/$1'"
        fi
fi
