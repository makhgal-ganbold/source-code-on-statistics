#
# Олон хэмжээст өгөгдлийн статистик шинжилгээ
#
# Факторын шинжилгээ
#
# (c) 2020, 2022 Г.Махгал
#

# Өгөгдөл -----------------------------------------------------------------

X <- datasets::mtcars[1:7]

head(X)

# Факторын тоо ------------------------------------------------------------

k <- 2

# Загварын чөлөөний зэрэг -------------------------------------------------

p <- ncol(X)
d <- 1/2*(p-k)**2 - 1/2*(p+k)
print(d)

# Гол хэсгийн арга --------------------------------------------------------

# Түүврийн корреляцийн матриц, түүний хувийн утга болон хувийн вектор

R <- cor(X)

eig <- eigen(R)
Lambda <- diag(eig$values)
Gamma <- eig$vectors

# Факторын ачилт

L <- Gamma[,1:k] %*% sqrt(Lambda[1:k,1:k])
print(L)

# Нийлэмж

h2 <- diag(L %*% t(L))
print(h2)

# Хөндлөнгийн хүчин зүйлсийн "дисперс"

psi <- diag(R - L %*% t(L))
print(psi)

# Факторын оноо

F <- t(t(L) %*% solve(R) %*% t(scale(X)))
print(F)

# Бэлэн функц -------------------------------------------------------------

fa <- psych::principal(r = X, nfactors = k, residuals = TRUE, rotate = "none")

print(fa)

# чөлөөний зэрэг

fa$dof

d

# түүврийн хэмжээ

fa$n.obs

nrow(X)

# хувийн утгууд

fa$values

eig$values

# факторын ачилт

fa$loadings

L
eig$values[1:k]
eig$values[1:k] / sum(eig$values)
cumsum(eig$values[1:k]) / sum(eig$values)

# нийлэмж

fa$communality

h2

# хөндлөнгийн хүчин зүйлийн "дисперс"

fa$uniquenesses

psi

# загварын алдаа

norm(fa$residual, type = "F") # загварын алдаа
norm(as.matrix(fa$values[-{1:k}]), type = "F") # дээд зааг

# факторын оноо

fa$scores

F

# Эргүүлэлттэй шинжилгээ --------------------------------------------------

fa <- psych::principal(r = X, nfactors = k, rotate = "varimax")

# эргүүлэлт

fa$rotation

# эргүүлэлтийн матриц

fa$rot.mat

# эргүүлэлттэй ачилт

fa$loadings

# эргүүлэлттэй оноо

fa$scores
