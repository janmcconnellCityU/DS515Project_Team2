# Load the filtered dataset
popular_products_filtered <- read.csv("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/popular_products_filtered.csv") # nolint

# Build a linear regression model to predict purchase counts with the filtered data # nolint
model <- lm(purchase_count ~ prod_name + colour_group_name + month + day_of_week + year, data = popular_products_filtered) # nolint

# View the summary of the model
summary(model)

# Optional: Save the model for future use
saveRDS(model, "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/purchase_count_model.rds") # nolint

# Print a message to indicate completion
cat("05_build_model.R has finished executing.\n")