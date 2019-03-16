library(rpart)
library(rpart.plot)

fit <- rpart(log_house_value~., 
             data = data, 
             method = "anova",
             maxdepth = 4)

show.prp.palettes()

rpart.plot(fit,
           type = 1,
           digits = 2, 
           box.palette = "BuPu",
           cex = 1)

