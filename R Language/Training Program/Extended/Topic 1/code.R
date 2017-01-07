#
# Training Program for R Langauge
# Topic 1 - Introduction
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/07 09:07:30
#

## Sample Mean

data <- c(3,5,7,9)
mean(data)

## Linear Model

X <- c(1,2,3); Y <- c(2,4,1); Z <- c(5,3,2);
lm(Z ~ (X + Y) ^ 2 - X)

## Random numbers

X <- rnorm(1e+6)
print(X)

## Hello World!

# greetings
print('Hello Statisticians!')

# assign data
X <- c(1,2,3,4,5,6)

# sample mean
mean(X)

## Help & Search

help(mean)
# or
?mean

# About the function help()
?help

help.search(mean)
# or
??mean

## Package commands

install.packages("RMySQL")

# Load package
library(RMySQL)
# or
require(RMySQL)

# Unload package
detach(package:RMySQL)

update.packages()

remove.packages("RMySQL")
