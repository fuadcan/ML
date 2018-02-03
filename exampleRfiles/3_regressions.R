### Loading house_data ###
load("data/housesalessubset.rda")
dim(house_data)
head(house_data)

# Plotting price vs sqft
pl <- ggplot(house_data,aes(sqft_living,price,color=price))
pl <- pl + geom_point() + ggtitle("HP ve Sqft")
pl

# Plotting various combinations
plot(price ~ sqft_living + floors + yr_built + bedrooms + region,data=house_data)

# Fitting a linear model
lineer.fit <- lm(price~sqft_living,data=house_data)
summary(lineer.fit)
pred <- predict(lineer.fit)

# Graph
pl <- ggplot(house_data,aes(sqft_living,price,color=price))
pl <- pl + geom_point() + ggtitle("HP ve Sqft")
pl <- pl + geom_line(aes(y=pred))
pl

# Various Combinations
lineer.fit <- lm(price~sqft_living + yr_built,data=house_data)
summary(lineer.fit)

lineer.fit <- lm(price~sqft_living + bedrooms + region,data=house_data)
summary(lineer.fit)

lineer.fit <- lm(price~sqft_living + bedrooms + region,data=house_data)
summary(lineer.fit)

lineer.fit <- lm(price~ . -date -id -long -lat -sqft_living15 -sqft_lot15 -condition -yr_renovated + region,data=house_data)
summary(lineer.fit)
pred <- predict(lineer.fit)

pl <- ggplot(house_data,aes(sqft_living,price,color=price))
pl <- pl + geom_point() + ggtitle("HP ve Sqft")
pl <- pl + geom_line(aes(y=pred),color='black') 
pl

#### Polinomial Regressions #####
lineer.fit <- lm(price ~ sqft_living + I(sqft_living^2) + I(sqft_living^3),data=house_data)
summary(lineer.fit)
pred <- predict(lineer.fit)

lineer.fit <- lm(price ~ sqft_living + poly(sqft_living,10),data=house_data)
summary(lineer.fit)
pred <- predict(lineer.fit)

# PLOT #
pl <- ggplot(house_data,aes(sqft_living,price,color=price))
pl <- pl + geom_point() + ggtitle("HP ve Sqft")
pl <- pl + geom_line(aes(y=pred),color='black') 
pl


lineer.fit <- lm(log(price) ~ poly(sqft_living,3),data=house_data)
summary(lineer.fit)
pred <- predict(lineer.fit)

pl <- ggplot(house_data,aes(sqft_living,log(price),color=price))
pl <- pl + geom_point() + ggtitle("HP vs Sqft, d=3")
pl <- pl + geom_line(aes(y=pred),color='black') 
pl


##################### Train - Test Split #######################
train_house <- split_train_test(house_data,.8)
test_house  <- train_house[[2]]
train_house <- train_house[[1]]

lineer.fit <- lm(log(price) ~ poly(sqft_living,1),data=train_house)
summary(lineer.fit)
pred <- predict(lineer.fit,test_house)
MSE <- sum((test_house$price - pred)^2)/length(pred)

# Write a function that will calculate MSE
calc.mse <- function(test_data, prediction){
  
}

# Now write a function that will return MSE for a given polinomial degree
calculate_mse <- function(train_data,test_data,degree){
  # Fit regression with the given degree to the train data
  
  
  # Predict house prices for test data
  
  
  
  # Calculate MSE
  
  return(MSE)
}

# Find the optimal degree for the given train - test data
mse_calcs <- sapply(1:10, function(d) calculate_mse(train_house,test_house,d))
mse_calcs <- cbind(1:10,mse_calcs)
mse_calcs[mse_calcs[,2]==min(mse_calcs[,2])]


############ KNN Regressions ##########
library("FNN")

pred_001 = knn.reg(train=train_house["sqft_living"], test = test_house["sqft_living"], y= log(train_house$price),k = 1)
pred_005 = knn.reg(train=train_house["sqft_living"], test = test_house["sqft_living"], y= log(train_house$price),k = 5)
pred_010 = knn.reg(train=train_house["sqft_living"], test = test_house["sqft_living"], y= log(train_house$price),k = 10)
pred_050 = knn.reg(train=train_house["sqft_living"], test = test_house["sqft_living"], y= log(train_house$price),k = 50)
pred_100 = knn.reg(train=train_house["sqft_living"], test = test_house["sqft_living"], y= log(train_house$price),k = 100)
pred_200 = knn.reg(train=train_house["sqft_living"], test = test_house["sqft_living"], y= log(train_house$price),k = 200)


fitline <- pred_050$pred
# Grafik
p1 <- ggplot(test_house, aes(x = sqft_living, y = log(price)))
p1 + geom_point(aes(color = price)) + geom_line(aes(y = fitline)) +  ggtitle(paste0("KNN, k = 1"))

     