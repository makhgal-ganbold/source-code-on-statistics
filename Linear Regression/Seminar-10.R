##
## Linear Regression
## Seminar 10
## Author: galaa
## Created on 2016/11/18 10:27:00
##

## -----------------------------------------------------------
## Exercise 1
## -----------------------------------------------------------

## data

y = c(-2.42, 1.43, 5.95, -3.29, 8.95, 0.21, 14.38, 15.47, 9.72, 8.31, 9.75, 10.37, 17.28, 9.52, 11.21, 29.1, 11.44, 10.62, 5.58, 9.93)
X2 = c(-1.02, -0.08, -0.23, -0.82, 0.77, -0.17, 0.97, 1.72, 0.26, 0.37, 1.18, 0.64, 1.3, 0.19, 1.59, -0.06, 0.84, 0.16, 0.63, 0.63)
X3 = c(0.5, 0.27, 1.55, 0.19, 0.11, 0.08, 1.8, 0.3, 1.89, 1.44, 0.24, 1.73, 1.55, 1.9, 0.15, 8.86, 1.01, 2.33, 0.21, 1)
X4 = c(0.79, 0.22, 0.81, 0.2, 0.51, 0.52, 0.08, 0.27, 0.81, 0.6, 0.01, 0.37, 0.72, 0.42, 0.24, 0.89, 0.58, 0.97, 0.16, 0.53)

## ---------------------------------------------------------------
## by using the function lrtest() from the package "lmtest"
## ---------------------------------------------------------------

# install.packages("lmtest") ## if required
library(lmtest) ## lrtest

lrtest(lm(y ~ X2 + X3 + X4), lm(y ~ X2 + X3)) ## models must be nested

## ---------------------------------------------------------------
## detailed computation with the function lm()
## ---------------------------------------------------------------

## residuals (models)

fm = lm(y ~ X2 + X3 + X4)
fm.ast = lm(y ~ X2 + X3)

u = residuals(fm)
u.ast = residuals(fm.ast)

## the number of restrictions
q = length(fm$coefficients) - length(fm.ast$coefficients)

## sample size
n = length(y)

## Likelihood Ratio statistic and its p-value

LR = n * log((t(u.ast) %*% u.ast) / (t(u) %*% u))
print(LR)

p.value = pchisq(q = LR, df = q, lower.tail = FALSE)
print(p.value)
