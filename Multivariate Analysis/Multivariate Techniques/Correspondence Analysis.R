#
# Correspondence Analysis
# Author: galaa
# Created on 2016/03/19 07:49:41
#

## Data 1

tab <- matrix(c(11, 4, 2, 6), nrow = 2, ncol = 2, byrow = TRUE);
dimnames(tab) <- list(c("High", "Low"), c("Yes", "No"));
names(dimnames(tab)) <- c("Cholesterin", "Heart_Disease");
print(tab);

## Data 2

tab <- matrix(c(32, 53, 10, 3, 11, 50, 10, 30, 10, 25, 7, 5, 3, 15, 7, 8), nrow = 4, ncol = 4, byrow = TRUE);
dimnames(tab) <- list(c("хүрэн", "цэнхэр", "бор", "ногоон"), c("хар", "хүрэн", "улаан", "цайвар"));
names(dimnames(tab)) <- c("Нүд", "Үс");
print(tab);

## Convert to dataframe

library(epitools);
Dataframe <- expand.table(tab);
print(Dataframe);

## C matrix

m = nrow(tab);
n = ncol(tab);

C <- E <- matrix(rep(c(0), n*m), nrow = m, ncol = n);
for (i in 1:m) {
  for (j in 1:n) {
    E[i,j] <- sum(tab[i,]) * sum(tab[,j]) / sum(tab);
  }
}
print(E);
for (i in 1:m) {
  for (j in 1:n) {
    C[i,j] <- (tab[i,j] - E[i,j]) / sqrt(E[i,j]);
  }
}
print(C);

## svd

library(expm);
R = rankMatrix(C);

C. <- svd(C, nu = R, nv = R);
print(C.);
Gamma <- C.$u; Lambda <- C.$d[1:R]; Delta <- C.$v;

plot(cbind(Gamma, Delta));

## A and B matrix

A = c();
for (i in 1:m) {
  A <- c(A, sum(tab[i,]));
}
A = diag(A);
print(A);

B = c();
for (j in 1:n) {
  B <- c(B, sum(tab[,j]));
}
B = diag(B);
print(B);

## a and b vectors

a = A %*% rep(c(1), m);
t(C) %*% sqrt(a);

b = B %*% rep(c(1), n);
C %*% sqrt(b);

# tr(CC^T)

library(psych);
tr(C %*% t(C));
Lambda^2;

## r and s

library(expm); library(MASS);

r <- c();
for (k in 1:R) {
  r <- cbind(r, Lambda[k] * sqrtm(ginv(A)) %*% Gamma[,k]);
}
print(r);

s <- c();
for (k in 1:R) {
  s <- cbind(s, Lambda[k] * sqrtm(ginv(B)) %*% Delta[,k]);
}
print(s);

t(r) %*% a;

t(s) %*% b;

## Contributions

C_row = c();
for (k in 1:R) {
  t = c();
  for (i in 1:m) {
    t = cbind(t, A[i,i] * r[i,k]^2 / Lambda[k]^2);
  }
  C_row = rbind(C_row, t);
}
print(C_row);

C_col = c();
for (k in 1:R) {
  t = c();
  for (j in 1:n) {
    t = cbind(t, B[j,j] * s[j,k]^2 / Lambda[k]^2);
  }
  C_col = rbind(C_col, t);
}
print(C_col);

## ------------------------------------------------------------------
## Correspondence Analysis with specific function from the package ca
## ------------------------------------------------------------------

install.packages("ca") # if required

library(ca)

prop.table(tab, 1) # row percentages
prop.table(tab, 2) # column percentages

output <- ca(tab)
print(output) # basic results
summary(output)
plot(output)
