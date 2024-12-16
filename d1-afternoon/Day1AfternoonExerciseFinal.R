#Number 1
library(tidyverse)
df <- read_delim("~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")
# Number 2
glimpse (df) 
#Number 3
SMGEBTCHT <- df %>%
  filter(SMGEBTCHT == "TruSeq.v1")
#Number4
ggplot(data=SMGEBTCHT, mapping = aes( x=SMTSD )) + 
  geom_bar() + 
  theme(axis.text.x = element_text(angle = -90))
  xlab("Tissue Type") + 
  ylab("Sample Count") +
  ggtitle("Relationship between Sample Count and Tissue Type")
#Number 5
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN)) +
  geom_histogram(binwidth=0.1) +
  xlab("RNA Integrity Number") + 
  ylab("Number of Samples") +
  ggtitle("Number of Samples and RNA Integrity")
#In the the code for number 5 I used a histogram to plot the data because i think it best visualized the distribution
# In the following graph the distribution appeared unimodal with slight outliers at the RIN value of 10. 
#Number 6
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN, y=SMTS)) +
  geom_boxplot() +
  xlab("RNA Integrity Number") + 
  ylab("Types of Tissue Samples") +
  ggtitle("Relationship between Tissue Types and RNA Integrity")
# After some discussion I decided to use a boxplot to display the distributions across multiple groups. 
# In observing the boxplots, many of the average RIN values for most samples were weighted towards the range of 6~8. 
# When observing samples gathered from bone marrow it had the tightest spread of values and an average RIN value of nearly 10. 
# My hypothesis for this outlier might have to do with how rapidly the samples were used after retrieving from the subject. There is a high probability that the sampel taken from the bone marrow were used first possibly because storage due to the fragility of the samples was complicated.
#Number 7
ggplot(data=SMGEBTCHT, mapping=aes(x=SMGNSDTC, y=SMTS)) +
  geom_boxplot() +
  xlab("Number of Genes Detected per Sample") + 
  ylab("Types of Tissue Samples") +
  ggtitle("Relationship between Tissue Type and Genes Detected")
#Again similar to number 8 I used a boxplot to visualize the data. 
#When looking at the data I noticed an outlier in the number of genes detected in the samples taken from the Testes. 
#To possibly explain the outlier of the testes: the samples taken from the testes could be cells that are pluripotent and express the largest number of genes of any mammalian organ.
#Number 8
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN, y=SMTSISCH)) +
  geom_point(size = 0.5,alpha = 0.5)+
  facet_wrap(.~SMTSD)+
  geom_smooth(method = "lm") +
  xlab("RNA Integrity Number") + 
  ylab("Ischemic time") +
  ggtitle("Relationship between Ischemic Time and RNA Integrity")
#To visualize this massive dataset I used a scatterplot, and notice a majority of the tissue samples had downtrending in ischemic time compared to the RNA integrity. 
#In many of the tissues the higher RNA integirty seems to be correlated with lower ischemic times and this relationship seems to be conserved across many of the different tissue types. 
#Number 9
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN, y=SMTSISCH)) +
  geom_point(aes(color = SMATSSCR), size = 0.5,alpha = 0.5)+
  facet_wrap(.~SMTSD)+
  geom_smooth(method = "lm") +
  xlab("RNA Integrity Number") + 
  ylab("Ischemic time") +
  ggtitle("Relationship between Ischemic Time and RNA Integrity")
#When looking at the data points with higher SMATSSCR scores they seemed to also be data points from higher ischemic times and therefore lower overall RNA integrity. 
#Although it was quite difficult to extract a lot of information from this data set. 

#Number 10: I finished at 6 and I'm currently revising this at 10 pm so I did not finish in time for this question. 

