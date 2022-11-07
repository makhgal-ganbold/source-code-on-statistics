
# -------------------------------------------------------------------------
# 2016 оны мэдээлэл
# -------------------------------------------------------------------------

# Нэр импортлох -----------------------------------------------------------

bikers <- readxl::read_excel(
  path = "UUDAG-2016-2021.xlsx",
  sheet = "2016", range = "G2:BF2",
  col_names = FALSE
)
bikers <- t(bikers)[,1]
bikers <- as.vector(bikers)

any(duplicated(bikers))

# write.csv(x = as.data.frame(bikers), file = "bikers_2016.csv", row.names = FALSE)
# Үүний дараа тус өгөгдөлд "id" гэсэн багана нэмэв.
# Тус баганын утгуудыг өөр эх сурвалжаас олсон тул write.csv() функцийг ахин ажиллуулах хэрэггүй.
# Харин цааш үргэлжлүүлэхдээ дараах мөрд буй read.csv() функцийг ажиллуулж тийнхүү өөрчилсөн өгөгдлийг ачаална.

bikers <- read.csv(file = "bikers_2016.csv")
user_ids <- bikers$id
bikers <- bikers$bikers

# Аяллын мэдээлэл ---------------------------------------------------------

rides <- readxl::read_excel(
  path = "UUDAG-2016-2021.xlsx",
  sheet = "2016",
  col_names = FALSE,
  skip = 2, n_max = 27
)

rides <- rides[,c(3,5)]
rides <- as.data.frame(rides)
colnames(rides) <- c("date", "distance")

anyNA(rides$date)
any(duplicated(rides$date))

anyNA(rides$distance)
which(is.na(rides$distance)) # == 22

rides$date[22]
rides$distance[22] <- 0

# rides$date <- as.POSIXct(paste(2016, rides$date), tz = "Asia/Ulaanbaatar", format = "%Y %m сар %d")

# write.csv(x = rides, file = "rides_2016.csv", row.names = FALSE)
# Үүний дараа тус өгөгдөлд "ride_id" гэсэн багана нэмэв.
# Тус баганын утгуудыг өөр эх сурвалжаас олсон тул write.csv() функцийг ахин ажиллуулах хэрэггүй.
# Харин цааш үргэлжлүүлэхдээ дараах мөрд буй read.csv() функцийг ажиллуулж тийнхүү өөрчилсөн өгөгдлийг ачаална.

rides <- read.csv(file = "rides_2016.csv")
ride_ids <- rides$ride_id

# Жийлтийн мэдээлэл -------------------------------------------------------

participation <- readxl::read_excel(
  path = "UUDAG-2016-2021.xlsx",
  sheet = "2016", range = "G3:BF29",
  col_names = FALSE
)

colnames(participation) <- paste0("ID_", user_ids)
participation <- round(x = participation / rides$distance, digits = 2)

# Өргөн бүтэцтэй өгөгдөл үүсгэх -------------------------------------------

wide <- cbind("ride_id" = ride_ids, participation)

# Өргөн бүтцээс урт бүтэц руу хувиргах ------------------------------------

long <- reshape2::melt(
  data = wide,
  id.vars = "ride_id",
  measure.vars = paste0("ID_", user_ids),
  variable.name = "biker_id",
  value.name = "participation"
)

# NaN утгуудыг 1 болгох ---------------------------------------------------

long$participation[is.nan(long$participation)] <- 1

# "Хоосон утга" (NA) зайлуулах --------------------------------------------

long <- long[complete.cases(long),]

# Гишүүдийн ID ------------------------------------------------------------

long$biker_id <- as.integer(substr(x = long$biker_id, start = 4, stop = 15))

# Эцсийн хэлбэр -----------------------------------------------------------

ride_user <- data.frame(
  ride_id = long$ride_id,
  user_id = long$biker_id,
  started = 1,
  finished = long$participation
)

rm(list = ls()[!{ls() %in% "ride_user"}])

write.csv(x = ride_user, file = "ride_user_2016.csv", row.names = FALSE)
