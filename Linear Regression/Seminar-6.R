#
# Linear Regression
# Seminar 6
# Author: galaa
# Created on 2016/10/31 09:43:00
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 19

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# data

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

y = c(-7.4, 14.5, 9.9, 2.3, 3.1, 3.3, -0.1, -2.8, 10.8, -4.5, 14.9, -2.7, 14.3, 13.1, 28.6)

X = matrix(
  data = c(1.6, 9.7, 4.7, 7.8, 4.1, 5.4, 2.1, 1.9, 7.8, 1.9, 4.3, 0, 8.3, 8.3, 9.6, 2.7, 1, -0.7, 1.2, 0.6, 2.4, 1, 1.7, 2, 2.5, -1.5, 0.9, 0.9, 2.7, -0.9, 4.7, 9.2, 5.8, 8.1, 8.2, 8.4, 1.6, 1.4, 13.4, 2, 10.8, 5.6, 6.3, 6.9, 1.4),
  nrow = 15,
  ncol = 3,
  byrow = FALSE
)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Results by built-in function lm()

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

summary(lm(y ~ X))

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Detailed computation

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# sample size

n = length(y)

# combine with constant term

X <- cbind(rep(x = 1, times = n), X)

# k

k = dim(X)[2]

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# sub problem : A : H_0:b_4=0

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# blocks

X1 = X[,1:3]; X2 = X[,4]

# matrix M1

I_n = matrix(rep(c(1,0*(1:n)), times = n), nrow = n, ncol = n)

M1 = I_n - X1 %*% solve(t(X1) %*% X1) %*% t(X1)

# b2.hat = \hat{b}_4

b2.hat = solve(t(X2) %*% M1 %*% X2) %*% t(X2) %*% M1 %*% y

print(b2.hat)

# residuals

I_n = matrix(rep(c(1,0*(1:n)), times = n), nrow = n, ncol = n)

M = I_n - X %*% solve(t(X) %*% X) %*% t(X)

u.hat = M %*% y

# Standart error

SE = sqrt(t(u.hat) %*% u.hat / (n - k))

# Standart Error of parameter \hat{b}_4 (b2.hat)

SE.b2.hat = SE * sqrt(solve(t(X) %*% X)[4,4])

# t statistics and its sig.level for H_0:\hat{b}_4=0

t = b2.hat / SE.b2.hat

print(t)

p.value = 2 * pt(q = abs(t), df = n - k, lower.tail = FALSE)

print(p.value)

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# sub problem : A : H_0:b_2=b_3=B_4=0

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

SSE = t(u.hat) %*% u.hat

SST = t(y) %*% y - n * mean(y)^2

SSR = SST - SSE

F = (SSR / (k - 1)) / (SSE / (n - k))

p.vaule = pf(q = F, df1 = k - 1, df2 = n - k, lower.tail = FALSE)
