#
# Example: Meteorology
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random, math
random.seed(0)

transition = [[0.2, 0.4, 0.4, 0.0], [0.2, 0.4, 0.3, 0.1], [0.1, 0.4, 0.4, 0.1], [0.0, 0.4, 0.5, 0.1]]
current_state = 0
number_of_drought_years = 0
year = 1

while year <= 1000 :
  u = random.random()
  cum_prob = 0
  new_state = -1
  while cum_prob < u :
    new_state += 1;
    cum_prob += transition[current_state][new_state]
  current_state = new_state
  year += 1
  if current_state == 0 :
    number_of_drought_years += 1

print("P(drought) = ", float(number_of_drought_years) / 1000)
print("Frequency = ", 1000.0 / number_of_drought_years)
