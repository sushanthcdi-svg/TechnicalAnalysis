
# BDA400 Assignment 2
# Required packages installation

install.packages(c("quantmod", "TTR", "ggplot2", "xts", "zoo"))

library(quantmod)
library(TTR)
library(ggplot2)
library(xts)
library(zoo)

# Verify package installation

packages <- c("quantmod", "TTR", "ggplot2", "xts", "zoo")

data.frame(
  Package = packages,
  Installed = packages %in% rownames(installed.packages())
)
