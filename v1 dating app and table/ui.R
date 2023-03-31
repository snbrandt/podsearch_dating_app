# ui test 2
library(shiny)
library(shinydashboard)
library(fresh)
library(dplyr)
library(ggplot2)

library(DT)
library(rsconnect)

# PUT WHICHEVER PODSEARCH CSV YOU WANT INTO HERE
podsearch_df <- read.csv("C:/Users/14804/Desktop/ISTA498Website/podsearch_csv/podsearch_df_03_30_2023.csv")

bachelor_num <- sort(sample.int(length(podsearch_df), 1)) # for when they hit the randomize button. would need to be len(sorted df )  tho
print(bachelor_num)

# IGNORE THIS 
rsconnect::setAccountInfo(name='sydbrandt', token='EF859E7A02830E61EF605D72CF47B4F4', secret='zbbW4QOLHEeD9R+Jk+Chw335nf7ZwxV2sD5wou3e')


fluidPage(
  titlePanel("PodSearch"),
  fluidRow(
    column(2, 
           selectInput("number_episodes",
                       "Number of Episodes (minimum):",
                       c("All",
                         c("5", "10", "20", "40", "80", "160"))),
           selectInput("explicit",
                       "Explicit:",
                       c("All",
                         c("explicit", "not explicit"))),
           selectInput("avg_duration_min",
                       "Average Duration (minimum):",
                       c("All",
                         c(25, 50, 75, 100, 125, 150))),
           selectInput("zodiac",
                       "Zodiac:",
                       c("All",
                         c("Aries", "Taurus", "Gemini", "Cancer", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces")))),
    mainPanel(column(10, 
      (tabsetPanel(type="tabs",
                  tabPanel("Dating", 
                           box(h2(""),
                           h3("Meet your match!"),
                           h3(),
                           h4(podsearch_df$title[bachelor_num]),
                           h5("[put image ehre AUGHHH]"), ###########################working on img
                           h5(podsearch_df$description[bachelor_num]),
                           column(5,
                             h5("Number of Episodes:",podsearch_df$number_episodes[bachelor_num], "episodes"),
                             h5("Birthday (air-date):", podsearch_df$birthday[bachelor_num]),
                             h5("Show Link:",tags$a(href= podsearch_df$show_link[bachelor_num], "Click here!"))
                             
                             ), # end of baby column 1
                           column(5,
                             h5("Average Duration:", podsearch_df$avg_duration_min[bachelor_num], "minutes"),
                             h5("Zodiac Sign:", podsearch_df$zodiac[bachelor_num]),
                             h5("Explicit:", podsearch_df$explicit[bachelor_num])

                             ))# end of baby column 2
                           ), # end of dating tab
        
                  
                  tabPanel("Table", 
                           box(h2(""),
                           h3("All eligible podcasts!"),
                           h2(""),
                           DT::dataTableOutput("table"))
                  
                  )))))))



