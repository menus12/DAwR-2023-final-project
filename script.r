# Setting working directory
setwd("$pwd/DAwR-2023-final-project")

# install library for reading excel files (if not yet installed)
# install.packages("readxl")
# Load library to read data from excel sheets
library("readxl")

# Loading excel sheets 
frame1 <- read_excel("Datafiles/participants100.xlsx")
frame2 <- read_excel("Datafiles/participants200.xlsx")
frame3 <- read_excel("Datafiles/participants300.xlsx")

# Merging all sheets into a single dataframe
cis_data <- rbind(frame1, frame2, frame3)

