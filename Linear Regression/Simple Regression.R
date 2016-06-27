#
# Linear Regression
# Author: galaa
# Created on 2016/05/09 12:00:00
#

# Generate random data for Linear Regression Model X = 1 + 2 * t + epsilon

set.seed(1); beta = c(1, 2); n = 10;

Z = cbind(rep(1, n), round(runif(n = n, min = 0, max = 10), digits = 1));
print(Z);
epsilon = round(rnorm(n = n, mean = 0, sd = 1), digits = 1);

X = Z %*% beta + epsilon;
print(X);

cbind(X,Z);
cbind(Z[,2],X);

# Regression Analysis with built-in (stats package) function

result <- lm(X ~ Z[,2]);
print(result);
summary(result);
confint(result, level = 0.95);
fitted(result);
residuals(result);

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Detailed computation

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Parameter estimation

A = t(Z) %*% Z;
Y = t(Z) %*% X;

A_inv = solve(A);
beta_hat = A_inv %*% Y;
print(beta_hat);

# Fitted values

X_hat = Z %*% beta_hat;
print(X_hat);

# Residuals

epsilon = X - X_hat;
print(epsilon);
fivenum(epsilon);

# Residual Standard Error

SSE = t(epsilon) %*% epsilon;
k = length(Z[1,]);
SE = sqrt(SSE/(n-k));
print(SE);

# Standard Error of Parameter Estimation

for (j in 1:k) {
  print(SE * sqrt(A_inv[j,j]));
}

# R-Squared (Coefficeint of Determination)

SST = t(X - mean(X)) %*% (X - mean(X));
print(1 - SSE / SST);

# Adjusted R-Squared

print(1 - (SSE / (n - k)) / (SST / (n - 1)));

# t statistic and its p-value (two tailed)

for (j in 1:k) {
  t = beta_hat[j] / (sqrt(A_inv[j,j]) * SE);
  print(t);
  print(pt(t, df = n - k, lower.tail = FALSE) * 2);
}

# Confidence interval of parameter estimation

gamma = 0.95;
t_gamma = qt(p = (1 + gamma) / 2, df = n - k, lower.tail = TRUE);
for (j in 1:k) {
  m = t_gamma * sqrt(A_inv[j,j]) * SE;
  print(c(beta_hat[j] - m, beta_hat[j] + m));
}

# F statistic and its p-value

SSR = SST - SSE;
F = (SSR / (k-1)) / (SSE / (n-k));
print(F);
print(pf(F, df1 = k - 1, df2 = n - k, lower.tail = FALSE));
