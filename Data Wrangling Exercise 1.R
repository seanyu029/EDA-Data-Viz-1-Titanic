#Load csv in Rstudio
install.packages("dplyr")
library(dplyr)
setwd("Desktop")
df <- read.csv("refine_original.csv", header = TRUE)
install.packages("stringr")

#Clean up brand names
df$company[grepl('ps$', df$company, ignore.case = TRUE )] <- 'Phillips'
df$company[grepl('^A', df$company, ignore.case = TRUE)] <- 'Akzo'
df$company[grepl('^V', df$company, ignore.case = TRUE)] <- 'Van Houten'
df$company[grepl('er$', df$company)] <- 'Unilever'

#Separate product code and number
library(stringr)
df$Product_Code <- str_split_fixed(df$Product.code...number, "-", 2)[,1]
df$Product_Number <- str_split_fixed(df$Product.code...number, "-",2)[,2]
df$Product_Code <- as.factor(df$Product_Code)
df$Product_Number <- as.factor(df$Product_Number)

#Add product categories
df$Product_categories[grepl('p', df$Product_Code)] <- 'Smartphone'
df$Product_categories[grepl('q', df$Product_Code)] <- 'Tablet'
df$Product_categories[grepl('v', df$Product_Code)] <- 'TV'
df$Product_categories[grepl('x', df$Product_Code)] <- 'Laptop'

df$Product_categories <- as.factor(df$Product_categories)

#Add full address for geocoding
full_address <- with(df, paste(address, city, country, sep = ","))
df$full_address <- full_address
df$full_address <- as.factor(df$full_address)

#Create dummy variables for company and product category
df$company_Phillips <- as.factor(ifelse(df$company == 'Phillips', 1, 0))
df$company_Akzo <- as.factor(ifelse(df$company == 'Akzo', 1, 0))
df$company_Van_Houten <- as.factor(ifelse(df$company == 'Van Houten', 1, 0))
df$company_Unilever <- as.factor(ifelse(df$company == 'Unilever', 1, 0))

df$product_Smartphone <- as.factor(ifelse(df$Product_Code == 'p', 1, 0))
df$product_TV <- as.factor(ifelse(df$Product_Code == 'v', 1, 0))
df$product_Laptop <- as.factor(ifelse(df$Product_Code == 'x', 1, 0))
df$product_Tablet <- as.factor(ifelse(df$Product_Code == 'q', 1, 0))

#Exporting code and data frame
install.packages("xlsx")
library(xlsx)
write.xlsx(df, "refine_clean.xlsx")
