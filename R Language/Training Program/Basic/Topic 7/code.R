#
# Training Program for R Langauge
# Lesson 6 - Some Applications in Statistics / Статистик дахь зарим хэрэглээ
# Author: galaa (www.galaa.mn)
# Copyright (c) 2016 Makhgal
# Created on 2016/10/02 07:23:55
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Тархалттай холбогдох функцүүд

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

set.seed(17)

X = rnorm(n = 15, mean = 0, sd = 1)

print(X)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Тайлбарлагч статистикууд

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Өгөгдөл

set.seed(17)

X = data.frame(
  x1 = rnorm(n = 15, mean = 0, sd = 1), 
  x2 = runif(n = 15, min = 0, max = 1),
  g1 = factor(rbinom(n = 15, size = 1, prob = 0.5)),
  g2 = factor(rbinom(n = 15, size = 1, prob = 0.75))
)

# Төвийн хэмжээсүүд

# Дундаж

mean(X$x1); mean(X$x2)
colMeans(X[1:2])
sapply(X[1:2], mean)

# Медиан

median(X$x1); median(X$x2)
sapply(X[1:2], median)

# Моод

Mode <- function(x) {
  ux <- unique(x);
  ux[which.max(tabulate(match(x, ux)))];
}

Mode(X$g1)

# Давтамж, моодыг шалгах

table(X$g1)

# бүлгээр салгаж тооцоолох

tapply(X$x1, X$g1, mean)

aggregate(x1 ~ g1 + g2, X, mean)

# Хазайлтын хэмжээсүүд

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

# Байршлын хэмжээсүүд

# Хамгийн бага болон их утгууд

min(X$x1); max(X$x1)

sapply(X[1:2], min); sapply(X[1:2], max)

sapply(X[1:2], range)

# Квантилууд, probs аргументийг өгөөгүй тохиолдолд квартилуудыг буцаана

quantile(X$x1, probs = seq(0, 1, length.out = 5))

sapply(X[1:2], quantile, probs = seq(0, 1, length.out = 5))

# Хэлбэрийн хэмжээсүүд

# Шаардагдах багц

# install.packages("moments")
library(moments)

# Ассимметрийн коэффициент

skewness(X$x1)

sapply(X[1:2], skewness)

# Эксцессийн коэффициент

kurtosis(X$x1)

sapply(X[1:2], kurtosis)

# Бусад хэмжээсүүд

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

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Диаграм

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Өгөгдөл

set.seed(17)

X = rnorm(n = 100)

# Гистограм

hist(X,
  freq = FALSE,
  breaks = seq(-4, 4, by = 1),
  xlab = "Санамсаргүй тоонууд",
  main = "Санамсаргүй тоонуудын тархалт",
  col = "#00BFBF",                          # өнгө
  xlim = c(-4.5, 4.5),  ylim = c(0, 0.4)
)

# Гистограм дээр (dnorm - хэвийн тархалтын нягтын функц) тархалтын нягтын муруй нэмж зурах

curve(
   dnorm(x,
      mean = mean(X),       # дундаж
      sd = sd(X)            # стандарт хазайлт
   ),
   add = TRUE,              # өмнөх диаграм дээр нэмж зурах
   col = "#008080",         # өнгө
   lwd = 2                  # шугаман өргөний хэмжээ
)

# Хайрцган диаграм

boxplot(X,                      # өгөгдөл
  border = "#008080",           # хүрээний өнгө
  col = "#00BFBF",              # хайрцагны өнгө
  horizontal = TRUE             # чиг баримжаа
)

# Q-Q диаграм

qqnorm(X,                       # Q-Q диаграм
   main = "Q-Q диаграм",
   xlab = "Онолын квантилууд",
   ylab = "Түүврийн квантилууд"
)
qqline(X,                       # онолын шугам нэмэх
   distribution = qnorm         # хэвийн тархалт (qnorm - хэвийн тархалтын квантилын функц)
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Шинжүүр

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Дунджийн тухай таамаглал шалгах t шинжүүр

t.test(x = X, mu = 0, conf.level = 0.95)

# Дунджуудыг харьцуулах

set.seed(13)

Y = rnorm(n = 50, mean = 0.25, sd = 2)

t.test(x = X, y = Y, mu = 0, paired = FALSE, var.equal = FALSE)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Корреляц ба регресс

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Өгөгдөл

set.seed(17)
X = runif(n = 25)
Y = 2 * X + 1 + rnorm(n = 25)

# Пирсоны корреляцийн коэффициент

cor(x = X, y = Y)

cor(x = cbind(X, Y))

# Шугаман регрессийн шинжилгээ

result = lm(Y ~ X)

# Шинжилгээний үр дүн

summary(result)

# Параметрүүдийн итгэх завсар

confint(result, level = 0.95)

# Үнэлэгдсэн утга

fitted(result)

# Үлдэгдэл

residuals(result)

# Регрессийн шугаман загварын томъёолол

set.seed(17)
X = runif(n = 25)
Y = runif(n = 25)
Z = runif(n = 25)

lm(Y ~ X - 1)

lm(Z ~ X + Y)

lm(Z ~ X : Y)

lm(Z ~ X * Y)

lm(Z ~ (X + Y) ^ 2)

lm(Z ~ (X + Y) ^ 2 - X)

lm(log(Y) ~ log(X))
