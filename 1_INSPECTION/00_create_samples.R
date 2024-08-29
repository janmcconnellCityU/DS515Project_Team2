# Load necessary library
library(dplyr)

# Function to sample a CSV file and save the sample
sample_csv_file <- function(input_file_path, output_file_path, sample_size) {
  # Read in the large file
  large_data <- read.csv(input_file_path)

  # Randomly sample rows from the large dataset
  sampled_data <- large_data %>% sample_n(sample_size)

  # Save the sampled data to a new CSV file
  write.csv(sampled_data, output_file_path, row.names = FALSE)

  # Print a message indicating success
  cat("Sampled data saved to", output_file_path, "\n")
}

# Set the directory path
directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint

# Set the sample size (e.g., 1000 rows)
sample_size <- 1000

# Define file names
file_names <- c("articles.csv", "customers.csv", "transactions_train.csv")

# Loop through each file and create a sample
for (file_name in file_names) {
  input_file_path <- paste0(directory_path, file_name)
  output_file_path <- paste0(directory_path, "sample_", file_name)
  sample_csv_file(input_file_path, output_file_path, sample_size)
}
