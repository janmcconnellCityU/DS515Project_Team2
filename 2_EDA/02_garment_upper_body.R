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
articles <- read_csv(paste0(data_directory_path, "articles.csv")) # nolint

# Filter articles for 'Garment Upper Body'
garment_upper_body_articles <- articles %>% filter(product_group_name == "Garment Upper body") # nolint

# Plot 1: Distribution of Color Group Codes
p1 <- ggplot(garment_upper_body_articles, aes(x = factor(colour_group_code))) +
  geom_bar(fill = "blue") +
  ggtitle("Distribution of Color Group Codes in Garment Upper Body") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Color Group Code", y = "Count")

# Save the plot
ggsave(paste0(output_directory_path, "02_color_group_code_distribution.png"), plot = p1, width = 10, height = 8) # nolint

# Plot 2: Distribution of Color Group Names
p2 <- ggplot(garment_upper_body_articles, aes(x = factor(colour_group_name))) + # nolint
  geom_bar(fill = "blue") +
  ggtitle("Distribution of Color Group Names in Garment Upper Body") + # nolint
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Color Group Name", y = "Count")

# Save the plot
ggsave(paste0(output_directory_path, "02_color_group_name_distribution.png"), plot = p2, width = 10, height = 8) # nolint
