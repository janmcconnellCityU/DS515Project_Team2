# Clear current terminal before executing code
shell("cls")

# Load the model if it was saved previously
model <- readRDS("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/purchase_count_model.rds") # nolint

# Save the model for future use
saveRDS(model, "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/purchase_count_model_final.rds") # nolint

# Print a message to indicate completion
cat("09_save_model.R has finished executing.\n")