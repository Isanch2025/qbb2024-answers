library("tidyverse")

df <- read_tsv("~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")

df <- df %>%
  mutate( SUBJECT=str_extract( SAMPID, "[^-]+-[^-]+" ), .before=1 )

commonSubjects <- df %>%
  group_by( SUBJECT ) %>%
  summarize( count = n() ) %>%
  arrange( desc( count ) )
#K-562 and GTEx_npj8 have the most samples while GTEX-1JMI6 and GTEX-1PAR6 have the least 
df <- df %>%
  mutate( SUBJECT=str_extract( SAMPID, "[^-]+-[^-]+" ), .before=1 )
commontissues <- df %>% 
  group_by( SMTSD ) %>%
  summarize( count=n() ) %>%
  arrange( desc( count ) )
#Whole Blood and Muscle-Skeletal have the most samples while Kidney-Mudella and Cervix-Ectocervix have the least
#
df_npj8 <- subset( df, SUBJECT== "GTEX-NPJ8" ) %>%
  group_by( SMTSD ) %>%
  summarize( count = n() ) %>%
  arrange( desc( count ) )

SMATSSCR <- df %>%
  filter( !is.na(SMATSSCR) ) %>%
  group_by( SUBJECT ) %>%
  summarize(meanSM=mean(SMATSSCR))

sum(SMATSSCR$meanSM ==0 ) #There are 15 subjects with a SMATSSCR score of 0 



