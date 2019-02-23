#
# Training Program for R Langauge
# Topic C2 - Working with Text and Date/Time
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/10
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Тексттэй ажиллах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Текстийн уртыг олох

nchar("I speak R")

strings <- c("I speak R", "R is a programming language")
nchar(strings)

## Текстийн дэд хэсгийг ялган авах

mystr <- "I speak S"
substr(mystr, start = 9, stop = 9)

## Текстийн дэд хэсгийг засч өөрчлөх

substr(mystr, start = 9, stop = 9) <- "R"
print(mystr)

## substr() функцийн вектор дээрх үйлчлэл

strings <- c("I speak R", "R is a programming language")
substr(strings, start = 1, stop = 1)

## Текстийг хуваах

# ердийн текст горим

strings <- c("I speak R", "R is a programming language")
strsplit(x = strings, split = " ", fixed = TRUE)

# Regular Expression горим

strsplit(x = "a ... z", split = "[ .]+", fixed = FALSE)
strsplit(x = "a ... z", split = "[ .]+", fixed = TRUE)

## Текстийг залгаж нэгтгэх

# Ердийн текст

paste("I", "speak", "R", sep = " ")

# Векторууд

paste(1:4, c("st", "nd", "rd", "th"), sep = "")

# Нэг вектор

paste(c("I", "speak", "R"), sep = "")

# collapse параметр

paste(c("I", "speak", "R"), collapse = " ")

## Текстийг хайх ба солиход Regular Expression-ийг ашиглах

# Хайх

names <- c('Galaa', 'Munkhmandakh', 'Munkh-Yargui')
grep(pattern = '^Munkh', x = names, value = TRUE)

# Солих

names <- c('Galaa', 'Munkhmandakh', 'Munkh-Yargui')
sub(pattern = '(^Munkh)[a-z]+', replacement = '\\1uu', x = names)

## Текстийг бусад төрөл уруу хувиргах

type.convert(x = c("1", "2", "NA", "4"))

type.convert(x = c("FALSE", "T", "TRUE", "NA"))

type.convert(x = c("1.0000000000000001", "2", "NA", "4"), numerals = "warn.loss")

type.convert(x = c("1.0000000000000001", "2", "NA", "4"), as.is = TRUE, numerals = "no.loss")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Огноо ба цагтай ажиллах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Текстийг огноо уруу хувиргах

birthdates = as.Date(c("2014-02-24", "2012-01-29"))
days = birthdates[1] - birthdates[2]
print(days)

## Огноо ба цаг хугацааны мэдээллийг тодорхой форматаар хэвлэн гаргах

format(Sys.Date(),            # current system date
  format = "%A, %B %d, %Y")
