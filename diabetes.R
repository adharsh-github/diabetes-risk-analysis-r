# ==========================================
# Diabetes Risk Factor Analysis using R
# ==========================================

# This project analyzes key factors influencing diabetes
# and builds a predictive model using logistic regression.

# ------------------------------------------
# Load Libraries
# ------------------------------------------

library(ggplot2)
library(pROC)

# ------------------------------------------
# Load Dataset
# ------------------------------------------

# Dataset should be in the same folder as this script
data <- read.csv("diabetes.csv")

# ------------------------------------------
# Data Cleaning
# ------------------------------------------

# In this dataset, zero values for physiological variables
# like Blood Pressure, BMI, and Glucose are not realistic.
# These are treated as missing values.

data$BloodPressure[data$BloodPressure == 0] <- NA
data$BMI[data$BMI == 0] <- NA
data$Glucose[data$Glucose == 0] <- NA

# Remove missing values (simple approach for this analysis)
data <- na.omit(data)

# ------------------------------------------
# Exploratory Analysis
# ------------------------------------------

# Compare average values between diabetic and non-diabetic groups

# Observation: Diabetic patients show significantly higher glucose levels
aggregate(Glucose ~ Outcome, data, mean)

# Slightly higher blood pressure in diabetic individuals
aggregate(BloodPressure ~ Outcome, data, mean)

# Diabetic patients tend to be older on average
aggregate(Age ~ Outcome, data, mean)

# ------------------------------------------
# Visualization
# ------------------------------------------

# Glucose distribution clearly shifts higher for diabetic patients
ggplot(data, aes(x = Glucose, fill = factor(Outcome))) +
  geom_histogram(binwidth = 10)

# BMI distribution shows higher values in diabetic group
ggplot(data, aes(x = BMI, fill = factor(Outcome))) +
  geom_histogram(binwidth = 2)

# Age distribution indicates increased diabetes risk with age
ggplot(data, aes(x = Age, fill = factor(Outcome))) +
  geom_histogram(binwidth = 5)

# ------------------------------------------
# Correlation Analysis
# ------------------------------------------

# Most variables show weak correlations,
# suggesting independent contributions to diabetes risk
cor(data[, c("Glucose", "BloodPressure", "BMI", "Age")])

# ------------------------------------------
# Statistical Testing
# ------------------------------------------

# T-test confirms that glucose levels differ significantly
# between diabetic and non-diabetic groups
t.test(Glucose ~ Outcome, data = data)

# ------------------------------------------
# Logistic Regression Model
# ------------------------------------------

# Build model to predict probability of diabetes
model <- glm(Outcome ~ Glucose + BMI + Age,
             data = data,
             family = "binomial")

# Model summary shows all variables are statistically significant
summary(model)

# Convert coefficients to odds ratios for interpretation
# Each unit increase in glucose increases odds of diabetes (~3.5%)
# BMI and Age also contribute positively to risk
exp(coef(model))

# ------------------------------------------
# Model Evaluation
# ------------------------------------------

# Generate predicted probabilities
pred <- predict(model, type = "response")

# Classification using threshold = 0.5
pred_class <- ifelse(pred > 0.5, 1, 0)

# Confusion matrix
# Model performs well for non-diabetics but misses some true cases
table(Predicted = pred_class, Actual = data$Outcome)

# Overall accuracy (~77%)
mean(pred_class == data$Outcome)

# ------------------------------------------
# ROC Curve & AUC
# ------------------------------------------

# ROC curve evaluates model's ability to distinguish classes
roc_obj <- roc(data$Outcome, pred)
plot(roc_obj)

# AUC ~0.83 indicates strong discriminative performance
auc(roc_obj)

# ------------------------------------------
# Final Insight
# ------------------------------------------

# The model shows strong ability to distinguish diabetic patients,
# with glucose emerging as the most influential predictor.
# However, moderate sensitivity suggests that threshold tuning
# is necessary for clinical screening applications.
