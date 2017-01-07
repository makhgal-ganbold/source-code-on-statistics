#
# Training Program for R Langauge
# Topic 2 - Data Types, Input and Export Data, Connecting to Database
# Author: galaa (www.galaa.mn)
# Copyright (c) 2016-2017 Makhgal
# Created on 2016/09/20 12:30:25
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Data Types / Өгөгдлийн төрлүүд
## Import data from file / Файлаас өгөгдөл оруулах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Вектор
prime.numbers = c(2, 3, 5, 7) # numbers
club.members = c("Ankhaa", "Undraa", "Gerelt") # characters
logical.values = c(TRUE, FALSE) # logical

# Тоон дараалал буюу тоон векторыг үүсгэх зарим арга
numbers = 1:10 # 1,2,...,10
even.numbers = seq(from = 2, to = 10, by = 2) # 2,4,...,10
zeros = rep(x = 0, times = 3) # 0 0 0

# Векторыг файлаас оруулах
a = scan(file = "data_matrix.csv", sep = ",", dec = ".", skip = 0, nlines = 2, na.strings = "NA")

## Матриц
A = matrix(data = 1:6, nrow = 2, ncol = 3, byrow = FALSE)
print(A)

# Матрицийг файлаас оруулах
A = matrix(
  data = scan(file = "data_matrix.csv", sep = ","),
  ncol = 3, byrow = TRUE
)
print(A)

## Array буюу массив
A = array(
  data = 1:8,
  dim = c(2, 2, 2)
)
print(A)

## Фактор
qualative.data <- factor(
  x = c("m", "f", "m"),          # data
  levels = c("m", "f"),          # categories
  labels = c("male", "female"),  # labels
  ordered = FALSE)
print(qualative.data)

## Датафрэйм
X = data.frame(
  name = c("Erdene", "Khaliun", "Od"),
  sex = factor(x = c(1, 2, 1), levels = c(1, 2), labels = c("male", "female"), ordered = TRUE),
  age = c(21, 19, 20),
  row.names = c(3, 2, 1),
  stringsAsFactors = FALSE
)
print(X)

# Дата фрэймийг файлаас оруулах
X = read.table(file = "data_dataframe.csv",
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
  "string"        # unnamed value
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Access elements / Обьектийн элементүүд уруу хандах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

X["name"]

X[["name"]]
X$name

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Export data / Өгөгдөл экспортлох

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

write.table(x = X,
  file = "data_export.csv", append = FALSE,
  sep = ",", na = "NA", dec = ".",
  row.names = TRUE, col.names = TRUE
)

## save() ба load() функцүүд

# Обьектийг үүсгэх
object = "R is a programming language and software environment for statistical computing and graphics"

# Обьектийг хадгалах
save(object, file = "object.RData")

# Обьектийг устгах ба шалгах
rm(object)
print(object)

# Обьектийг ачаалах ба шалгах
load(file = "object.RData")
print(object)

## save.image() функц

save.image(file = "work_space.RData")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Working with MySQL Database / Өгөгдлийн сантай ажиллах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# RMySQL багцыг суулгах
install.packages("RMySQL")

# RMySQL дуудаж ачаалах
library(RMySQL)

# Өгөгдлийн сангийн системд холбогдох
connection <- dbConnect(MySQL(), user = "root", password = "", host = "localhost") # өгөгдлийн сангийн хэрэглэгчийн нэр ба нууц үг шаардагдана. Шаардлагатай бол хостыг 127.0.0.1 гэж авна.

# Өгөгдлийн сан үүсгэх
dbSendQuery(connection, "CREATE DATABASE r")

# Өгөгдлийн санг устгах
dbSendQuery(connection, "DROP DATABASE r")

# Өгөгдлийн санд холбогдох
dbSendQuery(connection, "USE r")
connection <- dbConnect(MySQL(), user = "root", password = "", host = "localhost", dbname = "r")

# Хүснэгт үүсгэх
dbSendQuery(connection, "
  CREATE TABLE students (
    id INT
      AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    age INT UNSIGNED
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;")

# Хүснэгтэнд мэдээлэл оруулах
dbSendQuery(connection, "
  INSERT INTO students
    (name, age)
    VALUES
      ('Od',20),
      ('Erdene',19);
  ")

# Хүснэгтээс мэдээлэл унших
student = fetch(dbSendQuery(connection, "
  SELECT
    id, name, age
  FROM
    students
  WHERE
    age = 20
  ;"))

print(student) # мэдээллийг хэвлэх
class(student) # обьектийн классыг харуулах

# Хүснэгтэн дэх мэдээллийг засч өөрчлөх
dbSendQuery(connection, "
  UPDATE students
    SET
      age = 21
    WHERE
      name = 'Erdene';")

# Хүснэгтээс мэдээллийг устгах
dbSendQuery(connection, "
  DELETE FROM students
    WHERE
      age >= 21;")

# Холболтыг салгах
dbDisconnect(connection)
