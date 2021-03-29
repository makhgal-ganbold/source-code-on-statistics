#
# Ratio of Uniforms
# Author: galaa
# Created on 2017/10/13 11:28:50
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Distribution, for example Exponential Distribution
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

lambda <- 1 # distribution parameter

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Helper function
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

h <- function (x) {
  exp(- lambda * x)
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Parameters of Uniform distributions
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

b <- 1; d <- 2/lambda*exp(-1); c <- 0

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Simulation
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

set.seed(11) # seed
n <- 100 # sample size
replicate(n = n, expr = {
  repeat {
    # Step 1
    u1 <- runif(n = 1, max = b)
    u2 <- runif(n = 1, min = c, max = d)
    # Step 2
    x <- u2 / u1
    if (u1 <= sqrt(h(x))) {
      return(x)
    }
  }
}) ->
  X # random sample

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Confirmation
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

ks.test(x = X, y = pexp, rate = lambda)
