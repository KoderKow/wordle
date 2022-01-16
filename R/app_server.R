#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Reactive Values ----
  r <- reactiveValues(
    word_bank = word_bank
  )

  # Modules ----
  mod_wordle_row_server("wordle_row_ui_1", r)
  mod_wordle_row_server("wordle_row_ui_2", r)
  mod_wordle_row_server("wordle_row_ui_3", r)
  mod_wordle_row_server("wordle_row_ui_4", r)
  mod_wordle_row_server("wordle_row_ui_5", r)
}


