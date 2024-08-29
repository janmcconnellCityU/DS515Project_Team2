# Clear current terminal before executing code
shell("cls")

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Define file paths
articles_file <- paste0(data_directory_path, "articles.csv")
customers_file <- paste0(data_directory_path, "customers_cleaned_x2.csv")
transactions_file <- paste0(data_directory_path, "transactions_train.csv") # nolint

# Load the datasets
articles <- read.csv(articles_file)
customers <- read.csv(customers_file)
transactions_train <- read.csv(transactions_file) # nolint

# Get file sizes
articles_size <- file.info(articles_file)$size
customers_size <- file.info(customers_file)$size
transactions_size <- file.info(transactions_file)$size

# Convert sizes to MB for easier readability
articles_size_mb <- round(articles_size / (1024^2), 2)
customers_size_mb <- round(customers_size / (1024^2), 2)
transactions_size_mb <- round(transactions_size / (1024^2), 2)

# Display the file sizes
cat("File Sizes:\n")
cat("Articles.csv: ", articles_size_mb, "MB\n")
cat("Customers_cleaned_x2.csv: ", customers_size_mb, "MB\n")
cat("Transactions_train.csv: ", transactions_size_mb, "MB\n")

# Display the first few rows of each dataset
head(articles)
head(customers)
head(transactions_train)
