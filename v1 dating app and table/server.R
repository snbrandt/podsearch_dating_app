# server test2


# Server
function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- podsearch_df
    if (input$number_episodes != "All") {
      data <- data[as.numeric(data$number_episodes) >= as.numeric(input$number_episodes),]
    }
    if (input$explicit != "All") {
      data <- data[data$explicit == input$explicit,]
    }
    if (input$avg_duration_min != "All") {
      data <- data[as.numeric(data$avg_duration_min) >= as.numeric(input$avg_duration_min),]
    }
    if (input$zodiac != "All") {
      data <- data[data$zodiac == input$zodiac,]
    }
    data[c("title", "description", "number_episodes", "avg_duration_min", "explicit", "zodiac")]
    
  }))
  
}
