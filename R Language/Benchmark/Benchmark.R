#
# Benchmark
# Author: galaa
# Created on 2017/05/19 15:00:00
#

## Memory consumption

gc(reset = TRUE)
x <- matrix(runif(1.5e7), ncol = 200)
a <- apply(x[, 1:100], 2, quantile)
b <- apply(x, 2, quantile)
gc()

## Time consumption

system.time(
  {
    x <- matrix(runif(1.5e7), ncol = 200)
    a <- apply(x[, 1:100], 2, quantile)
    b <- apply(x, 2, quantile)
  }
)
