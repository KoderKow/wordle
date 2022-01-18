dashboard_body <- function() {
  bs4Dash::dashboardBody(
    bs4Dash::tabItems(
      bs4Dash::tabItem(
        tabName = "tab_1",
        mod_wordle_row_ui("wordle_row_ui_1"),
        mod_wordle_row_ui("wordle_row_ui_2"),
        mod_wordle_row_ui("wordle_row_ui_3"),
        mod_wordle_row_ui("wordle_row_ui_4"),
        mod_wordle_row_ui("wordle_row_ui_5")
      )
    )
  )
}
