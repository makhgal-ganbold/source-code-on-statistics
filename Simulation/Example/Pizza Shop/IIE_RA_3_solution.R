## --------------------------------------
## IIE/RA 3 - Sally Model’s SM Pizza Shop
## --------------------------------------

rm(list = ls()) # ажлын огторгуйг цэвэрлэх

set.seed(1) # сийдийг бэхлэх

## Үндсэн параметрүүд

the.number.of.person.at.make.table = 3 # <= 3
oven.size = 1 # <= 3
the.number.of.delivery.person = 5

## Шаардагдах тархалтуудыг загварчлах

# Гурвалжин тархалт

rtriangular = function (n, a, c, b) {
  ifelse((u = runif(n)) < (c-a)/(b-a), a + sqrt((b-a)*(c-a)*u), b - sqrt((b-a)*(b-c)*(1-u)))
}

# hist(rtriangular(n = 500, a = 0.5, c = 0.7, b = 0.8)) # rtriangular() функцийг шалгах

## Захиалга орж ирэх хугацааны эгшинг загварчлах

simulate.demands = function () {

  demands.per.minute = splinefun( # smoothing
    x = (time = c(0,45,90,135,180)),
    y = (demands = c(20,40,60,40,20) / 60)
  )

  # plot(0:180, demands.per.minute(0:180)) # demands.per.minute() функцийг шалгах

  time = 0
  demands.time = c()
  repeat {
    time.between.demands = rexp(n = 1, rate = demands.per.minute(time))
    time = time + time.between.demands
    if (time > 180) {
      break
    }
    demands.time = c(demands.time, time)
  }
  return(demands.time)

}

demands = simulate.demands()

print(demands)

rm(simulate.demands) # хэрэгцээгүй обьектийг устгах

# ls() # обьектүүдийн жагсаалт

## Захиалгын зарим мэдээлэл: пиццаны тоо ба хэмжээ, захиалгын төрөл (delivery эсвэл carry-out), хүргэлтийн хугацаа

simulate.count.and.size = function (demands = c()) {

  # нэг захиалга дахь пиццаны тоо ба хэмжээний тархалт

  prob.dist.the.number.of.pizza = cumsum(c(64,31,5))/100
  prob.dist.size.of.pizza = cumsum(c(32,56,12))/100

  # пиццаны тоог хэмжээ тус бүрээр ялгаж хадгалах обьектүүд

  large <- medium <- small <- type <- c()

  # нэг захиалга дахь пиццаны тоо ба хэмжээг загварчлах хэсэг

  for (demand in demands) {
    the.number.of.pizza = which.max(prob.dist.the.number.of.pizza > runif(1)) # нэг захиалга дахь пиццаны тоо
    l <- m <- s <- 0
    i = 0
    while (i < the.number.of.pizza) { # пицца нэг бүрийн хэмжээг загварчлах хэсэг
      i = i + 1
      switch(which.max(prob.dist.size.of.pizza > runif(1)), # пиццаны хэмжээ
        (l = l + 1), (m = m + 1), (s = s + 1)
      )
    }
    large = c(large, l); medium = c(medium, m); small = c(small, s) # нэг захиалга дахь том, дунд ба жижиг пиццаны тоо
  }

  # захиалгын төрөл ба хүргэлтийн хугацаа

  type = factor(x = ifelse(runif(n = length(demands)) > 0.4, 1, 2), levels = c(1, 2), labels = c("delivery", "carry-out"), ordered = FALSE)

  delivery.duration = ifelse(as.numeric(type) == 1, rtriangular(n = 1, a = 3, c = 5, b = 12), 0)

  # нийт захиалга: цаг, хэмжээ, тоо, захиалгын төрөл, хүргэлтийн хугацаа

  return(data.frame(time = demands, large, medium, small, type, delivery.duration))

}

demands = simulate.count.and.size(demands)

rm(simulate.count.and.size) # хэрэгцээгүй обьектийг устгах

# ls() # обьектүүдийн жагсаалт

print(demands)

## Пиццаны зарим мэдээлэл

simulate.pizza.making = function (demands = data.frame()) {

  demand.id <- size <-
    task_1 <- # Dough and saucing
    task_2 <- # Primary ingredients
    task_3 <- # Final ingredients
    c()

  for (i in as.numeric(row.names(demands))) {
    demand = demands[i,]
    demand.id = c(demand.id, rep(i, times = sum(c(demand[["large"]], demand[["medium"]], demand[["small"]]))))
    if ((n = demand[["large"]]) > 0) {
      size = c(size, rep(3, times = n))
      task_1 = c(task_1, rtriangular(n = n, 0.5, 0.7, 0.8))
      task_2 = c(task_2, rtriangular(n = n, 0.6, 0.8, 1.0))
      task_3 = c(task_3, rtriangular(n = n, 0.5, 0.6, 0.7))
    }
    if ((n = demand[["medium"]]) > 0) {
      size = c(size, rep(2, times = n))
      task_1 = c(task_1, rtriangular(n = n, 0.5, 0.7, 0.8))
      task_2 = c(task_2, rtriangular(n = n, 0.6, 0.8, 1.0))
      task_3 = c(task_3, rtriangular(n = n, 0.5, 0.6, 0.7))
    }
    if ((n = demand[["small"]]) > 0) {
      size = c(size, rep(1, times = n))
      task_1 = c(task_1, rtriangular(n = n, 0.5, 0.7, 0.8))
      task_2 = c(task_2, rtriangular(n = n, 0.6, 0.8, 1.0))
      task_3 = c(task_3, rtriangular(n = n, 0.5, 0.6, 0.7))
    }
  }

  return(data.frame (
    demand.id, # demand id on object "demands"
    size = factor(x = size, levels = c(3,2,1), labels = c("large", "medium", "small"), ordered = TRUE),
    task_1, task_2, task_3
  ))

}

pizzas = simulate.pizza.making(demands)

rm(simulate.pizza.making) # хэрэгцээгүй обьектийг устгах

# ls() # обьектүүдийн жагсаалт

print(pizzas)

## Пиццаг бэлдэх ажлыг загварчлах

pizza.making.one.person = function () {

  made.time = rep(NA, times = nrow(pizzas))
  for (i in as.numeric(row.names(pizzas))) {
    if (i == 1) {
      made.time[i] = demands[["time"]][pizzas[["demand.id"]][i]] + # захиалга орж ирсэн эгшин
        sum(pizzas[i,3:5]) # пиццаг бэлдэх нийт хугацаа
    } else {
      made.time[i] = 
        max(
          made.time[i-1], # өмнөх пиццаг бэлдэж дуусгасан эгшин
          demands[["time"]][pizzas[["demand.id"]][i]] # захиалга орж ирсэн эгшин
        ) +
        sum(pizzas[i,3:5]) # пиццаг бэлдэх нийт хугацаа
    }
  }
  pizzas$made.time = made.time
  return(pizzas)

}

pizza.making.two.person = function () { ## нэг хүн нэг пиццаг дагнан хийх

  pizza.makers.free.time = c(0, 0) # пицца хийгчдийн чөлөөтэй болсон байх хугацааны эгшин, 2 хүн ажиллана
  made.time = rep(NA, times = nrow(pizzas))
  for (i in as.numeric(row.names(pizzas))) {
    time = demands[["time"]][pizzas[["demand.id"]][i]] # захиалга орж ирсэн эгшин
    pizza.making.started = FALSE # пиццаг хийж эхэлсэн эсэхийг заах хувьсагч
    while (!pizza.making.started) { # time эгшинд пицца хийгдэж эхлэхтэй холбогдох тооцоо
      free.mans = which(pizza.makers.free.time <= time) # time эгшинд чөлөөлөгдсөн (чөлөөлөгдөж байх) ажилчид
      if (length(free.mans) > 0) {
        pizza.makers.free.time = pizza.makers.free.time[-free.mans[1]] # чөлөөтэй ажилчдын нэгэнд ажил оногдоно
        made.time[i] = time + # пиццаг хийж эхлэх эгшин
          sum(pizzas[i,3:5]) # пиццаг бэлдэх нийт хугацаа: task_1, task_2 ба task_3
        pizza.makers.free.time = c(pizza.makers.free.time, made.time[i]) # тухайн ажилчны эргэн чөлөөлөгдөх эгшин
        pizza.making.started = TRUE
      } else {
        time = sort(pizza.makers.free.time)[1] # хамгийн түрүүнд чөлөөлөгдөх ажилчны чөлөөлөгдөх эгшин
      }
    }
  }
  pizzas$made.time = made.time
  return(pizzas)

}

pizza.making.three.person = function () {

  made.time <- task_1.start <- task_1.end <- task_2.start <- task_2.end <- task_3.start <- rep(NA, times = nrow(pizzas))
  for (i in as.numeric(row.names(pizzas))) {
    if (i == 1) {
      task_1.start[i] = demands[["time"]][pizzas[["demand.id"]][i]]
      task_2.start[i] = (task_1.end[i] = task_1.start[i] + pizzas[["task_1"]][i])
      task_3.start[i] = (task_2.end[i] = task_2.start[i] + pizzas[["task_2"]][i])
      made.time[i] = task_3.start[i] + pizzas[["task_3"]][i]
    } else if (i == 2) {
      task_1.end[i] = (task_1.start[i] = max(demands[["time"]][pizzas[["demand.id"]][i]], task_1.end[i-1])) + pizzas[["task_1"]][i]
      task_2.end[i] = (task_2.start[i] = max(task_1.end[i], task_2.end[i-1])) + pizzas[["task_2"]][i]
      made.time[i] = (task_3.start[i] = max(task_2.end[i], made.time[i-1])) + pizzas[["task_3"]][i]
    } else {
      task_1.end[i] = (task_1.start[i] = max(demands[["time"]][pizzas[["demand.id"]][i]], task_1.end[i-1], task_2.end[i-2])) + pizzas[["task_1"]][i]
      task_2.end[i] = (task_2.start[i] = max(task_1.end[i], task_2.end[i-1], made.time[i-2])) + pizzas[["task_2"]][i]
      made.time[i] = (task_3.start[i] = max(task_2.end[i], made.time[i-1])) + pizzas[["task_3"]][i]
    }
  }
  pizzas$task_1.start = task_1.start; pizzas$task_1.end = task_1.end
  pizzas$task_2.start = task_2.start; pizzas$task_2.end = task_2.end
  pizzas$task_3.start = task_3.start; pizzas$made.time = made.time
  return(pizzas)

}

pizzas = switch(the.number.of.person.at.make.table,
  pizza.making.one.person(),
  pizza.making.two.person(),
  pizza.making.three.person()
)

rm(pizza.making.one.person, pizza.making.three.person)

print(pizzas)

ls()

## Зуухны хэсгийг загварчлах

oven = function () {

  oven.load.area.size = switch(oven.size, 435, 520, 605) # зуухны талбай

  pizzas$size.as.square.inches <<- apply(as.matrix(as.numeric(pizzas[["size"]])), 1, switch, 115, 175, 250) # пиццаны хэмжээг талбайн хэмжээнд шилжүүлэх

  load.time = rep(NA, times = nrow(pizzas))
  oven.load.area.status = list(
    current.availeble.size = oven.load.area.size, # үлдэгдэл сул зай
    size.will.be.free = list( # чөлөөлөгдөх зайн мэдээлэл
      size = c(), # зайн хэмжээ
      time = c()  # хугацааны эгшин, оруулах хэсгийг чөлөөлөх буюу зууханд шилжих
    )
  )
  for (i in as.numeric(row.names(pizzas))) {
    time = pizzas[["made.time"]][i] # бэлтгэгчийн ширээнээс пицца ирэх үеийн хугацааны эгшин
    pizza.loaded = FALSE # пицца зуухны оруулах хэсэгт шилжсэн эсэхийг заах хувьсагч
    while (!pizza.loaded) { # заагдсан эгшинд пицца зуухны оруулах хэсэгт шилжихтэй холбогдох тооцоо
      # time эгшинд чөлөөлөгдсөн (чөлөөлөгдөж байх) байх зайн хэмжээ
      indices = which(oven.load.area.status$size.will.be.free$time <= time) # чөлөөлөгдөх зай, индексүүд
      if (length(indices) > 0) {
        oven.load.area.status[["current.availeble.size"]] = oven.load.area.status[["current.availeble.size"]] + sum(oven.load.area.status$size.will.be.free$size[indices]) # + чөлөөлөгдөх нийт зайн хэмжээ
        # чөлөөлөгдсөн зайн мэдээллийг устгах
        oven.load.area.status$size.will.be.free$size = oven.load.area.status$size.will.be.free$size[-indices]
        oven.load.area.status$size.will.be.free$time = oven.load.area.status$size.will.be.free$time[-indices]
      }
      # пицца оруулах хэсэгт нэвтрэх ба хүлээгдэх байдлын тооцоо
      if (oven.load.area.status$current.availeble.size >= pizzas[["size.as.square.inches"]][i]) { # пицца оруулах хэсэгт багтана
        oven.load.area.status$current.availeble.size = oven.load.area.status$current.availeble.size - pizzas[["size.as.square.inches"]][i]
        oven.load.area.status$size.will.be.free$size = c(oven.load.area.status$size.will.be.free$size, pizzas[["size.as.square.inches"]][i])
        oven.load.area.status$size.will.be.free$time = c(oven.load.area.status$size.will.be.free$time, time + 1.9) # хугацааны тухайн эгшин + зуухны оруулах хэсэгт өнгөрүүлэх хугацаа
        load.time[i] = time
        pizza.loaded = TRUE # пицца оруулах хэсэгт шилжсэн
      } else { # пицца багтаагүй, хүлээгдэнэ
        # пицца оруулах хэсгийг орхих буюу зай чөлөөлөгдөх хамгийн ойрын эгшинг тодорхойлох
        time = oven.load.area.status$size.will.be.free$time[1]
      }
    }
  }

  pizzas$baked.time <<- (pizzas$from.load.to.bake.time <<- (pizzas$load.time <<- load.time) + 1.9) + 7.5

}

oven()

rm(oven)

print(pizzas)

## Хэрчиж савлах, захиалгыг гаргах хэсгийг загварчлах

# Дараах хэдэн мөрийг ажиллуулахын тулд # тэмдэгтийг арилгана уу
# data = scan(file = "IIE_SM_3.dat") # Захиалгыг багцалж бэлдэхэд зарцуулагдах хугацаа гэж үзэв. Жич: Захиалгын хэмжээтэй хамааралгүйгээр өгчээ. Мөн файлын замыг анхаар!
# hist(data) # тайлбар дээр "алдаатай" гэсэн нь хоёр тархалтын холимог маягаар илэрч буй бололтой
# data = data[which(data < 6)]
# hist(data) # тархалтыг  a = 1, c = 3, b = 6 параметрүүдтэй гурвалжин тархалт гэж үзье
# rm(data)

cut.and.box = function () {

  cut.and.box = rep(NA, times = nrow(demands))
  for (i in as.numeric(row.names(demands))) {
    cut.and.box[i] = max(pizzas[["baked.time"]][which(pizzas[["demand.id"]] == i)]) + rtriangular(n = 1, a = 1, c = 3, b = 6)
  }
  demands$cut.and.box <<- cut.and.box

}

cut.and.box()

rm(cut.and.box)

print(demands)

## Хүргэлтийн хэсгийг загварчлах

delivery = function () {

  delivery.person.back_time = rep(0, times = the.number.of.delivery.person) # хугацааны эхэнд бүх хүргэгч бэлэн байгаа
  delivery.time = rep(NA, times = nrow(demands))
  for (i in as.numeric(row.names(demands))) {
    if (as.numeric(demands[["type"]][i]) == 1) { # delivery
      delivery.person.back_time = sort(delivery.person.back_time) # бэлэн эсвэл хамгийн түрүүнд эргэж ирэх хүргэгч
      delivery.time[i] = max(demands[["cut.and.box"]][i], delivery.person.back_time[1]) + demands[["delivery.duration"]][i]
      delivery.person.back_time[1] = delivery.time[i] + demands[["delivery.duration"]][i] # хүргэгчийн эргэж ирэх хугацаа
    } else { # carry-out
      delivery.time[i] = demands[["cut.and.box"]][i]
    }
  }
  demands$delivery.time <<- delivery.time

}

delivery()

rm(delivery)

print(demands)

## Захиалгыг гүйцэтгэхэд зарцуулсан нийт хугацаа ба түүний зарим статистик үзүүлэлтүүд

demands$elapsed.time = demands[["delivery.time"]] - demands[["time"]]

print(demands)

tapply(demands[["elapsed.time"]], demands[["type"]], mean)
tapply(demands[["elapsed.time"]], demands[["type"]], sd)
tapply(demands[["elapsed.time"]], demands[["type"]], fivenum) # minimum, lower-hinge, median, upper-hinge, maximum
boxplot(formula = elapsed.time ~ type, data = demands)
