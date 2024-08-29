# Install necessary package if not already installed
if (!require(summarytools)) {
  install.packages("summarytools")
  library(summarytools)
}

# Load necessary libraries
library(dplyr)
library(summarytools)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Define file names
file_names <- c("articles.csv", "customers.csv", "transactions_train.csv") # nolint

# Function to generate detailed summary statistics for numeric columns
generate_summary_stats <- function(data) {
  numeric_data <- data %>% select_if(is.numeric)
  stats <- data.frame(
    Min = sapply(numeric_data, min, na.rm = TRUE),
    "1st Qu." = sapply(numeric_data, quantile, probs = 0.25, na.rm = TRUE),
    Median = sapply(numeric_data, median, na.rm = TRUE),
    Mean = sapply(numeric_data, mean, na.rm = TRUE),
    "3rd Qu." = sapply(numeric_data, quantile, probs = 0.75, na.rm = TRUE),
    Max = sapply(numeric_data, max, na.rm = TRUE)
  )
  return(stats)
}

# Function to analyze a dataset
analyze_dataset <- function(file_name) {
  file_path <- paste0(data_directory_path, file_name) # nolint

  # Read in the dataset
  data <- read.csv(file_path)

  # Print the first few rows
  cat("\n\nFirst few rows of", file_name, ":\n")
  print(head(data))

  # Print the structure of the dataset
  cat("\n\nStructure of", file_name, ":\n")
  str(data)

  # Check for missing values
  cat("\n\nMissing values in", file_name, ":\n")
  print(sapply(data, function(x) sum(is.na(x))))

  # Generate summary statistics for numeric columns
  cat("\n\nSummary statistics of", file_name, ":\n")
  summary_stats <- generate_summary_stats(data)
  print(summary_stats)

  # Save summary statistics to a CSV file
  summary_file_path <- paste0(output_directory_path, "summary_", file_name) # nolint
  write.csv(summary_stats, summary_file_path, row.names = TRUE)

  # Return summary statistics for further use
  return(summary_stats)
}

# Loop through each file and analyze the dataset
for (file_name in file_names) {
  analyze_dataset(file_name)
}

cat("\n\nAnalysis complete. Please review the output above for each dataset.\n")
