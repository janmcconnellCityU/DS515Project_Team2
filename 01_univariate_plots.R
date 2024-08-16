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
customers_cleaned <- read_csv(paste0(data_directory_path, "customers_cleaned.csv")) # nolint
transactions_cleaned <- read_csv(paste0(data_directory_path, "transactions_cleaned.csv")) # nolint

# Univariate Analysis for articles_cleaned.csv

# Plot 1: Distribution of Product Group Names
p1 <- ggplot(articles_cleaned, aes(x = product_group_name)) +
  geom_bar(fill = "blue") +
  theme_minimal() +
  ggtitle("Distribution of Product Group Names in Articles") +
  xlab("Product Group Name") +
  ylab("Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Save the plot
ggsave(paste0(output_directory_path, "01_product_group_name_distribution.png"), plot = p1, width = 10, height = 8) # nolint

# Plot 2: Distribution of Color Group Codes
p2 <- ggplot(articles_cleaned, aes(x = factor(colour_group_code))) +
  geom_bar(fill = "blue") +
  theme_minimal() +
  ggtitle("Distribution of Color Group Codes in Articles") +
  xlab("Color Group Code") +
  ylab("Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Save the plot
ggsave(paste0(output_directory_path, "02_colour_group_code_distribution.png"), plot = p2, width = 10, height = 8) # nolint

# Plot 3: Distribution of Graphical Appearance Numbers
p3 <- ggplot(articles_cleaned, aes(x = factor(graphical_appearance_no))) +
  geom_bar(fill = "blue") +
  theme_minimal() +
  ggtitle("Distribution of Graphical Appearance Numbers in Articles") +
  xlab("Graphical Appearance Number") +
  ylab("Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Save the plot
ggsave(paste0(output_directory_path, "03_graphical_appearance_distribution.png"), plot = p3, width = 10, height = 8) # nolint

# Univariate Analysis for customers_cleaned.csv

# Plot 1: Distribution of Ages
p1 <- ggplot(customers_cleaned, aes(x = age)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  theme_minimal() +
  ggtitle("Distribution of Ages in Customers") +
  xlab("Age") +
  ylab("Count")

# Save the plot
ggsave(paste0(output_directory_path, "01_age_distribution.png"), plot = p1, width = 10, height = 8) # nolint

# Plot 2: Distribution of Club Member Statuses
p2 <- ggplot(customers_cleaned, aes(x = club_member_status)) +
  geom_bar(fill = "blue") +
  theme_minimal() +
  ggtitle("Distribution of Club Member Statuses in Customers") +
  xlab("Club Member Status") +
  ylab("Count")

# Save the plot
ggsave(paste0(output_directory_path, "02_club_member_status_distribution.png"), plot = p2, width = 10, height = 8) # nolint

# Plot 3: Distribution of Fashion News Frequencies
p3 <- ggplot(customers_cleaned, aes(x = fashion_news_frequency)) +
  geom_bar(fill = "blue") +
  theme_minimal() +
  ggtitle("Distribution of Fashion News Frequencies in Customers") +
  xlab("Fashion News Frequency") +
  ylab("Count")

# Save the plot
ggsave(paste0(output_directory_path, "03_fashion_news_frequency_distribution.png"), plot = p3, width = 10, height = 8) # nolint

# Univariate Analysis for transactions_cleaned.csv

# Plot 1: Distribution of Prices
p1 <- ggplot(transactions_cleaned, aes(x = price)) +
  geom_histogram(binwidth = 0.01, fill = "blue", color = "black") +
  theme_minimal() +
  ggtitle("Distribution of Prices in Transactions") +
  xlab("Price") +
  ylab("Count")

# Save the plot
ggsave(paste0(output_directory_path, "01_price_distribution.png"), plot = p1, width = 10, height = 8) # nolint

# Plot 2: Distribution of Sales Channel IDs
p2 <- ggplot(transactions_cleaned, aes(x = factor(sales_channel_id))) +
  geom_bar(fill = "blue") +
  theme_minimal() +
  ggtitle("Distribution of Sales Channel IDs in Transactions") +
  xlab("Sales Channel ID") +
  ylab("Count")

# Save the plot
ggsave(paste0(output_directory_path, "02_sales_channel_id_distribution.png"), plot = p2, width = 10, height = 8) # nolint
