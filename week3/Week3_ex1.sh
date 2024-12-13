#!/bin/bash

head -n 4 A01_09.fastq | tail -n 1 | tr -d '\n' | wc -c
#Orginally I did not include the tr -d '/n' but after realizing there were some discrepanciees in my output, I knew I had to remove the new line characters at the end of the line. 
#But the code is just grabbing the first four lines and extracting the second part of each line and counting the number of characters. 

#Question 1.1: How long are the sequencing reads?
    #Using the code above, there are 76 nucleotides in the reads. 

#Question 1.2. How many reads are present within the file?
wc -l A01_09.fastq | bc -l -e  "(2678192) / 4"
    #The total number of reads based on the code is 669,548. The code counted the total number of lines first, then divided by 4 (for the number of reads). 

#Question 1.3: Given your answers to 1 and 2, as well as knowledge of the length of the S. cerevisiae reference genome, what is the expected average depth of coverage?
bc -l -e "(669548 * 76) / 12157000"
#This multiplies the number of reads by the read length and dividing by the genome. 
#The expected avergae depth of coverage is 4 times. 

#Question 1.4: Which sample has the largest file size (and what is that file size, in megabytes)? Which sample has the smallest file size (and what is that file size, in megabytes)?

du -h *.fastq | sort -rh | head -n 1
#To find the largest file, use this. 
#The largest file is A01_62.fastq at 149M 

du -h *.fastq | sort -h | head -n 1
#To find the smallest file, use this bit of code. 
# The smallest file is A01_27.fastq at 110M. 

#Question 1.5: Run the program FastQC on your samples (with default settings). Open the HTML report for sample A01_09.
fastqc A01_09.fastq

#The median base quality score along the reads is about 35~36. This means that based on the formula given in the slides 10 ^ (-Quality score / 10), the probability for error is 0.0003162, which is very low. 
#As for the variation in quality based on the position in the read, there were a few outliers present at the starting and ending positions but overall there was little variation in quality across the positions in the reads. 
