library(shiny)
shinyUI(fluidPage(
  hr(),
  sidebarPanel( 
                width = 4,
                h3("Projects Risk Evaluation"),
               
                selectInput("input_type", "Indicator Name:", choices = c("region","practice","fragile_state"="level","year"), selected = "region"),
                selectInput("risk_code", "Risk Rating Code:", choices = rating_code_list, selected = "Overall")
                
  ),
  
  mainPanel(
    
    tabsetPanel(
      
      tabPanel("Percentage of Risk Levels",  
               plotOutput("bar"),textOutput("text1"))
      
      
    )
    
  )
  
))
