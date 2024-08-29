# Clear current terminal before executing code
shell("cls")

# Load necessary libraries
library(dplyr)
library(lubridate)

# Load the datasets
transactions_train <- read.csv("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/transactions_train.csv") # nolint
articles <- read.csv("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/articles.csv") # nolint
customers <- read.csv("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/customers_cleaned_x2.csv") # nolint

# Convert t_dat to Date type
transactions_train <- transactions_train %>%
  mutate(t_dat = as.Date(t_dat, format = "%Y-%m-%d"))

# Merge transactions with articles
transactions_articles <- transactions_train %>%
  left_join(articles, by = "article_id")

# Merge the resulting dataset with customers
full_data <- transactions_articles %>%
  left_join(customers, by = "customer_id")

# Remove unnecessary columns
full_data <- full_data %>%
  select(-club_member_status, -fashion_news_frequency)

# Print a message to indicate completion
cat("01_data_preparation.R has finished executing.\n")