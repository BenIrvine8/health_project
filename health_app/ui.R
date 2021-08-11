#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)

# Define UI for health application
shinyUI(navbarPage("Scottish Public Health",
          theme = shinytheme("flatly"), 
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
                     column(4, plotOutput("greenspacemap", width = "575", height = "575")),
                     column(4, plotOutput("indicatormap", width = "575", height = "575")),
                       ),
                   fluidRow(
                     column(5,),
                     column(7,
                            selectInput("map_indic_input",
                                        "Select indicator",
                                        choices = unique(scottish_survey_local$scottish_health_survey_indicator)),
                            
                            )
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
          tabPanel(""),

          tabPanel("SIMD",
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
