# Install Packages first
install.packages("FactoMineR")
install.packages("factoextra")
install.packages("corrplot")
install.packages("gplots")

head(housetasks)

library("FactoMineR")
library("factoextra")
library("corrplot")
library("gplots")

#### Baloon Plot for Housetasks data ####
dat <- as.table(as.matrix(housetasks))

balloonplot(t(dat), main ="housetasks", xlab ="", ylab="",
            label = FALSE, show.margins = FALSE)

#### Correspondance Analysis ####
ca <- CA(housetasks,graph=T)
ca$eig
eig.val <- get_eigenvalue(ca)

#### Explained variances w.r.t. dimensions
fviz_screeplot(ca, addlabels = TRUE)

#### Adding a threshold level for the plot
fviz_screeplot(ca) +
  geom_hline(yintercept=33.33, linetype=2, color="red")

#### Biplot that monitors the variances in both columns and rows
fviz_ca_biplot(ca, repel = TRUE)


#### Analysis for row variables
row <- get_ca_row(ca)
row$coord
row$contrib
row$cos2

#### Plots for rows
fviz_ca_row(ca, repel=T)
fviz_ca_row(ca, col.row = "cos2",repel = TRUE)

corrplot(row$cos2, is.corr=FALSE)
fviz_cos2(ca, choice = "row", axes = 1:2)
corrplot(row$contrib, is.corr=FALSE)    

# Contribution of rows to first dimension
fviz_contrib(ca, choice = "row", axes = 1, top = 10)
# Contribution of rows to first and second dimension
fviz_contrib(ca, choice = "row", axes = 1:2, top = 10)

fviz_ca_row(ca, col.row = "contrib",repel = TRUE)

#### Analysis for column variables
column <- get_ca_col(ca)
column$coord
column$contrib
column$cos2

#### Plots for rows
fviz_ca_col(ca, repel=T)
fviz_ca_col(ca, col.col = "cos2",repel = TRUE)

corrplot(column$cos2, is.corr=FALSE)
fviz_cos2(ca, choice = "col", axes = 1:2)
corrplot(column$contrib, is.corr=FALSE)    

# Contribution of rows to first dimension
fviz_contrib(ca, choice = "col", axes = 1, top = 10)
# Contribution of rows to first and second dimension
fviz_contrib(ca, choice = "col", axes = 1:2, top = 10)

fviz_ca_col(ca, col.col = "contrib",repel = TRUE)



# Install Packages first
library("FactoMineR")
library("factoextra")
library("ca")
head(author)

#### Baloon Plot for Housetasks data ####
dat <- as.table(as.matrix(author))
# library(gplots)
# balloonplot(t(dat), main ="Author", xlab ="", ylab="",
#             label = FALSE, show.margins = FALSE)

#### Correspondance Analysis ####
ca <- CA(College[,-1],graph=T)
ca$eig
eig.val <- get_eigenvalue(ca)

#### Explained variances w.r.t. dimensions
fviz_screeplot(ca, addlabels = TRUE)

#### Adding a threshold level for the plot
fviz_screeplot(ca) +
  geom_hline(yintercept=10, linetype=2, color="red")

#### Biplot that monitors the variances in both columns and rows
fviz_ca_biplot(ca, repel = TRUE)


#### Analysis for row variables
row <- get_ca_row(ca)
row$coord
row$contrib
row$cos2

#### Plots for rows
fviz_ca_row(ca, repel=T)
fviz_ca_row(ca, col.row = "cos2",repel = TRUE)
corrplot(row$cos2, is.corr=FALSE)

fviz_cos2(ca, choice = "row", axes = 1)
corrplot(row$contrib, is.corr=FALSE)    

# Contribution of rows to first dimension
fviz_contrib(ca, choice = "row", axes = 1, top = 10)
# Contribution of rows to first and second dimension
fviz_contrib(ca, choice = "row", axes = 1:2, top = 10)

fviz_ca_row(ca, col.row = "contrib",repel = TRUE)

#### Analysis for column variables
column <- get_ca_col(ca)
column$coord
column$contrib
column$cos2

#### Plots for rows
fviz_ca_col(ca, repel=T)
fviz_ca_col(ca, col.col = "cos2",repel = TRUE)

corrplot(column$cos2, is.corr=FALSE)
fviz_cos2(ca, choice = "col", axes = 1:2)
corrplot(column$contrib, is.corr=FALSE)    

# Contribution of rows to first dimension
fviz_contrib(ca, choice = "col", axes = 1, top = 10)
# Contribution of rows to first and second dimension
fviz_contrib(ca, choice = "col", axes = 1:2, top = 10)

fviz_ca_col(ca, col.col = "contrib",repel = TRUE)

