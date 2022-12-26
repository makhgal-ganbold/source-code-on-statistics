
"https://cran.r-project.org/web/packages/available_packages_by_date.html" |>
  rvest::read_html() |>
  rvest::html_node("table") |>
  rvest::html_table() |>
  transform(Date = as.Date(Date)) |>
  transform(Year = format(Date, format = "%Y")) |>
  subset(select = Year) |>
  table() -> pkgs

print(pkgs)

plot(x = names(pkgs), y = as.vector(pkgs), type = "h", xlab = "Year", ylab = "The number of packages", main = "The number of published CRAN packages per year")
