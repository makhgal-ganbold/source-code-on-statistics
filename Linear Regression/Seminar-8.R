#
# Linear Regression
# Seminar 8
# Author: galaa
# Created on 2016/11/02 21:08:00
#

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# data

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

set.seed(11)

X_1 = round(runif(n = 20, min = 1, max = 5), digits = 2)
y_1 = X_1 * 3 + 1 + round(rnorm(n = length(X_1)))

X_2 = round(runif(n = 5, min = 5, max = 10), digits = 2)
y_2 = X_2 * 0.5 + 15 + round(rnorm(n = length(X_2)))

X = c(X_1, X_2)
y = c(y_1, y_2)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 22

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# scatter plot

plot(X, y)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 23

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

#install.packages("strucchange")

library(strucchange)

sctest(y ~ X, type = "Chow", point = 20)

# alternate computation

f <- factor(c(rep(1, 20), rep(2, 5)))
m0 <- lm(y ~ X)
m1 <- lm(y ~ f/(X))
anova(m0, m1)

# Detailed computation

# matrix M

M = function (X) {
  X = as.matrix(X)
  n = nrow(X)
  I_n = matrix(rep(c(1,0*(1:n)), times = n), nrow = n, ncol = n)
  M = I_n - X %*% solve(t(X) %*% X) %*% t(X)
  return(M)
}

combine.with.ones = function (X) {
  X = as.matrix(X)
  n = nrow(X)  
  cbind(rep(x = 1, times = n), X)
}

# combine with constant term

X_1 <- combine.with.ones(X_1)
X_2 <- combine.with.ones(X_2)
X <- combine.with.ones(X)

# sample size

n = length(y)

# the number of independent variables

k = dim(X)[2]

# restricted SSE : SSE_ast

u.hat_ast = M(X) %*% y

SSE_ast = t(u.hat_ast) %*% u.hat_ast

# unrestricted SSE : SSE

u.hat_1 = M(X_1) %*% y_1

SSE_1 = t(u.hat_1) %*% u.hat_1

u.hat_2 = M(X_2) %*% y_2

SSE_2 = t(u.hat_2) %*% u.hat_2

SSE = SSE_1 + SSE_2

# test statistics

F = ( (SSE_ast - SSE) / k ) / ( SSE / (n - 2 * k) )

print(F)

# p-value

pf(q = F, df1 = k, df2 = n - 2 * k, lower.tail = FALSE)
