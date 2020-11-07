#
# Speed Up R code - Pure R vs. Built-in vs. Rcpp vs. Python
# Author: galaa
# Created on 2020/01/20 10:11:00
#

# -----------------------------------------------------------------
# Бенчмарк
# -----------------------------------------------------------------

x <- 1:100000
bench::mark(
  "built-in" = sd(x),
  "loop" = sd_R.loop(x),
  "vectorized" = sd_R.vectorized(x),
  "C++" = sd_cpp(x),
  "Python" = sd_py(x),
  time_unit = 'ms'
)[1:9]
