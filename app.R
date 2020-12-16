library(shiny)
library(tidymodels)
library(tidyverse)
library(reactable)
library(ranger)


model <- readRDS("model_list.rds")

ui <- fluidPage(
    titlePanel("Preditor de Pinguins"),
    sidebarLayout(
        sidebarPanel(),
        mainPanel(
            fileInput("csv", "Carregue aqui o seu CSV", multiple = FALSE, accept = ".csv"),
            shiny::downloadButton("download"),
            reactable::reactableOutput("predicoes")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    dados_preditos <- reactive({
        new_data <- NULL
        if(!is.null(input$csv)) {
            new_data <- read.csv(input$csv$datapath) %>% glimpse()

            new_data <- na.omit(new_data)
            y.pred <- predict(model$fit_rf, new_data = new_data)

            new_data$pred <- y.pred$.pred_class
        }

        new_data
    })

    output$predicoes <- reactable::renderReactable({
        if(!is.null(dados_preditos()))
            reactable(dados_preditos())
    })

    output$download <- downloadHandler(
        filename = function() {
            paste("predicoes-pinguins-", Sys.Date(), ".csv", sep="")
        },
        content = function(file) {
            write.csv(dados_preditos(), file)
        }
    )
}

# Run the application
shinyApp(ui = ui, server = server)
