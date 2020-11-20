
# 1 -----------------------------------------------------------------------

testthat::expect_true(is.perfect(496))
testthat::expect_false(is.perfect(25))

# 2 -----------------------------------------------------------------------

testthat::expect_equivalent(object = number.e(), expected = 2.7182818284590452353602874713527)

# 3 -----------------------------------------------------------------------

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
})
testthat::expect_equivalent(object = odd.rowMeans(X), expected = c(6.25, 4.75, 5.75))

# 5 -----------------------------------------------------------------------

testthat::expect_true(is.palindrome("civic"))
testthat::expect_true(is.palindrome("madam"))
testthat::expect_true(is.palindrome("refer"))
testthat::expect_false(is.palindrome("abc"))
testthat::expect_false(is.palindrome("baba"))
testthat::expect_false(is.palindrome("Madam"))
