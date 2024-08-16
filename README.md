# **DS515Project_Team2**
# **Hybrid Recommendation System Project**

This project is developed as part of the **DS515_01_ON: Data Science Overview** course at the **City University of Seattle**. The goal of this project is to create a hybrid recommendation system using collaborative filtering and segmentation techniques with R programming.

## **Team Members**

- **Jan McConnell** - [janmcconnell@cityuniversity.edu](mailto:janmcconnell@cityuniversity.edu)
- **Miray Rosalia** - [mirayrosalia@cityuniversity.edu](mailto:mirayrosalia@cityuniversity.edu)
- **Humaira Khan** - [khanhumairaakram@cityuniversity.edu](mailto:khanhumairaakram@cityuniversity.edu)
- **Johnathan Roberts** - [robertsjohnathan@cityuniversity.edu](mailto:robertsjohnathan@cityuniversity.edu)

## **Project Description**

The goal of this project is to develop a hybrid recommendation system that utilizes collaborative filtering and segmentation techniques using R programming to target improvements in the recommendation system for new customers. We will utilize segmentation techniques such as **K-means** and **agglomerative clustering** to provide customer segment profiles that can be utilized by collaborative filtering to improve recommendations. We will evaluate the recommendation system using metrics such as **Precision**, **Recall**, **F1-Score**, **RMSE (Root Mean Square Error)**, and **MAE (Mean Absolute Error)**. We will also compare the performance of the hybrid system and those of the individual collaborative and clustering methods, utilizing data visualization techniques to illustrate results. We will also consider the impact of scalability and processing time on the recommendation systems’ usability and success.

## **Summary of Processes**

**1. Data Loading and Inspection:**
- Loaded datasets (articles_cleaned.csv and transactions_cleaned.csv) using the readr package.
- Inspected and filtered the data to focus on the "Garment Upper Body" product group.

**2. Univariate Analysis:**
- Created various univariate plots to explore the distribution of different variables within the "Garment Upper Body" product group.
- Used ggplot2 to generate and save visualizations such as bar charts and line charts.

**3. Time Series Analysis:**
- Analyzed trends over time by plotting the number of transactions and total sales for the "Garment Upper Body" product group.
- Created smoothed line plots to observe long-term trends in the data.

**4. Clustering Analysis:**
- Performed K-means clustering to segment customers based on their purchasing behavior, using the cluster package.
- Visualized the clusters using factoextra, providing insights into the distinct customer segments.
- Conducted agglomerative hierarchical clustering and visualized the results using dendrograms.
- Explored the optimal number of clusters using the elbow method.

**5. Visualization and Reporting:**
- Saved and documented the various visualizations created during the analysis.
- Provided explanations and interpretations of key visual outputs, such as the elbow plot, cluster plot, and dendrogram.

## **Acknowledgments**

We would like to thank our instructor, **Dr. Paul Dooley**, and the **City University of Seattle** for providing the resources and guidance needed to complete this project.
