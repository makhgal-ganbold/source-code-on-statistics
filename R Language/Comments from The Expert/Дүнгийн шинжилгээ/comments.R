#
# Comments from Expert
# Author: galaa
# Created on 2017/12/02 09:46:00
#

## --------------------------------------------------------------------------
## Өгөгдөл
## --------------------------------------------------------------------------

X <- data.frame(
  id = 1:16,
  value = c(18, 15, 15, 18, 6, 9, 18, NA, 3, 18, 24, 15, 15, 12, 12, 24),
  group = factor(x = c(3, 3, 4, 2, 1, 2, 3, NA, 1, 4, 2, 4, 3, 1, 1, 2))
)

print(X)

## --------------------------------------------------------------------------
## Орхигдсон утга зайлуулах
## --------------------------------------------------------------------------

## Орхигдсон утга бүхий мөрүүдийн дугаар

which(!complete.cases(X))

## Орхигдсон утга бүхий мөрүүд

X[!complete.cases(X),]

## Орхигдсон утга бүхий мөрүүдийг зайлуулах

X <- X[complete.cases(X),]

print(X)

## --------------------------------------------------------------------------
## Бүлгүүд адил тэнцүү дисперстэй эсэхийг шалгах
## --------------------------------------------------------------------------

## Бүлэг тус бүрийн стандарт хазайлт

aggregate(formula = value ~ group, data = X, FUN = sd)

## Таамаглал: Бүх бүлэг адил тэнцүү дисперстэй

bartlett.test(formula = value ~ group, data = X)

## Таамаглал: 1, 3, 4 дүгээр бүлгүүд адил тэнцүү дисперстэй

bartlett.test(formula = value ~ group, data = X, subset = group %in% c(1,3:4))

## Таамаглал: Хоёр бүлэг адил тэнцүү дисперстэй

combination <- combn(x = nlevels(x = X$group), m = 2)

print(combination)

var.test.p.value <- apply(
  X = combination,
  MARGIN = 2,
  FUN = function (comb) {
    var.test(formula = value ~ group, data = X, subset = group %in% comb)$p.value
  }
)

print(var.test.p.value)

## 0.05 итгэх төвшинд дисперсээрээ ялгаатай бүлгүүдийн хосууд

comb.non.homo.var <- combination[, var.test.p.value < 0.05, drop = FALSE]

print(comb.non.homo.var)

## 0.05 итгэх төвшинд дисперсээрээ үл ялгарах бүлгүүдийн хосууд

comb.homo.var <- combination[, !(var.test.p.value < 0.05), drop = FALSE]

print(comb.homo.var)

## --------------------------------------------------------------------------
## Бүлгүүдийн дундаж адил тэнцүү эсэхийг шалгах
## --------------------------------------------------------------------------

## Бүлэг тус бүрийн дундаж

aggregate(formula = value ~ group, data = X, FUN = mean)

## Таамаглал: Бүх бүлгийн дундаж адил тэнцүү

summary(aov(formula = value ~ group, data = X))

## Таамаглал: Хоёр бүлгийн дундаж адил тэнцүү

apply(
  X = comb.non.homo.var,
  MARGIN = 2,
  FUN = function (comb) {
    t.test(formula = value ~ group, data = X, subset = group %in% comb)$p.value
  }
)

apply(
  X = comb.homo.var,
  MARGIN = 2,
  FUN = function (comb) {
    t.test(formula = value ~ group, data = X, subset = group %in% comb, var.equal = TRUE)$p.value
  }
)

## Таамаглал: Дунджийн ялгаврын тухай таамаглал : 1 дүгээр бүлгийн дундаж болон бусад бүлэг хоорондын дунджийн ялгавар -6

for (i in 2:4) {
  print(t.test(x = X$value[X$group == 1], y = X$value[X$group == i], mu = -6, var.equal = TRUE)$p.value)
}

## 1 дүгээр бүлгийн утгуудыг 6-аар нэмэгдүүлэх

X$value[X$group == 1] <- X$value[X$group == 1] + 6

print(X)

## Бүлгүүдийн байршил

boxplot(value ~ group, data = X)
