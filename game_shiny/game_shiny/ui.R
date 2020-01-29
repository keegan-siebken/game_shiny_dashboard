shinyUI(fluidPage(

    titlePanel("Game Developer Comparison"),

    # Sidebar with a slider input for year selection and checkboxes for developer filtering
    sidebarLayout(
        sidebarPanel(
            sliderInput("year",
                        "Select Year:",
                        min = min(game_sales$year_of_release),
                        max = max(game_sales$year_of_release),
                        value = median(min(game_sales$year_of_release):max(game_sales$year_of_release)),
                        sep = ""
                        ),
            checkboxGroupInput("developers", 
                               "Select Developers", 
                               choices = sort(unique(game_sales$developer)), 
                               selected = sort(unique(game_sales$developer))),
            #need reaction button - too many selections to not have one:
            actionButton("update", "Get Comparison")
        ),

        # Main panel with two sections
        mainPanel(
            #Top section: line graph showing mean sales per game to illustrate which developers are making the most prosperous games in any given yearß
          tabsetPanel(  
            tabPanel("Graphs", 
          fluidRow(
                column(12, plotOutput("mean_sales"))
                ),
            fluidRow(column(12, tags$h3("Breakdown in Year Selected:"))),
            #Bottom section: tabs showing different graphs to examine what each developer was focused on that year
            fluidRow(
                column(12,
                    tabsetPanel(
                        tabPanel(
                            "Total",
                            plotOutput("total_games")
                        ),
                        tabPanel(
                            "Genre",
                            plotOutput("genre")
                        ),
                        tabPanel(
                            "ESRB",
                            plotOutput("esrb")
                        ),
                        tabPanel(
                            "Platform",
                            plotOutput("platform")
                        ),
                        tabPanel(
                            "Critic",
                            plotOutput("critic")
                        ),
                        tabPanel(
                            "User",
                            plotOutput("user")
                        )
                    )
                )
            )
        ),
        tabPanel(
          "Data",
          DTOutput("data")
        )))
    )
))
