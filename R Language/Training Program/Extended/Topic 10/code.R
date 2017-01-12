#
# Training Program for R Langauge
# Topic 10 - Statistical Tests
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/ 13:35:25
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Дунджийн тухай таамаглал шалгах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Нэг түүврийн дунджийн тухай

X <- c(18, 17, 16, 15, 16, 15, 15, 15, 15, 15, 15)
t.test(X, mu = 16)

## Холбоост хоёр түүврийн дунджийн тухай

install.packages("OpenMx");
library(OpenMx);
data(myTwinData);
myindex <- c(4, 13, 15, 30, 31, 39, 56, 57, 58, 62, 72, 86, 90, 93, 95);
X <- myTwinData[myindex, 11:12];

t.test(X$bmi1, X$bmi2, mu = 0, paired = TRUE)

## Хамааралгүй хоёр түүврийн дунджийн тухай

X <- chickwts[
  which( chickwts$feed %in% c("linseed", "soybean") )
  , # all columns or variables
]
X$feed <- factor(X$feed) # remove unused levels

t.test(X$weight ~ X$feed)

## Хамааралгүй түүврүүдийн дунджийн тухай

result = aov(weight ~ feed, data = chickwts)
summary(result)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Колмогоров-Смирновын шинжүүр

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Тархалтын хуулийн тухай таамаглал шалгах Колмогоров-Смирновын шинжүүр

set.seed(17)
X = rnorm(n = 50, mean = 0.5, sd = 1)
ks.test(x = X, pnorm, 0, 1, alternative = "two.sided")

## Нэгэн төрлийн байх тухай таамаглал шалгах Колмогоров-Смирновын шинжүүр

set.seed(17)
X = rnorm(n = 50, mean = 0.5, sd = 1)
Y = rnorm(n = 75, mean = 0, sd = 1)
ks.test(x = X, y = Y, alternative = "two.sided")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хи-квадрат шинжүүрүүд

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Тархалтын тухай таамаглал шалгах Хи-квадрат шинжүүр

chisq.test(x = c(2,5,18), p = c(0.1, 0.2, 0.7))

## Ижил тархалттай эсэхийг шалгах Хи-квадрат шинжүүр

chisq.test(x = matrix(c(11,40,4,5,24,3,6,24,3), ncol = 3, byrow = TRUE))

## Хамааралгүй эсэхийг шалгах Хи-квадрат шинжүүр

X = array(
  data = c(2,8,4,9,6,13,8,21,8,11),
  c(2,5),
  dimnames = list(
    c("male","female"),
    c("I","II","III","IV","V")
  )
)
print(X)

install.packages("epitools") # if required
library(epitools) # expand.table()
X <- expand.table(X)
chisq.test(x = X[,1], y = X[,2])
