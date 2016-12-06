#
# Training Program for R Langauge
# Lesson 4 - Some important concepts and around the error
# Author: galaa (www.galaa.mn)
# Copyright (c) 2016 Makhgal
# Created on 2016/10/01 22:00:45
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Зарим чухал ойлголт

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Нэрийн огторгуй

X = matrix(data = 1:4, nrow = 2)
print(X)

t = function (x) {
  print("энэ бол хэрэглэгчийн функц")
}

t(x = X)

base::t(x = X)

# Обьектийн оршин буй эсэхийг шалгах ба устгах

x = "энэ бол текстэн обьект"

exists("x")

rm(x)

exists("x")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Алдаанууд

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# unexpected numeric constant in

c(-1, 0 1)

# unexpected ‘=’ in

if (1 = 1) print("тэнцүү")

# object of type '...' is not subsettable

mean[1] # mean бол base багц дахь функц юм

# subscript out of bounds

X = matrix(data = 1:4, nrow = 2)

X[3,3]

# not meaningful for factors

X = factor(c("X","Y","X","X","Y"))

X + 1

# invalid 'type' (character) of argument эсвэл argument is not numeric

str = "text"

mean(str)

# unexpected ‘else’ in “else”

x <- 3
if (x %% 2 == 0)
  print("even")
else
  print("odd")

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Анхааруулга, Алдаа болон Мэдэгдэл үүсгэх

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

warning("Heads Up!")

stop("Fatal Error!")

message("Done")
