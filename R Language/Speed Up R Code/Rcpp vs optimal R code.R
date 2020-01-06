#
# Speed Up R code - Pure R vs. Built-in vs. Rcpp
# Author: galaa
# Created on 2020/01/06 21:50:00
#

# -----------------------------------------------------------------
# Бусад хэлний хэв маягаар бичсэн R код
# -----------------------------------------------------------------

sd_R.loop <- function (x) {
  n <- length(x)
  sum <- 0
  for (i in 1:n) {
    sum <- sum + x[i]
  }
  mu <- sum / n
  sum <- 0
  for (x.i in x) {
    sum <- sum + {x.i - mu} ** 2
  }
  sqrt(sum / {n - 1})
}

# -----------------------------------------------------------------
# R-ын онцлогийг харгалзаж бичсэн код
# -----------------------------------------------------------------

sd_R.vectorized <- function (x) {
  mu <- sum(x) / {n <- length(x)}
  sqrt(sum({x - mu} ** 2) / {n - 1})
}

# -----------------------------------------------------------------
# Бенчмарк
# -----------------------------------------------------------------

x <- 1:100000
microbenchmark::microbenchmark(
  "built-in" = sd(x),
  "loop" = sd_R.loop(x),
  "vectorized" = sd_R.vectorized(x),
  "Rcpp" = sd_cpp(x),
  control = list(warmup = 2), check = "equal", times = 1000
)
