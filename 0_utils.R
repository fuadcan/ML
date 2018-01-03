split_train_test <- function(data,split_ratio,seed=156){
  ## Splits data into train and test set for a given split ratio and 
  ## seed that determines psuedo random numbers
  train_ind <- sample(1:nrow(data),floor(nrow(data) * split_ratio))
  test_ind  <- (1:nrow(data))[-train_ind]
  train_set <- data[train_ind,]; test_set <- data[test_ind,]
  return(list(train_set,test_set))
}