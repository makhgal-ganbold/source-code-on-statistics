##
## Linear Regression
## Seminar 11
## Author: galaa
## Created on 2016/11/09 19:57:00
##

## -----------------------------------------------------------
## Exercise 2
## -----------------------------------------------------------

## data

y = c(-2.42, 1.43, 5.95, -3.29, 8.95, 0.21, 14.38, 15.47, 9.72, 8.31, 9.75, 10.37, 17.28, 9.52, 11.21, 29.1, 11.44, 10.62, 5.58, 9.93)
X2 = c(-1.02, -0.08, -0.23, -0.82, 0.77, -0.17, 0.97, 1.72, 0.26, 0.37, 1.18, 0.64, 1.3, 0.19, 1.59, -0.06, 0.84, 0.16, 0.63, 0.63)
X3 = c(0.5, 0.27, 1.55, 0.19, 0.11, 0.08, 1.8, 0.3, 1.89, 1.44, 0.24, 1.73, 1.55, 1.9, 0.15, 8.86, 1.01, 2.33, 0.21, 1)
X4 = c(0.79, 0.22, 0.81, 0.2, 0.51, 0.52, 0.08, 0.27, 0.81, 0.6, 0.01, 0.37, 0.72, 0.42, 0.24, 0.89, 0.58, 0.97, 0.16, 0.53)

## ---------------------------------------------------------------
## detailed computation
## ---------------------------------------------------------------

## sample size
n = length(y)

## combine constant term
X1 = rep(x = 1, times = n)

## independent variables
X = cbind(X1, X2, X3, X4)

## the number of independent variables
k = dim(X)[2]

## restriction

R = matrix(data = c(0, 1, -2, 0, 0, 0, 0, 1), nrow = 2, byrow = TRUE)
r = c(1, 2)
q = nrow(R)

## parameter estimation

b.hat = solve(t(X) %*% X) %*% t(X) %*% y

## residuals

I_n = matrix(rep(c(1,0*(1:n)), times = n), nrow = n, ncol = n)
M = I_n - X %*% solve(t(X) %*% X) %*% t(X)
u.hat = M %*% y

## SE^2 (estimation of least square method)

SE.square = t(u.hat) %*% u.hat / (n - k)

## Wald statistics and its p-value

W = t(R %*% b.hat - r) %*% solve(R %*% solve(t(X) %*% X) %*% t(R)) %*% (R %*% b.hat - r) / SE.square
print(W)

p.value = pchisq(q = W, df = q, lower.tail = FALSE)
print(p.value)

## ---------------------------------------------------------------
## by using the function linearHypothesis() from the package "car"
## ---------------------------------------------------------------

## linear model

fm = lm(y ~ X2 + X3 + X4)

## library dependencies

# install.packages("car") ## if required
library(car) ## linearHypothesis()

## linear hypothesis; the followings are equivalent

linearHypothesis(model = fm, hypothesis.matrix = R, rhs = r, test = "Chisq")
linearHypothesis(model = fm, c("1 * X2 - 2 * X3 = 1", "X4 = 2"), test = "Chisq")
