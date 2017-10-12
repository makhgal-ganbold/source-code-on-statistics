#
# Discrete Time Process
# Author: galaa
# Created on 2016/06/23 11:02:00
#

# Non-optimal code

n = 25;
Z <- c();
Z[1] <- 0;
n <- n + 1; # R index starts from 1
for (i in 2:n) {
  Z[i] <- Z[i-1] + rnorm(n = 1, mean = 0, sd = 1);
}
Z <- Z[-1]; # remove Z_0
print(X);

# Optimal code

cumsum(rnorm(n = 25, mean = 0, sd = 1));
