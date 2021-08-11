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

          tabPanel("Health Indicators and Greenspace",
                   fluidRow(
                     column(4, plotOutput("greenspacemap")),
                     column(4, plotOutput("indicatormap")),
                     column(4,
                            selectInput("map_indic_input",
                                        "Select indicator",
                                        choices = unique(scottish_survey_local$scottish_health_survey_indicator)),
                            
                            )
                       ),
                   
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  br(),
                  
                   fluidRow(
                     column(8, DT::dataTableOutput("greenspace_indicator_table")),
                     column(4,)
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
                   br(),
                   br(),
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
          tabPanel("SIMD",
                   fluidPage(
                          tags$text("The Scottish Index of Multiple Deprivation is a relative measure of deprivation across 6,976 small areas (called data zones). If an area is identified as ‘deprived’, this can relate to people having a low income but it can also mean fewer resources or opportunities. SIMD looks at the extent to which an area is deprived across seven domains: income, employment, education, health, access to services, crime and housing.
SIMD is an area-based measure of relative deprivation: not every person in a highly deprived area will themselves be experiencing high levels of deprivation."),
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

                   )


)
)
