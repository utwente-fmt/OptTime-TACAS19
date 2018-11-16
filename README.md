# Minimal-Time Synthesis for Parametric Timed Automata

This repository hosts the results for the paper.

Please note that all experiments in the paper were performed on an
Intel Core<sup>TM</sup> i7-4710MQ processor with 2.50GHz and 7.4Gib memory,
running Debian Stretch.

Submitted to [TACAS 2019].

This work is partially supported by the ANR national research program PACS
(ANR-14-CE28-0002) and PHC Van Gogh project PAMPAS.

Authors:
---

* LIPN, Université Paris 13, Villetaneuse, France
    - Étienne André*
      [<Etienne.Andre@lipn13.fr>](mailto:Etienne.Andre@lipn13.fr)
    - Laure Petrucci
      [<Laure.Petrucci@lipn.univ-paris13.fr>](mailto:Laure.Petrucci@lipn.univ-paris13.fr)

* Formal Methods and Tools, University of Twente, The Netherlands
    - Vincent Bloemen**:
      [<v.bloemen@utwente.nl>](mailto:v.bloemen@utwente.nl)

* University of Aarhus, Denmark
    - Jaco van de Pol:
      [<jaco@cs.au.dk>](mailto:jaco@cs.au.dk)

\* Supported by ERATO HASUO Metamathematics for Systems Design Project (No. JPMJER1603), JST  
\** Supported by the 3TU.BSR project.  

Abstract
---
*Parametric timed automata (PTA) extend timed automata by allowing parameters
in clock constraints. Such a formalism is for instance useful when reasoning
about unknown delays in a timed system. Using existing techniques, a user can
synthesize the parameter constraints that allow the system to reach a
specified goal location, regardless of how much time has passed for the
internal clocks.*

*We focus on synthesizing parameters such that not only the goal location is
reached, but we also address the following questions: what is the minimal
time to reach the goal location? and for which parameter values can we achieve
this? We analyse the problem and present an algorithm that solves it. We also
discuss and provide solutions for minimizing a specific parameter value to
still reach the goal.*

*We empirically study the performance of these algorithms on a benchmark set
for PTAs and show that minimal-time reachability synthesis is more efficient to compute
than the standard synthesis algorithm for reachability.*


Installation
---

The IMITATOR version that we used can be found on GitHub under the `tacas19`
tag:
* `git clone https://github.com/imitator-model-checker/imitator.git -b tacas19`

Please read the IMITATOR web page ([https://www.imitator.fr/download.html](https://www.imitator.fr/download.html)) for instructions on how to install IMITATOR.

For post-processing of the data, we use R to create scatterplots.

Running the experiments
---

The `testall.sh` script will perform all experiments, by executing several
IMITATOR instances for every model from the `models-global-time-param`
directory , with a timeout of 60s.  Before executing this file, please make
sure to set the `imit` variable to the location of the IMITATOR binary.

Analyzing the experiments
---

Once the experiments are finished, please copy the `parse_results.sh` and
`plotresults.r` files from the `results-2018-11-08` directory to the newly
created `results` directory.

Then, A CSV file, containing the experimental results, is created by executing
the `parse_results.sh` file. This CSV file can then be used to create
scatterplot images by running the `plotresults.r` file.


Data
---

The data present in the `results-2018-11-08` directory has been created with a
timeout of 3600s on the mentioned computer architecture.


[TACAS 2019]: https://conf.researchr.org/track/etaps-2019/tacas-2019-papers









