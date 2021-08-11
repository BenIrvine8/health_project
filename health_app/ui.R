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
          
          br(),
          br(),
            
          
            fluidRow(
              column(3, selectInput("sex_input",
                                    "Select gender",
                                    choices = unique(scottish_survey_local$sex)),

                     selectInput("indic_input",
                                 "Select indicator",
                                 choices = unique(scottish_survey_local$scottish_health_survey_indicator))),

              column(9, plotOutput("localPlot", width = "800")),
            )
          
          ),

          tabPanel("Focus",
                   fluidRow(
                     column(3,
                            selectInput("year_input",
                                        "Year",
                                        choices = unique(greenspace$date_code)),
                            selectInput("age_input",
                                        "Age Group",
                                        choices = unique(greenspace$age)),
                            selectInput("distance_input",
                                        "Reported distance to Green Space",
                                        choices = unique(greenspace$distance_to_nearest_green_or_blue_space)),
                            ),
                     column(4, plotOutput("greenspacemap", width = "600", height = "600")),
                     column(4, plotOutput("greenspacebar", width = "500", height = "600")),
                       ),
                   ),


          tabPanel("SMID",
                   fluidPage(
                           titlePanel(tags$h1("Life Expectancy at Birth")),
                           fluidRow(
                                   column(3, 
                                          selectInput("simd_quintiles",
                                                      "Which SIMD quintile?",
                                                      choices = simd_codes)
                                   ),
                                   column(9,
                                          plotOutput("birth_plot"))
                           ),
                           br(),
                           br(),
                           fluidRow(
                                   column(3),
                                   column(9,
                                          plotOutput("gender_plot"))
                           )
                   )
                   
                   ),
          tabPanel("Download")
                   
)
)
