# Clear current terminal before executing code
shell("cls")

# Convert categorical variables to factors
full_data <- full_data %>%
  mutate(
    prod_name = as.factor(prod_name),
    product_type_name = as.factor(product_type_name),
    colour_group_name = as.factor(colour_group_name),
    month = month(t_dat, label = TRUE),
    quarter = quarter(t_dat, with_year = TRUE),
    year = year(t_dat),
    day_of_week = wday(t_dat, label = TRUE)
  )

# Print a message to indicate completion
cat("02_feature_engineering.R has finished executing.\n")