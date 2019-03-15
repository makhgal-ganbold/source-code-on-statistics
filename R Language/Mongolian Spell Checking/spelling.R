words <- c("монгол", "хэл", "бичиг", "алдатай")
is.correct <- hunspell::hunspell_check(
  words = words,
  dict = hunspell::dictionary(lang = "mn_MN")
)
print(is.correct)
