# Load necessary libraries
library(ggplot2)

# Define the path to the original datasets
data_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint

# Load the original datasets
customers <- read.csv(paste0(data_path, "customers.csv"))
articles <- read.csv(paste0(data_path, "articles.csv"))
transactions <- read.csv(paste0(data_path, "transactions_train.csv"))

# Example: Define dynamic thresholds using IQR for a more robust outlier detection # nolint
calculate_thresholds <- function(df, column) {
  Q1 <- quantile(df[[column]], 0.25, na.rm = TRUE) # nolint
  Q3 <- quantile(df[[column]], 0.75, na.rm = TRUE) # nolint
  IQR <- Q3 - Q1 # nolint
  lower_limit <- Q1 - 1.5 * IQR
  upper_limit <- Q3 + 1.5 * IQR
  return(list(lower_limit = lower_limit, upper_limit = upper_limit))
}

# Function to create scatter plots and highlight outliers
plot_scatter_with_outliers <- function(df, x_column, y_column, dataset_name, output_directory) { # nolint
  # Calculate thresholds for the y_column
  thresholds <- calculate_thresholds(df, y_column)
  lower_limit <- thresholds$lower_limit
  upper_limit <- thresholds$upper_limit

  # Create a new column to differentiate outliers
  df$outlier <- ifelse(df[[y_column]] > upper_limit | df[[y_column]] < lower_limit, "Outlier", "Non-Outlier") # nolint

  # Plot
  plot <- ggplot(df, aes_string(x = x_column, y = y_column, color = "outlier")) + # nolint
    geom_point() +
    scale_color_manual(values = c("Non-Outlier" = "blue", "Outlier" = "red")) + # nolint
    theme_minimal() +
    labs(title = paste("Scatter Plot of", y_column, "with Outliers Highlighted in", dataset_name), # nolint
         x = x_column,
         y = y_column,
         color = "Data Points") +
    theme(legend.position = "bottom")

  # Save the plot
  output_file <- paste0(output_directory, "00a_scatterplot_", dataset_name, "_", y_column, "_outliers.png") # nolint
  ggsave(output_file, plot, width = 10, height = 8)
}

# Define the output directory
output_directory <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Ensure the output directory exists
if (!dir.exists(output_directory)) {
  dir.create(output_directory, recursive = TRUE)
}

# Generate scatter plots with outliers for each dataset
plot_scatter_with_outliers(articles, "article_id", "perceived_colour_master_id", "Articles", output_directory) # nolint
plot_scatter_with_outliers(transactions, "article_id", "price", "Transactions", output_directory) # nolint
plot_scatter_with_outliers(customers, "customer_id", "age", "Customers", output_directory) # nolint
