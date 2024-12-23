# Time Series Analysis: Visitors to the US from China

This project analyzes quarterly visitor data from China to the US from 1998 to 2012. The objective is to build and evaluate regression models to understand the long-term trends and seasonal patterns in the data.

---

## Objectives
1. Load and preprocess the visitor dataset.
2. Visualize data trends and perform initial regression analysis.
3. Build seasonal indices to deseasonalize the data.
4. Fit multiple regression models to the deseasonalized data.
5. Reseasonalize predictions and compare model performance.

---

## Dataset Description
The dataset contains:
- **Year**: Year of the observation.
- **Quarter**: Quarter of the year (1 to 4).
- **China Visitors**: Number of visitors from China in thousands.

---

## Analysis Steps

### 1. Data Preprocessing
- Loaded data using `rio::import`.
- Added a sequential time index for analysis.
- Created plots to visualize the relationship between:
  - Visitors and Year
  - Visitors and Quarter
  - Visitors and Time

### 2. Initial Regression Model
- A simple regression model using `time` as the predictor.
- **Result**: R-squared value of 0.2748, indicating moderate explanatory power.

### 3. Seasonal Index and Deseasonalization
- Calculated seasonal indices for each quarter.
- Deseasonalized visitor data to remove seasonal effects.

### 4. Regression Models on Deseasonalized Data
- **Base Model**: Linear regression with `time` as the predictor.
- **Second Order Model**: Added quadratic term (`time^2`).
- **Third Order Model**: Added cubic term (`time^3`).

### 5. Reseasonalized Forecasts
- Predicted values were reseasonalized using seasonal indices.
- Plotted original data and reseasonalized forecasts.

---

## Results

### Model Performance
- **Base Model**: R-squared = 0.2748, Correlation = 0.524236.
- **Second Order Model**: R-squared = 0.3145, Correlation = 0.6045537.
- **Third Order Model**: R-squared = 0.6884, Correlation = 0.8446287.

### Best Model
The **third-order model** provides the best fit, capturing both seasonal patterns and long-term trends.

---

## Tools Used
- **R Libraries**:
  - `rio`: Data import.
  - `car`: Durbin-Watson test for autocorrelation.
  - Base R functions for regression and visualization.

---
