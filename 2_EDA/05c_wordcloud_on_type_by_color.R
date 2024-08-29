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

# Normalize color name spelling
filtered_data$colour_group_name <- gsub("Colour", "Color", filtered_data$colour_group_name, ignore.case = TRUE) # nolint

# Group by product type and color to get frequencies
color_frequencies <- filtered_data %>%
  group_by(.data$product_type_name, .data$colour_group_name) %>%
  summarize(freq = n()) %>%
  ungroup()

# Function to create and save a word cloud for color frequencies within each product type # nolint
create_color_frequency_word_cloud <- function(data_frame, product_type, output_file) { # nolint
  subset_data <- data_frame %>% filter(.data$product_type_name == product_type)
  word_freq <- subset_data$freq
  names(word_freq) <- subset_data$colour_group_name
  png(filename = paste0(output_directory_path, output_file), width = 800, height = 800) # nolint
  par(mar = c(2, 2, 4, 2))  # Adjust margins to make space for the title
  wordcloud(names(word_freq), freq = word_freq, max.words = 50, colors = brewer.pal(8, "Dark2")) # nolint
  title(main = paste("Color Frequency in", product_type), col.main = "black", font.main = 4)  # Add title # nolint
  dev.off()
}

# Get unique product types
product_types <- unique(filtered_data$product_type_name)

# Loop through each product type and create a word cloud for color frequencies
for (product_type in product_types) {
  create_color_frequency_word_cloud(color_frequencies, product_type, paste0("05cwordcloud_", gsub(" ", "_", product_type), "_color_frequencies.png")) # nolint
}
