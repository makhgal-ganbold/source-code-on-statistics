#
# Training Program for R Langauge
# Topic A2 - Data Types, Input and Export Data
# Author: galaa (www.galaa.mn)
# Copyright (c) 2016-2019 Makhgal
# Created on 2016/09/20
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Data Types / Өгөгдлийн төрлүүд
## Import data from file / Файлаас өгөгдөл оруулах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Скаляр
number <- 2
string = "Text"
another.string <- 'String'
logical.value <- TRUE

## Вектор
prime.numbers <- c(2, 3, 5, 7) # numbers
my.children <- c("Munkhmandakh", "Munkh-Yargui") # characters
logical.values <- c(TRUE, FALSE) # logical
empty.vector <- c()

# Тоон дараалал буюу тоон вектор үүсгэх зарим арга
numbers <- 1:10 # 1,2,...,10
even.numbers <- seq(from = 2, to = 10, by = 2) # 2,4,...,10
zeros <- rep(x = 0, times = 3) # 0 0 0

# Вектор файлаас оруулах
a <- scan(file = "data_matrix.csv", sep = ",", dec = ".", skip = 0, nlines = 2, na.strings = "NA")

## Матриц
A <- matrix(data = 1:6, nrow = 2, ncol = 3, byrow = FALSE)
print(A)

# Матриц файлаас оруулах
A <- matrix(
  data = scan(file = "data_matrix.csv", sep = ","),
  ncol = 3, byrow = TRUE
)
print(A)

## Array буюу массив
A <- array(
  data = 1:8,
  dim = c(2, 2, 2)
)
print(A)

## Фактор
qualative.data <- factor(
  x = c("m", "f", "m"),          # data
  levels = c("m", "f"),          # categories
  labels = c("male", "female"),  # labels
  ordered = FALSE                # type
)
print(qualative.data)

## Датафрэйм
X <- data.frame(
  name = c("Erdene", "Khaliun", "Od"),
  sex = factor(x = c(1, 2, 1), levels = c(1, 2), labels = c("male", "female"), ordered = FALSE),
  age = c(21, 19, 20),
  row.names = c(3, 2, 1),
  stringsAsFactors = FALSE
)
print(X)

# Датафрэймийг файлаас оруулах
X <- read.table(file = "data_dataframe.csv",
  header = TRUE, sep = ",", dec = ".", na.strings = "NA",
  row.names = "ID",
  col.names = c("ID", "Name", "Sex", "Age"),
  colClasses = c("numeric", "character", "factor", "numeric")
)
print(X)

## Лист

mixed.values <- list(
  statistical.packages = c("R", "SAS", "Stata", "SPSS", "EViews"),
  free = c(TRUE, FALSE),
  quantity = 1,
  "string"        # unnamed element
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Access elements / Объектын элемент уруу хандах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

mixed.values[4]
qualative.data[2]

X[1,3]
X[1,]
X[,3]
X[c(1,2),2:3]

X["Name"]

X[["Name"]]
X$Name

mixed.values["statistical.packages"]
mixed.values[["statistical.packages"]]
mixed.values$statistical.packages

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Export data / Өгөгдөл экспортлох

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

write.table(x = X,
  file = "data_export.csv", append = FALSE,
  sep = ",", na = "NA", dec = ".",
  row.names = TRUE, col.names = TRUE
)

## save() ба load() функцүүд

# Объект үүсгэх
object <- "R is a programming language and software environment for statistical computing and graphics"

# Объект хадгалах
save(object, file = "object.RData")
saveRDS(object, file = "object.Rds")

# Объект устгах болон шалгах
rm(object)
print(object)

# Объект ачаалах болон шалгах
load(file = "object.RData")
object <- readRDS(file = "object.Rds")
print(object)

## save.image() функц

save.image(file = "work_space.RData")
