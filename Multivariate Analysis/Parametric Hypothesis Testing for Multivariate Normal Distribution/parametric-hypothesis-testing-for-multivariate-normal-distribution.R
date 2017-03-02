#
# Parametric Hypothesis Testing for Multivariate Normal Distribution
# Author: galaa
# Created on 2016/03/19 07:49:41
#

## Таамаглал 1: Дунджийн тухай, Ковариацийн матриц мэдэгдэх үед

library(MASS);
mu_0 = c(2, -1);
Sigma = matrix(c(2/3, 0, 0, 2/3), 2, 2);
X = matrix(c(2.91, -1.84, 2.85, -1.10, 1.90, 0.32, 1.51, -1.37, 1.73, -1.50, 2.83, -0.42, 2.03, -1.20, 1.97, -0.60, 2.14, -1.27, 1.95, 0.54), nrow = 10, ncol = 2, byrow = TRUE);
n = length(X[,1]);
x_m = colMeans(X);
n/2 * t(x_m - mu_0) %*% ginv(Sigma) %*% (x_m - mu_0);
qchisq(c(0.05), df=2, lower.tail=FALSE);

## Таамаглал 2: Дунджийн тухай, Ковариацийн матриц мэдэгдэхгүй үед

# F шинжүүрээр
mu_0 = c(2, -1);
X = matrix(c(2.91, -1.84, 2.85, -1.10, 1.90, 0.32, 1.51, -1.37, 1.73, -1.50, 2.83, -0.42, 2.03, -1.20, 1.97, -0.60, 2.14, -1.27, 1.95, 0.54), nrow = 10, ncol = 2, byrow = TRUE);
p = dim(X)[2]; n = dim(X)[1];
x_m = colMeans(X); S = cov(X);
(n-p)/p * n/(n-1) * t(x_m - mu_0) %*% solve(S) %*% (x_m - mu_0);
qf(p = 0.05, df1 = p, df2 = n - p, lower.tail = FALSE)

# ICSNP багц дахь HotellingsT2() функцээр (дээрх детальчилсан тооцооныхтой адил үр дүн өгөхийг ажиглана уу)
install.packages("ICSNP")
library(ICSNP)
HotellingsT2(X, mu = mu_0, test = "f")

## Таамаглал 3: Ковариацийн матрицийн тухай

library(MASS);
library(psych);
Sigma_0 = matrix(c(2/3, 0, 0, 2/3), 2, 2);
X = matrix(c(2.91, -1.84, 2.85, -1.10, 1.90, 0.32, 1.51, -1.37, 1.73, -1.50, 2.83, -0.42, 2.03, -1.20, 1.97, -0.60, 2.14, -1.27, 1.95, 0.54), nrow = 10, ncol = 2, byrow = TRUE);
p = length(X[1,]);
n = length(X[,1]);
x_m = colMeans(X);
S = cov(X);
n * tr(ginv(Sigma_0) %*% S) - n * log(det(ginv(Sigma_0) %*% S)) - n * p;
qchisq(c(0.05), df = p*(p+1)/2, lower.tail = FALSE);

## Таамаглал 6: Шугаман таамаглал

library(MASS);
mu = c(1, 0);
Sigma = matrix(c(2, 1, 1, 3), nrow = 2, ncol = 2);
n = 10;
X = round(mvrnorm(n, mu, Sigma), digits = 2);
print(X);
A = matrix(c(1,2), 1, 2); a = c(1);
q = length(a);
x_m = colMeans(X); print(x_m);
S = cov(X); print(S);
(n - 1) * t(A %*% x_m - a) %*% ginv(A %*% S %*% t(A)) %*% (A %*% x_m - a);
qf(c(0.05), df1 = q, df2 = n-1, lower.tail = FALSE);

## Таамаглал 7: Хоёр дунджийн тухай таамаглал

X_1 = matrix(c(0.16, -1.72, 3.00, 4.65, 2.42, 0.37, 0.61, -0.38, 2.95, -0.14, 1.54, -2.29, 0.81, -2.81, 0.55, -2.20, 0.65, -1.12, 1.32, -1.20), nrow = 10, ncol = 2, byrow = TRUE);
X_2 = matrix(c(0.96, 0.73, 2.56, 1.91, -0.06, 0.31, -0.03, -3.40, 1.48, 2.74, 1.75, 0.40, 1.17, 1.58, 1.20, -0.34), nrow = 8, ncol = 2, byrow = TRUE);
p = dim(X_1)[2];
n_1 = dim(X_1)[1]; n_2 = dim(X_2)[1];
x_m_1 = colMeans(X_1); x_m_2 = colMeans(X_2);
S_1 = cov(X_1); S_2 = cov(X_2);
S = ((n_1 - 1) * S_1 + (n_2 - 1) * S_2) / (n_1 + n_2 - 2);
n_1 * n_2 / (n_1 + n_2) * (n_1 + n_2 - p - 1) / (p * (n_1 + n_2 - 2)) * t(x_m_1 - x_m_2) %*% solve(S) %*% (x_m_1 - x_m_2);
qf(0.05, df1 = p, df2 = n_1 + n_2 - p - 1, lower.tail = FALSE);

# ICSNP багц дахь HotellingsT2() функцээр (дээрх детальчилсан тооцооныхтой адил үр дүн өгөхийг ажиглана уу)
install.packages("ICSNP")
library(ICSNP)
HotellingsT2(X = X_1, Y = X_2, test = "f")
