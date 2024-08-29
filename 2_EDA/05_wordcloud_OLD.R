# Load necessary libraries
library(tm) # Text mining
library(wordcloud) # Making word clouds
dev.off()
library(RColorBrewer) # Making word clouds colorful
library(e1071) # Naive Bayes model
library(SnowballC) # Text processing
library(caret) # Confusion matrix

# Set the data and output directory paths
data_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/_fashiondata/" # nolint
output_directory_path <- "C:/Users/JanMc/Dropbox/Education/02 CityUniversity Coursework 2024 Summer/DS 515 Data Science Overview/_team project/ggplot2 images captured/" # nolint

# Ensure the output directory exists
if (!dir.exists(output_directory_path)) {
  dir.create(output_directory_path, recursive = TRUE)
}

# Setting random seed for reproducibility
set.seed(515)

# Step 1: Data loading and exploration
articlesData <- read.csv(paste0(data_directory_path, "articles_cleaned.csv")) # nolint
articlesData$prod_name <- as.character(articlesData$prod_name) # nolint
articlesData$product_type_name <- as.character(articlesData$product_type_name) # nolint
head(articlesData)
str(articlesData)

# Step 2: Data visualization
png(filename = paste0(output_directory_path, "wordcloud_prod_name.png"), width = 800, height = 600) # nolint
wordcloud(articlesData$prod_name, max.words = 100, random.order = FALSE,
dev.off()
colors = brewer.pal(7, "Dark2"))

png(filename = paste0(output_directory_path, "wordcloud_product_type_name.png"), width = 800, height = 600) # nolint
wordcloud(articlesData$product_type_name, max.words = 100, random.order = FALSE,
dev.off()
colors = brewer.pal(7, "Dark2"))

prop.table(table(articlesData$type))

# Step 3: Data preprocessing
# Create corpus (a collection of text documents)
articlesData$prod_name <- as.character(articlesData$prod_name) # nolint
articlesData$product_type_name <- as.character(articlesData$product_type_name) # nolint
as.character(articles_corpus[[1]])

# To lowercase transformation
corpus_clean <- tm_map(articles_corpus, content_transformer(tolower))
as.character(corpus_clean[1])

# Remove punctuation transformation
corpus_clean <- tm_map(corpus_clean, removePunctuation)
as.character(corpus_clean[[1]])

# Stem document transformation
corpus_clean <- tm_map(corpus_clean, stemDocument)
as.character(corpus_clean[[1]])

# Remove stopwords transformation
corpus_clean <- tm_map(corpus_clean, removeWords, stopwords("en"))
as.character(corpus_clean[[1]])

# DTM sparse matrix
articles_dtm <- DocumentTermMatrix(corpus_clean)
articles_dtm

articles_dtm <- DocumentTermMatrix(articles_corpus, control = list(
tolower = TRUE,
removeNumbers = TRUE,
removePunctuation = TRUE,
stemming = TRUE,
stopwords = TRUE
))
articles_dtm

# Step 4: Data Visualization after Preprocessing
cleaned_articles <- data.frame(text = sapply(corpus_clean, as.character),
stringsAsFactors = FALSE,
type = articlesData$type)

# Create wordcloud for the cleaned articles
dev.off()
png(filename = paste0(output_directory_path, "wordcloud_prod_name.png"), width = 800, height = 600) # nolint
wordcloud(articlesData$prod_name, max.words = 100, random.order = FALSE,
dev.off()
colors = brewer.pal(7, "Dark2"))

png(filename = paste0(output_directory_path, "wordcloud_product_type_name.png"), width = 800, height = 600) # nolint
wordcloud(articlesData$product_type_name, max.words = 100, random.order = FALSE,
dev.off()
colors = brewer.pal(7, "Dark2"))

# Create wordcloud for the specific article type
dev.off()
specific_articles <- subset(cleaned_articles, type == "specific_type")  # Replace "specific_type" with the actual type you want # nolint
png(filename = paste0(output_directory_path, "wordcloud_prod_name.png"), width = 800, height = 600) # nolint
wordcloud(specific_articles$prod_name, max.words = 100, random.order = FALSE,
dev.off()
colors = brewer.pal(7, "Dark2"))

png(filename = paste0(output_directory_path, "wordcloud_product_type_name.png"), width = 800, height = 600) # nolint
wordcloud(specific_articles$product_type_name, max.words = 100, random.order = FALSE, # nolint
dev.off()
colors = brewer.pal(7, "Dark2"))

# Create wordcloud for another article type
dev.off()
another_type_articles <- subset(cleaned_articles, type == "another_type")  # Replace "another_type" with the actual type you want # nolint
png(filename = paste0(output_directory_path, "wordcloud_prod_name.png"), width = 800, height = 600) # nolint
wordcloud(another_type_articles$prod_name, max.words = 100, random.order = FALSE, # nolint
dev.off()
colors = brewer.pal(7, "Dark2"))

png(filename = paste0(output_directory_path, "wordcloud_product_type_name.png"), width = 800, height = 600) # nolint
wordcloud(another_type_articles$product_type_name, max.words = 100, random.order = FALSE, # nolint
dev.off()
colors = brewer.pal(7, "Dark2"))

# Step 5: Splitting the data
# Split into training & test set
articles_dtm_train <- articles_dtm[1:4457, ]
articles_dtm_test <- articles_dtm[4458:5572, ]

# Split into training & test labels
articles_train_labels <- articlesData[1:4457, ]$type
articles_test_labels <- articlesData[4458:5572, ]$type

# Proportion for training & test labels
prop.table(table(articles_train_labels))
prop.table(table(articles_test_labels))

# Step 6: Trimming the data
threshold <- 0.1
min_freq <- round(articles_dtm$nrow * (threshold / 100), 0)
min_freq

# Create vector of most frequent words
freq_words <- findFreqTerms(x = articles_dtm, lowfreq = min_freq)
str(freq_words)

# Filter the DTM
articles_dtm_freq_train <- articles_dtm_train[, freq_words]
articles_dtm_freq_test <- articles_dtm_test[, freq_words]

dim(articles_dtm_freq_train)
dim(articles_dtm_freq_test)

# Convert values to either yes or No
convert_values <- function(x) {
x <- ifelse(x > 0, "Yes", "No")
}

articles_train <- apply(articles_dtm_freq_train, MARGIN = 2, convert_values)
articles_test <- apply(articles_dtm_freq_test, MARGIN = 2, convert_values)

# Step 7: Training the Naive Bayes model
# Create model from the training dataset
articles_classifier <- naiveBayes(articles_train, articles_train_labels)

# Step 8: Evaluate the naive Bayes model
# Make predictions on test set
articles_test_pred <- predict(articles_classifier, articles_test)

# Convert articles_test_pred and articles_test_labels to factors
articles_test_pred <- as.factor(articles_test_pred)
articles_test_labels <- as.factor(articles_test_labels)

# Create confusion matrix
confusionMatrix(data = articles_test_pred, reference = articles_test_labels,
positive = "specific_type", dnn = c("Prediction", "Actual"))
