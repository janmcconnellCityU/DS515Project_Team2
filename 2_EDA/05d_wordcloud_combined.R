# Load necessary libraries
library(dplyr)
library(tidyr)
library(wordcloud)
library(RColorBrewer)

# Define paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Check if the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Load data
articles <- read.csv(paste0(data_directory_path, "articles.csv"))

# Filter data for 'Garment Upper body'
filtered_data <- articles %>% filter(product_group_name == "Garment Upper body")

# Normalize color name spelling
filtered_data$colour_group_name <- gsub("Colour", "Color", filtered_data$colour_group_name, ignore.case = TRUE) # nolint

# Group by color and calculate overall frequencies across all product types
combined_frequencies <- filtered_data %>%
  group_by(colour_group_name) %>%
  summarize(total_freq = n()) %>%
  ungroup()

# Create a combined word cloud for all product types
output_file <- paste0(output_directory_path, "05d_combined_color_frequency_wordcloud.png") # nolint
png(filename = output_file, width = 800, height = 800) # Reduced size to 800x800
par(mar = c(1, 1, 2, 1))  # Reduced margins
wordcloud(words = combined_frequencies$colour_group_name,
          freq = combined_frequencies$total_freq,
          max.words = 100,
          colors = brewer.pal(8, "Dark2"),
          scale = c(4, 0.5)) # Adjusted scale to make better use of space
title(main = "Combined Color Frequency Across All Product Types", col.main = "black", font.main = 4)  # Add title # nolint
dev.off()

# Check if the file was saved correctly
if (file.exists(output_file)) {
  message("The word cloud has been saved successfully at: ", output_file)
} else {
  warning("There was an issue saving the word cloud. Please check the file path and permissions.") # nolint
}
