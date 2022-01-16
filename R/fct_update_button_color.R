#' update_button_color
#'
#' @description A function to update a letter box to colors to represent match, wrong spot match, and no match.
#'
#' @return Action: Updates the color of the letter buttons
#'
#' @noRd
update_button_color <- function(rv, id, ns) {
  letter_status <- stringr::str_c(id, "_status")

  if (rv[[letter_status]] == "success") {
    rv[[letter_status]] <- "warning"
  } else if (rv[[letter_status]] == "warning") {
    rv[[letter_status]] <- "default"
  } else {
    rv[[letter_status]] <- "success"
  }

  shinyBS::updateButton(
    session = getDefaultReactiveDomain(),
    inputId = ns(id),
    style = rv[[letter_status]]
  )
}
