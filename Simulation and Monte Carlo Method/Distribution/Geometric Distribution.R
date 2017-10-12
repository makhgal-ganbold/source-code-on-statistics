#
# Geometric Distribution Simulation
# Author: galaa
# Created on 2017/09/21 10:50:01
#

p = 0.5 # Геометр тархалтын параметр
X = c()
for (i in 1:100) { # санамсаргүй 100 утга
  x = 1
  p.x = p
  p.cum = p.x
  u = runif(1) # алгоритмын 1-р алхам
  while (u > p.cum) { # алгоритмын 2-р алхам
    x = x + 1
    p.x = p.x * (1 - p)
    p.cum = p.cum + p.x
  }
  X = c(X, x)
}
print(X) # үр дүнг хэвлэх
table(X) # давтамж олох

chisq.test(x = table(X), p = dgeom(x = sort(unique(X)), prob = p), rescale.p = TRUE) # chi-square test
