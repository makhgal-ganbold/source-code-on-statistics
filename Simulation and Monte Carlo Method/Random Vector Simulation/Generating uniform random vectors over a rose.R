#
# Generating uniform random vectors over a rose
# Author: galaa
# Created on 2021/03/22 12:30:00
#

k <- 6

X <- t(replicate(n = 500, expr = {
  if (k == 0)
    stop("k != 0")
  repeat {
    x <- runif(n = 1, "min" = -2, "max" = 2)
    y <- runif(n = 1, "min" = -2, "max" = 2)
    if (k %% 2 == 0) {
      if (x^2+y^2 < 4*sin(k*atan(y/x))^2)
        return(c(x,y))
    } else {
      if (sqrt(x^2+y^2) < 2*sin(k*atan(y/x))) {
        if (x < 0)
          y <- - y
        return(c(x,y))
      }
    }
  }
}))
plot(X, cex = 0.1, col = "red", xlab = "", ylab = "", asp = 1, axes = FALSE)

(function () {
  if (k == 0)
    stop("k != 0")
  phi <- seq(from = 0, to = 2 * pi, "length.out" = 600)
  r <- 2 * sin( k * phi )
  points(
    cbind(
      r * cos(phi),
      r * sin(phi)
    ),
    type = "l", col = "red"
  )
})()