
# өгөгдөл ачаалах ---------------------------------------------------------

X <- readxl::read_excel("DT_NSO_2400_028V2_-_2024-12-10_-_www.1212.mn.xlsx", skip = 1)

date <- readxl::read_excel("DT_NSO_2400_028V2_-_2024-12-10_-_www.1212.mn.xlsx", col_names = FALSE, skip = 1, n_max = 1)

# өгөгдөл цэвэрлэх ---------------------------------------------------------

# 2 ширхэг УБ-ын эхнийхийг устгах

X <- X[-34,]

# улсын дүн зэрэг үүсмэл статистикийн утгуудыг зайлуулах

X <- X[!{X[[1]] %in% c("Улсын дүн", "Баруун бүс", "Хангайн бүс", "Төвийн бүс", "Зүүн бүс")},]

# өгөгдөл эмхлэх ------------------------------------------------------------

# огноо

date[[1]] <- NULL
date <- as.vector(t(date[1,]))
date |>
  substr(start = 1, stop = 4) |>
  as.integer() ->
  year
date |>
  substr(start = 6, stop = 7) |>
  as.integer() ->
  month

# хувьсагчид : хот, өдрийн тоо, огноо (он, сар)

df_city <- NULL
df_count <- NULL
df_year <- NULL
df_month <- NULL

# эмхлэх

for (i in 1:nrow(X)) {
  for (j in 2:ncol(X)) {
    if (is.na(X[i,j])) {
      next
    }
    if (X[i,j] == 0) {
      next
    }
    df_city <- c(df_city, X[[1]][i])
    df_year <- c(df_year, year[j-1])
    df_month <- c(df_month, month[j-1])
    df_count <- c(df_count, X[i,j])
  }
}
simplify2array(df_count) |> as.integer() -> df_count
df_city |> as.factor() -> df_city
X <- data.frame("year" = df_year, "month" = df_month, "city" = df_city, "count" = df_count)

rm(list = ls()[ls() != "X"])

print(X)

write.csv(x = X, file = "tidy.csv")

# NSO1212 -----------------------------------------------------------------

X <- NSO1212::get_table(tbl_id = "DT_NSO_2400_028V2")
X <- data.frame(
  "year" = X$Period |> substr(start = 1, stop = 4) |> as.integer(),
  "month" = X$Period |> substr(start = 5, stop = 6) |> as.integer(),
  "city" = X$SCR_MN |> as.factor(),
  "count" = X$DTVAL_CO
)
print(X)

# статистик: хот бүрээрх цасан шуургатай өдрийн дундаж тоо, сараар --------

average <- aggregate(x = count ~ city + month, data = X, FUN = mean)
average <- average[order(average$city, average$month),]

print(average)
