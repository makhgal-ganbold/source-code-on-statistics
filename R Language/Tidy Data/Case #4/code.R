
# Ашигласан өгөгдлийн эх сурвалж ------------------------------------------

# https://1212.mn/

# "1212.xlsx" файл дахь өгөгдөлд 1. засаг захиргааны нэгжийн нэр 2. нэгжийн шатлал 3. он 4. хүн амын тоо гэсэн дөрвөн санамсаргүй хувьсагч байна.

# Өгөгдөл ачаалах ---------------------------------------------------------

messy <- readxl::read_excel(
  path = "1212.xlsx",
  trim_ws = FALSE # нүдний эхлэл дэх сул зайг арилгахгүй байх (үүнийг засаг захиргааны нэгжийн түвшнийг ялгахад ашиглана)
)

View(messy)

# Өгөгдөл цэвэрлэх --------------------------------------------------------

# дэс дугаар бүхий эхний баганыг устгах
messy$sort_no <- NULL

# Өгөгдлийн бүтэц зохион байгуулалт ---------------------------------------

# шинээр эмхэлж буй өгөгдлийг хадгалах векторууд
administration_unit_mn <- administration_unit_en <- NULL
administration_unit_level_mn <- administration_unit_level_en <- NULL
gender_mn <- gender_en <- NULL
year <- NULL
population <- NULL

# оныг урьдчилж бэлдэх
years <- as.numeric(substr(x = colnames(messy)[-{1:4}], start = 3, stop = 6))

# баг болон сумын харьяалагдах нэгжийн нэр
aimag_mn <- aimag_en <- sum_mn <- sum_en <- ""

n <- 0 # түүврийн хэмжээг илэрхийлэх хувьсагч
for (i in 1:nrow(messy)) { # мөрийн дагуу гүйх давталт
  current_administration_unit_mn <- trimws(messy$obj1_name[i])
  current_administration_unit_en <- trimws(messy$obj1_name_eng[i])
  if (substr(x = messy$obj1_name_eng[i], start = 12, stop = 12) == " ") { # багийн нэрийн өмнөх 12 тэмдэгт "хоосон"
    current_administration_unit_level_mn <- paste0(sum_mn, " ", current_administration_unit_mn)
    current_administration_unit_level_en <- paste0(sum_en, " ", current_administration_unit_en)
  } else if (substr(x = messy$obj1_name_eng[i], start = 9, stop = 9) == " ") { # сумын нэрийн өмнөх 9 тэмдэгт "хоосон"
    sum_mn <- current_administration_unit_level_mn <- paste0(aimag_mn, " аймаг ", current_administration_unit_mn, " сум")
    sum_en <- current_administration_unit_level_en <- paste0(aimag_en, " province ", current_administration_unit_en, " sum")
  } else if (substr(x = messy$obj1_name_eng[i], start = 6, stop = 6) == " ") { # аймгийн нэрийн өмнөх 6 тэмдэгт "хоосон"
    aimag_mn <- current_administration_unit_level_mn <- current_administration_unit_mn
    aimag_en <- current_administration_unit_level_en <- current_administration_unit_en
  } else if (substr(x = messy$obj1_name_eng[i], start = 3, stop = 3) == " ") { # бүсийн нэрийн өмнөх 3 тэмдэгт "хоосон"
    current_administration_unit_level_mn <- current_administration_unit_mn
    current_administration_unit_level_en <- current_administration_unit_en
  } else {
    current_administration_unit_level_mn <- current_administration_unit_mn
    current_administration_unit_level_en <- current_administration_unit_en
  }
  current_gender_mn <- messy$obj2_name[i]
  current_gender_en <- messy$obj2_name_eng[i]
  for (j in 5:ncol(messy)) { # багана буюу оны дагуу гүйх давталт
    current_population <- messy[[i,j]]
    if (is.na(current_population)) { # орхигдсон утгуудыг алгасах
      next
    }
    n <- n + 1
    administration_unit_mn[n] <- current_administration_unit_mn
    administration_unit_en[n] <- current_administration_unit_en
    administration_unit_level_mn[n] <- current_administration_unit_level_mn
    administration_unit_level_en[n] <- current_administration_unit_level_en
    gender_mn[n] <- current_gender_mn
    gender_en[n] <- current_gender_en
    year[n] <- years[j-4]
    population[n] <- current_population
  }
}

# Хүснэгтлэх буюу датафрейм болгох ----------------------------------------

tidy <- data.frame(administration_unit_mn, administration_unit_en, administration_unit_level_mn, administration_unit_level_en, gender_mn, gender_en, year, population, stringsAsFactors = FALSE) # шинээр зохиосон векторуудыг агуулсан, эмхэлсэн өгөгдөл бүхий датафрейм үүсгэх

# хэрэггүй хувьсагчдыг устгах
rm(n, i, j, current_administration_unit_mn, administration_unit_mn, current_administration_unit_en, administration_unit_en, current_administration_unit_level, current_administration_unit_level_mn, administration_unit_level_mn, current_administration_unit_level_en, administration_unit_level_en, current_gender_mn, gender_mn, current_gender_en, gender_en, years, year, current_population, population,aimag_mn, aimag_en, sum_mn, sum_en)

# нүдний эхлэл дэх хоосон зайг устгах
tidy$administration_unit_mn <- trimws(tidy$administration_unit_mn)
tidy$administration_unit_en <- trimws(tidy$administration_unit_en)
tidy$gender_mn <- trimws(tidy$gender_mn)
tidy$gender_en <- trimws(tidy$gender_en)

# бусад нэмэлт ажлууд
tidy$administration_unit_level_mn[tidy$administration_unit_en == "Total"] <- "Улс"
tidy$administration_unit_level_en[tidy$administration_unit_en == "Total"] <- "State"
tidy$administration_unit_mn[tidy$administration_unit_en == "Total"] <- "Улс"
tidy$administration_unit_en[tidy$administration_unit_en == "Total"] <- "State"
tidy$gender_mn[tidy$gender_en == "Total"] <- "Нийт"

# эмхэлсэн өгөгдлөө харах
View(tidy)

# Файлд хадгалах ----------------------------------------------------------

write.csv(x = tidy, file = "1212_tidy.csv", row.names = FALSE) # Гарсан үр дүнг CSV форматаар экспортлох

saveRDS(object = tidy, file = "1212_tidy.Rds") # R програмын форматаар хадгалах
