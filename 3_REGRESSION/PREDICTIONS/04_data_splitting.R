# Clear current terminal before executing code
shell("cls")

# Load the filtered dataset
popular_products_filtered <- read.csv("C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/popular_products_filtered.csv") # nolint

# Split the data into training and testing sets
set.seed(123)  # For reproducibility

# Assuming a 70/30 train-test split
train_indices <- sample(seq_len(nrow(popular_products_filtered)), size = 0.7 * nrow(popular_products_filtered)) # nolint

train_data <- popular_products_filtered[train_indices, ]
test_data <- popular_products_filtered[-train_indices, ]

# Print a message to indicate completion
cat("04_data_splitting.R has finished executing.\n")