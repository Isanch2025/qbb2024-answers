library(tidyverse)
library(broom)

dnm <- read_csv(file = "~/qbb2024-answers/day4-morning/aau1043_dnm.csv")
ages <-read_csv(file = "~/qbb2024-answers/day4-morning/aau1043_parental_age.csv") 

dnm_summary <- dnm %>%
  group_by(Proband_id) %>%
  summarize(n_paternal_dnm = sum(Phase_combined == "father", na.rm = TRUE), 
            n_maternal_dnm = sum(Phase_combined == "mother", na.rm = TRUE))

dnm_by_parental_age <- left_join(dnm_summary, ages, by = "Proband_id")

ggplot(data = dnm_by_parental_age, mapping = aes(x = Mother_age, y= n_maternal_dnm)) +
  geom_point()

ggplot(data = dnm_by_parental_age, mapping = aes(x = Father_age, y = n_paternal_dnm)) +
  geom_point()

 #exercise 2.2
mother_model <- lm(data = dnm_by_parental_age, 
                 formula = n_maternal_dnm ~ 1 + Mother_age)
summary(mother_model)
#the size of this relationship is the 0.37757 which is the slope of this relationship
# This size or slope of the relationship is referring to the correlation between our two variables in this case, the the count of maternal de novo mutations and maternal age
#This realtionship is significant based upon the p-value and the R^2 value of 0.2255. The p-value is the percent chance that these results are due to chance and because it is small means the relationship is significant.
# slope is size, R^2 is strength 

#exercise 2.3
father_model <- lm(data = dnm_by_parental_age, 
                   formula = n_paternal_dnm ~ 1 + Father_age)
summary(father_model)
#the size of this relationship is the 1.35384 which is the slope of this relationship
#Again the slope is referring to the correlation between paternal age and count of paternal de novo mutations. 
#This realtionship is significant based upon the p-value and the R^2 value of 0.6178. The p-value is the percent chance that these results are due to chance and because it is small means the relationship is significant. 

new_proband <- tibble(
  Father_age = 50.5
)

print(predict(father_model, new_proband))

#exercise 2.5
ggplot(data + dnm_by_parental_age) +
  geom_
