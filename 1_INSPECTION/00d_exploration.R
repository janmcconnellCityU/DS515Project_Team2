# Load necessary libraries
library(dplyr)
library(ggplot2)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Ensure the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Define cleaned file names
file_names <- c("articles.csv", "customers.csv", "transactions_train.csv") # nolint
cleaned_file_names <- c("articles_cleaned.csv", "customers_cleaned.csv", "transactions_cleaned.csv") # nolint

# Function to clean and explore a dataset
clean_and_explore_dataset <- function(file_name, cleaned_file_name) {
  file_path <- paste0(data_directory_path, file_name)
  cleaned_file_path <- paste0(data_directory_path, cleaned_file_name)

  # Read in the dataset
  data <- read.csv(file_path)

  # Remove duplicates
  data <- data %>% distinct()

  # Check for missing values
  cat("\n\nMissing values in", cleaned_file_name, ":\n")
  print(sapply(data, function(x) sum(is.na(x))))

  # Generate summary statistics for numeric columns
  cat("\n\nSummary statistics of", cleaned_file_name, ":\n")
  print(summary(data))

  # Inspect the first few rows
  cat("\n\nFirst few rows of", cleaned_file_name, ":\n")
  print(head(data))

  # Check for duplicates
  cat("\n\nNumber of duplicate rows in", cleaned_file_name, ":", sum(duplicated(data)), "\n") # nolint

  # Save cleaned dataset
  write.csv(data, cleaned_file_path, row.names = FALSE)

  # Visualize data distributions for numeric columns
  numeric_cols <- data %>% select_if(is.numeric)

  # Ensure the specific columns are included
  specific_cols <- c("index_group_no", "section_no", "garment_group_no")
  numeric_cols <- numeric_cols %>% select(any_of(specific_cols))

  for (col_name in colnames(numeric_cols)) {
    # Filter out non-finite values
    finite_data <- numeric_cols %>% filter(is.finite(.data[[col_name]]))

    p <- ggplot(finite_data, aes_string(x = col_name)) +
      geom_histogram(binwidth = 1000, fill = "blue", color = "black") + # Adjusted binwidth to 1000 # nolint
      ggtitle(paste("Distribution of", col_name, "in", cleaned_file_name)) +
      theme_minimal()

    # Save the plot directly
    plot_file_path <- paste0(output_directory_path, "distribution_", col_name, "_", cleaned_file_name, ".png") # nolint
    tryCatch({
      png(plot_file_path, width = 800, height = 600)
      print(p)
      dev.off()
    }, error = function(e) {
      cat("Error saving plot for", col_name, "in", cleaned_file_name, ":", e$message, "\n") # nolint
    })
  }
}

# Loop through each file, clean and explore the dataset
for (i in seq_along(file_names)) {
  clean_and_explore_dataset(file_names[i], cleaned_file_names[i])
}

cat("\n\nData cleaning and exploration complete. Cleaned datasets have been saved and histograms generated.\n") # nolint
