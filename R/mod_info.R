#' info UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_info_ui <- function(id){
  ns <- NS(id)
  tagList(
    tags$h1("Info"),
    tags$p("The goal of this project was an exercise to programmatically help solve daily wordle puzzles. I initially started building an algorithm to help solve the puzzle as quickly as possible. To make the algorithm easy to use and not boot up R everytime, I implemented my workflow into this shiny app. This was a fun app to code up!"),
    tags$h1("Links"),
    tags$ul(
      tags$li(tags$a(href = "https://github.com/KoderKow/wordle", "Github"))
    )
  )
}

#' info Server Functions
#'
#' @noRd
mod_info_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_info_ui("info_ui_1")

## To be copied in the server
# mod_info_server("info_ui_1")
