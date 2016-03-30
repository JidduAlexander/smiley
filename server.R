library(shiny)
library(ggplot2)

circles <- function(center = c(0,0),diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

theHead <- circles(c(0,0),2,npoints = 100)
# leftEye <- circles(c(-0.4,0.4),0.4,npoints = 100)
# rightEye <- circles(c(0.4,0.4),0.4,npoints = 100)
# mouth <-  data.frame(x = c(seq(-0.5,0.5,length.ou = 40), rep(0.5, 10),seq(0.5, -0.5,length.ou = 40),rep(-0.5, 10)), y = c(rep( -0.5, 40), seq(-0.5, -0.4,length.ou = 10), rep( -0.4, 40),seq( -0.4, -0.5,length.ou = 10)))

shinyServer(function(input, output){

  leftEye <- reactive({
    leftEye = circles(c(-input$leftEye,input$leftEye),0.4,npoints = 100)
  })
  rightEye <- reactive({
    rightEye = circles(c(input$rightEye,input$rightEye),0.4,npoints = 100)
  })
  mouth <- reactive({
    mouth = data.frame(x = c(seq(-input$mouth,input$mouth,length.ou = 40), rep(input$mouth, 10),seq(input$mouth, -input$mouth,length.ou = 40),rep(-input$mouth, 10)), y = c(rep( -0.5, 40), seq(-0.5, -0.4,length.ou = 10), rep( -0.4, 40),seq( -0.4, -0.5,length.ou = 10)))
  })
  
  output$smiley <- renderPlot({
    g <- ggplot() 
    g <- g + theme_void()
    if(input$colour == "red"){
      g <- g + geom_polygon(data = theHead, aes(x,y), fill = "red")
    }
    else{
      g <- g + geom_polygon(data = theHead, aes(x,y), fill = "yellow")
    }
    g <- g + geom_path(data = theHead, aes(x,y))
    g <- g + geom_polygon(data = leftEye(), aes(x,y), fill = "white")
    g <- g + geom_path(data = leftEye(), aes(x,y))
    g <- g + geom_polygon(data = rightEye(), aes(x,y), fill = "white")
    g <- g + geom_path(data = rightEye(), aes(x,y))
    g <- g + geom_polygon(data = mouth(), aes(x,y), fill = "white")
    g <- g + geom_path(data = mouth(), aes(x,y))
    g
  }, height = 300, width = 300)

})