#
# Training Program for R Langauge
# Topic 3 - Operators, Functions and Environment
# Author: galaa (www.galaa.mn)
# Copyright (c) 2016-2018 Makhgal
# Created on 2016/09/30 06:30:25
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Operators / Операторууд

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Арифметик оператор

2 ^ 3

# Арифметик операторын вектор дээрх үйлчлэл

c (1, 2, 3) + 1

## Утга оноох оператор

x <- 2
3 -> y
x ^ y

## Харьцуулах оператор

x <- 1
y <- 2
x < y

## Логик оператор

x <- c (TRUE, FALSE, 0, 2)
y <- c (FALSE, TRUE, FALSE, TRUE)
x & y

## Инфикс оператор

`+` (1, 2) == 1 + 2

## Шинээр оператор тодорхойлох

'%-%' = function (x, y) { # syntax: '%operator.name%'
  max (x - y, y - x)
}

1 %-% 3

'%-%' (1, 3)

## Үйлдлийн дараалал

1 + 2 * 3
(1 + 2) * 3
{1 + 2} * 3
(1 + 2 * {2 - 1}) * 3
# {1 + (2 + 3} - 4) ## ERROR

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Functions / Функц

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Функц зарлах

decrease <- function (number, by = 1) {
  number - by
}

## Функц дуудах

decrease(5, 2)

decrease(by = 1, number = 3)

decrease(by = 1, 3)

decrease(3)

## ... аргумент

average <- function (...) {
  mean(...)
}

average(c(-1, 0, 1))

## Функцийн утга ба return() функц

multiple_values <- function () {
  return(list("size" = 39, "color" = "black"))
  print("it will not print")
}

multiple_values()

## Бүлэг тушаал

x <- -1:1

{
  z <- x
  z[z < 0] <- 0
  z
}

## Нэргүй функц

(function (x, y) {
  z <- x + y
  return(z)
})(1, 2)

apply(X, MARGIN = 2, FUN = function (x) {
  x[x < 0] <- 0
  mean(x)
})

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Environment / Хүрээ

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хүрээний нэр

environment()

## Объектуудын нэрс

ls()

## Бүх объектыг устгах

rm(list = ls())

## "локал" хувьсагч

x <- TRUE

func.local.variable <- function () {
  x <- FALSE
  return(x)
}

func.local.variable()

## "глобал" хувьсагч

x <- TRUE

func.global.variable <- function () {
  return(x)
}

func.global.variable()

## "глобал" хувьсагчид утга оноох

x <- TRUE # глобал хувьсагч

environment()

func.assign.global.variable <- function () {
  print(environment())
  x <- TRUE # локал хувьсагч
  x <<- FALSE # эх хүрээлэл дэх глобал хувьсагчид утга онооно
  print(x) # x локал хувьсагчийн утга хэвлэгдэнэ
}

func.assign.global.variable()

print(x)

## "глобал" хувьсагчийн утга авах

x <- TRUE

environment()

func.get.global.variable <- function () {
  print(environment())
  x <- FALSE
  print(x) # FALSE
  print(parent.env(environment()))
  x <- parent.env(environment())$x
  print(x) # TRUE
}

func.get.global.variable()
