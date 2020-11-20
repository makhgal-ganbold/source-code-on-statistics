
# 1 -----------------------------------------------------------------------

testthat::expect_equal(maximal.digit(6), 6)
testthat::expect_equal(maximal.digit(1745738), 8)
testthat::expect_equal(maximal.digit(4131233), 4)

# 2 -----------------------------------------------------------------------

testthat::expect_equal(sum.series(10), 0.9090909)
testthat::expect_equal(sum.series(999), 0.999)

# 3 -----------------------------------------------------------------------

testthat::expect_true(object = is.lucky.number(7566))
testthat::expect_false(object = is.lucky.number(3881))
