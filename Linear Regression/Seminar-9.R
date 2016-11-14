#
# Linear Regression
# Seminar 9
# Author: galaa
# Created on 2016/11/09 19:57:00
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 24

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# data

set.seed(11); n = 20

X1 = round(rexp(n = n), digits = 2)
X2 = round(rnorm(n = n), digits = 2)
X3 = round(1 + 2 * X1 - 3 * X2 + rnorm(n = n), digits = 2)
y = round(2 + X1 + 2 * X2 + X3 + rnorm(n = n), digits = 2)

cbind(y, X1, X2, X3)

# by using correlation matrix

cor(cbind(X1, X2, X3))

# by using the function vif()

fit = lm(y ~ X1 + X2 + X3)

summary(fit)

# install.packages("car")

library(car) # vif

vif(fit)

# detailed computation

R2.squared = summary(lm(X3 ~ X1 + X2))$r.squared

VIF = 1 / (1 - R2.squared)

print(VIF)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 25

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# data: generation

set.seed(11);  n = 30

X = round(runif(n = n, min = 0, max = 5), digits = 2)
C = rbinom(n = n, size = 2, prob = 0.5)
y = round(2 - 2 * X + 3 * C + rnorm(n = n), digits = 2)

cbind(y, X, C)

# data: direct input

y = c(1.12, 4.06, 0.58, 0.28, 6.49, -4.06, 3.95, 0.65, -4.41, 0.41, -1.40, -2.38, -3.19, -4.39, -1.45, 1.92, -2.01, -0.42, 4.14, 3.42, 3.75, -2.03, 0.54, 2.00, 1.54, 0.70, 0.84, 8.28, 2.23, 1.08)
X = c(1.39, 0.00, 2.55, 0.07, 0.32, 4.77, 0.43, 1.45, 4.40, 0.62, 0.88, 2.20, 4.54, 4.26, 3.67, 2.87, 2.41, 1.65, 0.79, 2.40, 1.02, 3.40, 1.82, 1.75, 0.31, 2.42, 2.00, 0.08, 0.63, 1.99)
C = c(1, 1, 1, 0, 2, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 2, 1, 0, 1, 2, 1, 1, 1, 1, 0, 1, 1, 2, 0, 1)

# dummy variables

D1 = ifelse(C == 1, 1, 0)
D2 = ifelse(C == 2, 1, 0)

# linear model

summary(lm(y ~ X + D1 + D2))
