
# BDA400 Assignment 2
# Technical Analysis using R - Preliminary Stage
# Main execution script

library(quantmod)
library(TTR)
library(ggplot2)

# Load utility functions
source("load_stock_data.R")
source("calculate_statistics.R")
source("display_data.R")

# Import stock data
stock_data <- load_stock_data()

# Calculate statistics
stock_results <- calculate_all_statistics(stock_data)

# Create summary table
summary_table <- do.call(
  rbind,
  lapply(stock_results, function(x) x$Statistics)
)

summary_table$Stock <- rownames(summary_table)

summary_table <- summary_table[, c(
  "Stock",
  "Mean",
  "Mode",
  "Median",
  "Standard_Deviation",
  "Latest_SMA20"
)]

rownames(summary_table) <- NULL

# Display stock data and statistics
display_stock_data(stock_results)

print(summary_table)

# Export statistics
write.csv(summary_table,
          "stock_statistics.csv",
          row.names = FALSE)

# Generate individual stock charts
for (symbol in names(stock_results)) {
  ggsave(
    filename = paste0(symbol, "_Price_Analysis.png"),
    plot = plot_stock_price(stock_results, symbol),
    width = 10,
    height = 6,
    dpi = 300
  )
}

# Generate comparison charts
ggsave(
  "Stock_Comparison.png",
  plot = plot_all_stocks(stock_results),
  width = 10,
  height = 6,
  dpi = 300
)

ggsave(
  "Stock_Volatility.png",
  plot = plot_volatility(summary_table),
  width = 10,
  height = 6,
  dpi = 300
)

print(plot_all_stocks(stock_results))

cat("\nTechnical analysis completed successfully!\n")
