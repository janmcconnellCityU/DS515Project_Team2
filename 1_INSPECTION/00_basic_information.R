# Load the necessary libraries
library(readr)

# Define the file paths
articles_file <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/articles.csv" # nolint
customers_file <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/customers.csv" # nolint
transactions_file <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/transactions_train.csv" # nolint

# Load the datasets
articles <- read_csv(articles_file)
customers <- read_csv(customers_file)
transactions_train <- read_csv(transactions_file)

# Get the number of rows in each dataset
num_rows_articles <- nrow(articles)
num_rows_customers <- nrow(customers)
num_rows_transactions <- nrow(transactions_train)

# Print the number of rows
cat("Number of rows in articles.csv:", num_rows_articles, "\n")
cat("Number of rows in customers.csv:", num_rows_customers, "\n")
cat("Number of rows in transactions_train.csv:", num_rows_transactions, "\n")
