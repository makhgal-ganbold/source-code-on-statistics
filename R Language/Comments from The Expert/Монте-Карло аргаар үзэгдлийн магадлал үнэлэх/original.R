x = runif(1000)
y = runif(1000)
na = 0
n = 1000
for (i in 1:1000) {
  if (x[i]^2 + y[i]^2 <= 1) {
    na = na + 1
  }
}
na / n