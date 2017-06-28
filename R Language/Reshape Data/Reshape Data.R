#
# Reshape Data
# Author: galaa
# Created on 2017/04/25 17:00:00
#

## wide to long

X.wide <- data.frame(
  type = c(3,1),
  a = c(1.2, 1.5),
  b = c(0.8, 1.4)
)

require(reshape2)
melt(data = X.wide, id.vars = "type", measure.vars = c("a", "b"), variable.name = "category", value = "value")

## long to wide

X.long <- data.frame(
  type = c(3,1,3,1),
  category = c("a", "a", "b", "b"),
  value = c(1.2, 1.5, 0.8, 1.4)
)

require(reshape2)
dcast(X.long, type ~ category, value.var = "value")
