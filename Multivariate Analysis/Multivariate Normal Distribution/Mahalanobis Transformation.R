#
# Mahalanobis Transformation
# Author: galaa
# Created on 2017/02/16 14:35:30
#

## Normal data (two dimensional)
Y = matrix(rnorm(n = 250 * 2), ncol = 2)

## Distribution Parameters
mu = c(3,2)
Sigma = matrix(data = c(1,-3/2,-3/2,4), nrow = 2, ncol = 2)

## Mahalanobis Transformation
X = t(sqrtm(Sigma) %*% t(Y) + mu)

## Validation (compare following results against distribution parameters)
cov(X)
colMeans(X)
