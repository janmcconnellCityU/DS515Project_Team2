# Clear current terminal before executing code
shell("cls")

# Load the filtered dataset
popular_products_filtered <- read.csv("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/popular_products_filtered.csv") # nolint

# Load the model if it was saved previously
model <- readRDS("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/purchase_count_model.rds") # nolint

# Split the data into training and testing sets (if this step hasn't been done yet) # nolint
set.seed(123)
train_indices <- sample(seq_len(nrow(popular_products_filtered)), size = 0.7 * nrow(popular_products_filtered)) # nolint

train_data <- popular_products_filtered[train_indices, ]
test_data <- popular_products_filtered[-train_indices, ]

# Make predictions on the test data
predictions <- predict(model, newdata = test_data)

# Combine the predictions with the actual values
predictions_results <- data.frame(
  prod_name = test_data$prod_name,
  colour_group_name = test_data$colour_group_name,
  month = test_data$month,
  year = test_data$year,
  Actual = test_data$purchase_count,
  Predicted = predictions
)

# Save the results for later use
write.csv(predictions_results, "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/predictions_results.csv", row.names = FALSE) # nolint

# Print a message to indicate completion
cat("06_make_predictions.R has finished executing.\n")