#' reduce_word_bank
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
reduce_word_bank <- function(word_guess, results, r) {
  # 1 = good, 2 = wrong spot, 3 = bad
  word_split <- word_guess %>% stringr::str_split("") %>% unlist()
  word_bank <- r$word_bank

  d <-
    dplyr::tibble(
      index = 1:length(word_split),
      letter = word_split,
      result = results
    ) %>%
    dplyr::mutate(
      regex = dplyr::case_when(
        result == 1 ~ letter,
        result == 2 ~ stringr::str_c("(?=.*", letter, ")"),
        TRUE ~ "."
      )
    )

  for (i in 1:5) {
    if (d$result[i] == 1) {
      right_spot <- rep(".", 5)
      right_spot[i] <- d$letter[i]
      right_spot <- stringr::str_c(right_spot, collapse = "")

      word_bank <-
        word_bank %>%
        stringr::str_subset(right_spot)
    }
  }

  bad_letters <-
    d %>%
    dplyr::filter(result == 3) %>%
    dplyr::pull(letter) %>%
    unique()

  for (i in bad_letters) {
    word_bank <-
      word_bank %>%
      stringr::str_subset(i, negate = TRUE)
  }

  for (i in 1:5) {
    if (d$result[i] == 2) {
      wrong_spot <- rep(".", 5)
      wrong_spot[i] <- d$letter[i]
      wrong_spot <- stringr::str_c(wrong_spot, collapse = "")

      word_bank <-
        word_bank %>%
        stringr::str_subset(wrong_spot, negate = TRUE)

      word_bank <-
        word_bank %>%
        stringr::str_subset(d$letter[i])
    }
  }

  ## Help pick the best word
  words_splits <-
    word_bank %>%
    stringr::str_split("") %>%
    purrr::map(unique) %>%
    purrr::set_names(word_bank)

  dim_scores <-
    words_split %>%
    unlist() %>%
    table() %>%
    sort() %>%
    tibble::enframe(
      name = "letter",
      value = "count"
    ) %>%
    dplyr::mutate(score = dplyr::row_number()) %>%
    dplyr::select(-count)

  d <-
    words_splits %>%
    purrr::map_dfr(
      tibble::enframe,
      value = "letter",
      .id = "word"
    ) %>%
    dplyr::left_join(
      y = dim_scores,
      by = "letter"
    ) %>%
    dplyr::group_by(word) %>%
    dplyr::summarize(
      score = sum(score)
    ) %>%
    dplyr::arrange(dplyr::desc(score))

  gt <-
    d %>%
    gt::gt() %>%
    gt::data_color(
      columns = score,
      colors = scales::col_quantile(
        palette = c("#d600ff", "#bd00ff", "#001eff", "#00b8ff", "#00ff9f"),
        domain = NULL
      )
    ) %>%
    gt::cols_label(
      word = "Word",
      score = "Score"
    )

  return_list <- list(
    possible_words = word_bank,
    gt = gt
  )

  print("~ Done!")

  return(return_list)
}
