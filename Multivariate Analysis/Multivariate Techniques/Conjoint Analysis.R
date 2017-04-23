#
# Conjoint Analysis
# Author: galaa
# Created on 2017/04/23 16:46:00
#

## Package Dependence

# to install required package rgl due to install conjoint on Ubuntu Linux
# sudo apt-get install r-cran-rgl
require(conjoint)

## n = 1

X = expand.grid(packing = c("biscuit", "plastic"), ingredients = c("curd", "chocolate", "fruit"))
y = c(2, 1, 6, 3, 5, 4)

caModel(y = y, x = X) # Remember $\sum_{l=1}^{L_k}\beta_{kl}=0$

caUtilities(y = y, x = X, z = factor(c(1:5))) # $\mu$ \& $\beta_{ij}$

caTotalUtilities(y = y, x = X) # $\hat{Y}$

caImportance(y = y, x = X) # importance of factors

## n > 1

X = expand.grid(X1 = 1:2, X2 = 1:3)
y = c(1, 2, 3, 5, 4, 6, 2, 1, 4, 5, 3, 6)

Conjoint(y = y, x = X, z = factor(c(1:5)))

caUtilities(y = y, x = X, z = factor(c(1:5)))

caPartUtilities(y = y, x = X, z = factor(c(1:5))) # Utilities for all respondents

caTotalUtilities(y = y, x = X)

ShowAllUtilities(y = y, x = X, z = factor(c(1:5)))

caImportance(y = y, x = X)

caSegmentation(y = y, x = X, c = 3) # k-means clustering, c > 3, n > c
