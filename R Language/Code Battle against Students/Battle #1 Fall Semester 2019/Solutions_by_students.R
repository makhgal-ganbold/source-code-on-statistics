
# 1 -----------------------------------------------------------------------

is.perfect <- function(n) {
  s <- 0
  i <- 1
  while (i < n) {
    if( n %% i == 0) {
      s <- s + i
    }
    i <- i + 1
  }
  s == n
}

testthat::expect_true(is.perfect(496))
testthat::expect_false(is.perfect(25))

# 2 -----------------------------------------------------------------------



# 3 -----------------------------------------------------------------------

digit.sum <- function(n) {
  i <- 1
  s <- 0
  while (i <= n) {
    p <- i
    while(p > 0) {
      k <- p %% 10
      s <- s + k
      p <- p %/% 10
    }
    i <- i + 1
  }
  return(s)
}

testthat::expect_equivalent(object = digit.sum(13), expected = 55)
testthat::expect_equivalent(object = digit.sum(20), expected = 102)

# 4 -----------------------------------------------------------------------



# 5 -----------------------------------------------------------------------

