# Clear current terminal before executing code
shell("cls")

# Ensure the year and month columns exist in full_data
full_data <- full_data %>%
  mutate(year = year(t_dat),
         month = month(t_dat, label = TRUE))  # Extract year and month from the transaction date # nolint

# Aggregate the data to get purchase counts per product, including necessary columns # nolint
popular_products <- full_data %>%
  group_by(prod_name, product_type_name, colour_group_name, month, day_of_week, year) %>% # nolint
  summarise(purchase_count = n()) %>%
  ungroup()

# Save the aggregated data for later use
write.csv(popular_products, "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/popular_products.csv", row.names = FALSE) # nolint

# Print a message to indicate completion
cat("03_aggregate_data.R has finished executing.\n")