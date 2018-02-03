library(tree)
library("randomForest")


################## Decision Tree ########################
train_boston <- split_train_test(Boston,.8,101)
test_boston  <- train_boston[[2]]; train_boston  <- train_boston[[1]]

tree.boston <- tree(medv ~ .,data = train_boston)
summary(tree.boston)
plot(tree.boston)
text(tree.boston)

# Test Accuracy
predict.tree.boston <- predict(tree.boston,test_boston)
plot(predict.tree.boston,test_boston$medv)
abline(0,1)
mean((predict.tree.boston - test_boston$medv)^2) # MSE of Model

###################### Bagging ##########################
# Fit Bagging model
# bag.boston <- randomForest(medv ~ . , data = train_boston,mtry = 13, ntree=25)
bag.boston <- randomForest(medv ~ . , data = train_boston,mtry = 13)
plot(bag.boston)

# Test accuracy
predict.bag.boston <- predict(bag.boston,test_boston)
plot(predict.bag.boston,test_boston$medv)
abline(0,1)
mean((predict.bag.boston - test_boston$medv)^2) # MSE of Model

###################### Random Forest ####################
# Fit Bagging model
forest.boston <- randomForest(medv ~ . , data = train_boston,mtry = 6)
plot(forest.boston)

# Test accuracy
predict.forest.boston <- predict(forest.boston,test_boston)
plot(predict.forest.boston,test_boston$medv)
abline(0,1)
mean((predict.forest.boston - test_boston$medv)^2) # MSE of Model
forest.boston$importance
varImpPlot(forest.boston)

# Boosting
library("gbm")
set.seed(156)
# boost.boston <- gbm(medv~.,data = train_boston, distribution = 'gaussian',n.trees=5000, interaction.depth = 4,shrinkage = .2)
boost.boston <- gbm(medv~.,data = train_boston, distribution = 'gaussian',n.trees=5000, interaction.depth = 4)
summary(boost.boston)

par(mfrow =c(1,2))
plot(boost.boston ,i="rm") # marginal effect of rm
plot(boost.boston ,i="lstat")  # marginal effect of lstat
par(mfrow =c(1,1))
preds.boost <- predict(boost.boston, test_boston,n.trees = 5000)
mean((preds.boost-test_boston$medv)^2)


# 
# 
# library(ISLR)
# attach(Carseats)
# High <- ifelse (Sales <=8," No"," Yes ")
# Carseats =data.frame(Carseats ,High)
# tree.carseats <- tree(High???.-Sales ,Carseats )
# summary(tree.carseats)
# 
# tree.carseats2 <- rpart(High???.-Sales ,Carseats,method="class")
# summary(tree.carseats2)
# 
# 
# train_carseats <- split_train_test(Carseats,.5)
# test_carseats  <- train_carseats[[2]]
# train_carseats <- train_carseats[[1]]
# 
# tree.carseats3 <- tree(High~.-Sales, train_carseats)
# tree.pred <- predict(tree.carseats3,test_carseats, type="class")
# crosstab <- table(tree.pred, test_carseats$High)
# sum(diag(crosstab))/200
# set.seed(3)
# pruned <- cv.tree(tree.carseats3,FUN=prune.misclass)
# 
# plot(pruned$size,pruned$dev,type='b')
# plot(pruned$k,pruned$dev,type='b')
# 
# prune.carseats <- prune.misclass(tree.carseats, best=5)
# plot(prune.carseats)
# tree.pred <- predict(prune.carseats, test_carseats,type='class')
# confmat   <- table(tree.pred,test_carseats$High)
# sum(diag(confmat))/sum(confmat)
# 
# prune.carseats <- prune.misclass(tree.carseats3, best=5)
# plot(prune.carseats)
# tree.pred <- predict(prune.carseats, test_carseats,type='class')
# confmat   <- table(tree.pred,test_carseats$High)
# sum(diag(confmat))/sum(confmat)
