#' wordle_row UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_wordle_row_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      class = "wordle_row",
      col_6(
        fluidRow(
          align = "center",
          textInput(
            inputId = ns("word"),
            label = "Guess a word!"
          )
        ),
        fluidRow(
          align = "center",
          shinyBS::bsButton(
            inputId = ns("letter_1"),
            label = "",
            class = "tile"
          ),
          shinyBS::bsButton(
            inputId = ns("letter_2"),
            label = "",
            class = "tile"
          ),
          shinyBS::bsButton(
            inputId = ns("letter_3"),
            label = "",
            class = "tile"
          ),
          shinyBS::bsButton(
            inputId = ns("letter_4"),
            label = "",
            class = "tile"
          ),
          shinyBS::bsButton(
            inputId = ns("letter_5"),
            label = "",
            class = "tile"
          )
        ),
        fluidRow(
          align = "center",
          col_12(
            shinyBS::bsButton(
              inputId = ns("submit_results"),
              label = "Submit Results",
              disabled = TRUE
            )
          )
        )
      ),
      col_3(
        tags$div(
          class = "possible_words",
          gt::gt_output(
            outputId = ns("possible_words")
          )
        )
      )
    )
  )
}

#' wordle_row Server Functions
#'
#' @noRd
mod_wordle_row_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    rv <- reactiveValues(
      word_bank = word_bank,
      letter_1_status = "default",
      letter_2_status = "default",
      letter_3_status = "default",
      letter_4_status = "default",
      letter_5_status = "default"
    )

    observeEvent(
      eventExpr = input$word,
      handlerExpr = {
        word_split <- strsplit(
          x = input$word,
          split = ""
        ) |>
          unlist()

        if (is.null(word_split[1]) || is.na(word_split[1])) {
          rv$letter_1 <- ""
        } else {
          rv$letter_1 <- word_split[1]
        }

        if (is.null(word_split[2]) || is.na(word_split[2])) {
          rv$letter_2 <- ""
        } else {
          rv$letter_2 <- word_split[2]
        }
        if (is.null(word_split[3]) || is.na(word_split[3])) {
          rv$letter_3 <- ""
        } else {
          rv$letter_3 <- word_split[3]
        }
        if (is.null(word_split[4]) || is.na(word_split[4])) {
          rv$letter_4 <- ""
        } else {
          rv$letter_4 <- word_split[4]
        }
        if (is.null(word_split[5]) || is.na(word_split[5])) {
          rv$letter_5 <- ""
        } else {
          rv$letter_5 <- word_split[5]
        }

        shinyBS::updateButton(
          session = getDefaultReactiveDomain(),
          inputId = ns("letter_1"),
          label = rv$letter_1
        )

        updateActionButton(
          inputId = "letter_2",
          label = rv$letter_2
        )

        updateActionButton(
          inputId = "letter_3",
          label = rv$letter_3
        )

        updateActionButton(
          inputId = "letter_4",
          label = rv$letter_4
        )

        updateActionButton(
          inputId = "letter_5",
          label = rv$letter_5
        )

        if (
          rv$letter_1 != "" &
          rv$letter_2 != "" &
          rv$letter_3 != "" &
          rv$letter_4 != "" &
          rv$letter_5 != ""
        ) {
          shinyjs::enable("submit_results")
        } else {
          shinyjs::disable("submit_results")
        }
      }
    )

    # Button click ----
    observeEvent(
      eventExpr = input$letter_1,
      handlerExpr = {
        update_button_color(rv, "letter_1", ns)
      }
    )

    observeEvent(
      eventExpr = input$letter_2,
      handlerExpr = {
        update_button_color(rv, "letter_2", ns)
      }
    )

    observeEvent(
      eventExpr = input$letter_3,
      handlerExpr = {
        update_button_color(rv, "letter_3", ns)
      }
    )

    observeEvent(
      eventExpr = input$letter_4,
      handlerExpr = {
        update_button_color(rv, "letter_4", ns)
      }
    )

    observeEvent(
      eventExpr = input$letter_5,
      handlerExpr = {
        update_button_color(rv, "letter_5", ns)
      }
    )

    # Possible words ----
    observeEvent(
      eventExpr = input$submit_results,
      handlerExpr = {
        shinyjs::disable("word")
        shinyjs::disable("submit_results")
        shinyjs::disable("letter_1")
        shinyjs::disable("letter_2")
        shinyjs::disable("letter_3")
        shinyjs::disable("letter_4")
        shinyjs::disable("letter_5")

        letter_1_result <- get_letter_result(rv$letter_1_status)
        letter_2_result <- get_letter_result(rv$letter_2_status)
        letter_3_result <- get_letter_result(rv$letter_3_status)
        letter_4_result <- get_letter_result(rv$letter_4_status)
        letter_5_result <- get_letter_result(rv$letter_5_status)

        # Reduce word bank
        remaining_words <-
          reduce_word_bank(
            word_guess = input$word,
            # word_guess = "arose",
            results = c(
              letter_1_result,
              letter_2_result,
              letter_3_result,
              letter_4_result,
              letter_5_result
            ),
            r = r
          )

        r$word_bank <-
          possible_words <-
          remaining_words$possible_words

        output$possible_words <- gt::render_gt({
          remaining_words$gt
        })
      }
    )
  })
}

## To be copied in the UI
# mod_wordle_row_ui("wordle_row_ui_1")

## To be copied in the server
# mod_wordle_row_server("wordle_row_ui_1")
