# Clear current terminal before executing code
shell("cls")

# I found it necessary to remove some records from the 'customers' dataset
# because I kept having difficulty prepping the data for regression.

# Load necessary libraries
library(dplyr)

# Define file paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint

# Load datasets
customers <- read.csv(paste0(data_directory_path, "customers_cleaned_x2.csv")) # nolint
transactions_train <- read.csv(paste0(data_directory_path, "transactions_train.csv")) # nolint

# STEP 1: Remove customers with no transactions
customers_with_transactions <- customers %>%
  filter(customer_id %in% transactions_train$customer_id)

# STEP 2: Remove any customers missing a numeric value from 'age'
customers_cleaned <- customers_with_transactions %>%
  filter(!is.na(age) & is.numeric(age))

# STEP 3: Replace any value (or missing value) <> 1 in the 'FN' column with 0
customers_cleaned <- customers_cleaned %>%
  mutate(FN = ifelse(FN == 1, 1, 0)) %>%
  mutate(FN = ifelse(is.na(FN), 0, FN)) # Ensure NAs are replaced with 0

# STEP 4: Replace any value (or missing value) <> 1 in the 'Active' column with 0 # nolint
customers_cleaned <- customers_cleaned %>%
  mutate(Active = ifelse(Active == 1, 1, 0)) %>%
  mutate(Active = ifelse(is.na(Active), 0, Active)) # Ensure NAs are replaced with 0 # nolint

# STEP 5: Replace any missing value in the 'club_member_status' column with NA
customers_cleaned <- customers_cleaned %>%
  mutate(club_member_status = ifelse(club_member_status == "" | is.na(club_member_status), NA, club_member_status)) # nolint

# STEP 6: Replace any missing value in the 'fashion_news_frequency' column with NA # nolint
customers_cleaned <- customers_cleaned %>%
  mutate(fashion_news_frequency = ifelse(fashion_news_frequency == "" | is.na(fashion_news_frequency), NA, fashion_news_frequency)) # nolint

# STEP 7: Save new dataset as 'customers_cleaned_x2'
write.csv(customers_cleaned, paste0(data_directory_path, "customers_cleaned_x2.csv"), row.names = FALSE) # nolint

# STEP 8: Check 'customers_cleaned_x2' for any missing values
missing_values <- sapply(customers_cleaned, function(x) sum(is.na(x)))
print(missing_values)
