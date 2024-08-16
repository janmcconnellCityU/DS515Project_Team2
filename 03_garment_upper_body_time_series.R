# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Ensure the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Load the datasets
articles_cleaned <- read_csv(paste0(data_directory_path, "articles_cleaned.csv")) # nolint
transactions_cleaned <- read_csv(paste0(data_directory_path, "transactions_cleaned.csv")) # nolint

# Filter data for 'Garment Upper Body'
garment_upper_body_articles <- articles_cleaned %>% filter(product_group_name == "Garment Upper body") # nolint

# Merge articles and transactions data
garment_upper_body_transactions <- transactions_cleaned %>% # nolint
  inner_join(garment_upper_body_articles, by = "article_id")

# Convert t_dat to Date type
garment_upper_body_transactions$t_dat <- as.Date(garment_upper_body_transactions$t_dat) # nolint

# Plot 1: Number of Transactions Over Time
p1 <- ggplot(garment_upper_body_transactions, aes(x = t_dat)) +
  geom_line(stat = "count", color = "blue") +
  ggtitle("Number of Transactions Over Time for Garment Upper Body") +
  theme_minimal() +
  labs(x = "Date", y = "Number of Transactions")

# Save the plot
ggsave(paste0(output_directory_path, "03_transactions_over_time.png"), plot = p1, width = 10, height = 8) # nolint

# Plot 2: Total Sales Over Time
p2 <- ggplot(garment_upper_body_transactions, aes(x = t_dat, y = price)) +
  geom_line(stat = "summary", fun = sum, color = "blue") +
  ggtitle("Total Sales Over Time for Garment Upper Body") +
  theme_minimal() +
  labs(x = "Date", y = "Total Sales")

# Save the plot
ggsave(paste0(output_directory_path, "03_total_sales_over_time.png"), plot = p2, width = 10, height = 8) # nolint

# Plot 3: Average Price Over Time
p3 <- ggplot(garment_upper_body_transactions, aes(x = t_dat, y = price)) +
  geom_line(stat = "summary", fun = mean, color = "blue") +
  ggtitle("Average Price Over Time for Garment Upper Body") +
  theme_minimal() +
  labs(x = "Date", y = "Average Price")

# Save the plot
ggsave(paste0(output_directory_path, "03_average_price_over_time.png"), plot = p3, width = 10, height = 8) # nolint
