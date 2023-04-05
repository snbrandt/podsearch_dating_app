# server test2


# Server
function(input, output) {
  
  file = reactiveVal(NA)
  end_url = reactiveVal()
  
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
  
  output$filtered_podcast <- renderText({
    
    if(input$zodiac == "All") {
      paste(h2("Use filters to get your match!"))
    } else{
    filtered_df <- podsearch_df %>% 
      filter(zodiac %in% input$zodiac)
    
    pod_match <- sample_n(filtered_df, 1)
    
    pod_match %>% 
      mutate(title = paste0(h2(""),
                            h4("Meet your match!"),
                            h3(),
                            h3(title),
                            img(src=paste(zodiac, ".png", sep = "")), # added conditional for zodiac image
                            h5(description),
                            column(6,
                                   h5("Number of Episodes:",number_episodes, "episodes"),
                                   h5("Birthday (air-date):", birthday)
                                   
                            ), # end of baby column 1
                            column(6,
                                   h5("Average Duration:", avg_duration_min, "minutes"),
                                   h5("Zodiac Sign:", zodiac),
                                   h5("Explicit:", explicit)
                                   
                            ),
                            column(12),
                            column(6,
                                   actionButton("shuffleButton", "", icon = icon("random"))),
                            column(6,
                                   actionButton("podlinkButton", "", icon = icon("podcast"),
                                                onclick = paste0("window.open('", show_link, "', '_blank')") # added link functionality
                                   )))) %>% 
      pull(title)
    }
    
  })
  

  
  output$zodiac_image <- renderImage({
    if(input$zodiac != "All"){
    list(src = paste0("www/", input$zodiac, ".png"), height = 100, width = 100)
    }
  })
  
  '
  output$table <- {
    podsearch_df %>% 
      filter(avg_duration_min > input$ave_duration_min_slider[1] & avg_duration_min <= input$ave_duration_min_slider[2] & number_episodes > input$number_episodes_slider[1] & number_episodes <= input$number_episodes_slider[2] & explicit %in% input$explicit)
  }
  '
}
