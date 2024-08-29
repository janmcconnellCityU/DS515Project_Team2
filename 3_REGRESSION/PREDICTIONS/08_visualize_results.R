# Clear current terminal before executing code
shell("cls")

# Load necessary libraries
library(ggplot2)
library(dplyr)
library(cowplot)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Load the predictions dataset
predictions_results <- read.csv(file.path(data_directory_path, "predictions_results.csv")) # nolint

# Ensure the month column is treated as a factor with ordered levels
predictions_results$month <- factor(predictions_results$month,
                                    levels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"))

# Function to create split plots for each article
create_split_plot <- function(article_name, product_group_name) {
  article_data <- predictions_results %>%
    filter(prod_name == article_name) # nolint

  # Check if there is any data available for the article, skip plotting if none
  if (nrow(article_data) == 0) {
    cat("No data available for", article_name, "\n")
    return(NULL)
  }

  p_black <- ggplot(article_data %>% filter(colour_group_name == "Black"), aes(x = month)) + # nolint
    geom_point(aes(y = Predicted, color = "Predicted", shape = "Predicted")) + # nolint
    geom_point(aes(y = Actual, color = "Actual", shape = "Actual")) + # nolint
    scale_color_manual(values = c("Actual" = "black", "Predicted" = "green")) +
    scale_shape_manual(values = c("Actual" = 16, "Predicted" = 17)) +
    theme_minimal(base_size = 14) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          plot.title = element_text(size = 12)) +
    labs(
      title = paste("Actual vs. Predicted Purchase Counts -", article_name, "- Black"), # nolint
      x = "Month of the Year",
      y = "Purchase Count",
      color = "Legend",
      shape = "Legend"
    )

  p_white <- ggplot(article_data %>% filter(colour_group_name == "White"), aes(x = month)) + # nolint
    geom_point(aes(y = Predicted, color = "Predicted", shape = "Predicted")) + # nolint
    geom_point(aes(y = Actual, color = "Actual", shape = "Actual")) + # nolint
    scale_color_manual(values = c("Actual" = "gray", "Predicted" = "green")) +
    scale_shape_manual(values = c("Actual" = 16, "Predicted" = 17)) +
    theme_minimal(base_size = 14) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1),
          plot.title = element_text(size = 12)) +
    labs(
      title = paste("Actual vs. Predicted Purchase Counts -", article_name, "- White"), # nolint
      x = "Month of the Year",
      y = "Purchase Count",
      color = "Legend",
      shape = "Legend"
    )

  # Arrange the two plots vertically
  combined_plot <- cowplot::plot_grid(p_black, p_white, ncol = 1)

  # Save the plot
  ggsave(filename = paste0(output_directory_path, "08_split_plot_", gsub(" ", "_", article_name), ".png"), # nolint
         plot = combined_plot, height = 8, width = 6)
}

# Generate plots for each article
articles <- c("Tilly (1)", "Cat Tee.", "Tilda tank", "Despacito", "Nora T-shirt") # nolint
product_group <- "Garment Upper body"  # Define the product group here
lapply(articles, function(article_name) create_split_plot(article_name, product_group)) # nolint

# Print a message to indicate completion
cat("08_visualize_results.R has finished executing.\n")
