#
# Alias Method for discrete distribution simulation
# Author: galaa
# Created on 2016/07/03 14:40:31
#

# # # # # # # # # # # # # # # # # #
# Distribution, for example
# # # # # # # # # # # # # # # # # #

x <- c(-1, 0, 1);
p <- c(0.5, 0.3, 0.2);

# # # # # # # # # # # # # # # # # #
# Initialize
# # # # # # # # # # # # # # # # # #

k <- length(x);

# Step 0

a <- 1:k;
P <- rep(0, times = k);

b <- c();
L <- c();
H <- c();
for (i in 1:k) {
  b <- c(b, p[i] - 1/k);
  if (b[i] < 0) {
    L <- c(L, i);
  } else {
    H <- c(H, i);
  }
}

# Step 1
while (abs(max(b)) > .Machine$double.eps) {
  # Step 2
  l <- L[1]; h <- H[1];
  # Step 3
  c <- b[l]; d <- b[h];
  # Step 4
  b[l] <- 0; b[h] <- c + d;
  # Step 5
  L <- L[-1];
  # Step 6
  if (b[h] <= 0) {
    H <- H[-1];
  }
  if (b[h] < 0) {
    L <- c(L, h);
  }
  # Step 7
  a[l] <- h; P[l] <- 1 + k * c
}

# # # # # # # # # # # # # # # # # #
# Simulation
# # # # # # # # # # # # # # # # # #

set.seed(17); # seed
n <- 1000; # sample size
X <- c(); # sample
for (i in 1:n) {
  # Step 1
  u <- runif(n = 1);
  # Step 2
  i <- sample.int(n = k, size = 1);
  # Step 3
  if (u <= P[i]) {
    X <- c(X, x[i]);
  } else {
    X <- c(X, x[a[i]]);
  }
}
table(X)/length(X); # prequency table
