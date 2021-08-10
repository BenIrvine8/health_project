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
            aes(x = year, y = percentage, colour = sex) +
            geom_line() +
            geom_point() +
            scale_x_continuous(breaks = 2008:2019) +
            expand_limits(y = c(1, 100)) +
        theme_wsj() +
        theme(axis.text.x = element_text(face = "bold", size = 10),
              axis.text.y = element_text(face = "bold", size = 10),
              title =element_text(size=12, face='bold'),
              axis.title=element_text(size=12)) +
        labs(x = "Year",
             y = "Percent\n",
             colour = "",
             title = "Scottish Health Survey-Scotland level data") +
        scale_colour_manual(values = c("All" = "black", "Male" = "light blue", "Female" = "pink"))

    })
    # Area Level Survey Visualisation
    output$localPlot <- renderPlot({
        scottish_survey_local %>%
            filter(sex == input$sex_input,
                   scottish_health_survey_indicator == input$indic_input) %>%
            group_by(scottish_health_survey_indicator, sex) %>%
            mutate(scotland_percent = mean(percentage)) %>%
            ggplot() +
            aes(x= ca_name, y = percentage, fill = case_when(
                ca_name == "Scotland" ~ "Scotland",
                percentage > scotland_percent ~ "Above Scotland",
                percentage < scotland_percent ~ "Below Scotland",
                )) +
            geom_col() +
            theme_wsj() +
            theme(axis.text.x = element_text(face = "bold", size = 10, angle = 45, hjust = 1),
                  axis.text.y = element_text(face = "bold", size = 10),
                  title =element_text(size=12, face='bold'),
                  axis.title=element_text(size=12)) +
            labs(x = "Local Authority",
                 y = "Percent\n",
                 fill = "",
                 title = "Scottish Health Survey-Local area level data") +
                scale_fill_wsj(palette = "rgby")
                


    })
     # Green space Line Graph
      output$greenspaceline <- renderPlot({
        greenspace %>%
          filter(gender == "All",
                 age == input$age_input,
                 distance_to_nearest_green_or_blue_space == input$distance_input,
                 urban_rural_classification == "All",
                 simd_quintiles == "All",
                 type_of_tenure ==  "All",
                 household_type == "All",
                 ethnicity == "All",
                 ca_name == input$council_input) %>%
          ggplot() +
          aes(x = date_code, y = value_percent) +
          geom_line() +
          geom_point()
          })

}
