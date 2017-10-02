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

# Дээрх тохиолдолд хоёр бүлгийн дундаж тэнцүү гэх таамглалыг шалгагдана. Харин хоёр бүлгийн дунджийн ялгавар компонент нэг бүрээрээ харгалзан жишээлбэл 0 ба -1-тэй тэнцүү гэх таамаглалыг шалгахын тулд дараах маягийн кодыг бичнэ.
HotellingsT2(X = X_1, Y = X_2, mu = c(0, -1), test = "f")

## Таамаглал 8: Ковариацууд тэнцүү байх тухай таамаглал

set.seed(17)
X_1 = MASS::mvrnorm(n = 75, mu = c(0,0), Sigma = matrix(data = c(4,1,1,2), ncol = 2))
X_2 = MASS::mvrnorm(n = 50, mu = c(1,1), Sigma = matrix(data = c(3,1,1,2), ncol = 2))

S = (((n_1 = nrow(X_1)) - 1) * (S_1 = cov(X_1)) + ((n_2 = nrow(X_2)) - 1) * (S_2 = cov(X_2))) / (n = n_1 + n_2 - (k = 2))
M = n * log(det(S)) - ( (n_1-1)*log(det(S_1)) + (n_2-1)*log(det(S_2)) )
u = (1/(n_1-1) + 1/(n_2-1) - 1 / (n_1 + n_2 - 1)) * (2*(p = ncol(X_1))^2 + 3*p - 1) / (6*(p+1)*(k-1))
t = (1 - u) * M; print(t)
df = (k - 1) * p * (p + 1) / 2; print(df)
p.value = pchisq(q = t, df = df, lower.tail = FALSE); print(p.value)

# biotools багц дахь boxM() функцээр (дээрх детальчилсан тооцооныхтой адил үр дүн өгөхийг ажиглана уу)
install.packages("biotools") ## sudo apt-get install bwidget tcl-dev tk-dev -y
library(biotools)
boxM(data = rbind(X_1,X_2), grouping = c( rep(1, times = 75), rep(2, times = 50) ))

## Таамаглал 10: Бүлгүүд нэг төрлийн байх тухай таамаглал буюу олон хэмжээст дисперсийн шинжилгээ (MANOVA)

# Өгөгдөл

X = matrix(data = c(9, 3, 6, 2, 9, 7, 0, 4, 2, 0, 3, 8, 1, 9, 2, 7), ncol = 2, byrow = TRUE) # хоёр хэмжээст тоон өгөгдөл
group = as.factor(rep(x = 1:3, times = c(3,2,3))) # бүлэг, фактор хэлбэртэй өгөхийг анхаар
print(cbind(X, group)) # өгөгдөл хэвлэх

# Дэлгэрэнгүй тооцоо

p = ncol(X) # векторын хэмжээс
k = length(unique(group)) # бүлгийн тоо
n.group = as.vector(table(group)) # бүлэг тус бүрийн хэмжээ
n = sum(n.group) # нийт түүврийн хэмжээ

mean.overal = colMeans(X) # нийт түүврийн дундаж
mean.groups = apply(X, 2, tapply, group, mean) # бүлэг тус бүрийн дундаж

A = cov(X) * (n - 1) # нийт квадратуудын нийлбэр
B = matrix(
  data = rowSums(apply(cbind(mean.groups, n.group), 1, function (x) {(y = x[1:p] - mean.overal) %*% t(y) * x[p+1]})),
  ncol = p
) # бүлэг хоорондын квадратуудын нийлбэр
W =  A - B # бүлгийн дотоод квадратуудын нийлбэр

Lambda = det(W) / det(B + W); print(Lambda) # Wilks' Lambda
lambda = eigen(solve(W) %*% B, only.values = TRUE)$values; print(lambda)

sum(lambda / (1 + lambda)) # Pillai
sum(lambda) # Hotelling-Lawley
prod(rep(1, times = length(lambda)) / (1 + lambda)) # Wilks == Wilk's Lambda
max(lambda) # Roy

F.stat = (n-k-1)/(k-1)*(1-sqrt(Lambda))/sqrt(Lambda); print(F.stat) # шинжүүрийн статистикийн туршилтын утга
p.value = pf(q = F.stat, df1 = 2*(k-1), df2 = 2*(n-k-1), lower.tail = FALSE); print(p.value) # магадлалын утга

# stats багц дахь manova() функцээр (дээрх детальчилсан тооцооныхтой адил үр дүн өгөхийг ажиглана уу)

output = summary(manova(X ~ group), test = "Wilks") # "Pillai", "Wilks", "Hotelling-Lawley", "Roy"
print(output)
output$SS$group # == B
output$SS$Residuals # == W
output$Eigenvalues # == lambda
