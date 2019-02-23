
## ------------------------------------------------------------------------------
## Өгөгдөл
## ------------------------------------------------------------------------------

# Аймгийн төвүүд, нийслэл хоорондын зай

setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) ## Requires RStudio

distance.between.cities <- read.csv("Distance between cities.csv", row.names = NULL, stringsAsFactors = FALSE)
dim(distance.between.cities)
head(distance.between.cities)

provinces <- names(distance.between.cities)[6:26]
print(provinces)
distance <- as.matrix(distance.between.cities[,5:26])
print(distance)

## ------------------------------------------------------------------------------
## Кластерын шинжилгээ - Шатлах алгоритм
## ------------------------------------------------------------------------------

# Зайн матриц

d <- as.dist(distance)

# Шинжилгээ

clustering <- hclust(d = d, method = "complete")

# Диаграмм

plot(clustering)
rect.hclust(tree = clustering, k = 4)

# Хуваалт

cluster.membership <- cutree(tree = clustering, k = 4)

sapply(X = 1:4, FUN = function (i) {
  names(cluster.membership[cluster.membership == i])
})

## ------------------------------------------------------------------------------
## Олон хэмжээст координатын шинжилгээ - Multidimensional Scaling
## ------------------------------------------------------------------------------

# Шинжилгээ

coordinates <- cmdscale(d = d, k = 2)
print(coordinates)

# Диаграмм

plot(coordinates)

# Зайн матриц эерэг тодорхойлогдсон эсэхийг шалгах

# install.packages("matrixcalc")
matrixcalc::is.positive.definite(x = distance)
# Зайн матриц эерэг тодорхойлогдоогүй тул шинжилгээ (classical multidimensional scaling) хийх боломжгүй боллоо.
# Мөн цэгүүдийн координат олоогүй байгаа тул хэсэгчлэх алгоритм бүхий кластерын шинжилгээ хийх боломжгүй.

# Зайн матриц эерэг тодорхойлогдоогүйг тойрох нэг оролдлого

distance.new <- as.matrix(Matrix::nearPD(x = distance, keepDiag = TRUE, doSym = TRUE, maxit = 1000)$mat)

# Шалгах

matrixcalc::is.positive.definite(x = distance.new)
# FALSE буюу оролдлого амжилтгүй болов

# Шинэ болон хуучин зай хоорондын дундаж ялгаа

norm(x = distance.new - distance, type = "F") / { n <- dim(distance)[1]; n * (n - 1) / 2 }

## Нэмэлт шинжилгээ

non.metric.mds <- MASS::isoMDS(d = d, k = 2)

plot(non.metric.mds$points, asp = TRUE)

# install.packages("smacof")
stress.min.mds <- smacof::mds(delta = d, ndim = 2)

plot(stress.min.mds)

class(stress.min.mds)

?plot.smacof

plot(stress.min.mds, label.conf = list(label = TRUE, col = "darkgray"), col = "blue")

coordinates <- stress.min.mds$conf

## ------------------------------------------------------------------------------
## Кластерын шинжилгээ - Хэсэгчлэх алгоритм
## ------------------------------------------------------------------------------

clustering <- kmeans(x = coordinates, centers = 4)

cluster::clusplot(coordinates, clustering$cluster, labels = 2, lines = 0, asp = TRUE)

## ------------------------------------------------------------------------------
## Travelling Salesman Problem
## ------------------------------------------------------------------------------

# Шалгаж үзэх нийт боломжийн тоо

factorial(21)

# Генетик алгоритм

fitness <- function(x) {
  d <- 0
  x <- c(1, {x + 1}, 1) # УБ-аас гараад эргэж ирнэ
  for (i in 1:22) {
    d <- d + distance[[x[i], x[i+1]]]
  }
  -d
}

# install.packages("GA")
result <- GA::ga(
  type = "permutation",
  fitness = fitness,
  lower = rep.int(x = 1, times = 21), upper = rep.int(x = 21, times = 21),
  popSize = 100, pcrossover = 0.8, pmutation = 0.25,
  maxiter = 10000
)

summary(result)
-result@fitnessValue
result@solution
plot(result)
plot(-result@summary[,1], type = "l", ylab = "Distance", xlab = "Generation")

solution <- list(
  "version.1" = provinces[result@solution[1,]],
  "version.2" = provinces[result@solution[2,]],
  "length" = -result@fitnessValue,
  "ga" = result
)

solution$version.1
solution$version.2
solution$length
result <- solution$ga

# save(solution, file = "Solution of Travelling Salesman Problem.RData", compression_level = 9)
load(file = "Solution of Travelling Salesman Problem.RData")
