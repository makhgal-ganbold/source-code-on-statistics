#
# Example: Nuclear Chain Reaction
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random, math

reaction = [[2, 1.0/8], [4, 1.0/4], [6, 3.0/8], [8, 1.0/2]]
neutrons = 1
period = 1

while period <= 10 :
    new_neutrons = 0
    neutron = 1
    while neutron <= neutrons :
        u = random.random()
        cum_prob = 0
        index = -1
        while cum_prob < u :
            index += 1;
            cum_prob += reaction[index][1]
        new_neutrons += reaction[index][0]
        neutron += 1
    neutrons = new_neutrons
    period += 1

print neutrons
