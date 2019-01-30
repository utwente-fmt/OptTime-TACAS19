#!/usr/bin/env python
import os.path
import csv
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
from matplotlib.ticker import ScalarFormatter


def alglabel(algname):
	if algname == "results-EF-incl-merge": return "Time Synth (sec)"
	elif algname == "results-PQ-incl-merge": return "Time MTSynth (sec)"
	elif algname == "results-EFmin-incl-merge": return "Time MPReach (sec)"
	elif algname == "results-EFsynthmin-incl-merge": return "Time MPSynth (sec)"
	elif algname == "results-PQ": return "Time MTSynth-noRed (sec)"
	elif algname == "results-PQ-early-termination-incl-merge": return "Time MTReach (sec)"

def checkfile(file):
    if not (os.path.isfile(file)):
        print "ERROR: cannot find file: {}".format(file)
        sys.exit()

def makeplot(file, alg_a, alg_b):
	f = open(file, 'rb')
	reader = csv.DictReader(f)
	# parse the times from the results file
	xvals = []
	yvals = []
	for row in reader:
		# check if there are values for both alg_a and alg_b, otherwise don't add
		if alg_a in row and alg_b in row:
			xvals.append(float(row[alg_a]))
			yvals.append(float(row[alg_b]))
	f.close()
	# Plot
	plt.scatter(xvals, yvals, marker='x', s=100)
	plt.plot([0.0005,20000], [0.0005,20000], c='black')
	plt.plot([0.0005,20000], [10000,10000], c='red', linestyle='dashed')
	plt.plot([10000,10000], [0.0005,20000], c='red', linestyle='dashed')
	plt.grid(color='grey', linestyle='-', linewidth=0.3)
	plt.xticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
	plt.yticks([0.001, 0.01, 0.1, 1, 10, 100, 1000])
	plt.xlim(0.0005,20000)
	plt.ylim(0.0005,20000)
	plt.yscale('log')
	plt.xscale('log')
	#plt.title('Scatterplot comparison of different algorithm configurations.')
	plt.xlabel(alglabel(alg_a))
	plt.ylabel(alglabel(alg_b))


def main():
    INFILE  = "results_time.csv"
    checkfile(INFILE) # does the file exist?
    plt.figure(figsize=(8, 10))
    plt.subplot(3, 2, 1)
    makeplot(INFILE, "results-PQ-incl-merge", "results-EF-incl-merge")
    plt.subplot(3, 2, 2)
    makeplot(INFILE, "results-EFsynthmin-incl-merge", "results-EF-incl-merge")
    plt.subplot(3, 2, 3)
    makeplot(INFILE, "results-PQ-incl-merge", "results-EFsynthmin-incl-merge")
    plt.subplot(3, 2, 4)
    makeplot(INFILE, "results-PQ-incl-merge", "results-PQ")
    plt.subplot(3, 2, 5)
    makeplot(INFILE, "results-PQ-early-termination-incl-merge", "results-PQ-incl-merge")
    plt.subplot(3, 2, 6)
    makeplot(INFILE, "results-EFmin-incl-merge", "results-EFsynthmin-incl-merge")
    plt.tight_layout()
    plt.savefig('plots.pdf', dpi='figure')


if __name__ == "__main__":
    main()
