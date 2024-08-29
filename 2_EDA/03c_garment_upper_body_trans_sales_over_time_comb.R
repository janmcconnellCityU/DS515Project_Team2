# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(lubridate)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Ensure the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Load the datasets
articles <- read_csv(paste0(data_directory_path, "articles.csv")) # nolint
transactions_train <- read_csv(paste0(data_directory_path, "transactions_train.csv")) # nolint

# Filter data for 'Garment Upper Body'
garment_upper_body_articles <- articles %>% filter(product_group_name == "Garment Upper body") # nolint

# Merge articles and transactions data
garment_upper_body_transactions <- transactions_train %>% # nolint
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

# Summarize the transactions data by date
transactions_summary <- transactions_train %>%
  mutate(date = as.Date(t_dat)) %>%
  group_by(date) %>%
  summarise(total_sales = sum(price), transaction_count = n())

# Create a dual-axis plot with legend
dual_axis_plot <- ggplot(data = transactions_summary, aes(x = date)) +
  geom_line(aes(y = total_sales, color = "Total Sales")) +
  geom_line(aes(y = transaction_count / 10, color = "Transaction Count")) +  # Scale transaction_count for better visibility # nolint
  scale_y_continuous(
    name = "Total Sales",
    sec.axis = sec_axis(~.*10, name = "Transaction Count")  # Adjust the scale to match transaction_count # nolint
  ) +
  scale_color_manual(values = c("Total Sales" = "green", "Transaction Count" = "blue")) + # nolint
  labs(title = "Transactions and Sales Over Time", x = "Date", color = "Metric") + # nolint
  theme_minimal() +
  theme(legend.position = "bottom")

# Save the dual-axis plot with the legend
ggsave(paste0(output_directory_path, "03c_transactions_and_sales_over_time.png"), plot = dual_axis_plot, width = 8, height = 6) # nolint
