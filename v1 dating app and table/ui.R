# ui test 2
library(shiny)
library(shinydashboard)
library(fresh)
library(dplyr)
library(ggplot2)
library(tidyverse)

library(bslib)
library(spsComps)

library(DT)
library(rsconnect)

# PUT WHICHEVER PODSEARCH CSV YOU WANT INTO HERE
podsearch_df <- read_csv("data/podsearch_df_04_04_2023_v2.csv")

bachelor_num <- sort(sample.int(length(podsearch_df), 1)) # for when they hit the randomize button. would need to be len(sorted df )  tho
print(bachelor_num)

# IGNORE THIS 
rsconnect::setAccountInfo(name='sydbrandt', token='EF859E7A02830E61EF605D72CF47B4F4', secret='zbbW4QOLHEeD9R+Jk+Chw335nf7ZwxV2sD5wou3e')

# Added styling
fluidPage(
  tags$head(tags$style(HTML('* {
                            font-family: "Space Mono", monospace;
                            color: #291440;
                            background-color: #F2EDF9;
                            }
                            .shiny-input-container {
                            color: #291440;
                            }
                            .js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {
                            background: #A64EFF;
                            }
                            h1 {
                            background-color: #A64EFF;
                            color: #F2EDF9;
                            padding: 15px
                            }
                            h3 {
                            font-weight: bold;
                            text-align: justify;
                            }
                            h5 {
                            text-align: left;
                            font-size: 1.15em;
                            }
                            #pod-link {
                            text-align: center;
                            }
                            .btn, button {
                            display: block;
                            margin: 20px auto;
                            height: 50px;
                            width: 50px;
                            border-radius: 50%;
                            border: 2px solid #A64EFF;
                            }
                            img {
                            width: 100%;
                            height: auto;
                            padding-bottom: 15px;
                            padding-top: 15px;
                            border-radius: 10%;
                            }'))),
  titlePanel(h1("PodSearch")),
  fluidRow(
    column(2, 
           # Added slider input alternative
           sliderInput("number_episodes_slider",
                       "Select range of episodses:",
                       min = 1, max = 160,
                       value = c(1, 160)),
           selectInput("number_episodes",
                       "Number of Episodes (minimum):",
                       c("All",
                         c("5", "10", "20", "40", "80", "160"))),
           selectInput("explicit",
                       "Explicit:",
                       c("All",
                         c("explicit", "not explicit"))),
           sliderInput("ave_duration_min_slider",
                       "Select range of duration in minutes:",
                       min = 1, max = 150,
                       value = c(1, 150)),
           selectInput("avg_duration_min",
                       "Average Duration (minimum):",
                       c("All",
                         c(25, 50, 75, 100, 125, 150))),
           selectInput("zodiac",
                       "Zodiac:",
                       c("All",
                         c("Aries", "Taurus", "Gemini", "Cancer", "Virgo", "Leo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces")))),
    mainPanel(column(12, 
      (tabsetPanel(type="tabs",
                  tabPanel("Dating", 
                           box(h2(""),
                           h4("Meet your match!"),
                           h3(),
                           h3(podsearch_df$title[bachelor_num]),
                           img(src=paste(podsearch_df$zodiac[bachelor_num], ".png", sep = "")), # added conditional for zodiac image
                           h5(podsearch_df$description[bachelor_num]),
                           column(6,
                             h5("Number of Episodes:",podsearch_df$number_episodes[bachelor_num], "episodes"),
                             h5("Birthday (air-date):", podsearch_df$birthday[bachelor_num])
                             
                             ), # end of baby column 1
                           column(6,
                             h5("Average Duration:", podsearch_df$avg_duration_min[bachelor_num], "minutes"),
                             h5("Zodiac Sign:", podsearch_df$zodiac[bachelor_num]),
                             h5("Explicit:", podsearch_df$explicit[bachelor_num])

                             ),
                           column(12
                                  #, h5("Show Link:",tags$a(href= podsearch_df$show_link[bachelor_num], "CLICK HERE!"), id = "pod-link")
                                  ),
                           column(6,
                                  actionButton("shuffleButton", "", icon = icon("random"))),
                           column(6,
                                  actionButton("podlinkButton", "", icon = icon("podcast"),
                                               onclick = paste0("window.open('", podsearch_df$show_link[bachelor_num], "', '_blank')") # added link functionality
                                               )))# end of baby column 2
                           ), # end of dating tab
        
                  
                  tabPanel("Table", 
                           box(h2(""),
                           h3("All eligible podcasts!"),
                           h2(""),
                           DT::dataTableOutput("table"))
                  
                  ),
                  
                  tabPanel("Work",
                           box(
                             htmlOutput("filtered_podcast")
                           ))
                  
                  ))))))



