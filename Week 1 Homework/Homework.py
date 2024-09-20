#!/usr/bin/env python3

#30,000 reads are needed.

import sys
import numpy

genome_size = 1000000
desired_coverage = 3
read_size = 100

reads_3 = int(genome_size * desired_coverage / read_size)
genome_coverage = numpy.zeros(1000000, int)

for x in range(reads_3): 
    start_position = numpy.random.randint(0, genome_size - read_size +1)
    end_position = start_position + read_size
    genome_coverage[start_position:end_position] += 1 

numpy.savetxt("genome_coverage_3x.txt", genome_coverage)

max_coverage = max(genome_coverage)
xs = list(range(0, max_coverage +1))

poisson_estimates = scipy.stats.poisson.pmf(xs, coverage)

normal_estimates = scipy.stats.norm.pdf(xs, numpy.mean(genome_coverage), numpy.std(genome_coverage))

#For 10x coverage 
#Parameters: 
genome_size10 = 1000000
desired_coverage2 = 10
read_size10 = 100

#From the pseudocode
reads_10 = int(genome_size10 * desired_coverage2 / read_size10)
genome_coverage10 = numpy.zeros(1000000, int)

for x in range(reads_10): 
    start_position = numpy.random.randint(0, genome_size10 - read_size10 +1)
    end_position = start_position + read_size10
    genome_coverage10[start_position:end_position] += 1 

numpy.savetxt("genome_coverage_10x.txt", genome_coverage10)

max_coverage10 = max(genome_coverage10)
xs10 = list(range(0, max_coverage10 +1))

poisson_estimates10 = scipy.stats.poisson.pmf(xs10, coverage)

normal_estimates10 = scipy.stats.norm.pdf(xs10, numpy.mean(genome_coverage10), numpy.std(genome_coverage10))

#For 30x coverage 
#parameters 

genome_size30 = 1000000
desired_coverage30 = 30
read_size30 = 100

reads_30 = int(genome_size30 * desired_coverage30 / read_size30)
genome_coverage30 = numpy.zeros(1000000, int)

for x in range(reads_30): 
    start_position = numpy.random.randint(0, genome_size30 - read_size30 +1)
    end_position = start_position + read_size30
    genome_coverage30[start_position:end_position] += 1 

numpy.savetxt("genome_coverage_30x.txt", genome_coverage30)

max_coverage30 = max(genome_coverage30)
xs30 = list(range(0, max_coverage30 +1))

poisson_estimates30 = scipy.stats.poisson.pmf(xs30, coverage)

normal_estimates30 = scipy.stats.norm.pdf(xs30, numpy.mean(genome_coverage30), numpy.std(genome_coverage30))

