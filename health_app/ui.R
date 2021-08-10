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
            fluidRow(
              column(4, selectInput("sex_input",
                                    "Select gender",
                                    choices = unique(scottish_survey_local$sex)),

                     selectInput("indic_input",
                                 "Select indicator",
                                 choices = unique(scottish_survey_local$scottish_health_survey_indicator))),

              column(8, plotOutput("localPlot", width = "800")),
            )
          ),

          tabPanel("Focus",
                   fluidRow(
                     column(3,
                            selectInput("year_input",
                                        "Year",
                                        choices = sort(unique(greenspace$date_code), decreasing = TRUE)),
                            selectInput("age_input",
                                        "Age Group",
                                        choices = sort(unique(greenspace$age), decreasing = TRUE)),
                            selectInput("distance_input",
                                        "Reported distance to Green Space",
                                        choices = sort(unique(greenspace$distance_to_nearest_green_or_blue_space))),
                            selectInput("map_indic_input",
                                        "Select indicator",
                                        choices = unique(scottish_survey_local$scottish_health_survey_indicator)),
                            ),
                     column(4, plotOutput("greenspacemap", width = "575", height = "575")),
                     column(4, plotOutput("indicatormap", width = "575", height = "575")),
                       )
          ),
          tabPanel("Summary and statistics",
                   fluidRow(
                     column(12,
                     h2(" Distance from Greenspace and Indicators of Health for Scotland")
                     ),
                     column(12,
                     p(" Generate summary statistics for Scotland by age for 
                       distance to green space and by exercise-related health indicator")
                     )
                   ),
                   fluidRow(
                     column(4,
                            selectInput("age_table_input",
                                        "Age Group",
                                        choices = sort(unique(greenspace$age))),
                     ),
                     column(6, DT::dataTableOutput("greenspace_stats_table"))
                     ),
                   fluidRow(column(12,)),
                   fluidRow(
                     column(4,
                            selectInput("indic_table_input",
                                        "Select indicator",
                                        choices = unique(
                                          scottish_survey_local$scottish_health_survey_indicator)),
                            ),
                     column(6, DT::dataTableOutput("indicator_stats_table"))
                   )
                   ),
          tabPanel("")
          )
        )

