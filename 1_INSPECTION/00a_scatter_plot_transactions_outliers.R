# Load necessary libraries
library(ggplot2)
library(dplyr)

# Define the path to the original datasets (before cleaning)
data_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint

# Load the original datasets
customers <- read.csv(paste0(data_path, "customers.csv"))
articles <- read.csv(paste0(data_path, "articles.csv"))
transactions <- read.csv(paste0(data_path, "transactions_train.csv"))

# Function to cap outliers for Transactions dataset only
cap_outliers <- function(data) {
  cap <- function(x) {
    quantiles <- quantile(x, c(0.01, 0.99), na.rm = TRUE)
    pmin(pmax(x, quantiles[1]), quantiles[2])
  }
  data <- data %>% mutate(across(where(is.numeric), cap))
  return(data)
}

# Apply capping only to the transactions dataset
transactions <- cap_outliers(transactions)

# Example: Scatter plot for the 'transactions' dataset with 'price' as the y_variable and 'article_id' as the x_variable # nolint
upper_limit <- quantile(transactions$price, 0.99, na.rm = TRUE)
lower_limit <- quantile(transactions$price, 0.01, na.rm = TRUE)

# Create a new column to differentiate outliers in the 'transactions' dataset
transactions$outlier <- ifelse(transactions$price > upper_limit | transactions$price < lower_limit, "Outlier", "Non-Outlier") # nolint

# Plot
ggplot(transactions, aes(x = article_id, y = price, color = outlier)) +
  geom_point() +
  scale_color_manual(values = c("Non-Outlier" = "blue", "Outlier" = "red")) +
  theme_minimal() +
  labs(title = "Scatter Plot of Transaction Prices with Outliers Highlighted",
       x = "Article ID",
       y = "Price",
       color = "Data Points") +
  theme(legend.position = "bottom")

# Save the plot
ggsave(paste0(data_path, "00a_scatterplot_Transactions_price_outliers.png"))
