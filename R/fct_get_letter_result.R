#' get_letter_result
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
get_letter_result <- function (letter_status) {
  # print(letter_status)
  if (letter_status == "success") {
    result <- 1
  } else if (letter_status == "warning") {
    result <- 2
  } else {
    result <- 3
  }

  return(result)
}
