#### TASK: Find whether Fenerbahce had lost game at home ####
# Read football data 


#
head(football_data)
fdata <- football_data

##### Find the teamlist ######
home_teams <- football_data$HomeTeam
home_teams <- home_teams[!duplicated(home_teams)]


htdata <- subset(football_data, HomeTeam == "Fenerbahce")
head(htdata)

nrow(htdata[htdata$FTAG>htdata$FTHG,])


# Write a function to check how many times a given team loses match at home #
islosthome <- function(teamname,dat,datcol){
  htdata <- football_data[football_data[[datcol]]==teamname,]
  nrow(htdata[htdata$FTAG>htdata$FTHG,])
  
}

islosthome("Fenerbahce",football_data,3)

# Write a report that lists number of times that a team loses match at home #

######## KÖTÜ #######

######## İYİ ########
counts <- sapply(home_teams, function(t) islosthome(t,football_data,3))
report <- cbind(as.character(home_teams),counts)

######## GÜZEL ########
report <- data.frame(home_teams,sapply(home_teams, function(t) islosthome(t,football_data,3)))
names(report) <- c("Team", "Count")

report$Team <- reorder(report$Team, report$Count, sum)
ggplot(report, aes(Team,Count,color=Count,reorder(Currency, -Value, sum))) + geom_point(color="Red") + theme(axis.text.x = element_text(angle = 90, hjust = 1))

## Write a function that extracts number of goals of a given team ##
ngoals <- function(team){
  hdata <- football_data[football_data$HomeTeam == team,]
  adata <- football_data[football_data$AwayTeam == team,]
  goals <- sum(hdata$FTHG) + sum(adata$FTAG)
  goals
}

goalcounts <- data.frame(home_teams,sapply(home_teams,ngoals))
colnames(goalcounts) <- c("Team","Count")

plot(goalcounts)
ggplot(goalcounts, aes(Team,Count,color=Count)) + geom_point() + theme(axis.text.x = element_text(angle = 90, hjust = 1))


################################ END ###########################################
## Write a function that extracts number of hits and concedes of a given team ##
hit_concede <- function(team){
  hdata <- football_data[football_data$HomeTeam == team,]
  adata <- football_data[football_data$AwayTeam == team,]
  goals <- rbind(hdata[,c(2:3,5:6)],adata[,c(2:3,6:5)])
  # subcount <- sapply(goals,sum)
  
  colnames(goals) <- c("Date","team","hit","concede")
  goals
}

goalreport <- lapply(home_teams,hit_concede)
goalreport <- do.call(rbind,goalreport)
plot(hit/concede~Date, data=subset(goalreport, team %in% c("Fenerbahce","Galatasaray","Besiktas")))

