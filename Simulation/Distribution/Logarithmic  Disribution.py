#
# Logarithmic Distribution Simulation
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random, math

p = float(raw_input("p = ")) # parameter
n = int(raw_input("n = ")) # sample size

while n > 0 :
    cum_prob = prob = 1 - p
    k = 1
    r = random.random()
    while cum_prob < r :
        prob *= p
        cum_prob = cum_prob + prob
        k += 1
    if random.random() < 1.0 / k :
        n -= 1
        print k
