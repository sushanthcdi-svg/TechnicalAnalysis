
# BDA400 Assignment 2
# Function to import historical stock data

library(quantmod)

load_stock_data <- function(
    portfolio_file = "portfolio.txt",
    start_date = "2025-01-01",
    end_date = "2026-01-01") {
  
  symbols <- readLines(portfolio_file)
  symbols <- trimws(symbols)
  symbols <- symbols[nzchar(symbols)]
  
  stock_data <- list()
  
  for (symbol in symbols) {
    
    data <- getSymbols(
      symbol,
      src = "yahoo",
      from = start_date,
      to = end_date,
      auto.assign = FALSE
    )
    
    df <- data.frame(
      Date = as.Date(index(data)),
      Open = as.numeric(Op(data)),
      High = as.numeric(Hi(data)),
      Low = as.numeric(Lo(data)),
      Close = as.numeric(Cl(data)),
      Volume = as.numeric(Vo(data)),
      Adjusted = as.numeric(Ad(data))
    )
    
    stock_data[[symbol]] <- df
    
    message("Successfully loaded: ", symbol)
  }
  
  return(stock_data)
}
