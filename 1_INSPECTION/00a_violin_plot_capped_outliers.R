# Load necessary libraries
library(ggplot2)
library(dplyr)

# Define the paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Ensure the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Load datasets
articles <- read_csv(paste0(data_directory_path, "articles.csv"))
customers <- read_csv(paste0(data_directory_path, "customers.csv"))
transactions_train <- read_csv(paste0(data_directory_path, "transactions_train.csv")) # nolint

# List of columns to plot
columns_to_plot <- list(
  list(df = articles, column = "perceived_colour_master_id"),
  list(df = articles, column = "perceived_colour_value_id"),
  list(df = articles, column = "product_code"),
  list(df = articles, column = "product_type_no"),
  list(df = articles, column = "article_id"),
  list(df = articles, column = "colour_group_code"),
  list(df = articles, column = "department_no"),
  list(df = articles, column = "garment_group_no"),
  list(df = articles, column = "graphical_appearance_no"),
  list(df = articles, column = "index_group_no"),
  list(df = articles, column = "section_no"),
  list(df = customers, column = "age"),
  list(df = customers, column = "FN"),
  list(df = customers, column = "Active"),
  list(df = transactions_train, column = "price"),
  list(df = transactions_train, column = "article_id"),
  list(df = transactions_train, column = "sales_channel_id")
)

# Create violin plots for capped outliers
for (item in columns_to_plot) {
  df <- item$df
  column <- item$column

  plot <- ggplot(df, aes_string(x = factor(1), y = column)) +
    geom_violin(fill = "blue") +
    labs(title = paste("00_Violin Plot for Capped Outliers -", column),
         x = "",
         y = column) +
    theme_minimal()

  # Save the plot
  ggsave(paste0(output_directory_path, "00_violinplot_capped_outliers_", column, ".png"), # nolint
         plot = plot, width = 10, height = 8)
}
