#
# Speed Up R code - for vs. replicate
# Author: galaa
# Created on 2017/10/12 21:58:00
#

# -----------------------------------------------------------------
# Нэг тушаалыг олон удаа давтах -- for vs. replicate
# Жигдийн харьцааны аргаар илтгэгч тархалт загварчлах тохиолдолд
# -----------------------------------------------------------------

n = 1e5 # түүврийн хэмжээ
lambda = 1 # тархалтын параметр
h = function (x) { lambda * exp(- lambda * x) } # жигдийн харьцааны аргатай холбогдох функц

system.time({ # давталтын for оператор ашигласан үед
  X = c()
  for (i in 1:n) {
    repeat {
      u = runif(n = 2); x = u[2] / u[1]
      if (u[1] <= sqrt(h(x))) {
        X = c(X, x); break
      }
    }
  }
})

system.time({ # replicate() функц ашигласан үед
  simulation = function() {
    repeat {
      u = runif(n = 2); x = u[2] / u[1]
      if (u[1] <= sqrt(h(x))) return(x)
    }
  }
  X = replicate(n = n, simulation())
})
