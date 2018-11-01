#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(tidytext)
library(formattable)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Top 100 Military Manufacturing Companies by Country"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      
     read_rds("saved.rds") %>%
       ggplot(aes(country_2016, total_companies, fill = country_sales_2016)) + geom_col() +
       xlab("Country") + ylab("Total No. of Companies") + theme_minimal() + theme(legend.position="right") +
       labs(fill = "Total Arms Sales\n(millions of $)") + 
       ggtitle("Concentration of Top 100 Military Manufacturing Companies by Country") +
       labs(subtitle = "A look at which countries have the most Top 100 companies, and how much they earn in arms sales.") +
       scale_fill_gradient2(low = "white", high = "lightseagreen", mid = "turquoise", midpoint = 108000)
      
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

