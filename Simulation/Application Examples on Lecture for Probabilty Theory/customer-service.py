#
# Example: Customer and Service 
# Author: galaa
# Created on 2016/03/19 07:49:41
#

import random, math

def operation(parameter, duration):
    operation = 0
    while duration > 0:
        duration += math.log(random.random()) / parameter
        operation += 1
    return operation

customers = operation(1, 120)
print 'Customers: ', customers

services = operation(0.5, 120)
print 'Services: ', services

print 'Required: ', float(customers)/services
