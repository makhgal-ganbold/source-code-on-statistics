#
# Generating uniform random vectors over a simplex
# Author: galaa
# Created on 2017/10/19 15:03:00
#

#

n = 500

#

simulation = function() {
  u = runif(n = 2)
  u = sort(u)
  return(u)
}
Z = t(replicate(n = n, simulation()))
plot(Z, asp = TRUE)

#

X = matrix(
  data = apply(
    X = Z,
    MARGIN = 1,
    FUN = function(u) {
      c(u[1], u[2] - u[1])
    }
  ),
  ncol = 2,
  byrow = TRUE
)
plot(X, asp = TRUE)

#

c0 = c(3,1)
c1 = c(5,3)
c2 = c(2,5)

C = cbind(c1 - c0, c2 - c0)

Y = t(C %*% t(X) + c0)
plot(Y, asp = TRUE)
