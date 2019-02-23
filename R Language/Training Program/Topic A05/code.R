#
# Training Program for R Langauge
# Topic A5 - R programming
# Author: galaa (www.galaa.mn)
# Copyright (c) 2019 Makhgal
# Created on 2019/02/23
#

X <- c(1, 3, 4, 0, 2)
mean(X)

average <- function (X) {
  S <- 0
  n <- length(X)
  for (i in 1:n) {
    S <- S + X[i]
  }
  return(S/n)
}

average <- function (X) {
  S <- 0
  n <- length(X)
  for (x in X) {
    S <- S + x
  }
  return(S/n)
}

average <- function (X) {
  S <- 0
  i <- 1
  n <- length(X)
  while (i <= n) {
    S <- S + X[i]
    i <- i + 1
  }
  return(S/n)
}

average <- function (X) {
  S <- 0
  i <- 1
  n <- length(X)
  repeat {
    S <- S + X[i]
    i <- i + 1
    if (i > n) {
      break
    }
  }
  return(S/n)
}

average <- function (X) {
  S <- 0
  i <- 1
  n <- length(X)
  repeat {
    if (i > n) {
      return(S/n)
    } else {
      S <- S + X[i]
      i <- i + 1
    }
  }
}
