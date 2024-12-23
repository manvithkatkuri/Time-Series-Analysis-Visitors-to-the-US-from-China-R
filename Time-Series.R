# Time Series Analysis: Visitors to the US from China

# Load Required Libraries
library(rio)
library(car)

# Clear Workspace
rm(list = ls())

# Load Data
visitors <- rio::import("6304 Module 7 Assignment Data 1.xlsx")

# Add Sequential Time Index
visitors$time <- seq(1:nrow(visitors))
attach(visitors)

# Plot the Data
plot(year, china.visitors, pch = 19, main = "Year vs Visitors")
plot(quarter, china.visitors, pch = 19, main = "Quarter vs Visitors")
plot(time, china.visitors, pch = 19, main = "Time vs Visitors")

# Base Regression Model
visitors.out <- lm(china.visitors ~ time, data = visitors)
summary(visitors.out)

# Plot Data with Regression Line
points(visitors.out$fitted.values, type = "l", lwd = 3, col = "red")
cor(china.visitors, visitors.out$fitted.values)

# Residuals Plot
plot(time, rstandard(visitors.out), pch = 19, type = "o", main = "Base Model, Standardized Residuals")
abline(0, 0, col = "red", lwd = 3)

# Durbin-Watson Test
durbin.out <- car::durbinWatsonTest(visitors.out)
print(durbin.out)

# Seasonal Indices
indices <- data.frame(month = 1:4, average = 0, index = 0)
for (i in 1:4) {
  count <- 0
  for (j in 1:nrow(visitors)) {
    if (i == quarter[j]) {
      indices$average[i] <- indices$average[i] + china.visitors[j]
      count <- count + 1
    }
  }
  indices$average[i] <- indices$average[i] / count
  indices$index[i] <- indices$average[i] / mean(china.visitors)
}

# Deseasonalizing Data
for (i in 1:4) {
  for (j in 1:nrow(visitors)) {
    if (i == quarter[j]) {
      visitors$deseason.china.visitors[j] <- china.visitors[j] / indices$index[i]
    }
  }
}

# Regression Models on Deseasonalized Data
visitors1.out <- lm(deseason.china.visitors ~ time, data = visitors)
visitors2.out <- lm(deseason.china.visitors ~ time + I(time^2), data = visitors)
visitors3.out <- lm(deseason.china.visitors ~ time + I(time^2) + I(time^3), data = visitors)

# Reseasonalizing Data
visitors$deseason.forecast <- visitors3.out$fitted.values
for (i in 1:4) {
  for (j in 1:nrow(visitors)) {
    if (i == quarter[j]) {
      visitors$reseason.forecast[j] <- visitors$deseason.forecast[j] * indices$index[i]
    }
  }
}

# Plot Original Data and Reseasonalized Forecasts
plot(time, china.visitors, type = "o", pch = 19, main = "Original Data and Reseasonalized Forecasts")
points(time, visitors$reseason.forecast, type = "o", pch = 19, col = "red")

# Summary of Models
summary(visitors.out)
summary(visitors1.out)
summary(visitors2.out)
summary(visitors3.out)

# Correlation Analysis
cor1 <- cor(china.visitors, visitors.out$fitted.values)
cor2 <- cor(china.visitors, visitors$reseason.forecast)
print(c(cor1, cor2))
