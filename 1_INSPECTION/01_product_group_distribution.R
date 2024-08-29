# Load necessary libraries
library(dplyr)
library(ggplot2)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Load the cleaned articles dataset
articles <- read.csv(paste0(data_directory_path, "articles_cleaned.csv"))

# Create the plot for product_group_name with blue bars and values
p <- ggplot(articles, aes(x = product_group_name)) +
  geom_bar(fill = "blue", color = "black") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position = "none") + # nolint
  ggtitle("Distribution of Product Group Name in Articles") +
  xlab("Product Group Name") +
  ylab("Count") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, size = 3.5)

# Save the plot
plot_file_path <- paste0(output_directory_path, "01_univariate_articles_product_group_name_distribution.png") # nolint
png(plot_file_path, width = 800, height = 800)
print(p)
dev.off()
