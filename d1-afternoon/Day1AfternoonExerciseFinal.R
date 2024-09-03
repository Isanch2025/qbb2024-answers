#Number 1
library(tidyverse)
df <- read_delim("~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")
# NUmber 2
glimpse (df)

# SMGEBTCHT <- df %>%
#   filter(SMGEBTCHT == "TruSeq.v1") %>%
#   group_by(SMTSD) %>%
#   summarize( count = n() ) %>%
#   arrange (-(count))
#
#Number 3
SMGEBTCHT <- df %>%
  filter(SMGEBTCHT == "TruSeq.v1")
#Number4
ggplot(data=SMGEBTCHT, mapping = aes( x=SMTSD )) + 
  geom_bar()
#Number 5
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN)) +
  geom_histogram(binwidth=0.1)
#Number 6
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN, color=SMTS)) +
  geom_density()
#Number 7
ggplot(data=SMGEBTCHT, mapping=aes(x=SMGNSDTC, y=SMTS)) +
  geom_boxplot()
#Number 8
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN, y=SMTSISCH)) +
  geom_point(size = 0.5,alpha = 0.5)+
  facet_wrap(.~SMTSD)+
  geom_smooth(method = "lm")
#Number 9
ggplot(data=SMGEBTCHT, mapping=aes(x=SMRIN, y=SMTSISCH)) +
  geom_point(aes(color = SMATSSCR), size = 0.5,alpha = 0.5)+
  facet_wrap(.~SMTSD)+
  geom_smooth(method = "lm")


