#
# Training Program for R Langauge
# Topic 12 - Cluster Analysis, Discriminant Analysis
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/13 05:00:00
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Кластерийн шинжилгээ

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Шатлах алгоритм, цуглуулах арга

X = matrix(c(2,-1,3,2,-1,2,2,3), ncol = 2, byrow = TRUE)
d = dist(X, method = "euclidean")
clust <- hclust(d, method = "average")
plot(clust)
clust$height

## Хэсэгчлэх алгоритм

X = matrix(c(5,3,-1,1,1,-2,-3,-2), ncol = 2, byrow = TRUE)
kmeans(X, centers = 2)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Дискриминантын шинжилгээ

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

Z = data.frame(
  X1 = c(60,71,60,80,85,85,80,60,70,76,70),
  X2 = c(72,74,64,68,70,66,82,94,96,90,94),
  group = factor(c(1,1,1,1,1,2,2,2,2,2,2))
)
install.packages("MASS")
library(MASS) # lda() predict()
r = lda(formula = group ~ X1 + X2, data = Z)
print(r)

predict(object = r, newdata = Z)
