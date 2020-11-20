
# 1 -----------------------------------------------------------------------

maximal.digit <- function (n) {
  M <- n %% 10
  while (M != 9 && n > 0) {
    if ({m <- n %% 10} > M) {
      M <- m
    }
    n <- n %/% 10
  }
  M
}

testthat::expect_equal(maximal.digit(6), 6)
testthat::expect_equal(maximal.digit(1745738), 8)
testthat::expect_equal(maximal.digit(4131233), 4)

# 2 -----------------------------------------------------------------------

sum.series <- function (n) {
  n <- 1:n
  sum(1 / {n * {n + 1}})
}

testthat::expect_equal(sum.series(10), 0.9090909)
testthat::expect_equal(sum.series(999), 0.999)

# 3 -----------------------------------------------------------------------

is.lucky.number <- function (n) {
  floor(n/1000) + floor(n/100) %% 10 == floor(n/10) %% 10 + n %% 10
}

testthat::expect_true(object = is.lucky.number(7566))
testthat::expect_false(object = is.lucky.number(3881))
