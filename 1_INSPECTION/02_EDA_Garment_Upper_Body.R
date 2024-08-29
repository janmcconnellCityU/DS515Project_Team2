# Load necessary libraries
library(dplyr)
library(ggplot2)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Ensure the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Read in the cleaned dataset
articles_cleaned <- read.csv(paste0(data_directory_path, "articles_cleaned.csv")) # nolint

# Filter data for 'Garment Upper body'
garment_upper_body <- articles_cleaned %>% filter(product_group_name == "Garment Upper body") # nolint

# Examine summary statistics for graphical_appearance_no
summary(garment_upper_body$graphical_appearance_no)

# Check the unique values for graphical_appearance_no
unique_values <- unique(garment_upper_body$graphical_appearance_no)

cat("Unique values in graphical_appearance_no:", unique_values, "\n")

# Plot 1: Bar plot of graphical appearance numbers
p1 <- ggplot(garment_upper_body, aes(x = as.factor(graphical_appearance_no))) + # nolint
  geom_bar(fill = "blue", color = "black") +
  ggtitle("Distribution of Graphical Appearance Numbers in Garment Upper Body") + # nolint
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +  # Rotate x-axis labels # nolint
  labs(x = "Graphical Appearance Number", y = "Count")

# Save the bar plot
ggsave(paste0(output_directory_path, "02_graphical_appearance_distribution.png"), plot = p1, width = 10, height = 8) # nolint

# Plot 2: Distribution of colour group codes
p2 <- ggplot(garment_upper_body, aes(x = as.factor(colour_group_code))) +
  geom_bar(fill = "blue", color = "black") +
  ggtitle("Distribution of Colour Group Codes in Garment Upper Body") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +  # Rotate x-axis labels # nolint
  labs(x = "Colour Group Code", y = "Count")

# Save the bar plot
ggsave(paste0(output_directory_path, "02_colour_group_code_distribution.png"), plot = p2, width = 10, height = 8) # nolint
