#
# Linear Regression
# Seminar 7
# Author: galaa
# Created on 2016/11/05 11:30:00
#

# Data

Y <- c(5.6, 8.9, 13.1, 19.8, 4.7, 20.5, 20.2, 13.6, 11.4, 3.3)
X <- c(2.7, 3.7, 5.7, 9.1, 2.0, 9.0, 9.4, 6.6, 6.3, 0.6)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 1

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

summary(lm(Y ~ X - 1))

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Exercise 3

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

new.data <- data.frame(X = seq(from = 0, to = 10, by = 1))
pred <- predict(lm(Y ~ X), new.data, interval = "prediction")
conf <- predict(lm(Y ~ X), new.data, interval = "confidence")
matplot(new.data$X, cbind(conf, pred[,-1]), lty = c(1,2,2,3,3), type = "l", ylab = "predicted y")
