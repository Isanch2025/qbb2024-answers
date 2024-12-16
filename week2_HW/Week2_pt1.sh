#!/bin/bash

#Exercise 1: Obtain the data
#Step 1.4 Use bedtools to merge elements within each feature file 

bedtools sort -i Chr1_genes.bed > sorted_genes_chr1.bed

bedtools merge -i sorted_genes_chr1.bed > merged_sorted_genes_chr1.bed

bedtools sort -i Exons-3.bed > sorted_exons_chr1.bed 


bedtools merge -i sorted_exons_chr1.bed > merged_sorted_exons_chr1.bed


bedtools sort -i Chr1_CCres.bed > sorted_ccres_chr1.bed

bedtools merge -i sorted_ccres_chr1.bed > merged_sorted_ccres_chr1.bed


#Step 1.5 Use bedtools to create intron feature file

bedtools subtract -a merged_sorted_genes_chr1.bed -b merged_sorted_exons_chr1.bed > introns_chr1.bed

# Step 1.6 Use bedtools to find intervals not covered by other features

bedtools subtract -a genome_chr1.bed -b introns_chr1.bed -b merged_sorted_exons_chr1.bed -b merged_sorted_ccres_chr1.bed > other_chr1.bed

