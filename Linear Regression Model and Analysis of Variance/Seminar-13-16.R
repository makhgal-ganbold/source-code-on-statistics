
## Data

y = c(-7.4, 14.5, 9.9, 2.3, 3.1, 3.3, -0.1, -2.8, 10.8, -4.5, 14.9, -2.7, 14.3, 13.1, 28.6)

X2 = c(1.6, 9.7, 4.7, 7.8, 4.1, 5.4, 2.1, 1.9, 7.8, 1.9, 4.3, 0, 8.3, 8.3, 9.6)
X3 = c(2.7, 1, -0.7, 1.2, 0.6, 2.4, 1, 1.7, 2, 2.5, -1.5, 0.9, 0.9, 2.7, -0.9)
X4 = c(4.7, 9.2, 5.8, 8.1, 8.2, 8.4, 1.6, 1.4, 13.4, 2, 10.8, 5.6, 6.3, 6.9, 1.4)

## Linear Model

fit = lm(y ~ X2 + X3 + X4)

## Heteroscedasticity

# H_0: error (residual) variance is constant

# install.packages("car")
# library dependecies
library(car)

## Breusch-Pagan Test
ncvTest(fit)

## detailed computation

# Step 1

# sample size
n = length(y)

# residuals
u = residuals(fit)

# estimation of variance of residual
sigma = sqrt(sum(u^2) / n)

# Step 2

# estimated values as variable z
z = fitted.values(fit); p = 2

# independent variable for "new" regression
u. = u^2 / sigma^2

# SSR of "new" regression
SST <- sum((u. - mean(u.))^2)
SSE <- sum(residuals(lm(u. ~ z))^2)
SSR <- SST - SSE

# Step 3

# Breusch-Pagan statistics
Breusch.Pagan.stat = SSR / 2

# p-value
pchisq(q = Breusch.Pagan.stat, df = p - 1, lower.tail = FALSE)

## Autocorrelation

# H_0: residuals are independent

# library dependecies
library(car)

# Durbin-Watson Test
durbinWatsonTest(fit)

# library dependecies
library(lmtest)

# Durbin-Watson Test
dwtest(fit)
