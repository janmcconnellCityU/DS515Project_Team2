# Clear current terminal before executing code
shell("cls")

# Evaluate the model using RMSE and MAE
rmse <- sqrt(mean((results$Actual - results$Predicted)^2))
cat("RMSE: ", rmse, "\n")

mae <- mean(abs(results$Actual - results$Predicted))
cat("MAE: ", mae, "\n")

# Print a message to indicate completion
cat("07_evaluate_model.R has finished executing.\n")