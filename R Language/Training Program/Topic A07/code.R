#
# Training Program for R Langauge
# Topic A7 - R programming II
# Author: galaa (www.galaa.mn)
# Copyright (c) 2019 Makhgal
# Created on 2019/02/23
#

set.seed(1)
n <- 1e5; p <- 0.5
X <- cbind(
  rgeom(n = n, prob = p),
  rexp (n = n, rate = - log(1 - p))
)

set.seed(1); n1 <- 20; n2 <- 10; n <- n1 + n2
X1 <- sort(runif(n = n1, min = 1, max = 5))
Y1 <- 3 * X1 + 1 + rnorm(n = n1)
X2 = sort(runif(n = n2, min = 5, max = 10))
Y2 = 0.5 * X2 + 15 + rnorm(n = n2)
X = c(X1, X2)
Y = c(Y1, Y2)
plot(x = X, y = Y, type = "p", col = rep(x = c("red", "blue"), times = c(n1, n2)))
strucchange::sctest(Y ~ X, type = "Chow", point = 20)
