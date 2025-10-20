#
# Find duplicate mp3 files that are downloaded from YouTube with yt-dlp.
#

(\(dir, extention_and_suffix){
  files <- dir(dir)
  n_files <- length(files)
  songs <- gsub(pattern = extention_and_suffix, replacement = "", x = files)
  similarity <- NULL
  pb <- utils::txtProgressBar(max = n_files-1, style = 3)
  for (i in 1:{n_files-1}) {
    for (j in {i+1}:n_files) {
      similarity <- rbind(
        similarity, c(
          "song_1" = songs[i],
          "song_2" = songs[j],
          "dist" = stringdist::stringdist(a = songs[i], b = songs[j], method = "lv")
        )
      )
    }
    utils::setTxtProgressBar(pb = pb, value = i)
  }
  close(pb)
  similarity <- as.data.frame(similarity)
  similarity$dist <- as.integer(similarity$dist)
  similarity <- similarity[order(similarity$dist),]
  similarity
})(dir = "Music/Songs", extention_and_suffix = "[ ]\\[[a-zA-Z0-9_-]+\\].mp3$") |>
  View()
