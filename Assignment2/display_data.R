
# BDA400 Assignment 2
# Stock data display and visualization

library(ggplot2)

# Display stock data
display_stock_data <- function(stock_results) {
  
  for (symbol in names(stock_results)) {
    
    cat("\nStock:", symbol, "\n")
    
    print(head(stock_results[[symbol]]$Data))
    
    cat("\nCalculated Statistics:\n")
    
    print(stock_results[[symbol]]$Statistics)
  }
}

# Plot closing prices and moving average
plot_stock_price <- function(stock_results, symbol) {
  
  df <- stock_results[[symbol]]$Data
  
  ggplot(df, aes(x = Date)) +
    geom_line(aes(y = Close, color = "Closing Price")) +
    geom_line(aes(y = SMA20, color = "20-Day SMA"),
              na.rm = TRUE) +
    scale_color_manual(values = c(
      "Closing Price" = "blue",
      "20-Day SMA" = "red"
    )) +
    labs(
      title = paste(symbol, "Stock Price Analysis"),
      x = "Date",
      y = "Price (USD)",
      color = "Legend"
    ) +
    theme_minimal()
}

# Compare closing prices of all stocks
plot_all_stocks <- function(stock_results) {
  
  combined <- do.call(rbind, lapply(
    names(stock_results), function(symbol) {
      
      df <- stock_results[[symbol]]$Data
      df$Stock <- symbol
      df
    }
  ))
  
  ggplot(combined,
         aes(x = Date, y = Close, color = Stock)) +
    geom_line() +
    labs(
      title = "Stock Closing Price Comparison",
      x = "Date",
      y = "Closing Price (USD)"
    ) +
    theme_minimal()
}

# Display standard deviation comparison
plot_volatility <- function(summary_table) {
  
  ggplot(summary_table,
         aes(x = Stock,
             y = Standard_Deviation,
             fill = Stock)) +
    geom_col() +
    labs(
      title = "Stock Price Variability Comparison",
      x = "Stock",
      y = "Standard Deviation (USD)"
    ) +
    theme_minimal() +
    theme(legend.position = "none")
}
