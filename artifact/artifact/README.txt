#######################
# Additional sofware: #
#######################

We use a static binary of the IMITATOR tool to compute the results for the
experiments, so no additional software is required for the experiments.
For processing the results, we have a python script that uses the matplotlib
library (in the original paper we used an R script, but since we were not able
to get this installed in a VM, we created a python script that does the same).
We install the Python packages pip, python-tk, and python-matplotlib as follows:

$ cd ./artifact/packages
$ sudo dpkg -i *.deb
$ cd ../..

############################
# Running the experiments: #
############################

We have set up a bash script that will run all experiments (i.e. running each
combination of algorithm and model), which can be executed as follows:

$ cd ./artifact/experiments
$ chmod +x imitator
$ chmod +x testall.sh
$ ./testall.sh

This will take some time to complete. We have set the timeout to 60 seconds per
algorithm-model combination, which results in 6x68 experiments, or a maximum of
408 minutes. But many of the experiments will be computed in a fraction of that
time. In our setting (Intel Core i7-4710MQ processor with 2.50GHz and 7.4GiB
memory, using a single thread), this took about 180 minutes. If that takes too
long, you can edit the testall.sh script to set the timeout to 10 seconds (then
the experiments run in about 40 minutes), but then most interesting results
will be omitted.
The results in the paper have been produced in our setting with a timeout of
3,600 seconds, but we consider a timeout of 60 seconds to be sufficient.

############################
# Visualizing the results: #
############################

We compare the algorithm's run times for each model. We first create a CSV file
that contains all runtimes, and then use a python script to generate a PDF file
that contains the plots. These plots should be similar to the ones in the paper
(Fig. 4). The scripts are executed as follows:

$ cd ./artifact/experiments
$ chmod +x parse_results.sh
$ ./parse_results.sh
$ python plotresults.py


##########################
# Analysing the results: #
##########################

The plots.pdf file contains the resulting scatterplots that compares the
run times of algorithms on each model. The most interesting result is the
top-left plot, which should show that the MTSynth algorithm is almost always
equally fast or faster than the Synth algorithm. To a lesser extend this is
also the case for MPSynth and Synth (top-right). And in the middle-left plot we
see that the MTSynth is almost always faster than MPSynth.



