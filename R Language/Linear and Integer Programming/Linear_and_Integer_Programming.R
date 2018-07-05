## R програм ашиглаж шугаман програмчлалын бодлого бодох
## Г.Махгал
## 2018 оны 7 сарын 5

# зэрэгцээ байрлах .Rmd болон .pdf файлуудыг үзнэ үү.

res <- lpSolve::lp(
  direction = "max",
  objective.in = c(32500, 72000),
  const.mat = matrix(data = c(11, 75, 25, 50, 30, 40, 20, 10), nrow = 4, byrow = TRUE),
  const.dir = c("<="),
  const.rhs = c(5700, 4200, 5600, 3400),
  int.vec = 1:2 # эсвэл all.int = TRUE
)

res$status
res$num.bin.solns

res$solution
res$objval

res$objective
res$constraints
