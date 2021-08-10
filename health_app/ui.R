#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)

# Define UI for health application
shinyUI(navbarPage("Scottish Public Health",
          tabPanel("Scottish Health Survey Overview",
          fluidRow(
            column(3, selectInput("gender_input",
                                  "Select gender",
                                  choices = unique(scottish_survey$sex)),
                   
                   
                   selectInput("indicator_input",
                               "Select indicator",
                               choices = unique(scottish_survey$scottish_health_survey_indicator))
            ),
            
            column(9, plotOutput("trendPlot",width = "800"))
            
          ),
          mainPanel(
            fluidRow(
              column(4, selectInput("sex_input",
                                    "Select gender",
                                    choices = unique(scottish_survey_local$sex)),
                     
                     selectInput("indic_input",
                                 "Select indicator",
                                 choices = unique(scottish_survey_local$scottish_health_survey_indicator))),
              
              column(8, plotOutput("localPlot", width = "800")),
            )
          )
          ),
          
          tabPanel("Focus"),
          tabPanel("SMID"),
          tabPanel("Download")
                   )
)



