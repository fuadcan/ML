#### Generate Random Data ####
library(e1071)
set.seed (1)
x <- matrix (rnorm (20*2) , ncol =2)
y <- c(rep (-1,10) , rep (1 ,10) )
x[y==1 ,] <- x[y==1,] + 1

plot(x, col =(3-y))
dat <- data.frame(x=x, y=as.factor(y))

#### Fit an SVM to the data ####
svmfit <-  svm(y ~ ., data=dat , kernel ="linear", cost =20,scale =FALSE )
plot(svmfit,dat)
svmfit$index

#### Tune the best parameter for cost ####
set.seed(1)
tune.out <- tune(svm ,y~.,data=dat ,kernel ="linear",
              ranges =list(cost=c(0.001 , 0.01, 0.1, 1,5,10,100) ))

summary(tune.out)
bestmod <- tune.out$best.model
summary(bestmod)

#### Generate a test data ####
set.seed(100)
xtest <- matrix (rnorm (20*2) , ncol =2)
ytest <- sample (c(-1,1) , 20, rep=TRUE)
xtest[ytest ==1 ,] <- xtest[ytest ==1,] + 1
testdat <- data.frame (x=xtest, y=as.factor(ytest))

#### Apply the model to the test data ####
ypred <- predict(bestmod,testdat)
table(predict=ypred, truth=testdat$y) ### Confusion matrix

#### Same analysis with cost=.01 ####
svmfit =svm(y~., data=dat , kernel ="linear", cost =.01,scale =FALSE )
ypred <- predict(svmfit,testdat)
table(predict=ypred, truth=testdat$y)

#### Increase distance between classes ####
x[y==1,] <- x[y==1,]+.5
plot(x, col =(y+5) /2, pch =19)
dat=data.frame(x=x,y=as.factor (y))

svmfit =svm(y~., data=dat , kernel ="linear", cost =1e5)
summary (svmfit )
plot(svmfit,dat)


################## SVM with Radial Classifier ####################
set.seed (1)
x <- matrix(rnorm (200*2), ncol =2)
x[1:100,]   <- x[1:100,]+2
x[101:150,] <- x[101:150,] -2
y <- c(rep(1,150),rep(2,50))
dat <- data.frame(x=x,y=as.factor(y))
plot(x, col=y, pch=20)

#### Train sample indice ####
train <- sample(200 ,100)
svmfit <- svm(y~.,data =dat[train,], kernel ="radial", gamma =1,cost =1)
plot(svmfit , dat[train ,])

#### Tune for the best parameter selection ####
set.seed(1)
tune.out <- tune(svm, y~., data=dat[train,], kernel ="radial",
              ranges =list(cost=c(0.1 ,1 ,10 ,100 ,1000),
                           gamma=c(0.5,1,2,3,4)))
summary (tune.out)
summary(svmfit)

##### Check accuracy of the best model ####
cmat <- table(true=dat[-train,]$y, pred=predict(tune.out$best.model,newdata=dat[-train,]))
cmat
sum(diag(cmat))/sum(cmat)

     