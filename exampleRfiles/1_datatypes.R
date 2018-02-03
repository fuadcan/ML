###########################################################
##################### Numeric Vektörler ###################

#
x <- 5
class(x)

#
x <- c(1,4,6)
class(x) # Vector are all multivariate numeric

#
x <- 1:10
class(x)

#
x <- seq(by=2,from=1,to=20)
#
x <- 1:10
y <- sample(1:25,10)
xy <- c(x,y)

#### Indice Operations ####
x <- seq(1,20,2)
x[c(1,6,2)]
x[c(1,2,6)]
#
ind <- x < 10
ind 
x[ind]
x[x<10]


##
vect  <- 5 + 1:20
plot(vect)
#
vect <- vect + rnorm(20)
plot(vect)
#
head(vect)
tail(vect)
head(vect,10)
tail(vect,10)

##
rands <- rnorm(1000)
plot(rands)
hist(rands)
hist(rands[rands>0])
#
rands <- rands + 5
hist(rands)
plot(density(rands))

# Random Walk
rands <- rnorm(1000)
rand_walk <- cumsum(rands)
plot(rand_walk,type='l')

rwalk_with_trend <- rand_walk + seq(1,50.5,.5)
plot(rwalk_with_trend,type='l')

###########################################################
######################## Character ########################
x <- 'a'
class(x)

x <- "a"
class(x)

x <- c("a","b","c")
class(x)

##
x <- letters # ingilizce küçük harfler
x <- LETTERS # ingilizce büyük harfler
x_collapsed <- paste0(LETTERS,collapse = "-")

head(x)
x[-(1:10)]
x[-c(2,4,6)]
x[-c(2,4,6:length(x))]

##
country_names <- paste0("Country","-",1:10)

##
deficit <- rnorm(10)
names(deficit) <- country_names
deficit

#
cnames <- names(deficit)
cnames <- substr(cnames,9,10)
cnames <- as.numeric(cnames)

## Subscripts ##
fruits <- c(rep("Apples",3),rep("Bananas",3),rep("Oranges",4))
fruits <- sample(fruits)

fruits[1:5]
sub_fruits  <- fruits[fruits == "Apples"]
sub_fruits2 <- fruits[fruits %in% c("Apples","Oranges")]
sub_fruits3 <- fruits[grepl("e",fruits)] # içinde e harfi geçenler
sub_fruits4 <- fruits[grepl("^A",fruits)] # A ile başlayanlar
sub_fruits5 <- fruits[grepl(".*a",fruits)] # içinde a geçenler
sub_fruits6 <- fruits[grepl(".*[Aa]",fruits)] # içinde A ya da a geçenler

###########################################################
#################### Dates ################################
d <- '2017-01-01'
class(d)
d <- as.Date(d)
class(d)

#
d <- '01.01.2017'
class(d)
d <- as.Date(d) # Hata
d <- as.Date(d,format = '%d.%m.%Y')
#
d <- '01/01/17'
d <- as.Date(d,format = '%d/%m/%y')
#
d <- '01JAN2017'
d <- as.Date(d,format = '%d%b%Y')
#
d <- '01JANUARY2017'
d <- as.Date(d,format = '%d%B%Y')

##
important_days <- c('1943-01-02','1945-04-05','1946-03-06')
important_days <- as.Date(c('1943-01-02','1945-04-05','1946-03-06'))
weekdays(important_days)

tday <- Sys.Date()
difftime(tday,important_days)/365

## 
seq(as.Date('2017-01-01'),tday,by = 'weeks')

###########################################################
#################### Matrices #############################
x <- matrix(1:30)
x <- matrix(1:30,5) # Satır sayısı = 5
x <- matrix(1:30,,5) # Sütun sayısı = 5

x <- matrix(,3,4) # NA matrisi
x <- matrix(0,3,4) # 0 Matrisi
x <- matrix(sample(25),5) # rassal sayılar matrisi

######## Döviz Kuru Örneği ########

dovizkuru <- 100 + cumsum(rnorm(50)) # Döviz kuru serisi
plot(dovizkuru,type='l')

library("timeDate")
getiri <- diff(dovizkuru) # hissenin getirisi

dovizkur  <- cbind(dovizkuru, c(NA,diff(dovizkuru)))
date_int <- tail(as.Date(timeSequence(as.Date("2017-1-1"), Sys.Date())),50) # tarihler
# Kolon - satır isimleri
rownames(dovizkur) <- as.character(date_int)
colnames(dovizkur) <- c("Dovizkur","Getiri")
head(dovizkur)
tail(dovizkur)

dovizkur[,1]
dovizkur[,2]

dovizkur[dovizkur[,2]<0,]
dovizkur[dovizkur[,2]>=0,]


haftagunu <- weekdays(as.Date(rownames(dovizkur)))
dovizkur2    <- cbind(dovizkur,haftagunu)
###################################################################
########################### Data Frame ############################

dovizkur <- data.frame(dovizkur)
dovizkur$Getiri
dovizkur$Artan <- ifelse(dovizkur$Getiri>0,"artan","azalan")
dovizkur$Haftagunu <- weekdays(as.Date(rownames(dovizkur)))
Mondays         <- subset(dovizkur,Haftagunu == "Monday")

dovizkur[1:2]
dovizkur[,1:2]
###################################################################
############################# List ################################
lst <- list()
lst[[1]] <- 3
length(lst)
#
lst[[4]] <- 4
length(lst)
#
# names(lst) <- paste0("element",1:7)

lst[[2]] <- letters[1:3]
lst[[3]] <- LETTERS[1:3]
#
lst[[5]] <- dovizkur
#
lst[1:2]
