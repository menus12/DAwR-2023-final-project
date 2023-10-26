# Setting working directory
setwd("$pwd/DAwR-2023-final-project")

# Loading required libraries
library(readxl)
library(tidyverse)
library(readr)

# Loading excel sheets 
frame1 <- read_excel("Datafiles/participants100.xlsx")
frame2 <- read_excel("Datafiles/participants200.xlsx")
frame3 <- read_excel("Datafiles/participants300.xlsx")

# Merging all sheets into a single dataframe
esim_data <- rbind(frame1, frame2, frame3)

# Exploring dataframe columns
glimpse(esim_data)

# Taking random 20 rows sample
sample <- esim_data[sample(nrow(esim_data), 20), ]
sample

# Exploring unique values for variables

# How many different values for medals
length(unique(esim_data$medal))
# What are the types of medals 
unique(esim_data$medal)

# How many different values for roles?
length(unique(esim_data$ChampRole))
# What are the competition roles?
unique(esim_data$ChampRole)
# there are some roles, but this data doesn't make much sense in current context

# How many teams identifiers in the dataset
length(unique(esim_data$fk_command)) 
# What are the values
head(unique(esim_data$fk_command),n = 10)
# might be useful for interpreting results

# How many organizations represented by competitors in the dataset?
length(unique(esim_data$organization))
unique(esim_data$organization) 
# variable is useless

# How many unique values in nok column?
length(unique(esim_data$nok))
# What are these unique values?
unique(esim_data$nok)
# Is there any results marked with nok=1 identifier?
length(esim_data$nok[esim_data$nok == "1"]) 
# at least 207 observaions are for demonstration exams

# How many unique values?
length(unique(esim_data$excludeFromResault))
# What are the values?
unique(esim_data$excludeFromResault)
# How many results with non-NA value?
nrow(esim_data %>% filter(!is.na(excludeFromResault)))
# Check consistency between provided values
tail(esim_data  %>% 
       filter(excludeFromResault == "YES") %>% 
       select(mark100, mark500, mark700, excludeFromResault))
tail(esim_data  %>% 
       filter(excludeFromResault == "N") %>% 
       select(mark100, mark500, mark700, excludeFromResault))
tail(esim_data  %>% 
       filter(is.na(excludeFromResault)) %>% 
       select(mark100, mark500, mark700, excludeFromResault))
# some observations marked with ```excludeFromResault``` are inconsistent

# Check non-NA unique values for mark700
length(unique(esim_data$mark700))
unique(esim_data$mark700) 

# Is there any valuable group markers for competitors?
length(unique(esim_data$competitorMarker))
unique(esim_data$competitorMarker) 
# variable is useless

# Is there any group markers for experts?
length(unique(esim_data$expertGroupMarker))
unique(esim_data$expertGroupMarker) 
# there are some markers, but in the current context this variable is useless

# Removing columns which won't be used for research
esim_data <- subset(esim_data, 
                   select = -c(ChampRole,
                               fkUserAdd,
                               competitorMarker,
                               expertGroupMarker,
                               fk_quotaCategory,
                               FK_USER_CP,
                               ACCESS_RKC,
                               organization,
                               excludeFromResault,
                               participant_updated_at,
                               is_requested,
                               is_accepted,
                               mark700))



# Moving mark700 column after mark500 for convenience
esim_data <- esim_data %>% relocate(mark700, .after = mark500)

# Renaming some of the columns for convenience
colnames(esim_data) <- c("result", 
                         "competitor", 
                         "competition", 
                         "skill", 
                         "region", 
                         "mark100", 
                         "mark500", 
                         "medal", 
                         "timestamp", 
                         "team", 
                         "expert", 
                         "nok")

glimpse(esim_data)

# How many observations where mark100 is NA?
nrow(esim_data[is.na(esim_data$mark100), ])
# How many observations where mark100 is 0?
nrow(esim_data %>% filter(mark100 == 0))

# Removing observations where mark100 is missing (NA or 0)
esim_data <- esim_data %>% 
  drop_na(mark100) %>% 
  filter(mark100 > 0)

# Check for duplicate result IDs
length(unique(esim_data$result)) == nrow(esim_data)
# Removing duplicate rows from dataframe
esim_data <- distinct(esim_data)
length(unique(esim_data$result)) == nrow(esim_data)
nrow(esim_data)