#
# Algorithm: Non-Replacement Random Sample Simulation
# Author: galaa
# Created on 2017/11/16 13:27:00
#

# Эх олонлог
P <- c("Matlab", "R", "SAS", "SPSS", "Stata")
# Эх олонлогийн элементүүдийн сонгогдох магадлал
p <- c(0.23, 0.45, 0.15, 0.07, 0.1)
# Магадлалуудын нийлбэр 1-тэй тэнцүү эсэхийг шалгах
if (all.equal(target = sum(p), current = 1) != TRUE) {
  stop("Магадлалуудын нийлбэр 1-тэй тэнцүү байх ёстой!")
}
# Эх олонлогийн хэмжээ
N <- length(P)
# Түүвэр
X <- c()
# Шалгах
for (k in 1:1000){
  # Загварчлал
  i <- 0; s <- 0; t <- 0
  repeat {
    # 1-р алхам
    i <- i + 1; u <- runif(1)
    # 2-р алхам
    if (u <= (p[i] - s) / (1 - t)) {
      X <- c(X, P[i])
      s <- s + p[i]
    }
    # 3-р алхам
    if (i == N) {
      break
    }
    t <- t + p[i]
  }
# print(X)
}
# Харьцангуй давтамж
mu <- table(X) / 1000
# Харьцангуй давтамжийг өгсөн магадлалтай харьцуулах
plot(x = mu, type = "l", main = "", xlab = "", ylab = "", ylim = c(0,max(mu, p) + 0.1), col = "blue")
lines(x = p, col = "red")
