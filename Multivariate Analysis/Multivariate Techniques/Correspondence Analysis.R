#
# Correspondence Analysis
# Author: galaa
# Created on 2016/03/19 07:49:41
#

## Data 1

N <- matrix(
  data = c(32, 53, 10, 3, 11, 50, 10, 30, 10, 25, 7, 5, 3, 15, 7, 8),
  nrow = 4, ncol = 4, byrow = TRUE,
  dimnames = list(
    "Нүд" = c("хүрэн нүд", "цэнхэр нүд", "бор нүд", "ногоон нүд"),
    "Үс" = c("хар үс", "хүрэн үс", "улаан үс", "цайвар үс")
  )
)

## Data 2

N <- matrix(c(326, 38, 241, 110, 3, 688, 116, 584, 188, 4, 343, 84, 909, 412, 26, 98, 48, 403, 681, 85), nrow = 4, ncol = 5, byrow = TRUE)
dimnames(N) <- list(c("цэнхэр нүд", "тунгалаг нүд", "дундаж өнгөтэй нүд", "бараан нүд"), c("цайвар үс", "улаан үс", "дундаж өнгөтэй үс", "бараан үс", "хар үс"))
names(dimnames(N)) <- c("Нүд", "Үс")

## Print Data

print(N)

## Convert Crosstab to dataframe

raw_data = epitools::expand.table(N)
# print(raw_data)

## Chi-square Test for independence

chisq.test(x = N)

## Sample Size & Row and Column Sums

n.. = sum(N)
m = nrow(N)
n = ncol(N)
sum_row = rowSums(N)
sum_col = colSums(N)

## Joint Distribution

P = N / n..; print(P)

## Row and Column Mass -- Marginal Distributions

p.mar_row = sum_row / n..; P.mar_row = diag(p.mar_row); print(p.mar_row) ## Row Mass
p.mar_col = sum_col / n..; P.mar_col = diag(p.mar_col); print(p.mar_col) ## Column Mass

## Row and Column Percentages -- Conditional Distributions

P.con_row = prop.table(N, 1); print(P.con_row) # row percentages
P.con_col = prop.table(N, 2); print(P.con_col) # column percentages

## Row Chi-square Distances to Centroid -- Chi-square Distances between Conditional Distributions and Marginal Distribution

ChiDist_row = c()
for (i in 1:m) {
  ChiDist_row[i] = sqrt(t(P.con_row[i,] - p.mar_col) %*% solve(P.mar_col) %*% (P.con_row[i,] - p.mar_col))
}
print(ChiDist_row)

## Column Chi-square Distances to Centroid -- Chi-square Distances between Conditional Distributions and Marginal Distribution

ChiDist_col = c()
for (j in 1:n) {
  ChiDist_col[j] = sqrt(t(P.con_col[,j] - p.mar_row) %*% solve(P.mar_row) %*% (P.con_col[,j] - p.mar_row))
}
print(ChiDist_col)

## Chi-square Distance to Independence & Inertia and Decomposition of Chi-square Distance

C = expm::sqrtm(solve(P.mar_row)) %*% (P - p.mar_row %*% t(p.mar_col)) %*% expm::sqrtm(solve(P.mar_col)); print(C)
r = Matrix::rankMatrix(C)[1]; print(r)
sum(diag(t(C) %*% C))
sum(diag(C %*% t(C)))

sum(C^2) ## Total Inertia

rowSums(C^2) ## Row Inertias
colSums(C^2) ## Column Inertias

inertia <- eigen(C %*% t(C))$values ## Inertias (by factors)
sum(eigen(C %*% t(C))$values) * n.. # (total inertia) * (sample size) = (chi-square statistics)
inertia/sum(inertia)*100 ## Inertia Percentage
cumsum(inertia)/sum(inertia)*100 ## Inertia Cumumlative Percentage
plot(inertia) ## plot

## Weighted Projections of Rows and Columns & Its properties

SVD = svd(C); Lambda = diag(SVD$d); Gamma = SVD$u; Delta = SVD$v

S = t(expm::sqrtm(solve(P.mar_row)) %*% Gamma %*% Lambda); print(t(S)) # principal coordinates
V = t(expm::sqrtm(solve(P.mar_col)) %*% Delta %*% Lambda); print(t(V)) # principal coordinates

S %*% p.mar_row # == 0
V %*% p.mar_col # == 0

S_std = t(Gamma) %*% expm::sqrtm(solve(P.mar_row)); print(t(S_std)) # standard coordinates
V_std = t(Delta) %*% expm::sqrtm(solve(P.mar_col)); print(t(V_std)) # standard coordinates

S_std %*% P.mar_row %*% t(S_std) # == identity matrix
V_std %*% P.mar_col %*% t(V_std) # == identity matrix

## Covariance of Principal Coordinates

for (k in 1:r) {
  print(sum(p.mar_row * S[k,]^2))
}
diag(Lambda)[1:r]^2

## Contributions

C_row = c()
for (k in 1:r) {
  t = c()
  for (i in 1:m) {
    t = cbind(t, p.mar_row[[i]] * S[k,i]^2 / diag(Lambda)[k]^2)
  }
  C_row = rbind(C_row, t)
}
print(C_row)

C_col = c()
for (k in 1:r) {
  t = c()
  for (j in 1:n) {
    t = cbind(t, p.mar_col[[j]] * V[k,j]^2 / diag(Lambda)[k]^2)
  }
  C_col = rbind(C_col, t)
}
print(C_col)

## ------------------------------------------------------------------
## Correspondence Analysis with specific function from the package ca
## ------------------------------------------------------------------

# install.packages("ca") # if required

library(ca)

output_ca <- ca(N)
print(output_ca) # basic results
summary(output_ca)
output_plot = plot(output_ca, arrows = c(TRUE, TRUE))
plot(output_ca, lines = c(TRUE, TRUE), mass = c(TRUE, TRUE), contrib = c("absolute", "absolute"))
