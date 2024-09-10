library(tidyverse)

expression <- read_tsv("dicts_expr.tsv")

#Glimpse data
glimpse(expression)

expression <- expression %>%
  mutate(Tissue_Data = paste0(Tissue, " ", GeneID)) %>%
  mutate(Log2_Expr = log2(Expr + 1))

#violin plot of expression data
ggplot(data = expression, mapping = aes(x = Tissue_Data, y = Log2_Expr)) + 
  geom_violin() +
  coord_flip() +
  labs(x = "Tissue Type + Gene", y = "Log 2 Gene Expression")


ggplot(data = expression, 
       mapping = aes(x = Log2_Expr, y = Tissue_Data))
