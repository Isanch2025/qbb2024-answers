# Homework Week 5 # 

## Exercise 1 ## 
Step 1.1 -> When looking at the data in FASTseq the per base sequence content and GC content stand out as slightly problematic. However a possible reason for the higher GC content and base content at beginning of sequences is the primer sequences being used to gather this data. The primers could be the reason. 

Step 1.2 -> 

## Exercise 2 ## 
Question 1 -> Based upon the multiQC file, the number of samples with at least a 45% unique reads would be 15. 
Question 2 -> Additionally the blocks of triplicates were clearly distinguishable giving the idea that there was a high amount of consistancy between each set of replicates. 

## Exercise 3 ## 

Question 3.3 -> The original PCA plot had some issues, mainly the clusters Fe and LFC-FE. In these clusters it seems two of the replicates had been swapped: LFC-FE rep 3 and Fe rep 1. So to fix this in the following step we will convert to a matrix and swap the data columns. 

Question 3.5 -> The categories of enrichment make sense if the dataset was taken from the fly midgut, because the analysis revealed proteolysis as the number 1 overrepresented group followed by 'protein metabolic process' and 'metabolic process.' So for samples taken from the midgut where they would likely be producing lots of enzymes, it would make sense that the data has proteolysis. 