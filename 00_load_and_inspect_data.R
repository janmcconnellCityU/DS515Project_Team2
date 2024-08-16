# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/"
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/"

# Ensure the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Load the datasets
articles_cleaned <- read_csv(paste0(data_directory_path, "articles_cleaned.csv"))
customers_cleaned <- read_csv(paste0(data_directory_path, "customers_cleaned.csv"))
transactions_cleaned <- read_csv(paste0(data_directory_path, "transactions_cleaned.csv"))

# Inspect the datasets
glimpse(articles_cleaned)
glimpse(customers_cleaned)
glimpse(transactions_cleaned)

# Check for missing values
colSums(is.na(articles_cleaned))
colSums(is.na(customers_cleaned))
colSums(is.na(transactions_cleaned))

# Summary statistics
summary(articles_cleaned)
summary(customers_cleaned)
summary(transactions_cleaned)
