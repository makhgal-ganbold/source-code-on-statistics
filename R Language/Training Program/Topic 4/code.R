#
# Training Program for R Langauge
# Lesson 3 - Flow Control
# Author: galaa (www.galaa.mn)
# Copyright (c) 2016 Makhgal
# Created on 2016/09/30 06:30:25
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Conditions / Нөхцөл

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# if оператор

x = c (0, 1)
if ( is.matrix (x) ) {
  print ("x is a matrix.")
} else {
  print ("x is not a matrix.")
}

if (is.matrix(x))
{
  print("x is a matrix.")
}
else # bad syntax
{
  print("x is not a matrix.")
}

# ifelse() функц

x = c(1, 2, 3, 4)
ifelse(x %% 2 == 0, "even", "odd")

# switch() функц

switch(2, "Mean", "Median", "Mode")

x = switch(4, "Mean", "Median", "Mode")
print(x)

statistics = "location"
switch(statistics, 
  "location" = "mean, median, mode", 
  "dispersion" = "range, variance",
  "shape" = "skewness, kurtosis"
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Loops / Давталт

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# for

for (i in 1:6) {
  print(i)
}

for (i in c(2,4,6,1,3,5)) {
  print(i)
}

# while

i = 1
while (i <= 6) {
  print(i); i = i + 1
}

# break

for (i in 1:6) {
  print(i)
  if (i > 1) {
    break
  }
}

# next

for (i in 1:6) {
  if (i > 1) next
  print(i)
}

# repeat

i = -1
repeat {
  if (i < 0) {
    break
  }
  i = i + 1; print(i)
  if (i == 6) {
    break
  }
}

# apply

apply(matrix(1:6, nrow = 2), 2, mean)

# tapply

tapply(c(1,2,3,4,5), factor(c("X","Y","X","X","Y")), sum)
