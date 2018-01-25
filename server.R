

shinyServer(function(input, output) {
  
    
  MyData <- function (){
    
    subdf  <- df[which(df$risk_rating_code== as.character(as.factor(input$risk_code))),]
    
    
    list <- function(type) {
      switch(type,
             "region"=  unique(df$region),
             "practice"=  unique(df$practice),
             "level"=  unique(df$fcs_indicator),
             "year"=  sort(unique(df$year))
             
      )
    }
    list <- list(input$input_type)
    
    
    len <- NULL
    i = 1
    dt <- NULL
    for (item in list){
      tmp <- function(type) {
        switch(type,
          "region"= subdf[which(subdf$region== as.character(as.factor(item))),],
          "practice"= subdf[which(subdf$practice== as.character(as.factor(item))),],
          "level"= subdf[which(subdf$fcs_indicator== as.character(as.factor(item))),],
          "year"= subdf[which(subdf$year== as.character(as.factor(item))),]
        )
      }
      tmp <- tmp(input$input_type)
      
      size <- nrow(tmp)
      len[1] <- nrow(tmp[which(tmp$risk_rating == as.character(as.factor("H"))),])*100/size
      len[2] <- nrow(tmp[which(tmp$risk_rating == as.character(as.factor("S"))),])*100/size
      len[3] <- nrow(tmp[which(tmp$risk_rating == as.character(as.factor("M"))),])*100/size
      len[4] <- nrow(tmp[which(tmp$risk_rating == as.character(as.factor("L"))),])*100/size
      if(i == 1)
        dt <- len
      else
        dt <- data.frame(dt, len)
      i = i + 1
    }
    
    colnames(dt) <- list
    rownames(dt) <- c("H","S","M","L")
    
    dx <- data.matrix(dt, rownames.force = NA)
    mean <- sqrt(rowSums((dx - mean(dx))^2)/(dim(dx)[2] - 1))
    
    
    return (dx)
  }
  
  

  output$bar <- renderPlot({
    
    #dx <- data.matrix(MyData(), rownames.force = NA)
    
    barplot(MyData())
  })
  
  output$text1 <- renderText({ 
    
    paste("Mean of standard deviations for each level of risk across different ",input$input_type, "s: ", round(mean(c(sd(MyData()[1,]),sd(MyData()[2,]),sd(MyData()[3,]),sd(MyData()[4,]))), digits=2), sep="")
    
  })
  
  
})

