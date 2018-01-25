if("shiny" %in% rownames(installed.packages()) == FALSE) {install.packages("shiny")}

library(shiny)

library(ggplot2)

data_file <- file.path("data", "project_data.csv") 
df1 <- read.csv(data_file, header=T, sep=",")

data_file <- file.path("data", "risk_data.csv") 
df2 <- read.csv(data_file, header=T, sep=",")

df <- merge(df1, df2, by="project_id")
df$year <- as.numeric(format(as.Date(df$tl_since, format="%m/%d/%Y"),"%Y"))

rating_code_list <-  unique(df$risk_rating_code)

mean <- NULL
