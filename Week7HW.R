
#Step 1.1: Loading data and importing libraries
library(tidyverse)
library(broom)
library(DESeq2)

setwd("~/qbb2024-answers/week_7/")

counts_df <- read_delim("gtex_whole_blood_counts_downsample.txt")
metadata_df <- read_delim("gtex_metadata_downsample.txt")

counts_df <- column_to_rownames(counts_df, var = "GENE_NAME")
metadata_df <- column_to_rownames(metadata_df, var = "SUBJECT_ID")

# Check the match between column from counts data and row from metadata 
table(colnames(counts_df) == rownames(metadata_df)) #it said true 

# Step 1.2: Create a DESeq2 object
dds <- DESeqDataSetFromMatrix(countData = counts_df,
                              colData = metadata_df,
                              design = ~ SEX + DTHHRDY + AGE)

#Step 1.3: Normalization and PCA
vsd <- vst(dds)

plotPCA(vsd, intgroup = "SEX")
plotPCA(vsd, intgroup = "DTHHRDY")
plotPCA(vsd, intgroup = "AGE")

#Question 1.3.3: What proportion of variance in the gene expression data is explained by each of the first two principal components?
  # 48% of the variance can be explained by PC1 and 7% of the variance is explained by PC2. 

#Question 1.3.3: Which principal components appear to be associated with which subject-level variables?
  # It appears that PC1 which explains 48% of the variance is closely associated with the cause of death or DTHHRDY variable. However, PC2 which explained much less of the variance, wasn't as closely associated with any of the subject groups, the closest group was the age varaible. 

# Exercise 2: Perform differential expression analysis
#Step 2.1: Perform a “homemade” test for differential expression between the sexes

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()
vsd_df <- bind_cols(metadata_df, vsd_df)

m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
#2.1.1: Does WASH7P show significant evidence of sex-differential expression (and if so, in which direction)? Explain your answer.
  # The p-value of the gene is 0.27924 which is not significant as it is below the threshold of 0.05. 

lm(data = vsd_df, formula = SLC25A47 ~ SEX + DTHHRDY + AGE) %>%
  summary() %>%
  tidy()
# 2.1.2: Now repeat your analysis for the gene SLC25A47. Does this gene show evidence of sex-differential expression (and if so, in which direction)? Explain your answer.
  # The p-value of the gene is 0.0257 which is below the threshold for significance (p = 0.05), meaning it is significant. Additionally the estimated value <dbl> of 0.518 gives evidence that this differential expression is driven towards the males rather than the females. 

#Step 2.2: Perform differential expression analysis “the right way” with DESeq2
dds <- DESeq(dds)

# Step 2.3: Extract and interpret the results for sex differential expression
Sex_results <- results(dds, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_NAME")

Sex_results <- Sex_results %>%
  filter(!is.na(padj)) %>%
  arrange(padj)

Locations <- read_delim("gene_locations.txt")

Sex_results <- left_join(Sex_results, Locations, by = "GENE_NAME")

#2.3.2: How many genes exhibit significant differential expression between males and females at a 10% FDR?
View(Sex_results)
Question_answer <- Sex_results %>%
  filter(padj < 0.1)
Gene_count = nrow(Question_answer)
View(Gene_count)
# this code gives a value of 262, meaning there's 262 genes that exhibit significant differential expression between males and females at a 10% FDR?

#2.3.3: Examine your top hits. Which chromosomes encode the genes that are most strongly upregulated in males versus females, respectively? Are there more male-upregulated genes or female-upregulated genes near the top of the list? Interpret these results in your own words.
  #Unsuprisingly the chromosome that encodes the genes most strongly unregulated in males vs females is the Y chromosome which is only present in males. In fact the male-upregulated genes far outway the female-upregulated genes at the top of the list. 

#2.3.4: Examine the results for the two genes (WASH7P and SLC25A47) that you had previously tested with the basic linear regression model in step 2.1. Are the results broadly consistent?
  # The new results for the two genes are still consistent with the previous testing. The WASH7P still shows no statistical significance and SLC25A47 (which is associated with the X chromosome) is significant for sex differential expression. 

#Step 2.4: Extract and interpret the results for differential expression by death classification
Death_results <- results(dds, name = "DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes") %>%
  as_tibble(rownames = "GENE_NAME")

Death_results <- Death_results %>%
  filter(!is.na(padj)) %>%
  arrange(padj)

Death_results <- left_join(Death_results, Locations, by = "GENE_NAME")

View(Death_results)
Question_answer2 <- Death_results %>%
  filter(padj < 0.1)
Gene_count2 = nrow(Question_answer2)
View(Gene_count2)

#2.4.1: How many genes are differentially expressed according to death classification at a 10% FDR?
  # Based on my work it said there were about 16857 genes differentially expressed according to death classification at a 10% FDR? (this is a bit weird because talking with some of my classmates this is a bit higher than they had)

#2.4.2: Interpret this result in your own words. Given your previous analyses, does it make sense that there would be more genes differentially expressed based on type of death compared to the number of genes differentially expressed according to sex?
  # Yes it makes sense for there to be a larger amount of genes differentially expressed based upon the type of death compared to sex because the variety and complexity of genes related to death far outweighs the amount of genes differentially expressed according to sex. The processes involved in different death types allow for a larger amount of genes to be expressed. 

#Exercise 3: Visualization

ggplot(data = Sex_results, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(aes(color = (abs(log2FoldChange) > 2 & padj < 1e-20))) +
  geom_text(data = Sex_results %>% filter(abs(log2FoldChange) > 2 & padj < 1e-50),
            aes(x = log2FoldChange, y = -log10(padj) + 5, label = GENE_NAME), size = 3,) +
  theme_bw() +
  theme(legend.position = "none") +
  scale_color_manual(values = c("darkgray", "coral")) +
  labs(y = expression(-log[10]("adjusted p-value")), x = expression(log[2]("fold change"))) +
  ggtitle("Differential Gene Expression by Sex")



