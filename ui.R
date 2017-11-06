fluidPage(
  # Application title
  titlePanel("Analysis of Twitter Data on US President Election 2016"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput("selection", "Choose a Date:",
                  choices = election_date),
      actionButton("update", "Change"),
      hr(),
      sliderInput("freq",
                  "Anlytical Scale",
                  min = 1,  max = 50, value = 15),
      sliderInput("max",
                  "Number of words:",
                  min = 1,  max = 300,  value = 100)
    ),
    
    # Show Analysis of Twitter Data
    mainPanel(
      plotOutput("plot")
    )
  )
)