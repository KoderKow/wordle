dashboard_page <- function() {
  bs4Dash::dashboardPage(
    header = dashboard_header(),
    sidebar = dashboard_sidebar(),
    body = dashboard_body()
  )
}
