#!/usr/bin/env python3

#import packages, and set up environment 
import sys
import numpy
#get first file from user input, should be gene tissue data
filename = sys.argv[1]
#open that file
fs = open(sys.argv[1])

#create dict to hold samples for gene-tissue pairs
relevant_samples = {}
# #step through file
for line in fs: 
#     #split line in file on tabs 
    fields = line.rstrip("\n").split("\t")
    
#     #create key from gene and tissue 
    key = (fields[0], fields[2])
    
#     #intialize dictionary element with key 
# value is list with list to hold samples
    relevant_samples[key] = []
print(relevant_samples)
#close file
fs.close()

#get metadata file
metadatafile = sys.argv[2]
fs = open(sys.argv[2])
#skip line 
fs.readline()
#create dict to hold smapels for gene-tissue pairs
tissue_samples = {}
#step through file
for line in fs: 
    #split line into fields
    fields = line.rstrip("\n").split("\t")
    #create key from gene and tissue 
    key = fields[6]
    value = fields[0]
    #intialize dict from key with list to hold samples
    tissue_samples.setdefault(key, [])
    tissue_samples[key].append(value)
print(tissue_samples)
fs.close()

another_one = sys.argv[3]
fs = open(sys.argv[3])
#skip line 
fs.readline()
fs.readline()

#Get sample IDs 
header = fs.readline().rstrip("\n").split("\t")
header = header[2:]
#Intialize dictionary to hold indices of samples associated with tissues
tissue_columns = {}
#Retrieve values and keys from tissue_samples dictionary 
for tissue, samples in tissue_samples.items():
#Making new entry in the dictionary for new tissues
    tissue_columns.setdefault(tissue, [])
#Step through relevent samples from tissue_samples dictionary
    for sample in samples:
#If sample present in gene expression data, keep track of column index 
        if sample in header:
            position = header.index(sample)
            tissue_columns[tissue].append(position) 
            #this makes a list of samples that corresponds to keys that are created by the tissue types.
print(header)
fs.close()

#Next step: get the length of the lists of sample columns (8)

for key, value in tissue_columns.items(): 
  #print out each key and length of the value in the dictionary
  print(key, len(value)) 
# top 3 tissue types are Muscle-Skeletal (803), Skin - Sun Exposed (Lower leg) (701), Whole Blood (755)
#Bottom 3 tissue types are Cells - Leukemia cell line (CML) 0, Kidney - Medulla 4, and Cervix - Ectocervix 9



