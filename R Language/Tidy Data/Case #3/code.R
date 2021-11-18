
# Ашигласан өгөгдлийн эх сурвалж ------------------------------------------

# https://foresightbi.com.ng/microsoft-power-bi/dirty-data-samples-to-practice-on/

# "badly-structured-sales-data.xlsx" файл дахь өгөгдөлд 1. Order Date 2. Segment 3. Ship Mode 4. Amount (энэ нэрийг зохиов) гэсэн дөрвөн санамсаргүй хувьсагч байна.
# Мөн тус өгөгдлийг Order Date хувьсагчаар гэх мэтчилэн эрэмбэлвэл зохимжтой юм.

# Өгөгдөл ачаалах ---------------------------------------------------------

# үндсэн өгөгдөл ачаалах

sales <- readxl::read_excel(
  path = "badly-structured-sales-data.xlsx", # файлын нэр
  sheet = 1, # эхний шийтийг уншина
  col_names = FALSE, # хувьсагчийн нэр болгож авах мөр байхгүй
  skip = 3 # эхний 2 мөрийг алгасна
)

View(sales)

# Өгөгдлийн бүтэц зохион байгуулалт ---------------------------------------

order_date <- NULL; segment <- NULL; ship_mode <- NULL; amount <- NULL # шинээр эмхэлж буй өгөгдлийг хадгалах векторууд

for (i in 1:nrow(sales)) { # Order Date дагуу гүйх давталт
  current_order_date <- sales[[1]][i]
  for (j in 2:13) { # тоон өгөгдөл бүхий багануудаар гүйх давталт
    current_amount <- sales[[j]][i]
    if (is.na(current_amount))
      next
    amount <- c(amount, current_amount)
    order_date <- c(order_date, current_order_date)
    if (j %in% c(2,5,8,11)) current_segment <- "consumer" else if (j %in% c(3,6,9,12)) current_segment <- "corporate" else current_segment <- "home/office"
    segment <- c(segment, current_segment)
    if (j <= 4) current_ship_mode <- "first class" else if (j <= 7) current_ship_mode <- "same day" else if (j <= 10) current_ship_mode <- "second class" else current_ship_mode <- "standard class"
    ship_mode <- c(ship_mode, current_ship_mode)
  }
}

# Хувьсагчийн төрөл хувиргалт ---------------------------------------------

# UNIX Timestamp хэлбэрт орсон огноог буцаан хувиргах
order_date <- as.Date(as.POSIXct(order_date, origin = "1970-01-01"))

# чанарын хувьсагчдыг фактор төрөл уруу хувиргах
segment <- factor(x = segment, levels = c("home/office", "corporate", "consumer"), ordered = TRUE)
ship_mode <- factor(x = ship_mode, levels = c("standard class", "second class", "same day", "first class"), ordered = TRUE)

# Хүснэгтлэх буюу датафрейм болгох ----------------------------------------

tidy_data <- data.frame(order_date, segment, ship_mode, amount) # шинээр зохиосон векторуудыг агуулсан, эмхэлсэн өгөгдөл бүхий датафрейм үүсгэх

# Өгөгдөл эрэмбэлэх -------------------------------------------------------

tidy_data <- tidy_data[order(tidy_data$order_date, segment, ship_mode),] # өгөгдөл эрэмбэлэх

View(tidy_data) # эмхэлсэн өгөгдлөө харах

# Файлд хадгалах ----------------------------------------------------------

write.csv(x = tidy_data, file = "tidy-sales-data.csv", row.names = FALSE) # Гарсан үр дүнг CSV форматаар экспортлох

saveRDS(object = tidy_data, file = "tidy-sales-data.Rds") # R програмын форматаар хадгалах
