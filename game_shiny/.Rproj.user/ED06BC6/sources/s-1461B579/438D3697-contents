shinyServer(function(input, output) {
    #filter by developer selector
    sales_dev_filtered <- eventReactive (input$update, {game_sales %>%
        filter(developer %in% input$developers)})
    
    #filter by year selector
    sales_year_filtered <- eventReactive(input$update, {sales_dev_filtered() %>%
        filter(year_of_release == input$year)})
    
    #main line graph plot:
    output$mean_sales <- renderPlot({
        sales_dev_filtered() %>%
            group_by(year_of_release, developer) %>%
            summarise(mean_sales_per_game = mean(sales)) %>%
            ggplot() +
            aes(
                x = year_of_release,
                y = mean_sales_per_game,
                colour = developer) +
            geom_line(stat = "identity",
                      alpha = 0.65) +
            geom_vline(xintercept = input$year,
                       linetype = "dashed",
                       alpha = 0.5) +
            labs(
                title = "Mean Sales Per Game Over Time",
                x = "Year of Release",
                y = "Mean Sales per Game (in millions)",
                colour = "Developer"
            ) +
            theme(legend.position = "bottom")
    })
    
    #total sales plot
    output$total_games <- renderPlot({
        ggplot(sales_year_filtered()) +
            aes(x = developer, fill = developer) +
            geom_bar() +
            labs(
                x = "Developer",
                y = "Games Produced",
                fill = "Developer",
                title = "Total Games Produced"
            ) +
            theme(legend.position = "bottom")
    })
    
    #Genre Plot
    output$genre <- renderPlot({
        ggplot(sales_year_filtered()) +
            aes(x = genre, fill = developer) +
            geom_bar(position = "dodge") +
            labs(
                x = "Genre",
                y = "Total Games Produced",
                fill = "Developer",
                title = "Games Produced by Genre"
            ) +
            theme(legend.position = "bottom")
    })
    
    #ESRB Rating Plot
    output$esrb <- renderPlot({
        ggplot(sales_year_filtered()) +
            aes(x = rating, fill = developer) +
            geom_bar(position = "dodge") +
            labs(
                x = "ESRB Rating",
                y = "Total Games Produced",
                fill = "Developer",
                title = "Games Produced by ESRB Rating"
            ) +
            theme(legend.position = "bottom")
    })
    
    #Platform plot
    output$platform <- renderPlot({
        ggplot(sales_year_filtered()) +
            aes(x = platform, fill = developer) +
            geom_bar(position = "dodge") +
            labs(
                x = "Platform",
                y = "Total Games Produced",
                fill = "Developer",
                title = "Games Produced by Platform"
            ) +
            theme(legend.position = "bottom")
    })
    
    #Mean Critic Score per Game Plot
    output$critic <- renderPlot({
        #need to do another group_by to get critic score
        sales_year_filtered() %>%
            group_by(developer) %>%
            summarise(mean_score = mean(critic_score)) %>%
            ggplot() +
            aes(x = developer, y = mean_score, fill = developer) +
            geom_bar(stat = "identity") +
            labs(
                x = "Developer",
                fill = "Developer",
                y = "Average Critic Score",
                title = "Average Critic Score per Game by Developer"
            ) +
            theme(legend.position = "bottom")
    })
    #Mean User Score per Game Plot
    #pretty much the same as critic score
    output$user <- renderPlot({
    sales_year_filtered() %>%
        group_by(developer) %>%
        summarise(mean_score = mean(user_score)) %>%
        ggplot() +
        aes(x = developer, y = mean_score, fill = developer) +
        geom_bar(stat = "identity") +
        labs(
            x = "Developer",
            fill = "Developer",
            y = "Average User Score",
            title = "Average User Score per Game by Developer"
        ) +
        theme(legend.position = "bottom")
    })
    
    #data table for second main tab
    output$data = renderDT({
      sales_year_filtered()
    })
})
