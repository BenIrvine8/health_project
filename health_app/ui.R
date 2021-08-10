#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)

# Define UI for health application
shinyUI(navbarPage("Scottish Public Health",
          tabPanel("Overview"),
          tabPanel("Focus"),
          tabPanel("SMID"),
          tabPanel("Download")
                   )
        )


