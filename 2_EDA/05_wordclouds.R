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

# Function to create and save word cloud with title
create_word_cloud <- function(data_column, output_file, title) {
  word_freq <- table(data_column)
  png(filename = paste0(output_directory_path, output_file), width = 800, height = 800) # nolint
  par(mar = c(2, 2, 4, 2))  # Adjust margins to make space for the title
  wordcloud(names(word_freq), freq = word_freq, max.words = 50, colors = brewer.pal(8, "Dark2")) # nolint
  title(main = title, col.main = "black", font.main = 4)  # Add title
  dev.off()
}

# 1) Word cloud for 'prod_name'
create_word_cloud(filtered_data$prod_name, "05_wordcloud_prod_name.png", "Word Cloud of Product Names") # nolint

# 2) Word cloud for 'product_type_name'
create_word_cloud(filtered_data$product_type_name, "05_wordcloud_product_type_name.png", "Word Cloud of Product Type Names") # nolint

# 3) Word cloud for 'colour_group_name' with "Color" spelling
filtered_data$colour_group_name <- gsub("Colour", "Color", filtered_data$colour_group_name, ignore.case = TRUE) # nolint
create_word_cloud(filtered_data$colour_group_name, "05_wordcloud_color_group_name.png", "Word Cloud of Color Group Names") # nolint
