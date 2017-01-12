#
# Training Program for R Langauge
# Topic 9 - 
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/ 10:05:45
#

X = rnorm(n = 15)
print(X)

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

mean(as.matrix(X[,1:2]))

colMeans(X[1:2])

sapply(X[1:2], mean)

median(X$x1)

sapply(X[1:2], median)

Mode = function(x) {
  ux = unique(x); ux[which.max(tabulate(match(x, ux)))]
}
Mode(X$g1)

table(X$g1)

## Бүлгээр салгаж тооцоолох нь

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

quantile(X$x1, probs = seq(0, 1, length.out = 10))

sapply(X[1:2], quantile, probs = seq(0, 1, length.out = 5))

## Хэлбэрийн хэмжээсүүд

# Шаардагдах багц

install.packages("moments")
library(moments)

# Ассимметрийн коэффициент

skewness(X$x1)

sapply(X[1:2], skewness)

# Эксцессийн коэффициент

kurtosis(X$x1) - 3

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

## Диаграмууд

X = rnorm(100, 0, 1);                # random numbers
value = hist(X);                     # histogram
print(value);                        # value

# Гистограм

hist(X, freq = FALSE,
   breaks = seq(-4, 4, by = 1),
   xlab = "Random Numbers",
   main = "Distribution of Random Numbers",
   col = "#00BFBF", xlim = c(-4.5, 4.5),  ylim = c(0, 0.4)
)

curve(
   dnorm(x,                       # density function
      mean = mean(X), sd = sd(X)  # distribution parameters
   ),
   add = TRUE,                    # add to existing graph
   col = "#008080", lwd = 2       # color and linewidth
)

# Хайрцган диаграм

X = c(7.27, 6.71, 6.68, 6.25, 6.32, 6.33, 6.37, 6.47, 6.11, 6.28, 6.34, 6.37, 6.05, 6.12, 6.08, 6.4, 6.34, 6.13, 6.1, 5.99, 5.75, 5.5, 5.47, 5.5, 4.88)
boxplot(X, border = "#008080", col = "#00BFBF", horizontal = TRUE)

# 

install.packages("Lock5Data")      # install package
library(Lock5Data)                 # load package
data(ColaCalcium)                  # load dataset

with(ColaCalcium,
  boxplot(Calcium ~ Drink,
    border = "#008080",
    col = "#00BFBF",
  )
)

# Q-Q диаграм

X <- rnorm(100, 0, 1)
qqnorm(X,                     # one sample QQPlot
   main = "Normal Q-Q Plot",
   xlab = "Theoretical Quantiles",
   ylab = "Sample Quantiles"
)
qqline(X,                     # adds theoretical line
   distribution = qnorm       # normal distribution
)

## Диаграмыг хадгалах

dev.print(
  pdf,                    # file type .pdf, .ps, .eps
  file = "/home/galaa/diagram.pdf",       # file path
  width = 8,                        # width in inches
  height = 6,                      # height in inches
  pointsize = 12                    # font size in pt
)

## Бусад диаграмууд

# цэгэн диаграм

X = data.frame(
  boil.temp = c(90.27778, 90.16667, 92.16667, 92.44444, 93.00000, 93.27778, 93.83333, 93.94444, 94.11111, 94.05556, 95.33333, 95.88889, 98.61111, 98.11111, 99.27778, 99.94444, 100.11111),
  press = c(70.40305, 70.40305, 75.85514, 76.76946, 78.39493, 79.07221, 80.90086, 81.23950, 81.34109, 81.30722, 85.13384, 89.97638, 96.47825, 94.00619, 98.34077, 101.18533, 101.79488)
)

scatter.smooth(
   x = X$press,
   y = X$boil.temp,
   xlab = "Press.",
   ylab = "Boil. Temp."
)

# Индекст цэгэн диаграм

kindergarten = c(164, 151, 181, 190, 218, 211, 228, 237, 256, 275, 308, 351, 437, 503)

scatter.smooth(
   x = kindergarten,
   y = NULL,
   xlab = NULL,
   ylab = "Number of Kindergartens"
)

# Шугаман диаграм

year = c(1935, 1944, 1956, 1963, 1969, 1979, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014)
citizen = c(738200, 759061, 845481, 1017158, 1197595, 1595006, 2043954, 2153466, 2177217, 2158362, 2171898, 2206892, 2242998, 2276016, 2307484, 2340134, 2373493, 2403105, 2432397, 2465657, 2495091, 2521733, 2551081, 2583254, 2620446, 2665955, 2716275, 2760968, 2811666, 2867744, 2930277, 2995949)

plot(
   x = year,
   y = citizen,
   type = "b",
   xlab = "Year",
   ylab = "Number of Citizen"
)

# Дугуй диаграм

X = table(
   data.frame(
      GPA = c("C","A","C","B","D","C","A","B","A","A","A","A","C","D","A","C","C","A","D","D","B","A","B","A","A")
   )
)

pie(x = X,
   labels = names(X),
   radius = 1,
   init.angle = 0,
   col = c("#009999","#00B3B3", "#00CCCC", "#00E6E6"),
   main = NULL
)

# Баганан диаграм}

X <- table(data.frame(
   GPA = c("C","A","C","B","D","C","A","B","A","A","A","A","C","D","A","C","C","A","D","D","B","A","B","A","A")
))

barplot(height = X, width = 1, space = 0.2,
   names.arg = NULL, legend.text = c("A - Grade Point A","B","C","D"),
   col = "#00BFBF", border = par("fg"),
   main = "Grade Points", xlab = "Grade Point", ylab = "Frequency",
   ylim = c(0,12),
   axes = TRUE, axisnames = TRUE,
   cex.axis = par("cex.axis"), cex.names = par("cex.axis")
)
