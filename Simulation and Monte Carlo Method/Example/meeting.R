#
# Example: Meeting Problem
# Author: galaa
# Created on 2016/09/09 18:53:00
#

# Longer Code

meets = 0; n = 1000

for (i in 1:n) {

  man.1 <- runif(n = 1, min = 0, max = 1)
  man.2 <- runif(n = 1, min = 0, max = 1)

  if(abs(man.1 - man.2) < 1/3) {
    meets = meets + 1
  }

}

print(meets/n)

# Shorter Code

n = 1000

length(which(abs(runif(n = n) - runif(n = n)) < 1/3))/n
