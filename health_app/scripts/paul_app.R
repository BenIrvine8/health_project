library(tidyverse)
library(shiny)
library(CodeClanData)
library(shinythemes)

life <- read_csv(here("data/clean_data/life_expectancy_clean.csv"))
# reformatting and sorting the age categories
life <- life %>% 
  mutate(age_new = str_remove(age, " years"))
date_ranges <- distinct(.data = life, date_code) 
simd_codes <- distinct(.data = life, simd_quintiles)

# -------------------------------------------------------------------------


ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel(tags$h1("Life Expectancy at Birth")),
  fluidRow(
    column(3, 
           selectInput("date_code",
                       "Which date range?",
                       choices = date_ranges),
           selectInput("simd_quintiles",
                       "Which SIMD quintile?",
                       choices = simd_codes)
    ),
    column(9,
           plotOutput("birth_plot"))
  ),
  fluidRow(
    column(3),
    column(9,
           plotOutput("gender_plot"))
  )
  )
  



# -------------------------------------------------------------------------



server <- function(input, output) {
  
  output$birth_plot <- renderPlot({
    
    # life expectancy at zero years
    life %>% 
      filter(age == "0 years",
             date_code == input$date_code,
             simd_quintiles == input$simd_quintiles,
             urban_rural_classification == "All",
             str_detect(area_code, "^S92")) %>% 
      ggplot() +
      aes(x = sex, y = years_to_live) +
      geom_col() +
      scale_y_continuous() +
      labs(
        x = "\nSex",
        y = "Life expectancy (years) at birth",
        title = "Life expectancy in Scotland\n",
        subtitle = "Data from the Scottish Government\n")
  })
  
  output$gender_plot <- renderPlot({
    
    # bar graph of male life expectancy, with age on the x axis, years to live on y axis
    
    
    life %>% 
      filter(sex != "All",
             date_code == input$date_code,
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
        title = "Life expectancy in Scotland\n",
        subtitle = "Data from the Scottish Government\n")
    
  })
  
}

# -------------------------------------------------------------------------



shinyApp(ui = ui, server = server)