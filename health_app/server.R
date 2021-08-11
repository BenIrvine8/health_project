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
                   scottish_health_survey_indicator == input$indic_input)%>%
            group_by(scottish_health_survey_indicator, sex) %>%
            mutate(scotland_percent = mean(percentage)) %>%
            ggplot() +
            aes(x= ca_name, y = percentage, fill = case_when(
                ca_name == "Scotland" ~ "Scotland",
                percentage < scotland_percent ~ "Below Scotland",
                percentage > scotland_percent ~ "Above Scotland"
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
     # Green space Bar Graph
      output$greenspacebar <- renderPlot({
        greenspace %>%
          filter(gender == "All",
                 age == input$age_input,
                 distance_to_nearest_green_or_blue_space == input$distance_input,
                 date_code == input$year_input,
                 urban_rural_classification == "All",
                 simd_quintiles == "All",
                 type_of_tenure ==  "All",
                 household_type == "All",
                 ethnicity == "All") %>%
          ggplot() +
          aes(x = ca_name, y = value_percent) +
          geom_col() +
          theme(axis.text.x = element_text(angle = 90))
          })
      
      #Green space Geospatial Graph
      output$greenspacemap <- renderPlot({
        greenspace_la_geo %>% 
          filter(date_code == input$year_input,
                 distance_to_nearest_green_or_blue_space == input$distance_input,
                 age == input$age_input, 
                 gender == "All",
                 urban_rural_classification == "All",
                 simd_quintiles == "All",
                 type_of_tenure == "All",
                 household_type == "All",
                 ethnicity == "All") %>% 
          ggplot() +
          geom_sf(aes(fill = value_percent), colour = "black") +
          theme_minimal()
      })

      # life expectancy at zero years
      output$birth_plot <- renderPlot({
        
        life %>% 
          filter(age == "0 years",
                 date_code == "2016-2018",
                 simd_quintiles == input$simd_quintiles,
                 urban_rural_classification == "All",
                 str_detect(area_code, "^S92")) %>% 
          ggplot() +
          aes(x = sex, y = years_to_live, fill = sex) +
          geom_col() +
          scale_y_continuous() +
          labs(
            x = "\nSex",
            y = "Life expectancy (years)",
            title = "Life expectancy in Scotland at birth in 2016-2018\n",
            subtitle = "(years) Data from the Scottish Government\n") +
          theme_wsj() +
          scale_fill_wsj(palette = "rgby") +
          expand_limits(y = c(1,100)) +
          geom_text(aes(label = years_to_live), vjust = -0.5)
      })
      
      # bar graph of male life expectancy, with age on the x axis, years to live on y axis
      output$gender_plot <- renderPlot({
        
        
        
        
        life %>% 
          filter(sex != "All",
                 date_code == "2016-2018",
                 simd_quintiles == input$simd_quintiles,
                 urban_rural_classification == "All",
                 str_detect(area_code, "^S92")) %>% 
          ggplot() +
          aes(x = reorder(age_new, desc(years_to_live)), y = years_to_live, fill = sex) +
          geom_col(position = "identity", alpha = 0.5) +
          theme(axis.text = element_text(angle = 90)) +
          labs(
            x = "\nage (years)",
            y = "years to live",
            title = "Life expectancy in Scotland in 2016-2018\n",
            subtitle = "(years, by age group) Data from the Scottish Government\n") +
          theme_wsj() +
          scale_fill_wsj(palette = "rgby") +
          expand_limits(y = c(1,100)) 
        
      })
      
}

