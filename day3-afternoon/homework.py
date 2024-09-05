#!/usr/bin/env python3

import sys 

import numpy

fs = open(sys.argv[1], mode='r')


#skip 2 lines
fs.readline()
fs.readline()

line = fs.readline()
# split column header by tabs and skip first two entries
fields = line.strip("\n").split("\t")
tissues = fields[2:]
# create way to hold gene names 
gene_names = []
gene_IDs = []
# create way to hold expression values 
expression = []

# for each line
for line in fs: 
    #     split line 
    fields = line.strip("\n").split("\t")
    #     save field 0 into gene IDS
    gene_IDs.append(fields[0])
    #     save field 1 into gene names 
    gene_names.append(fields[0])
    #     save 2+ into expression values 
    expression.append(fields[2:])
fs.close()

tissues = numpy.array(tissues)
gene_IDs = numpy.array(gene_IDs)
gene_names = numpy.array(gene_names)
gene_expression = numpy.array(expression, dtype=float)
# We need to tell numpy the type of expression data because 
# print(tissues)
# print(gene_IDs)
# print(gene_names)
# print(expression)

# #For 4 -> (we can't answer if its different than nested approach)
# mean_express = numpy.mean(expression[:10,:], axis=1 )
# print(mean_express)

#For 5-> The mean of the entire expression is 16.557814350910945 and the median is 0.0271075 which means we can infer that there is a differential expression of a select number of genes. 
# An overwhelming number of genes have low expression values while a select few genes have heightened levels of expression.
# mean_express = numpy.mean(expression)
# median_expression = numpy.median(expression)
# print(mean_express)
# print(median_expression)

#For number 6 -> 
log_express = numpy.log2(gene_expression + 1)
# # log_mean_express = numpy.mean(log_express)
# # log_median_expression = numpy.median(log_express)

# # For number 7 _> 

number7_express = numpy.copy(log_express)
sorted_number7_express_ax1 = numpy.sort(number7_express, axis=1)
diff_array = sorted_number7_express_ax1[:,-1] - sorted_number7_express_ax1[:,-2]
# print(diff_array)

high_tissue = numpy.where(diff_array > 10)
high_tissue_size = numpy.size(high_tissue)
print(high_tissue_size)
