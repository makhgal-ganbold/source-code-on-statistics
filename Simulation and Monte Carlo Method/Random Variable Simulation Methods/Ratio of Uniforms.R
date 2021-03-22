#
# Ratio of Uniforms
# Author: galaa
# Created on 2017/10/13 11:28:50
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Distribution, for example Exponential Distribution
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

lambda <- 1 # distribution parameter
h <- function (x) {
  exp(- lambda * x)
}

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Simulation
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

set.seed(11) # seed
n <- 100 # sample size
replicate(n = n, expr = {
  repeat {
    # Step 1
    u <- runif(n = 2)
    # Step 2
    x <- u[2] / u[1]
    if (u[1] <= sqrt(h(x))) {
      return(x)
    }
  }
}) ->
  X # random sample

# # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Confirmation
# # # # # # # # # # # # # # # # # # # # # # # # # # # #

ks.test(x = X, y = pexp, rate = lambda)
