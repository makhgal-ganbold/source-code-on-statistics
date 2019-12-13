
# 1 -----------------------------------------------------------------------

is.perfect <- function (x) {
  s <- 0
  for (i in 1:{x - 1}) {
    if (x %% i == 0) {
      s <- s + i
    }
  }
  x == s
}

testthat::expect_true(is.perfect(496))
testthat::expect_false(is.perfect(25))

# 2 -----------------------------------------------------------------------

number.e <- function (n = 10) {
  frac <- 1
  e <- 1
  for (i in 1:n) {
    frac <- frac / i
    e <- e + frac
  }
  e
}

testthat::expect_equivalent(object = number.e(10), expected = 2.7182818284590452353602874713527)

# 3 -----------------------------------------------------------------------

digit.sum <- function(n = 13) {
  numbers <- 1:n
  s <- 0
  for (number in numbers) {
    s <- s + sum(as.numeric(strsplit(x = as.character(number), split = "")[[1]]))
  }
  s
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

odd.rowMeans <- function(x) {
 rowMeans(x[seq(from = 1, to = nrow(x), by = 2), , drop = FALSE])
}

testthat::expect_equivalent(object = odd.rowMeans(X), expected = c(6.25, 4.75, 5.75))
testthat::expect_equivalent(object = odd.rowMeans(Y), expected = c(9, 8, 5))

# 5 -----------------------------------------------------------------------

is.palindrome <- function(x) {
  x <- strsplit(x = x, split = "")[[1]]
  all(rev(x) == x)
}

testthat::expect_true(is.palindrome("civic"))
testthat::expect_true(is.palindrome("madam"))
testthat::expect_true(is.palindrome("refer"))
testthat::expect_false(is.palindrome("abc"))
testthat::expect_false(is.palindrome("baba"))
testthat::expect_false(is.palindrome("Madam"))
