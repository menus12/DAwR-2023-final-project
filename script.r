# ------------ Appendix 1. Customizing the original dataset

# Setting working directory
setwd("$pwd/DAwR-2023-final-project")

# Install tidyverse package if not installed
# install.packages("tidyverse")

# Loading required libraries
library(readxl)
library(tidyverse)
library(readr)
library(skimr)

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
# variable is useless

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
                               nok,
                               excludeFromResault,
                               participant_updated_at,
                               is_requested,
                               is_accepted,
                               mark700))

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
                         "expert")

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

# Load dataframe with region names
regions <- read_csv2("Datafiles/regions.csv")
glimpse(regions)
# there are 168 region codes

# Join region names column to the resulting data frame
esim_data <- inner_join(esim_data, regions, by = c("region" = "code"), na_matches = "na", relationship = "many-to-many")

# ------------ Description of the data used

# Resulting dataset overview
glimpse(esim_data)

# How many unique and missing values for each column?
data.frame(unique=sapply(esim_data, function(x) sum(length(unique(x, na.rm = TRUE)))),
           missing=sapply(esim_data, function(x) sum(is.na(x) | x == 0)))

# Summary of Grouped Regions (removed NA values)
# Check summary statistics of mark100 per grouped region
                          
summary_by_regionName <- esim_data %>%
  group_by(regionName) %>%
  summarise(
    count = n(),                   # Count of observations
    mean_mark100 = mean(mark100),  # Mean of mark100
    median_mark100 = median(mark100),  # Median of mark100
    sd_mark100 = sd(mark100),      # Standard deviation of mark100
    avg_mark100 = mean(mark100)    # Average of mark100
summary_by_regionName

# Sort table by count of observations, most observations per region at the top
View(summary_by_region_sorted)
summary_by_region_sorted <- summary_by_regionName %>%
  arrange(desc(count))         
         
# Filter the top 10 regions in terms of observations (count)
top_regions <- esim_data %>%
  group_by(regionName) %>%
  summarise(count = n()) %>%
  top_n(10, wt = count) %>%
  pull(regionName)

# Filter the dataset for the top 10 regions
filtered_data_top10 <- esim_data %>% filter(regionName %in% top_regions)

# Create a boxplot to visualize 'mark100' for the top 10 regions
ggplot(filtered_data_top10, aes(x = as.factor(regionName), y = mark100)) +
  geom_boxplot() +
  labs(title = "Boxplot of 'mark100' for Top 10 Regions",
       x = "Region",
       y = "Mark 100") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# ------------ Results of the data analysis

# Framing a table with frequency of competitor IDs
n_occur <- data.frame(table(esim_data$competitor))

# Subsetting results with only those competitor IDs who participated more than 1 time
comp_repeat <- esim_data %>% filter(competitor %in% n_occur[n_occur$Freq > 1, ]$Var1)

# Ordering data frame by competitor ID and then by result ID
comp_repeat <- comp_repeat[with(comp_repeat, order(competitor, result)), ]

# Adding a column and computing the boolean value whether each next result is higher than previous (absolute score)
# If this is a first result of a given competitor, value is NA
# If this is not first result of a given competitor, and mark100 value is higher than previous mark100 value, than value is TRUE
# If this is not first result of a given competitor, and mark100 value is lower than previous mark100 value, than value is FALSE
comp_repeat$improve100 <- with(comp_repeat, 
                            ifelse(competitor == lag(competitor), 
                                   ifelse(mark100 > lag(mark100), TRUE, FALSE), NA))

# Ploting geom bar grouping repeated competitor participation cases by region
# with exclusion of 
# each first result (NA values)
# results without experts (NA or 0)
comp_repeat %>% filter(!is.na(improve100)) %>% filter(!is.na(expert)) %>% filter(expert > 0) %>% 
  ggplot(mapping = aes(x = factor(regionName),fill = factor(improve100) )) + 
  geom_bar(width = 0.5, position = position_dodge(width = 0.6)) +
  labs(title = "Repeated competitor participation (by region)\n", x = "Region name", y = "Number of repeated participations", fill = "Result has been improved\n") +
  scale_fill_manual(labels = c("False", "True"), values = c("red", "green")) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        plot.title = element_text(size = 20, face = "bold", color = "darkgreen"))

# Ploting summary geom bar 
# with exclusion of 
# each first result (NA values)
# results without experts (NA or 0)
comp_repeat %>% filter(!is.na(improve100)) %>% filter(!is.na(expert)) %>% filter(expert > 0) %>% 
  ggplot(mapping = aes(x = improve100)) + 
  geom_bar() +
  labs(title = "Repeated competitor participation\n", x = "Result has been improved", y = "Number of repeated participations") +
  theme_bw() +
  theme(plot.title = element_text(size = 20, face = "bold", color = "darkgreen"))  

# Framing a table with frequency of experts IDs
e_occur <- data.frame(table(esim_data$expert))

# Subsetting results with only those expert IDs who participated more than 1 time
expert_repeat <- esim_data %>% filter(expert > 0) %>% filter(expert %in% e_occur[e_occur$Freq > 1, ]$Var1)

# Ordering data frame by expert ID and then by result ID
expert_repeat <- expert_repeat[with(expert_repeat, order(expert, result)), ]

# Adding a column and computing the boolean value whether each next result is higher than previous
# If this is a first result of a given expert (compatriot competitor), value is NA
# If this is not first result of a given expert (compatriot competitor), and mark100 value is higher than previous mark100 value, than value is TRUE
# If this is not first result of a given expert (compatriot competitor), and mark100 value is lower than previous mark100 value, than value is FALSE
expert_repeat$improve100 <- with(expert_repeat, ifelse(expert == lag(expert), ifelse(mark100 > lag(mark100), TRUE, FALSE), NA))

# Ploting geom bar grouping repeated expert participation cases by region
# with exclusion of 
# each first result (NA values)
expert_repeat %>% filter(!is.na(improve100)) %>% filter(!is.na(expert)) %>% 
  ggplot(mapping = aes(x = factor(regionName),fill = factor(improve100) )) + 
  geom_bar(width = 0.5, position = position_dodge(width = 0.6)) +
  labs(title = "Repeated expert participation (by region)\n", x = "Region name", y = "Number of repeated participations", fill = "Result has been improved\n") +
  scale_fill_manual(labels = c("False", "True"), values = c("red", "green")) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        plot.title = element_text(size = 20, face = "bold", color = "darkgreen"))

# Ploting geom bar with exclusion of each first result (NA values)
expert_repeat %>% filter(!is.na(improve100)) %>% 
  ggplot(mapping = aes(x = improve100)) + 
  geom_bar() +
  labs(title = "Repeated expert participation\n", x = "Result has been improved", y = "Number of repeated participations") +
  theme_bw() +
  theme(plot.title = element_text(size = 20, face = "bold", color = "darkgreen"))  
