# Diabetes Risk Factor Analysis using R

## 📌 Overview
This project investigates key clinical factors associated with diabetes and develops a predictive model using logistic regression. The objective is to understand how variables such as glucose, BMI, and age contribute to diabetes risk, and to evaluate the model’s effectiveness in a screening context.

---

## 📊 Dataset
The analysis is based on the Pima Indians Diabetes Dataset, containing clinical measurements including:
- Glucose
- Blood Pressure
- BMI
- Age
- Diabetes Outcome (0 = Non-diabetic, 1 = Diabetic)

---

## ⚙️ Methodology

### Data Preprocessing
- Identified physiologically invalid zero values in Glucose, BMI, and Blood Pressure
- Treated these as missing values and removed incomplete observations

### Exploratory Analysis
- Compared mean values across diabetic and non-diabetic groups
- Visualized feature distributions using histograms

### Statistical Testing
- Conducted Welch’s t-test to evaluate differences in glucose levels between groups

### Predictive Modeling
- Built a logistic regression model using:
  - Glucose
  - BMI
  - Age
- Interpreted model coefficients using odds ratios

### Model Evaluation
- Confusion Matrix
- Accuracy (~77%)
- ROC Curve
- Area Under Curve (AUC ≈ 0.83)

---

## 📈 Key Findings

- Glucose is the strongest predictor of diabetes risk
- BMI and Age contribute as independent risk factors
- Diabetic patients exhibit significantly higher glucose levels (p < 0.001)
- The model demonstrates strong discriminative ability (AUC ≈ 0.83)
- However, sensitivity is moderate (~56%), indicating some diabetic cases are not detected

---

## ⚠️ Limitations

- Missing values were removed rather than imputed, reducing dataset size
- Moderate sensitivity limits effectiveness for clinical screening
- Model performance may improve with additional clinical features

---

## 🧠 Conclusion

This analysis confirms glucose as the dominant factor in diabetes risk prediction, with BMI and age contributing independently. While the model achieves good overall performance, its moderate sensitivity highlights the need for threshold optimization in clinical screening scenarios, where minimizing false negatives is critical.

---

## 🛠️ Tools & Libraries

- R
- ggplot2
- pROC

---

## 🚀 Future Work

- Implement missing data imputation techniques
- Explore advanced models (Random Forest, Gradient Boosting)
- Optimize classification thresholds to improve sensitivity
- Extend analysis with additional clinical variables
