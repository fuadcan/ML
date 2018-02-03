library("ISLR")
library("ggplot2")
?Auto

## 1 ##
plot(Auto$weight,Auto$mpg, xlab="Weight", ylab= "Miles Per Galon")
title("MPG ve Ağırlık")

## 2 ##
plot(mpg ~ weight,data=Auto)
abline(lm(mpg~weight,data=Auto))
title("MPG vs c")

## 3 ##
plot(mpg ~ weight,data=Auto,pch=20,col='blue')
abline(lm(mpg~weight,data=Auto))
title("MPG vs Weight")


### GGPLOT2 ###
## 1 ##
ggplot(Auto,aes(weight,mpg)) + geom_point() + ggtitle("MPG ve Weight")
pl <- ggplot(Auto,aes(weight,mpg))
pl <- pl  + geom_point()
pl <- pl  + ggtitle("MPG vs Weight")
pl


## 2 ##
pl <- ggplot(Auto,aes(weight,mpg,color=horsepower))
pl <- pl + geom_point() + ggtitle("MPG ve Weight")
pred <- predict(lm(mpg~weight+I(weight^2),data=Auto))
pl <- pl + geom_line(aes(y=pred),color='black') 
pl

brand <- Auto$name
brand <- strsplit(as.character(brand)," ")
brand <- sapply(brand, function(elem) elem[[1]])
Auto$brand <- brand

## 3 ##
pl <- ggplot(Auto,aes(horsepower,mpg,color=brand))
pl <- pl + geom_point() + ggtitle("MPG ve BG")
pred <- predict(lm(mpg~horsepower+I(horsepower^2),data=Auto))
pl <- pl + geom_line(aes(y=pred),color='black') 
pl

## 4 ##
pl <- ggplot(Auto,aes(horsepower,mpg,color=brand))
pl <- pl + geom_text(aes(label=brand),size=2)
pl

## 5 ##
Auto$mpg01 <- Auto$mpg > median(Auto$mpg)
pl <- ggplot(Auto,aes(horsepower,mpg,color=mpg01))
pl <- pl + geom_point() + ggtitle("MPG ve BG")
pl <- pl + geom_line(aes(y=pred),color='black') 
pl

## 6 ##
pl <- ggplot(Auto,aes(horsepower,mpg))
pl <- pl + geom_point() + ggtitle("MPG ve BG")
pl <- pl + geom_smooth()
pl


## 7 ##
pl <- ggplot(Auto,aes(horsepower,mpg,color=mpg01))
pl <- pl + geom_point() + ggtitle("MPG ve BG")
pl <- pl + geom_line(aes(y=pred),color='black') 
pl <- pl + geom_smooth()
pl


########## Do the same for mtcars ##########




############################################

#### Plotly ####
library("plotly")

## 1 ##
p <- plot_ly(data= Auto, y= ~mpg, x=~weight)
p <- layout(p,title = 'Mpg vs Weight')
p

## 2 ##
p <- plot_ly(data= Auto, y= ~mpg, x=~weight,
             marker = list(size = 10,
                           color = 'red',
                           line = list(color = 'orange',
                                       width = 2)))
p <- add_markers(p, text = brand)
p <- layout(p,title = 'Mpg vs Weight')


## 3 ##
p <- plot_ly(data= Auto, y= ~mpg, x=~weight, color=~horsepower)
p <- add_markers(p,text = brand)
layout(p,title = 'Mpg vs Weight')


## 4 ##
p <- plot_ly(data= Auto, y= ~mpg, x=~weight, color=~horsepower,size=~weight) %>%
      add_markers(text = brand) %>% 
      layout(title = 'MPG vs Weight')

## 5 ##
preds <- predict(lm(mpg ~ poly(weight,3),data = Auto))
p <- plot_ly(data= Auto) %>%
layout(p,title = 'MPG vs Weight') %>%
add_markers(y = ~mpg, x=~weight, name = 'Cars') %>%
add_lines(y = preds, x=~weight, name="Cubic",line=list(color='black'))

## 6 ##
preds <- predict(lm(mpg ~ poly(weight,3),data = Auto))
p <- plot_ly(data= Auto, x=~weight)
p <- layout(p,title = 'MPG vs Weight')
p <- add_markers(p,y = ~mpg, showlegend = T,color=~brand)
p <- add_lines(p, y = preds,name="Cubic",line = list(color = '#07A4B5'))

## 7 ##
p <- plot_ly(data= Auto, x=~weight) %>% 
  layout(title = 'MPG vs Weight') %>% 
  add_markers(y = ~mpg, text = brand, showlegend = F,color=~brand,size=~weight) %>%
  add_lines(y = preds,name="Cubic",line = list(color = 'Black'))
p

######## GoogleVis #########
library(googleVis)
dat <- readxl::read_excel("data/penn.xlsx")
dat <- data.frame(dat)
M <- gvisMotionChart(dat,idvar='country',timevar = 'year', options=list(height=800, width=1200))
plot(M)
