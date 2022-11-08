#
# Олон хэмжээст өгөгдлийн статистик шинжилгээ
#
# Гол хэсгийн шинжилгээ
#
# (c) 2020, 2022 Г.Махгал
#

# Энгийн жишээ ------------------------------------------------------------

# Өгөгдөл

X2 <- subset(
  "x" = datasets::iris,
  "subset" = Species == "setosa",
  "select" = c("Sepal.Length", "Sepal.Width")
)
plot(X2, asp = 1)

# Шинжилгээ

pca <- princomp(x = X2, fix_sign = FALSE)
plot(x = pca$scores[,1:2], asp = 1)

# Нэмэлт жишээ ------------------------------------------------------------

image <- imager::load.image("https://upload.wikimedia.org/wikipedia/commons/f/fa/Grayscale_8bits_palette_sample_image.png")

X <- as.matrix(image)
plot(imager::as.cimg(X), main = "Оригинал зураг", interpolate = FALSE, axes = FALSE)

dim(X)
pca <- princomp(x = t(X))

which.max(cumsum(pca$sdev ^ 2) / sum(pca$sdev ^ 2) > 0.99)

(function (pca, n) {
  Y <- pca$scores
  Y[,-{1:n}] <- 0
  X <- pca$loadings %*% t(Y) + pca$center
  plot(imager::as.cimg(X), main = paste("Нийт гол хэсгийн", round(n / ncol(pca$scores) * 100, 1), "хувь"), interpolate = FALSE, axes = FALSE)
})(pca, 45)

# Нэмэлт жишээ ------------------------------------------------------------

pca <- princomp(x = datasets::iris[-5])
plot(x = pca$scores, asp = 1, pch = unclass(iris$Species), col = c("red", "green", "blue")[unclass(iris$Species)])

pca <- FactoMineR::PCA(datasets::iris[-5], ncp = 4, scale.unit = FALSE, graph = FALSE)
factoextra::fviz_pca_ind(
  X = pca,
  geom.ind = "point",
  col.ind = iris$Species, # color by groups
  palette = c("red", "green", "blue"),
  addEllipses = TRUE,
  legend.title = "Species"
)

# Нарийвчилсан жишээ ------------------------------------------------------

# Өгөгдөл

X4 <- subset(
  "x" = datasets::iris,
  "subset" = Species == "setosa",
  "select" = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")
)
head(X4)
apply(X = X4, MARGIN = 2, FUN = var)
plot(X4, asp = 1)

# Шинжилгээ

pca <- princomp(x = X4)
pca.FMR <- FactoMineR::PCA(X = X4, scale.unit = FALSE, ncp = 4, graph = FALSE)

# Проекцын векторууд буюу хувийн векторууд

all.equal(abs(pca.FMR$svd$V), abs(pca$loadings[,]), check.attributes = FALSE)

# Эхний хоёр гол хэсэг дээрх проекц

pca$scores
pca.FMR$ind$coord
all.equal(abs(pca.FMR$ind$coord), abs(pca$scores), check.attributes = FALSE)

plot(pca$scores[,1:2], asp = 1)
factoextra::fviz_pca_ind(X = pca.FMR)

# Хувийн утга буюу гол хэсгийн дисперс

pca$sdev ** 2
(pca$sdev ** 2) / sum(pca$sdev ** 2)
cumsum(pca$sdev ** 2) / sum(pca$sdev ** 2) * 100
pca.FMR$eig

plot(pca$sdev ** 2, type = "b")
factoextra::fviz_eig(X = pca.FMR, addlabels = TRUE)

# Анхны хувьсагч ба гол хэсэг хоорондын корреляц

cor(x = X4, y = pca$scores)
pca.FMR$var$cor
corrplot::corrplot(corr = cor(x = X4, y = pca$scores)[,1:2])

# Сингуляр утгын задаргаа

svd <- svd(scale(X4, scale = FALSE))
svd$v
eig <- eigen(x = cov(X4))
eig$vectors
pca$loadings

# Гол хэсэг дээрх санамсаргүй хувьсагчдын проекц

t(diag(pca$sdev) %*% t(svd$v))
pca.FMR$var$coord

factoextra::fviz_pca_var(X = pca.FMR)

# Гол хэсэг дээрх хувьсагчдын оролцоо

all.equal(t(t(pca.FMR$var$coord ^ 2) / pca.FMR$eig[,1]) * 100, pca.FMR$var$contrib)

# prcomp() функц ба шинжилгээний онолын дагуух үр дүнгүүдийн харьцуулалт -----

# Өгөгдөл

X4 <- datasets::iris3[,c("Sepal L.", "Sepal W.", "Petal L.", "Petal W."), "Setosa"]

# prcomp() функц

pca <- prcomp(x = X4)

# Онолын дагуух тооцоолол

Y <- t(t(eigen(cov(X4))$vectors) %*% t(scale("x" = X4, "center" = TRUE, "scale" = FALSE)))

# Хоёр үр дүнгийн харьцуулалт буюу prcomp() функцийн буцаах утгын тайлбар

all.equal(pca$sdev, apply(X = Y, MARGIN = 2, FUN = sd))
all.equal(pca$rotation, eigen(cov(X4))$vectors, check.attributes = FALSE)
all.equal(pca$center, colMeans(X4))
pca$scale
all.equal(pca$x, Y, check.attributes = FALSE)

# prcomp() функцийн үр дүн онолын шинж чанарыг хангаж буй нь

# 1
all(colMeans(pca$x) < .Machine$double.eps)
# 2 ба 3
all.equal(cov(pca$x), diag(eigen(cov(X4))$values), check.attributes = FALSE)
# 4
apply(X = pca$x, MARGIN = 2, FUN = var) # сөрөг бус бөгөөд буурсан утгууд гарахыг ажиглана
# 5
all.equal(sum(pca$sdev^2), sum(diag(cov(X4))))
# 6
all.equal(prod(pca$sdev^2), det(cov(X4)))
