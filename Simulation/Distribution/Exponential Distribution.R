#
# Exponential Distribution Simulation
# Author: galaa
# Created on 2017/09/21 13:24:01
#

## Дэлгэрэнгүй код
lambda = 1
X = c()
for (i in 1:100) { # санамсаргүй 100 утга
  u = runif(n = 1)
  x = - log(u) / lambda
  X = c(X, x)
}

## Хураангуй код
X = - log(runif(n = 100)) / (lambda = 1)

## Үр дүнг хэвлэх
print(X)

## Гистограм байгуулах
hist(X)

## Колмогоров-Смирновын шинжүүрээр илтгэгч тархалтай болохыг шалгах
ks.test(x = X, y = pexp, rate = lambda)
