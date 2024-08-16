# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)

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

# Summarize data for the plot
summary_data <- garment_upper_body_transactions %>%
  group_by(t_dat) %>%
  summarize(
    num_transactions = n(),
    total_sales = sum(price)
  )

# Create a combined data frame for plotting
summary_data_long <- summary_data %>%
  pivot_longer(cols = c(num_transactions, total_sales), names_to = "metric", values_to = "value") # nolint

# Create the combined plot with smoothing
combined_plot <- ggplot(summary_data_long, aes(x = t_dat, y = value, color = metric)) + # nolint
  geom_smooth(se = FALSE) +
  labs(title = "Transactions and Total Sales Over Time", x = "Date", y = "Value") + # nolint
  scale_color_manual(values = c("num_transactions" = "blue", "total_sales" = "green"),  # nolint
                     labels = c("num_transactions" = "Transactions", "total_sales" = "Sales")) + # nolint
  theme_minimal()

# Save the combined plot
ggsave(paste0(output_directory_path, "03_transactions_and_sales_over_time_smoothed.png"), plot = combined_plot, width = 10, height = 8) # nolint
