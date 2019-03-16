rmse <- function(actual, predicted) {
  return(sqrt(mean((actual - predicted)^2)))
}