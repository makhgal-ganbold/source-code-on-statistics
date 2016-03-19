#
# Discriminant Analysis
# Author: galaa
# Created on 2016/03/19 07:49:41
#

# Data

X = matrix(
  c(85,66,80,82,60,94,70,96,76,90,70,94),
  nrow = 6, ncol = 2, byrow = TRUE
);

Y = matrix(
  c(60,72,71,74,60,64,80,68,85,70),
  nrow = 5, ncol = 2, byrow = TRUE
);

# Overal Mean and Covariance

mu_1 = colMeans(X);
mu_2 = colMeans(Y);
mu = ( mu_1 + mu_2 ) / 2;

S = cov(rbind(X,Y));

# Coefficients of discriminant function

library(MASS);
alpha = ginv(S) %*% (mu_1 - mu_2);
coefficents = c(alpha, - t(alpha) %*% mu);
print(coefficents);

# Prior probabilities

n_1 = length(X[,1]);
n_2 = length(Y[,1]);
n = n_1 + n_2;
pi = c(n_1, n_2) / n;
print(pi);

# Group means

print(mu_1); print(mu_2);

# Classification error probability

library(MASS);
delta = sqrt(t(mu_1 - mu_2) %*% ginv(S) %*% (mu_1 - mu_2));
err.prob <- pnorm (q = c(-delta / 2), mean = 0.00, sd = 1.00);
print(err.prob);

# 

Z = data.frame(
  x_1 = c(60,71,60,80,85,85,80,60,70,76,70),
  x_2 = c(72,74,64,68,70,66,82,94,96,90,94),
  group = factor(c(1,1,1,1,1,2,2,2,2,2,2))
);
library(MASS);
lda(formula = group ~ x_1 + x_2, data = Z);
