#
# Exponential Distribution Simulation
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random, math

n = int(raw_input("n = "))
Lambda = float(raw_input("Lambda = "))

while n > 0 :
    n -= 1
    print -1.0 * math.log( random.random() ) / Lambda
