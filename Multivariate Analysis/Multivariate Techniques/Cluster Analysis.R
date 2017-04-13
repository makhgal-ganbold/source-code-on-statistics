#
# Cluster Analysis
# Author: galaa
# Created on 2016/03/19 07:49:41
#

## Data

X = matrix(
  c(-21.9, -15.2, -17.1, -18.3, -20.5, -17.8, -20.6, -23.7, -20.2, -17.7, -17.3, -22.7, -14.4, -13.8, -21.2, -22.2, -20.2, -22.4, -23.9, -21.8, -30.6, -24.0, -16.3, -11.3, -13.0, -14.1, -16.0, -14.5, -15.1, -18.0, -15.0, -11.8, -12.3, -18.4, -10.7, -9.0, -16.0, -16.3, -15.7, -16.9, -18.6, -16.2, -27.6, -18.5, -7.3, -5.7, -5.9, -6.8, -7.4, -8.3, -6.1, -6.4, -7.0, -2.7, -4.8, -9.8, -5.2, -1.5, -6.6, -5.8, -8.1, -5.7, -8.1, -6.6, -16.3, -7.1, 2.7, 3.3, 2.9, 2.8, 2.9, 0.8, 3.8, 4.6, 4.6, 7.5, 4.5, 2.1, 3.4, 7.8, 4.7, 4.8, 1.7, 5.5, 3.8, 3.7, 2.8, 4.4, 10.2, 9.5, 10.5, 10.2, 10.0, 8.0, 11.7, 12.2, 12.4, 15.1, 11.9, 9.4, 9.8, 14.6, 12.5, 12.2, 9.1, 13.0, 11.6, 11.1, 12.7, 11.8, 16.4, 14.7, 15.9, 16, 15.8, 13.7, 18, 18.4, 19, 21.5, 18.2, 15.2, 15.5, 20.4, 18.6, 18.5, 15.3, 18.6, 17.8, 17, 18.4, 18, 19.3, 16.6, 17.9, 18.2, 17.9, 16, 21, 20.8, 21.7, 24.5, 21.1, 17.6, 17.8, 23.3, 21.5, 21, 18.1, 20.6, 20.5, 18.8, 20.6, 20.4, 16.7, 14.7, 15.9, 16.1, 15.6, 13.6, 18.2, 18.4, 19.3, 21.7, 18.4, 14.8, 15.6, 20.7, 19.3, 18.4, 15.5, 18.2, 17.8, 16.4, 17.8, 17.8, 9.9, 9.0, 9.6, 9.7, 8.5, 7.6, 11.6, 11.0, 12.2, 15.1, 11.9, 8.2, 10.2, 14.9, 12.5, 10.9, 8.9, 11.9, 10.9, 9.4, 10.5, 10.3, 0.5, 1.5, 1.3, 0.6, -0.2, -0.9, 1.9, 1.7, 2.2, 5.1, 2.6, -0.9, 2.1, 5.8, 2.4, 1.8, -0.4, 2.4, 0.7, 0.9, 1.6, 0.8, -11.4, -7.2, -7.7, -9.2, -11.1, -9.7, -9.8, -10.4, -9.6, -6.7, -8.1, -12.5, -6.9, -4.2, -9.6, -9.9, -11.1, -8.9, -11.9, -9.9, -8.6, -11.2, -19.6, -12.6, -14.4, -15.8, -18.2, -15.0, -17.8, -20.2, -17.7, -15.1, -15.0, -19.9, -12.3, -11.2, -18.2, -19.3, -17.7, -18.0, -20.5, -18.3, -23.6, -20.4),
  nrow = 22,
  ncol = 12,
  byrow = FALSE
)

## Alternate Data

# X = matrix(c(2,-1,3,2,-1,2,2,3),  nrow = 4,  ncol = 2,  byrow = TRUE)

## View Data

print(X)

## Prepare Data

X <- na.omit(X) # listwise deletion of missing value
X <- scale(X) # standardize variables

## Hierarchical Agglomerative

d <- dist(X, method = "euclidean") # distance matrix
cl <- hclust(d, method = "ward.D")
plot(cl) # display dendrogram
cl$height
groups <- cutree(cl, k = 5) # cut tree into 5 clusters
rect.hclust(cl, k = 5, border = "red") # draw dendogram with red borders around the 5 clusters; DON'T CLOSE PREVIOUS PLOT 

## K-Means Cluster Analysis

cl <- kmeans(X, 5) # 5 cluster solution
aggregate(X, by = list(cl$cluster), FUN = mean) # get cluster means
cl$centers
cl$cluster # cluster membership

## Plotting Cluster Solutions

cl <- kmeans(X, 5) # K-Means Clustering with 5 clusters

library(cluster)
clusplot(X, cl$cluster, color = TRUE, shade = TRUE, labels = 2, lines = 0) # Cluster Plot against 1st 2 principal components

## Comparing 2 cluster solutions

cl1 <- kmeans(X, 5)
cl2 <- kmeans(X, 4)

library(fpc)
cluster.stats(d, cl1$cluster, cl2$cluster)
cluster.stats # view function source code
?cluster.stats # documentation

## Single Linkage Algorithm

set.seed(17)

# generate elliptic data
Sigma = matrix(data = c(2,1,1,2), nrow = 2, ncol = 2, byrow = TRUE)
p = dim(Sigma)[1]; Y = c()
for (i in 1:100) {
  Z = rnorm(n = p)
  Y = rbind(Y, runif(1, min = 1.5, max = 2)^(1/p) * Z / sqrt(sum(Z^2)))
}
X = t(solve(t(chol(Sigma))) %*% t(Y))

# combine with normal data
X = rbind(X, matrix(rnorm(75 * p, sd = 0.15), ncol = p))

# hierarchical clustering with single linkage method and dividing into two groups
plot(X, col = cutree(hclust(dist(X), "single"), k = 2))
