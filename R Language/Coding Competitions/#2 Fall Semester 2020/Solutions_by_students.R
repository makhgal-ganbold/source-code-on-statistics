
# 1 -----------------------------------------------------------------------

maximal.digit <- function (n) {
  max<-n%%10;
  while(n>0) {
    if(max<n%%10){
      max=n%%10;
    }
    n=n%/%10;
  }
  return(max);
}

testthat::expect_equal(maximal.digit(6), 6)
testthat::expect_equal(maximal.digit(1745738), 8)
testthat::expect_equal(maximal.digit(4131233), 4)

# 2 -----------------------------------------------------------------------

sum.series <- function (n) {
  s <- 0
  for (i in 1:n){
    s <- s + (1/(i*(i+1)))
  }
  return(s)
}

testthat::expect_equal(sum.series(10), 0.9090909)
testthat::expect_equal(sum.series(999), 0.999)

# 3 -----------------------------------------------------------------------

is.lucky.number <- function (n) {
  a=floor(n/1000)+((floor(n/100))%%10)
  b=((floor(n/10))%%10)+(n%%10)
  if(a==b){
    return(TRUE)
  } else {
    return(FALSE)
  }
}

testthat::expect_true(object = is.lucky.number(7566))
testthat::expect_false(object = is.lucky.number(3881))
