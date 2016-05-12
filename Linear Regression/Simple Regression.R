
# Generate random data

set.seed(1); beta = c(1, 2); n = 10;

Z = cbind(rep(1, n), round(runif(n = n, min = 0, max = 10), digits = 1));
print(Z);
epsilon = round(rnorm(n = n, mean = 0, sd = 1), digits = 1);

X = Z %*% beta + epsilon;
print(X);

cbind(Z[,2],X);

# Regression Analysis with built-in (stats package) function

result <- lm(X ~ Z[,2]);
print(result);
summary(result);
confint(result, level = 0.95);
residuals(result);
fitted(result);

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Detailed calculation

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Parameter estimation

A = t(Z) %*% Z;
Y = t(Z) %*% X;

library(MASS);
A_inv = ginv(A);
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

for(i in 1:2){
  print(sqrt(A_inv[i,i]) * SE);
}

# R-Squared (Coefficeint of Determination)

SST = t(X - mean(X)) %*% (X - mean(X));
print(1 - SSE / SST);

# Adjusted R-Squared

print(1 - (SSE / (n - k)) / (SST / (n - 1)));

# t statistic and its p-value (two tailed)

for(i in 1:k){
  t = beta_hat[i] / (sqrt(A_inv[i,i]) * SE);
  print(t);
  print(pt(t, df = n - k, lower.tail = FALSE) * 2);
}

# Confidence interval of parameter estimation

gamma = 0.95;
t_gamma = qt(p = (1 + gamma) / 2, df = n - k, lower.tail = TRUE);
for(i in 1:k){
  m = t_gamma * sqrt(A_inv[i,i]) * SE;
  print(c(beta_hat[i] - m, beta_hat[i] + m));
}

# F statistic and its p-value

SSR = SST - SSE;
F = (SSR / (k-1)) / (SSE / (n-k));
print(F);
print(pf(F, df1 = k - 1, df2 = n - k, lower.tail = FALSE));
