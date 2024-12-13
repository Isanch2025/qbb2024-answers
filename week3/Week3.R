library(ggplot2)
library(tidyverse)

#First the allele frequency plot 

AF_data = read_tsv("~/qbb2024-answers/week3/AF.txt")
ggplot(data = AF_data, aes(x = `Allele Frequencies`)) +
  geom_histogram(bins = 11, fill = "red") +
  labs(x = "Allele Frequency", y = "Variation Count", title = "Distribution of Allele Frequency ")

#Question 3.1: Interpret this figure in two or three sentences in your own words. Does it look as expected? Why or why not? Bonus: what is the name of this distribution?
  #This figure has a normal distribution with an average allele frequency right around 0.50. This distribution is to be expected because SNPs are not in coding parts of the genome meaning they are not highly selected for or against. 
  #However at the right part of the graph at a value of 1 are likely SNPs that are selected for. 

#Then code for the read depth 
DP_data = read_tsv("~/qbb2024-answers/week3/DP.txt")
ggplot(data = DP_data, aes(x = `Read Depth of Each Variant`)) +
  geom_histogram(bins = 21, fill = "purple") +
  xlim(0, 20) +
  labs(x = "Coverage", y = "Variation Count", title = "Distribution of Read Depth across SNPs")

#Question 3.2: Interpret this figure in two or three sentences in your own words. Does it look as expected? Why or why not? Bonus: what is the name of this distribution?
  #In this figure we see a poisson distribution and this is the expected outcome. The distribution is centered around a read depth of 4, which is the calculated read depth from earlier in the assignment. 