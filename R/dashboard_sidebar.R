dashboard_sidebar <- function() {
  bs4Dash::dashboardSidebar(
    skin = "light",
    inputId = "sidebarState",
    # collapsed = TRUE,
    # disable = TRUE,
    elevation = 1,
    bs4Dash::sidebarMenu(
      id = "sidebar",
      bs4Dash::menuItem(
        tabName = "tab_1",
        text = "Wordle Helper",
        icon = icon("file-word")
      ),
      tags$br(),
      tags$a(
        href = "https://github.com/KoderKow/wordle",
        target = "_blank",
        icon("github", "fa-2x")
      )
    )
  )
}
