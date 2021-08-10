#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

server <- function(input, output) {
    
    # Scotland Survey Visualisation
    output$trendPlot <- renderPlot({
        scottish_survey %>%
            filter(sex == input$gender_input,
                   scottish_health_survey_indicator == input$indicator_input) %>% 
            ggplot() +
            aes(x = year, y = percentage) +
            geom_line() +
            scale_x_continuous(breaks = 2008:2019) +
            expand_limits(y = c(1, 100))
        
    })
    # Scotland Survey Visualisation
    output$localPlot <- renderPlot({
        scottish_survey_local %>%
            filter(sex == input$sex_input,
                   scottish_health_survey_indicator == input$indic_input) %>% 
            ggplot() +
            aes(x= ca_name, y = percentage, fill = ca_name) +
            geom_col() +
            theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
            scale_fill_manual(values = c("Scotland" = "darkgreen"
            ))
        
    })
}