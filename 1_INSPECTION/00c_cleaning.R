# Load necessary libraries
library(dplyr)

# Define the path to the original datasets (before cleaning)
data_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint

# Load the original datasets
customers <- read.csv(paste0(data_path, "customers.csv"))
articles <- read.csv(paste0(data_path, "articles.csv"))
transactions <- read.csv(paste0(data_path, "transactions_train.csv"))

# Function to cap outliers
cap_outliers <- function(data) {
  cap <- function(x) {
    quantiles <- quantile(x, c(0.01, 0.99), na.rm = TRUE)
    pmin(pmax(x, quantiles[1]), quantiles[2])
  }
  data <- data %>% mutate(across(where(is.numeric), cap))
  return(data)
}

# Apply the capping function to each dataset
customers_cleaned <- cap_outliers(customers)
articles_cleaned <- cap_outliers(articles)
transactions_cleaned <- cap_outliers(transactions)

# Save the cleaned datasets back to the same directory with a "_cleaned" suffix
write.csv(customers_cleaned, paste0(data_path, "customers_cleaned.csv"), row.names = FALSE) # nolint
write.csv(articles_cleaned, paste0(data_path, "articles_cleaned.csv"), row.names = FALSE) # nolint
write.csv(transactions_cleaned, paste0(data_path, "transactions_train_cleaned.csv"), row.names = FALSE) # nolint
