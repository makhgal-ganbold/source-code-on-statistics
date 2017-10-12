#
# Standard Normal Distribution Simulation
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random, math

n = int(raw_input("n = "))

while n > 0 :
  u = random.random()
  v = -1.0 * math.log(random.random())
  if u < math.exp(-1.0 * (v-1) ** 2 / 2.0) :
    n -= 1
    if random.random() > 0.5 :
      print v
    else :
      print -1.0 * v
