getwd()
setwd("E:/ML")
getwd()

### From txt ###
setwd("readingdata/")
europe <- read.table("europe.txt",header = T,sep=";")
head(europe)
class(europe)
europe <- data.matrix(europe)
class(europe)




### From csv ###
setwd("readingdata/")
# football <- read.table("football.csv",header=T,sep=",")
football <- read.csv("football.csv")
#
head(europe)
class(europe)
europe <- data.matrix(europe)
class(europe)

##
# default <- read.csv("default.csv")
default <- read.csv("default.csv",sep='|')


### From xlsx ###
default <- readxl::read_excel("default.xlsx")
default
class(default)
#
default <- data.frame(default)
class(default)

#######################################################################
########################### Merging Data ##############################

setwd("readingdata/")
file.exists("turkey_soccer")
file.rename("turkey_soccer","turkey_football")
dir("turkey_football/")

################# UGLY ################
football_data <- list()
dirs <- dir("turkey_football/")
for(i in 1:length(dirs)){ #### HATA ####
  temp <- read.csv(dirs[i])
  football_data[[i]] <- temp
}

################# BAD ##################
football_data <- list()
dirs <- dir("turkey_football/")
for(i in 1:length(dirs)){ 
  temp <- read.csv(paste0("turkey_football/",dirs[i]))
  football_data[[i]] <- temp
}

################# GOOD ###################
dirs <- dir("turkey_football/")
dirs <- paste0("turkey_football/",dirs)
football_data <- lapply(dirs, read.csv)
football_data <- do.call(rbind,football_data)
football_data <- football_data[!is.na(football_data$FTHG),]
football_data$Date <- as.Date(football_data$Date,format='%d/%m/%y')

########## Write to disc ################
save(football_data,file = "football_data.rda")
write.csv(football_data,file = "football_data.csv")

