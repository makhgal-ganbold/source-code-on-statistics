#
# Chi Distribution Simulation with parameter k = 2
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random

n = int(raw_input("n = ")) # sample size

c = 2.2039

while n > 0 :
    n -= 1
    while True :
        u = random.random()
        y = -1.0 * math.log(random.random())
        if c * u < y * (math.exp(-1.0 * y ** 2 / 2) + y) :
            print y
            break
