# Clear current terminal before executing code
shell("cls")

# Load necessary libraries
library(dplyr)
library(ggplot2)

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Filter for "Garment Upper body"
filtered_articles <- articles %>%
  filter(product_group_name == "Garment Upper body")

# Normalize color name spelling
filtered_articles$colour_group_name <- gsub("Colour", "Color", filtered_articles$colour_group_name, ignore.case = TRUE) # nolint

# Identify top 5 most popular colors
top_colors <- filtered_articles %>%
  count(colour_group_name, sort = TRUE) %>%
  top_n(5, wt = n)  # Select top 5 colors

# Merge with transactions to get the popularity data using prod_name instead of article_id # nolint
popular_articles <- transactions_train %>%
  inner_join(filtered_articles, by = "article_id") %>%
  count(prod_name, product_type_name, colour_group_name, sort = TRUE)

# Select the top 5 products by total transactions
top_5_products <- popular_articles %>%
  group_by(prod_name, product_type_name) %>%
  summarise(total_transactions = sum(n), .groups = "drop") %>%
  slice_max(order_by = total_transactions, n = 5) %>%  # Select top 5 products
  ungroup()

# Create new label for x-axis with product name and type
top_5_products <- top_5_products %>%
  mutate(prod_label = paste(prod_name, "(", product_type_name, ")", sep = ""))

# Filter the original data for only the top 5 products and top 5 colors
top_popular_articles <- popular_articles %>%
  filter(prod_name %in% top_5_products$prod_name &
           colour_group_name %in% top_colors$colour_group_name) %>%
  group_by(prod_name, colour_group_name) %>%
  slice_max(order_by = n, n = 5) %>%  # Select the top 5 colors within each product # nolint
  ungroup()

# Join with top_5_products to get correct labels and total_transactions
top_popular_articles <- top_popular_articles %>%
  inner_join(top_5_products %>% select(prod_name, prod_label, total_transactions), by = "prod_name") # nolint

# Visualization: Bar plot of the top 5 most popular articles and their top 5 colors # nolint
ggplot(top_popular_articles, aes(x = reorder(prod_label, -total_transactions), y = n, fill = colour_group_name)) + # nolint
  geom_bar(stat = "identity", position = "stack") +
  geom_text(aes(label = n, color = colour_group_name),
            position = position_stack(vjust = 0.5), size = 3) +  # Center counts vertically and horizontally, color text based on bar color # nolint
  scale_fill_manual(values = c("Black" = "black", "White" = "white",
                               "Dark Blue" = "darkblue",
                               "Grey" = "gray",
                               "Light Pink" = "lightpink")) +
  scale_color_manual(values = c("Black" = "white", "White" = "black",
                                "Dark Blue" = "white", "Grey" = "black",
                                "Light Pink" = "black")) +  # Set specific text colors for each fill color # nolint
  labs(title = "Top 5 Most Popular Articles for 'Garment Upper body' and Top 5 Colors", # nolint
       x = "Product Name", y = "Number of Transactions") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),  # Rotate x-axis labels for better readability # nolint
        legend.position = "none",  # Remove legend
        panel.background = element_rect(fill = "lightgray"), # Background color # nolint
        plot.background = element_rect(fill = "lightgray"))  # Apply background color to the whole plot # nolint

# Save the plot
ggsave(paste0(output_directory_path, "01b_top_popular_articles_top_5_5_colors.png"), width = 10, height = 8) # nolint
