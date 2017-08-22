#
# Linear Regression
# Seminar 1
# Author: galaa
# Created on 2016/09/09 16:31:00
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 1

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Data

Y <- c(5.6, 8.9, 13.1, 19.8, 4.7, 20.5, 20.2, 13.6, 11.4, 3.3)
X <- c(2.7, 3.7, 5.7, 9.1, 2.0, 9.0, 9.4, 6.6, 6.3, 0.6)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# by using function lm() from the package stats

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

summary(lm(Y ~ X))

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Detailed computation

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# estimation of slope b

b <- cor(Y, X) * sd(Y) / sd(X)

print(b)

# estimation of intercept a

a <- mean(Y) - b * mean(X)

print(a)

# coefficient of determination R^2

SST <- sum((Y - mean(Y))^2)

SSE <- sum((Y - (a + b * X))^2)

R.square <- 1 - SSE / SST

print(R.square)
