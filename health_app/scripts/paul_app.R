library(tidyverse)
library(shiny)
library(CodeClanData)
library(ggthemes)
library(here)

life <- read_csv(here("data/clean_data/life_expectancy_clean.csv"))
# reformatting and sorting the age categories
life <- life %>% 
  mutate(age_new = str_remove(age, " years"))
#simd_codes <- distinct(.data = life, simd_quintiles)
simd_codes <- c("All", "5 - least deprived", "4", "3", "2", "1 - most deprived")

# -------------------------------------------------------------------------


ui <- fluidPage(
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
  



# -------------------------------------------------------------------------



server <- function(input, output) {
  
  output$birth_plot <- renderPlot({
    
    # life expectancy at zero years
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
  
  output$gender_plot <- renderPlot({
    
    # bar graph of male life expectancy, with age on the x axis, years to live on y axis
    
    
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

# -------------------------------------------------------------------------



shinyApp(ui = ui, server = server)