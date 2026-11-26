
# BDA400 Assignment 2
# Statistical calculation functions

library(TTR)

# Function to calculate statistical mode
calculate_mode <- function(x) {
  x <- x[!is.na(x)]
  values <- unique(x)
  counts <- tabulate(match(x, values))
  
  if (length(counts) == 0 || max(counts) == 1) {
    return(NA_real_)
  }
  
  return(values[counts == max(counts)])
}

# Function to calculate stock statistics
calculate_statistics <- function(stock_df) {
  
  prices <- stock_df$Close
  
  stock_df$SMA20 <- SMA(prices, n = 20)
  
  mode_values <- calculate_mode(prices)
  
  statistics <- data.frame(
    Mean = mean(prices, na.rm = TRUE),
    Mode = paste(mode_values, collapse = ", "),
    Median = median(prices, na.rm = TRUE),
    Standard_Deviation = sd(prices, na.rm = TRUE),
    Latest_SMA20 = tail(stock_df$SMA20, 1)
  )
  
  return(list(
    Data = stock_df,
    Statistics = statistics
  ))
}

# Function to calculate statistics for all stocks
calculate_all_statistics <- function(stock_data) {
  
  results <- lapply(stock_data, calculate_statistics)
  
  return(results)
}
