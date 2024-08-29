# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)
library(cluster)  # For clustering algorithms
library(factoextra)  # For visualizing clusters

# Define the directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Load the datasets
articles <- read_csv(paste0(data_directory_path, "articles.csv")) # nolint
transactions_train <- read_csv(paste0(data_directory_path, "transactions_train.csv")) # nolint

# Filter data for 'Garment Upper Body'
garment_upper_body_articles <- articles %>% filter(product_group_name == "Garment Upper body") # nolint

# Merge articles and transactions data
garment_upper_body_transactions <- transactions_train %>% # nolint
  inner_join(garment_upper_body_articles, by = "article_id")

# Aggregate customer transaction data
customer_data <- garment_upper_body_transactions %>%
  group_by(customer_id) %>%
  summarise(
    total_purchases = n(),
    total_spending = sum(price),
    average_spending = mean(price)
  )

# Normalize the data (ensure columns are numeric)
customer_data_scaled <- customer_data %>%
  mutate(
    total_purchases = as.numeric(scale(total_purchases)),
    total_spending = as.numeric(scale(total_spending)),
    average_spending = as.numeric(scale(average_spending))
  )

# Save the prepared data
write_csv(customer_data_scaled, paste0(output_directory_path, "customer_data_scaled.csv")) # nolint

# Sample the data to handle memory limitations
set.seed(123)
customer_data_sample <- customer_data_scaled %>% sample_n(10000)

# Step 2: K-means Clustering
# Determine the optimal number of clusters using the Elbow method
set.seed(123)
elbow_plot <- fviz_nbclust(customer_data_sample[, -1], kmeans, method = "wss")

# Save the elbow plot
ggsave(paste0(output_directory_path, "04_elbow_plot.png"), plot = elbow_plot, width = 10, height = 8) # nolint

# Perform K-means clustering
set.seed(123)
kmeans_result <- kmeans(customer_data_sample[, -1], centers = 4, nstart = 25)

# Add cluster assignment to the data
customer_data_sample$cluster <- kmeans_result$cluster

# Visualize the clusters
cluster_plot <- fviz_cluster(kmeans_result, data = customer_data_sample[, -1])

# Save the cluster plot
ggsave(paste0(output_directory_path, "04_kmeans_cluster_plot.png"), plot = cluster_plot, width = 10, height = 8) # nolint

# Save the cluster assignment data
write_csv(customer_data_sample, paste0(output_directory_path, "customer_clusters_kmeans_sample.csv")) # nolint

# Step 3: Agglomerative Clustering
# Compute the dissimilarity matrix
dissimilarity_matrix <- dist(customer_data_sample[, -1])

# Perform hierarchical clustering
hclust_result <- hclust(dissimilarity_matrix, method = "ward.D2")

# Cut the tree into 4 clusters (this will limit the number of branches)
customer_data_sample$hclust_cluster <- cutree(hclust_result, k = 4)

# Visualize the dendrogram with the cut
dendrogram_plot <- fviz_dend(hclust_result, k = 4, rect = TRUE, rect_fill = TRUE) # nolint

# Save the dendrogram plot
ggsave(paste0(output_directory_path, "04_dendrogram.png"), plot = dendrogram_plot, width = 10, height = 8) # nolint

# Save the hierarchical clustering assignment data
write_csv(customer_data_sample, paste0(output_directory_path, "customer_clusters_hclust_sample.csv")) # nolint
