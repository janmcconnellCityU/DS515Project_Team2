# Load necessary libraries
library(ggplot2)
library(dplyr)

# Function to identify capped outliers and create box plots
plot_capped_boxplots <- function(data, dataset_name, output_directory) {

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

  # Plot box plots for each numeric column
  for (col in numeric_cols) {
    p <- ggplot(capped_data, aes_string(y = col)) +
      geom_boxplot(fill = "blue", color = "black") +
      ggtitle(paste("00_Box Plot of Capped Outliers in", col, "-", dataset_name)) + # nolint
      ylab(col) +
      theme_minimal()

    # Save the plot
    ggsave(
      filename = paste0(output_directory, "/00_boxplot_capped_outliers_", dataset_name, "_", col, ".png"), # nolint
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
articles <- read.csv(paste0(data_directory_path, "/articles.csv"))
transactions_train <- read.csv(paste0(data_directory_path, "/transactions_train.csv")) # nolint
customers <- read.csv(paste0(data_directory_path, "/customers.csv"))

# Generate box plots for capped outliers in each dataset
plot_capped_boxplots(articles, "Articles", output_directory_path)
plot_capped_boxplots(transactions_train, "Transactions_Train", output_directory_path) # nolint
plot_capped_boxplots(customers, "Customers", output_directory_path)
