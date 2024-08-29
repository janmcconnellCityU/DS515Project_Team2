# Load necessary libraries
library(readr)
library(dplyr)

# Define the paths to your datasets
data_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint

# Load the datasets
articles <- read_csv(paste0(data_path, "articles.csv"))
customers <- read_csv(paste0(data_path, "customers_cleaned.csv"))
transactions_train <- read_csv(paste0(data_path, "transactions_train.csv"))

# Inspect the datasets
summary(articles)
summary(customers)
summary(transactions_train)

# Check the structure of the datasets
str(articles)
str(customers)
str(transactions_train)

# View the first few rows of each dataset
head(articles)
head(customers)
head(transactions_train)

# Glimpse the datasets for a quick overview
glimpse(articles)
glimpse(customers)
glimpse(transactions_train)

# Check for missing values
colSums(is.na(articles))
colSums(is.na(customers))
colSums(is.na(transactions_train))
