#Set up work place
install.packages("dplyr")
install.packages("tidyr")
library(dplyr)
library(tidyr)

#Load the data in RStudio
setwd("Desktop")
df <- read.csv("titanic_original.csv", header = TRUE)

#Port of embarkation
df <- read.csv("titanic_original.csv", header=TRUE, na.strings=c("","NA"))
df[, "embarked"][is.na(df[, "embarked"])] <- "S"

#Age
df[, "age"][is.na(df[, "age"])] <- mean(df$age, trim = 0, na.rm = TRUE)

#Lifeboat
df$boat <- as.character(df$boat)
df[, "boat"][is.na(df[, "boat"])] <- "None"
df$boat <- as.factor(df$boat)

#Cabin
df$has_cabin_number <- ifelse(is.na(df$cabin), 0, 1)

#Exporting code and data frame
write.csv(df, file = "titanic_clean.csv")
