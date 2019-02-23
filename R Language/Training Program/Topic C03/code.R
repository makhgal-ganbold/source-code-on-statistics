#
# Training Program for R Langauge
# Topic C3 - Working with File and Directory
# Author: galaa (www.galaa.mn)
# Copyright (c) 2017 Makhgal
# Created on 2017/01/11
#

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Файл ба хавтастай ажиллах

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

## Ажлын хавтасны хаягийг авах ба өөрчлөх

getwd()

# relative path

setwd("./Documents")

# parent directory

setwd("..")

# absolute path

setwd("/home/galaa/Documents")

## Ажлын хавтсан дахь бүх файл ба хавтасны жагсаалт]

dir(path = ".", all.files = TRUE)

## Файлд текст мөрүүдийг бичих ба унших

# open an output file connection in the mode "write"
f <- file("example.txt", "w")
# write four lines
cat("This is an example", "1 2 3 4", "", "5 6 7 8", file = f, sep = "\n")
# write one more line
cat("One more line\n", file = f)
# close the file connection
close(f)

# open an input file connection in the mode "read"
f <- file("example.txt", "r")
# read all lines
x <- readLines(con = f, n = -1)
# close the file connection
close(f)

print(x)
class(x)
is.vector(x)

## Текстийг шахалттайгаар бичих ба унших

f <- gzfile("example.txt.gz", "w", compression = 6)
writeLines(text = c("this is a compression example", "2nd line", 10000:10010, "last line"),  con = f, sep = "\n")
close(f)

f <- gzfile("example.txt.gz")
x <- readLines(con = f, n = -1)
close(f)

print(x)

## Матриц болон датафрэймийг текст файлд шахалттайгаар бичих ба унших

df <- data.frame(id = c(1,3,2,4), value = c(1.12,2.54,0.06,-0.54))
f <- gzfile("example.txt.gz", "w", compression = 9)
write.table(x = df, file = f, sep = "\t")
close(f)

new.df <- read.table(file = gzfile("example.txt.gz"), header = TRUE, sep = "\t")

print(new.df)

## Zip файлтай ажиллах

X = read.table(unz("example.zip", "example.txt"), header = TRUE)
print(X)
