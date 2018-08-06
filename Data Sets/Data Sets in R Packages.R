#
# Data Sets in R Packages
# Author: galaa
# Created on 2018/08/06 10:04:45
#

# helper function

load.or.install.required.package <- function (package.name) {
  if (package.name %in% as.vector(installed.packages()[, 1]) == FALSE) {
    install.packages(package.name)
  }
  library(package.name, character.only = TRUE)
}


# gpk ---------------------------------------------------------------------

load.or.install.required.package("gpk")

help(gpk)

# UsingR ------------------------------------------------------------------

load.or.install.required.package("UsingR")

data(alltime.movies)
hist(alltime.movies$Gross)

data(blood)
with(data = blood, expr = { t.test(x = Machine, y = Expert) })

data(breakdown)
plot(time ~ voltage, data = breakdown)
plot(log(time) ~ voltage, data = breakdown)

data(diamond)
plot(formula = price ~ carat, data = diamond, pch = 5)

data(father.son)
plot(sheight ~ fheight, data = father.son, bty = "l", pch = 20)
abline(lm(sheight ~ fheight, data = father.son), lty = 1, lwd = 2)

data(homework)
boxplot(homework)

# mistat ------------------------------------------------------------------

load.or.install.required.package("mistat")

data(KEYBOARDS)
boxplot(errors ~ keyboard, data = KEYBOARDS, ylab = "Errors")

# GLMsData ----------------------------------------------------------------

load.or.install.required.package("GLMsData")

data(gpsleep)
plot(Sleep ~ Dose, data = gpsleep)

data(poison)
summary(poison)

# cluster.datasets --------------------------------------------------------

load.or.install.required.package("cluster.datasets")

data(sample.mammals.milk.1956)
help(sample.mammals.milk.1956)
cor(sample.mammals.milk.1956[,-1])

# msos --------------------------------------------------------------------

load.or.install.required.package("msos")

data(softdrinks)
help(softdrinks)

# EngrExpt ----------------------------------------------------------------

load.or.install.required.package("EngrExpt")

help(calcium)

help(cement, package = EngrExpt)
