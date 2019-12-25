
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

number.e <- function(n){
  a <- 0
  for (i in 1:n) {
    a <- a+1/factorial(i)
  }
  return(1+a)
}

testthat::expect_equivalent(object = number.e(10), expected = 2.7182818284590452353602874713527)

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

testthat::expect_silent({
  X <- read.table(text = "
                  9 5 6 5
                  8 6 1 9
                  8 1 7 3
                  7 8 4 9
                  5 2 9 7")
  Y <- read.table(text = "
                  9
                  8
                  8
                  7
                  5")
})

testthat::expect_equivalent(object = odd.rowMeans(X), expected = c(6.25, 4.75, 5.75))
testthat::expect_equivalent(object = odd.rowMeans(Y), expected = c(9, 8, 5))

# 5 -----------------------------------------------------------------------

is.palindrome <- function(x){
  str <- unlist(strsplit(as.character(x), ""))
  reverse <- unlist(rev(str))
  xx <- as.character(paste(reverse, collapse = ""))
  return(x==xx)
}

testthat::expect_true(is.palindrome("civic"))
testthat::expect_true(is.palindrome("madam"))
testthat::expect_true(is.palindrome("refer"))
testthat::expect_false(is.palindrome("abc"))
testthat::expect_false(is.palindrome("baba"))
testthat::expect_false(is.palindrome("Madam"))
