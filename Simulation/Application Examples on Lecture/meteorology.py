#
# Example: Meteorology
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random, math

movement = [[0.2, 0.4, 0.4, 0.0], [0.2, 0.4, 0.3, 0.1], [0.1, 0.4, 0.4, 0.1], [0.0, 0.4, 0.5, 0.1]]
current_status = 0

years_of_drought = 0
year = 1

while year <= 100 :
    u = random.random()
    cum_prob = 0
    new_status = -1
    while cum_prob < u :
        new_status += 1;
        cum_prob += movement[current_status][new_status]
    current_status = new_status
    year += 1
    if current_status == 0 :
        years_of_drought += 1

print 'P(drought) = ', float(years_of_drought) / 100
print 'Frequency = ', 100.0 / years_of_drought
