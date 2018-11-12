#!/bin/bash


imit=""

# Remove next 2 lines if the IMTITATOR file location is set
if [ "$imit" = "" ]
then
    echo "Please set the 'imit' variable to the IMITATOR binary location"
    exit
fi

timeout="60s"

# make folders if necessary
if [ -d "results" ]
then
    echo "results folder already exists, not sure if I should overwrite it so I'm going to exit!"
    exit
else
    echo "Creating folders"
    mkdir "results"
    mkdir "results/results-PQ-early-termination-incl-merge"
    mkdir "results/results-PQ"
    mkdir "results/results-PQ-incl-merge"
    mkdir "results/results-EF-incl-merge"
    mkdir "results/results-EFmin-incl-merge"
    mkdir "results/results-EFsynthmin-incl-merge"
fi

echo "Running algorithms"


for m in `ls models-global-time-param`
do
    echo $m
    if [ -e "results/results-PQ-incl-merge/${m%.imi}.txt" ]
    then
        echo "Already done!"
        continue
    fi
    model="models-global-time-param/$m"
    timeout $timeout $imit $model -mode EFsynthminpq -early-terminate -incl -merge &> "results/results-PQ-early-termination-incl-merge/${m%.imi}.txt"
    timeout $timeout $imit $model -mode EFsynthminpq &> "results/results-PQ/${m%.imi}.txt"
    timeout $timeout $imit $model -mode EFsynthminpq -incl -merge -merge-heuristic iter10 &> "results/results-PQ-incl-merge/${m%.imi}.txt"
    timeout $timeout $imit $model -mode EFmin -incl -merge &> "results/results-EFmin-incl-merge/${m%.imi}.txt"
    timeout $timeout $imit $model -mode EF -incl -merge &> "results/results-EF-incl-merge/${m%.imi}.txt"
    timeout $timeout $imit $model -mode EFsynthmin -incl -merge &> "results/results-EFsynthmin-incl-merge/${m%.imi}.txt"
done
