library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Welcome to GGPLOT Smiley"),
  sidebarPanel(
    radioButtons(inputId = "colour", label = "What colour smiley?", choices = c("yellow","red"), selected = "yellow"),
    sliderInput(inputId = "leftEye", label = "Slide the left eye", min = 0.3, max = 0.5, value = 0.4, step = 0.01),
    sliderInput(inputId = "rightEye", label = "Slide the right eye", min = 0.3, max = 0.5, value = 0.4, step = 0.01),
    sliderInput(inputId = "mouth", label = "Change the size of the mouth", min = 0.25, max = 0.75, value = 0.5, step = 0.05)
  ),
  mainPanel(
    plotOutput("smiley")
  )
))