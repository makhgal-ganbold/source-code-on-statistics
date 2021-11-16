
# Ашигласан өгөгдлийн эх сурвалж ------------------------------------------

# http://www.opendata.gov.mn/

# Өгөгдөл ачаалах ---------------------------------------------------------

# тоон өгөгдөл ачаалах

employee <- readxl::read_excel(
  path = "employee.xlsx", # файлын нэр
  sheet = 1, # эхний шийтийг уншина
  col_names = FALSE, # хувьсагчийн нэр болгож авах мөр байхгүй
  skip = 2 # эхний 2 мөрийг алгасна
)

View(employee)

# салбарын нэрсийг тусад нь ачаалах

sectors <- readxl::read_excel(
  path = "employee.xlsx", # файлын нэр
  sheet = 1, # эхний шийтийг уншина
  col_names = FALSE, # хувьсагчийн нэр болгож авах мөр байхгүй
  skip = 1, # эхний 1 мөрийг алгасна
  n_max = 1 # зөвхөн 1 мөр уншина
)

# Уг өгөгдөлд 1. аймаг, дүүрэг 2. бүс, нийслэл 3. салбар 4. хүйс гэсэн дөрвөн санамсаргүй хувьсагч байна.

# Өгөгдөл эмхлэх ----------------------------------------------------------

# салбарын нэрс

sectors <- as.vector(t(sectors[1,{1:21}*2+2]))

# Үндсэн мэдээлэл

region <- NULL; province <- NULL; sector <- NULL; gender <- NULL; number <- NULL # шинээр эмхэлж буй өгөгдлийг хадгалах векторууд

for (i in c(2:6,8:13,15:21,23:25,27:35)) { # аймаг, дүүргүүд
  if (i < 7) current_region <- "Баруун бүс" else if (i < 14) current_region <- "Хангайн бүс" else if (i < 22) current_region <- "Төвийн бүс" else if (i < 26) current_region <- "Зүүн бүс" else current_region <- "Улаанбаатар"
  current_province <- employee[[1]][i]
  for (j in 1:length(sectors)) { # салбарууд
    female <- employee[[2*j+2+1]][i]
    male <- employee[[2*j+2]][i] - female
    region <- c(region, current_region, current_region)
    province <- c(province, current_province, current_province)
    sector <- c(sector, sectors[j], sectors[j])
    gender <- c(gender, "female", "male")
    number <- c(number, female, male)
  }
}

tidy_data <- data.frame(region, province, sector, gender, number) # шинээр зохиосон векторуудыг агуулсан, эмхэлсэн өгөгдөл бүхий датафрейм үүсгэх

View(tidy_data) # эмхэлсэн өгөгдлөө харах

write.csv(x = tidy_data, file = "employee_tidy.csv", row.names = FALSE) # Гарсан үр дүнг CSV форматаар экспортлох
