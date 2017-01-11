#
# Training Program for R Langauge
# Topic 6 - Working with Data
# Author: galaa (www.galaa.mn)
# Copyright (c) 2016-2017 Makhgal
# Created on 2016/10/04 07:01:15
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хувьсагч зохиох

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Өгөгдөл

df =  data.frame(X = c(T, F), Y = c(F, F))

## I арга

df$new = df$X | df$Y
print(df$new)

## II арга, хуучин хувьсагчид хэвээр үлдэнэ

df = transform(df,
  or = X | Y,
  and = X & Y
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хувьсагчийн нэрийг өөрчлөх

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Өгөгдөл

df = data.frame(c(T, F))

## I арга

names(df)            # get variable names
names(df) <- c("X")  # set variable names

## II арга

fix(df)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Өгөгдөл устгах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хувьсагч (багана устгах)

## Өгөгдөл

df = data.frame(X = 1, Y = 0)

## Зааснаас бусдыг устгах

df = df["X"]

df = df[1]

## Заасныг устгах

df = df[, !(names(df) %in% c("Y")), drop = FALSE]

df$Y <- NULL

df[2] <- NULL

## Мөр устгах

## Өгөгдөл

df = data.frame(X = 1:10)

## Индексээр нь

df = df[-c(1, 4:9), , drop = FALSE]

## Утгаар буюу шинж чанараар нь

df = df[-which(df$X > 5), , drop = FALSE]

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Өгөгдөл ялгаж авах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хувьсагчдыг (багана) ялгаж авах

## Өгөгдөл

df = data.frame(X = 1, Y = FALSE, Z = "R");

## Заасныг

new.df = df[c("X", "Z")]

new.df = df[c(1, 3)]

## Зааснаас бусдыг

new.df = df[ , !(names(df) %in% c("Y")), drop = FALSE]

new.df = dataframe[c(-2)]

## Мөрүүдийг ялгаж авах

## Өгөгдөл

df = data.frame(X = rnorm(100))

## Индекс ба утгаар нь

new.df = df[1:50, , drop = FALSE]

new.df = df[which(df$X > 0), , drop = FALSE]

## subset() функцээр

new.df = subset(
  df,
  X > 0,
  select = c(X)
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Өгөгдөл нэгтгэх

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Мөрүүдийг нэгтгэх

df.A = data.frame(X = 1:3)
df.B = data.frame(X = 4:6)

merged.df = rbind(df.A, df.B)

## Багануудыг нэгтгэх

df.A = data.frame(X = c("S", "R"))
df.B = data.frame(Y = c(34, 56))

merged.df = cbind(df.A, df.B)

## merge() функц ашиглах

df.A = data.frame(id = c(3, 8), name = c("Od", "Az"))
df.B = data.frame(id = c(3, 7), height = c(1.7, 0.7))

merged.df = merge(df.A, df.B, by = c("id"), all = FALSE)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Эрэмбэлэх

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

df = data.frame(X = c(1,0,0,2), Y = c(0,1,-1,0))

df.XY = df[order(df$X, df$Y), ]

df.X = df[order( - df$X), ]

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хөрвүүлэх

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

df = data.frame(X = c(1,0), Y = c(0,1), row.names = c("a", "b"))

t(df)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Шошго зүүх ба кодлох

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Хувьсагчид шошго зүүх

df = data.frame(X = c(1,0), Y = c(0,1))

library(Hmisc)
label(df$X) <- "Label X"

## Чанарын өгөгдлийн анги\footnote{чанарын хувьсагчийн утга}удад шошго зүүх

df = data.frame(X = factor(c(0,1,0,-1,1)))

df$X = factor(df$X, levels = c(-1,0,1), labels = c("low", "medium", "high"))

## Чанарын өгөгдлийн ангиудыг кодлох

df = data.frame(type = factor(c(3,1,1,2,1), labels = c("low", "medium", "high"), ordered = T))

df$type <- factor(ifelse(as.numeric(df$type) >= 2, "good", "bad"), ordered = T)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Орхигдсон утгатай ажиллах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Шалгаж илрүүлэх

df = data.frame(X = c(1,NA,3), Y = c(-1,0,NA))

is.na(df); is.na(df$X); anyNA(df)

df[!complete.cases(df),]

## Алгасах

mean(c(1,NA,3), na.rm = TRUE)

## Зайлуулах 

df = na.omit(df)

## Алдаатай утгуудыг NA болгох

df = data.frame(X = c(1,-1,3))

df$X[df$X <= 0] <- NA

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Өгөгдлийн бүтэц зохион байгуулалтыг өөрчлөх

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Өргөн -> Урт

df = data.frame(
  type = c(3,1),
  a = c(1.2, 1.5),
  b = c(0.8, 1.4)
)

reshape(df, 
  direction = "long", 
  varying = list(2:3), 
  times = list("a", "b"), 
  timevar = "category", 
  v.names = "value"
)

## Урт -> Өргөн

df <- data.frame(
  type = c(3,1,3,1),
  category = c("a","a","b","b"),
  value = c(1.2,1.5,0.8,1.4)
)

reshape(df, 
  direction = "wide", 
  idvar = "type", 
  timevar = "category"
)
