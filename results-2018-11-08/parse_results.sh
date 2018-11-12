#!/bin/bash

# for storing function output
OUTPUT="NONE"

# remove the plots directory, if it exists
rm -f -r plots

# Compute the runtime of the algorithm on the model
function getcomptime_EF_csv() {
    OUTPUT="NONE";
    model=$1
    err=`cat $model | grep "ERROR"`
    t_found=`cat $model | grep "t_found"`
    t_done=`cat $model | grep "t_done\|t_all"`
	result=""
    if [ "$err" != "" ]
    then
        (>&2 echo "ERROR found in $model") # should not occur, output it
        result="10000";
    else 
        if [ "$t_done" != "" ]
        then
            t="${t_done#*:  }"
            t="${t% secon*}"
            result="$t";
        else
            t_done=`cat $model | grep "IMITATOR successfully terminated"`
            if [ "$t_done" != "" ]
            then
                t="${t_done#*after }"
                t="${t% secon*}"
                result="$t";
            else
                result="10000"
            fi
        fi
    fi
    # Prevent division by 0 errors
    if [ "$result" = "0.000" ]
    then
        result="0.001"
    fi
	OUTPUT="$result"
}


function get_execution_times_csv() {
    # print the headers
    echo -n "model"
    for alg in `ls -d */`
    do
        echo -n ",${alg%/}"
    done
    echo ""
    # print the contents
	for m in `ls results-PQ`
	do
        echo -n "$m"
        for alg in `ls -d */`
        do
            OUTPUT="-"
		    getcomptime_EF_csv "$alg$m"
            echo -n ",$OUTPUT"
        done 
        echo ""
	done
}


get_execution_times_csv > results_time.csv

