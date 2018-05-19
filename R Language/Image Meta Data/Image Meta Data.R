#
# Working with Image Meta Data
# Author: galaa
# Created on 2018/05/19 11:20:00
#

## ------------------------------------------------------------------------
## Шаардагдах багц
## ------------------------------------------------------------------------

# install.packages("exifr")

## ------------------------------------------------------------------------
## Зургийн файлын нэр
## ------------------------------------------------------------------------

image.file.names <- dir(
  path = "~/Pictures/Photos", # зураг агуулж буй хавтасны нэр (ӨӨРИЙНХӨӨРӨӨ СОЛИХ ШААРДЛАГАТАЙ)
  pattern = ".jpg", full.names = TRUE, recursive = TRUE, ignore.case = TRUE, no.. = TRUE
)

## ------------------------------------------------------------------------
## Зургийн мета мэдээлэл
## ------------------------------------------------------------------------

## Зургийн мета мэдээлэл

image.meta.infos <- exifr::read_exif(
  path = image.file.names,
  tags = c("DateTimeOriginal")
)

objects(image.meta.infos)

## Зураг дарсан огноо

image.date <- na.omit(as.Date(gsub(pattern = ":", replacement = "-", x = image.meta.infos$DateTimeOriginal)))

image.date <- data.frame(
  year = ordered(x = as.integer(substr(x = image.date, start = 1, stop = 4)), levels = 1997:2018),
  month = ordered(x = as.integer(substr(x = image.date, start = 6, stop = 7)), levels = 1:12)
)

head(image.date)
tail(image.date)

## ------------------------------------------------------------------------
## Зургийн "цаг хугацааны" тархалт (он ба сар)
## ------------------------------------------------------------------------

## Хамтын давтамжийн хүснэгт

crosstab <- table(image.date)

print(crosstab)

## Хамтын давтамж диаграммаар

heatmap(
  x = crosstab,
  Rowv = NA, Colv = NA, scale = "none",
  col = colorRampPalette(c("white", "red"))(n = 100), margins = c(2,2)
)
