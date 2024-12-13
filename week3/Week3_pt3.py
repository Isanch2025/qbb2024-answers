#!/usr/bin/env python3

import sys
import numpy

allele_frequency_doc = open('AF.txt', mode = 'w') 
allele_frequency_doc.write("Allele Frequencies\n")  
#First we can create an empty file to nest everything we pull out of the VCF file.


#Step 3.1: Parse the VCF file
#For these analyses, you’ll have to parse the VCF file that we provided. If you can find a python library that handles VCF parsing, you’re welcome to use it, but it may be easier to simply use the following structure:
for line in open(sys.argv[1], "r"):
    if line.startswith('#'):
        continue
    fields = line.rstrip('\n').split('\t')
    info_field = fields[7].split(";")                                     
    allele_frequency = info_field[3].lstrip("AF=")                       
    allele_frequency_doc.write(allele_frequency + '\n')                 
allele_frequency_doc.close()

#This for loop seems to work (had to troubleshoot a bit to extract the Info column and split it)
#But overall the for loop works by using the startign code given to us and then using the split fields and output all of the allele frequencies and then remove the AF= leaving only our value.


read_depth_doc = open('DP.txt', mode = 'w')                                   
read_depth_doc.write("Read Depth of Each Variant\n")                         

for line in open(sys.argv[1], "r"):                                       
    if line.startswith('#'):                                              
        continue
    fields = line.rstrip('\n').split('\t')                             
    for format_field in fields[9:]:                                     
        sample_data = format_field.split(':')                             
        read_depth = sample_data[2]                                       
        read_depth_doc.write(read_depth + '\n')                               
read_depth_doc.close() 

#Using our exact same logic as the previous for loop, just nesting an additional for loop to go through the fields starting at 9 and split these fields by a colon. 
#by doing that it gives us a file we can use. 