#
# Training Program for R Langauge
# Topic 9 - 
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/ 10:05:45
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Тайлбарлагч статистикууд

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

set.seed(17)
X = data.frame(
  x1 = rnorm(n = 15, mean = 0, sd = 1), 
  x2 = runif(n = 15, min = 0, max = 1),
  g1 = factor(rbinom(n = 15, size = 1, prob = 0.5)),
  g2 = factor(rbinom(n = 15, size = 1, prob = 0.75))
)

## 

mean(X$x1)

colMeans(X[1:2])

sapply(X[1:2], mean)

median(X$x1)

sapply(X[1:2], median)

Mode = function(x) {
  ux = unique(x); ux[which.max(tabulate(match(x, ux)))]
}
Mode(X$g1)

## Бүлгээр салгаж тооцоолох нь}

tapply(X$x1, X$g1, mean)

aggregate(x1 ~ g1 + g2, X, mean)

## Хазайлтын хэмжээсүүд

# Далайц

max(X$x1) - min(X$x1)

# Дундаж квадрат хазайлт

var(X$x1)

sapply(X[1:2], var)

# Стандарт хазайлт

sd(X$x1)

sapply(X[1:2], sd)

# Квартил хоорондын далайц

IQR(X$x1)

## Байршлын хэмжээсүүд

# Хамгийн бага болон их утгууд

min(X$x1); max(X$x1)

sapply(X[1:2], min)
sapply(X[1:2], max)

# sapply(X[1:2], range)

# Квантилууд

quantile(X$x1, probs = seq(0, 1, length.out = 5))

sapply(X[1:2], quantile, probs = seq(0, 1, length.out = 5))

## Хэлбэрийн хэмжээсүүд

# Шаардагдах багц

install.packages("moments")
library(moments)

# Ассимметрийн коэффициент

skewness(X$x1)

sapply(X[1:2], skewness)

# Эксцессийн коэффициент

kurtosis(X$x1)

sapply(X[1:2], kurtosis)

## Бусад хэмжээсүүд

# Түүврийн хэмжээ

length(X$x1)

sapply(X[1:2], length)

# Орхигдсон утгын тоо

Z = data.frame(
  z1 = c(1, 2, 3),
  z2 = c(2, 3, NA)
)

sum(is.na(Z))

sum(is.na(Z$z1))
