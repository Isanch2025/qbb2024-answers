#!/bin/bash

#After downloading the data, 
grep ">" sacCer3.fa | wc -l
#We can use the grep function to search for lines starting with > for chromosome 
#Question 2.1: How many chromosomes are in the yeast genome?
    #There are 17 chromosomes in the yeast genome

#Step 2.2: Align your reads to the reference ~ Step 2.5: Visualize your alignments

for Alignment in $(ls ./A01_*.fastq)
do
    Sample_Names=$(basename ${Alignment} .fastq)
    bwa mem -t 4 -R "@RG\tID:${Sample_Names}\tSM:${Sample_Names}" sacCer3.fa ${Alignment} > ${Sample_Names}.sam
    samtools sort -@ 4 -O bam -o ${Sample_Names}.bam ${Sample_Names}.sam
    samtools index ${Sample_Names}.bam
done
#Ok hopefully everything works, its a for loop going through my directory and grabbing the names of each sample read, 
#And then using bwa men to align the reads to the reference genome and then uses sam tools to sort and convert them to bam files 
#Finally saving them to an index. (everything seems to work)

#Step 2.3: Sanity check your alignments
#Question 2.2: How many total read alignments are recorded in the SAM file?
grep -v "^@" A01_09.sam | wc -l
#This code looks through the file only grabbing the alignments counts them 
    #There are 669548 total read alignments.

#Question 2.3: How many of the alignments are to loci on chromosome III?
sed '1,20d' A01_09.sam | grep -w "chrIII" | wc -l
#Using this code we can skip the first twenty lines which were header information and then grabbing the rest of the information and counting the lines 
    #There were 18195 alignments to the loci on chromosome III. 

#Question 2.4: Does the depth of coverage appear to match that which you estimated in Step 1.3? Why or why not?
#After opening IGV and scanning through the alignments I found that the depth of coverage appears to match what I answered previously (4) and there are some outlier areas that have either more or less coverage than expected but overall the coverage is about what I calculated. 

#Question 2.5: Set your window to chrI:113113-113343 (paste that string in the search bar and click enter). How many SNPs do you observe in this window? Are there any SNPs about which you are uncertain? Explain your answer.
    #There are three SNPs observed at this range and two of them have the correct amount of coverage but there is one that has less coverage than the other two casting some doubt and speculatation on this SNP. 

#Question 2.6: Set your window to chrIV:825548-825931. What is the position of the SNP in this window? Does this SNP fall within a gene?
    #This SNP is positioned at 825.834 on chromosome 4. 
    
