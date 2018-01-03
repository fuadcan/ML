library(ISLR)
source("0_utils.R")

#### Information about data ####
head(Smarket)
pairs(Smarket)
dim(Smarket)
summary(Smarket)
cor(Smarket[-9])
plot(Smarket$Volume)

# Fit logistic regression
logistic.fit <- glm(Direction ~ . -Year -Today, data=Smarket,family = 'binomial')
summary(logistic.fit)$coef
logistic.probs <- predict(logistic.fit,type='response')
head(logistic.probs) # All are around 0.5

### Confusion Matrix ###
table( logistic.probs>.5, Smarket$Direction == 'Up')
sum(logistic.probs>.5)
accuracy <- mean((logistic.probs>.5) == (Smarket$Direction == 'Up'))

## Fit another logistic regression
train_set <- subset(Smarket, Year == 2005)
logistic.fit2 <- glm(Direction ~ Lag1 + Lag2, data=train_set,family = 'binomial')
summary(logistic.fit2)$coef
logistic.probs2 <- predict(logistic.fit2,type='response')
head(logistic.probs2) # All are around 0.5
table( logistic.probs2>.5, train_set$Direction == 'Up')
sum(logistic.probs2>.5)
accuracy <- mean((logistic.probs2>.5) == (train_set$Direction == 'Up'))


############### Linear Discriminant Analysis ###################
library("MASS")
lda.fit <- lda(Direction ~ Lag1 + Lag2, data=train_set)
plot(lda.fit)
preds.lda <- predict(lda.fit)

table(preds.lda$class, train_set$Direction)
mean(preds.lda$class == train_set$Direction)
mean((preds.lda$posterior[,2]>.5) == (train_set$Direction=='Up'))

############### Quadratic Discriminant Analysis ###################
qda.fit <- qda(Direction ~ Lag1 + Lag2, data=train_set)
summary(qda.fit)
preds.qda <- predict(qda.fit)


table(preds.qda$class, train_set$Direction)
mean(preds.qda$class == train_set$Direction)
mean((preds.qda$posterior[,2]>.5) == (train_set$Direction=='Up'))

########################### KNN ###################################
library(class)
##### For k = 1 #####
train_Smarket <- Smarket[Smarket$Year<2005,]
test_Smarket  <- Smarket[Smarket$Year==2005,]
knn.pred <- knn(train_Smarket[,2:3],test_Smarket[,2:3],train_Smarket$Direction ,k=1)

table(knn.pred,test_Smarket$Direction)
mean(knn.pred == test_Smarket$Direction)

##### For k = 3 #####


#################################################################

library(ISLR)

#### Read default.xlsx
Default <- data.frame(readxl::read_excel("readingdata/default.xlsx"))
# Default$default <- as.factor(Default$default)
# Default$student <- as.factor(Default$student)

p <- ggplot(Default,aes(income,balance,color=default))
p <- p + geom_point() + ggtitle("Defaulted Loans")
p + scale_color_manual(values=c("blue", "red"))

#### Information about data ####
head(Default)
pairs(Default[,3:4])
dim(Default)
summary(Default)
cor(Default[3:4])
sum(Default$default == 'Yes')

# Fit logistic regression
logistic.fit <- glm(default ~ ., data=Default,family = 'binomial')
summary(logistic.fit)$coef
logistic.probs <- predict(logistic.fit,type='response')
head(logistic.probs) 

### Confusion Matrix ###
table( logistic.probs>.5, Default$default == 'Up')
sum(logistic.probs>.5)
accuracy <- mean((logistic.probs>.5) == (Default$default == 'Up'))

# Split data into test and train #
Default_Yes <- Default[Default$default == 'Yes',]
Default_No  <- Default[Default$default == 'No',][1:333,]
Default     <- rbind(Default_Yes,Default_No)
rm(Default_Yes,Default_No)

# Fit logistic regression
logistic.fit <- glm(default ~ ., data=Default,family = 'binomial')
summary(logistic.fit)$coef
logistic.probs <- predict(logistic.fit,type='response')
head(logistic.probs) 

### Confusion Matrix ###
table( logistic.probs>.5, Default$default == 'Up')
sum(logistic.probs>.5)
accuracy <- mean((logistic.probs>.5) == (Default$default == 'Up'))


############### Linear Discriminant Analysis ###################
library("MASS")
lda.fit <- lda( default ~ ., data=Default)
plot(lda.fit)
preds.lda <- predict(lda.fit)

table(preds.lda$class, Default$default)
mean(preds.lda$class == Default$default)
mean((preds.lda$posterior[,2]>.5) == (Default$default=='Up'))

############### Quadratic Discriminant Analysis ###################
qda.fit <- qda(default ~ ., data=Default)
summary(qda.fit)
preds.qda <- predict(qda.fit)


table(preds.qda$class, Default$default)
mean(preds.qda$class == Default$default)
mean((preds.qda$posterior[,2]>.5) == (Default$default=='Up'))

########################### KNN ###################################
library(class)
##### For k = 1 #####
train_default <- split_train_test(Default,.8)
test_default  <- train_default[[2]]
train_default <- train_default[[1]]
knn.pred <- knn(train_default[,-(1:2)],test_default[,-(1:2)],train_default$default ,k=3)

table(knn.pred,test_default$default)
mean(knn.pred == test_default$default)
