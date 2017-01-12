#
# Training Program for R Langauge
# Topic 11 - Correlation and Regression
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/12 23:44:15
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Корреляцийн шинжилгээ

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хосын корреляцийн коэффициент

X <- data.frame(
  dose = c(117.5, 117.5, 235, 235, 470, 470, 470, 705, 705, 940, 940, 940, 1410, 1410),
  surv = c(44, 55, 16, 13, 4, 1.96, 6.12, 0.5, 0.32, 0.11, 0.015, 0.019, 0.7, 0.006) 
)
cor(x = X, method = "pearson")

cor(x = X, method = "spearman")

## Хамааралгүй байх тухай таамаглалыг шалгах

install.packages("Hmisc")
library(Hmisc) # rcorr()
rcorr(x = as.matrix(X), type = "pearson")

## Тухайн корреляцийн коэффициент

airquality.NA <- na.omit(airquality)[,1:4]
print(airquality.NA)

install.packages("ppcor")
library(ppcor) # pcor() pcor.test()
pcor(airquality.NA)

## Нэр заасан хувьсагчдаар тухайн корреляцийг тооцоолох

pcor.test(
  airquality.NA$Ozone, airquality.NA$Solar.R, 
  airquality.NA[,c("Wind", "Temp")]
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Шугаман регрессийн шинжилгээ

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Өгөгдөл ба үндсэн үр дүнгүүд

data <- data.frame(
  education = c(11, 12, 11, 15, 8, 10, 11, 12, 17, 11),
  annual.income = c(25, 33, 22, 41, 18, 28, 32, 24, 53, 26)
)

fit <- lm(annual.income ~ education, data = data)
summary(fit)

# Үлдэгдэл

residuals(fit)

# Параметрүүдийн итгэх завсар

confint(fit, level = 0.95)

# Үнэлэгдсэн утгууд

fitted(fit)

# Прогноз ба түүний итгэх завсар

predict(fit, newdata = data.frame(education = c(22,24)), interval = "confidence", level = 0.95)

## Хетероскедастик

install.packages("car")
library(car)
ncvTest(fit)

## Автокорреляц

install.packages("car")
library(car)
durbinWatsonTest(fit, max.lag = 3)

install.packages("lmtest")
library(lmtest)
dwtest(fit,  alternative = "two.sided")

## Малтиколлинеар

set.seed(11); n = 20
X1 = round(rexp(n = n), digits = 2)
X2 = round(rnorm(n = n), digits = 2)
X3 = round(1 + 2 * X1 - 3 * X2 + rnorm(n = n), digits = 2)
y = round(2 + X1 + 2 * X2 + X3 + rnorm(n = n), digits = 2)

cor(cbind(X1, X2, X3))

fit = lm(y ~ X1 + X2 + X3)
install.packages("car")
library(car)
vif(fit)

## Бүтцийн өөрчлөлт

set.seed(11)

X_1 = round(runif(n = 20, min = 1, max = 5), digits = 2)
y_1 = X_1 * 3 + 1 + round(rnorm(n = length(X_1)))

X_2 = round(runif(n = 5, min = 5, max = 10), digits = 2)
y_2 = X_2 * 0.5 + 15 + round(rnorm(n = length(X_2)))

X = c(X_1, X_2)
y = c(y_1, y_2)

plot(y ~ X)

install.packages("strucchange")
library(strucchange)
sctest(y ~ X, type = "Chow", point = 20)

## Дамми хувьсагч

Y = c(7.5, 7.6, 9.3, 8.7, 10.4, 9.8, 12.1)
D2 = c(0, 0, 0, 1, 1, 0, 0)
D3 = c(0, 0, 0, 0, 0, 1, 1)
summary(lm(Y ~ D2 + D3))

## Дамми хувьсагч ба бүтцийн өөрчлөлттэй регрессийн загвар

D = ifelse(X >= 5, 1, 0)
summary(lm(y ~ X + I((X - 5) * D)))
