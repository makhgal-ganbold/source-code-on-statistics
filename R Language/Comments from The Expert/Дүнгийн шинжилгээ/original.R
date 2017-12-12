
X = data.frame(
  id = 1:16,
  value = c(18, 15, 15, 18, 6, 9, 18, NA, 3, 18, 24, 15, 15, 12, 12, 24),
  group = factor(c(3, 3, 4, 2, 1, 2, 3, NA, 1, 4, 2, 4, 3, 1, 1, 2))
)

print(X)

complete.cases(X)

X = X[complete.cases(X),]

print(X)

aggregate(value ~ group, data = X, FUN = mean)

boxplot(value ~ group, data = X)

bartlett.test(formula = value ~ group, data = X)

summary(aov(formula = value ~ group, data = X))
