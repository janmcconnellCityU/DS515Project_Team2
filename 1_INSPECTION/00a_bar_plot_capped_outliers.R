# Load necessary libraries
library(ggplot2)
library(dplyr)

# Function to identify capped outliers and create histograms
plot_capped_histograms <- function(data, dataset_name, output_directory) {

  # Define capping function based on the 1st and 99th percentiles
  cap_outliers <- function(x) {
    lower_bound <- quantile(x, 0.01, na.rm = TRUE)
    upper_bound <- quantile(x, 0.99, na.rm = TRUE)
    capped <- pmax(pmin(x, upper_bound), lower_bound)
    capped
  }

  # Apply capping function to numeric columns
  capped_data <- data %>%
    mutate(across(where(is.numeric), cap_outliers))

  # Identify numeric columns
  numeric_cols <- colnames(select_if(data, is.numeric))

  # Plot histograms for each numeric column
  for (col in numeric_cols) {
    p <- ggplot(capped_data, aes_string(x = col)) +
      geom_histogram(bins = 30, fill = "blue", color = "black") +
      ggtitle(paste("00_Capped Outliers in", col, "-", dataset_name)) +
      xlab(col) +
      ylab("Frequency") +
      theme_minimal()

    # Save the plot
    ggsave(
      filename = paste0(output_directory, "/00_capped_outliers_", dataset_name, "_", col, ".png"), # nolint
      plot = p,
      width = 10,
      height = 8
    )
  }
}

# Define dataset paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata" # nolint

# Define output directory for visualizations
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured" # nolint

# Load the datasets
articles <- read.csv(paste0(data_directory_path, "/sample_articles.csv"))
transactions_train <- read.csv(paste0(data_directory_path, "/sample_transactions_train.csv")) # nolint
customers <- read.csv(paste0(data_directory_path, "/sample_customers.csv"))

# Generate capped outlier histograms for each dataset
plot_capped_histograms(articles, "Articles", output_directory_path)
plot_capped_histograms(transactions_train, "Transactions_Train", output_directory_path) # nolint
plot_capped_histograms(customers, "Customers", output_directory_path)
