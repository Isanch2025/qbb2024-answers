#!/usr/bin/env python3

import sys

my_file = open( sys.argv[1] )

for my_line in my_file:
    fields = my_line.split("\t")
    chrom=fields[0]
    start=fields[3]
    stop=fields[4]
    gene_names = fields[-1].split(';')[2].rstrip("\"").lstrip("gene_name \"")
    print(chrom + "\t" + start + "\t" + stop + "\t" + gene_names)


    # print(chrom + "\t" + start + "\t" + stop) 
    # if fields[2] == "gene": 
    #     fc = fields[8].split(';')
    #     gene_name = fc[2].rstrip("\"").lstrip("gene_name \"")
    #     print(fields[0] + "\t" + fields[3] + "\t" + fields[4] + "\t" + gene_name)
