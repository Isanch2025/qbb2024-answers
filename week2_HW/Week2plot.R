library(tidyverse)
library(dplyr)
library(ggplot2)

my_data <- read_tsv("~/qbb2024-answers/week2_HW/snp_counts.txt")
View(my_data)

ggplot(data = my_data,
       mapping = aes(
         x = MAF, 
         y = log2(Enrichment), 
         color = Feature
       )
) + 
  geom_line() + 
  xlab("Minor Allele Frequency") + 
  ylab("SNP (Log2) Enrichment") + 
  scale_color_discrete(labels = c("cCREs", "Exons", "Introns", "Other"))

