
# -------------------------------------------------------------------------
# 2021 оны мэдээлэл
# -------------------------------------------------------------------------

# Нэр импортлох -----------------------------------------------------------

bikers <- readxl::read_excel(
  path = "UUDAG-2016-2021.xlsx",
  sheet = "2021", range = "B6:B303",
  col_names = FALSE
)
bikers <- bikers[[1]]

any(duplicated(bikers))
which(duplicated(bikers))
bikers[169] <- paste0(bikers[169], '_', 2018)
bikers[258] <- paste0(bikers[258], '_', 2021)
bikers[272] <- paste0(bikers[272], '_', 2021)

# write.csv(x = as.data.frame(bikers), file = "bikers_2021.csv", row.names = FALSE)
# Үүний дараа тус өгөгдөлд "id" гэсэн багана нэмэв.
# Тус баганын утгуудыг өөр эх сурвалжаас олсон тул write.csv() функцийг ахин ажиллуулах хэрэггүй.
# Харин цааш үргэлжлүүлэхдээ дараах мөрд буй read.csv() функцийг ажиллуулж тийнхүү өөрчилсөн өгөгдлийг ачаална.

bikers <- read.csv(file = "bikers_2021.csv")
user_ids <- bikers$id
bikers <- bikers$bikers

# Аяллын мэдээлэл ---------------------------------------------------------

rides <- readxl::read_excel(
  path = "UUDAG-2016-2021.xlsx",
  sheet = "2021", range = "H3:AG5",
  col_names = FALSE
)

rides <- t(rides)

rides <- as.data.frame(rides)
rides <- rides[3:1]
colnames(rides) <- c("date", "ride_title", "distance")
rownames(rides) <- NULL

anyNA(rides[-2])
any(duplicated(rides$date))

# write.csv(x = rides, file = "rides_2021.csv", row.names = FALSE)
# Үүний дараа тус өгөгдөлд "ride_id" гэсэн багана нэмэв.
# Тус баганын утгуудыг өөр эх сурвалжаас олсон тул write.csv() функцийг ахин ажиллуулах хэрэггүй.
# Харин цааш үргэлжлүүлэхдээ дараах мөрд буй read.csv() функцийг ажиллуулж тийнхүү өөрчилсөн өгөгдлийг ачаална.

rides <- read.csv(file = "rides_2021.csv")

ride_ids <- rides$ride_id

# Жийлтийн мэдээлэл -------------------------------------------------------

participation <- readxl::read_excel(
  path = "UUDAG-2016-2021.xlsx",
  sheet = "2021", range = "H6:AG303",
  col_names = FALSE
)

participation <- t(participation)
participation <- as.data.frame(participation)
colnames(participation) <- paste0("ID_", user_ids)
rownames(participation) <- NULL
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

write.csv(x = ride_user, file = "ride_user_2021.csv", row.names = FALSE)
