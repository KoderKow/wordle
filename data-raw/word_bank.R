## code to prepare `word_bank` dataset goes here
word_bank <-
  words::words %>%
  dplyr::filter(word_length == 5) %>%
  dplyr::pull(word)

usethis::use_data(word_bank, overwrite = TRUE)
