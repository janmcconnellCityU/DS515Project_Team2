# Load necessary libraries
library(dplyr)
library(tidyr)
library(wordcloud)
library(RColorBrewer)

# Define paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Load data
articles <- read.csv(paste0(data_directory_path, "articles.csv"))

# Filter data for 'Garment Upper body'
filtered_data <- articles %>% filter(product_group_name == "Garment Upper body")

# Determine the most popular color within each product_type_name
popular_colors <- filtered_data %>%
  mutate(colour_group_name = gsub("Colour", "Color", colour_group_name, ignore.case = TRUE)) %>% # nolint
  group_by(product_type_name) %>%
  summarize(most_popular_color = names(which.max(table(colour_group_name)))) %>%
  ungroup()

# Function to create and save word cloud with title
create_combined_word_cloud <- function(data_frame, output_file, title) {
  word_freq <- table(data_frame$most_popular_color)
  png(filename = paste0(output_directory_path, output_file), width = 800, height = 800) # nolint
  par(mar = c(2, 2, 4, 2))  # Adjust margins to make space for the title
  wordcloud(names(word_freq), freq = word_freq, max.words = 50, colors = brewer.pal(8, "Dark2")) # nolint
  title(main = title, col.main = "black", font.main = 4)  # Add title
  dev.off()
}

# Create the combined word cloud for most popular color within each product type
create_combined_word_cloud(popular_colors, "05b_wordcloud_combined_color_product_type.png", "Most Popular Color by Product Type") # nolint
