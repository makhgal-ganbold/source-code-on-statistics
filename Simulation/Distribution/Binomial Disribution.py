#
# Binomial Distribution Simulation
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random

n = int(raw_input("n = ")) # parameter n
p = float(raw_input("p = ")) # parameter p

success = 0
experiment = 0
while experiment < n :
    experiment += 1
    if random.random() < p :
        success += 1
print success
