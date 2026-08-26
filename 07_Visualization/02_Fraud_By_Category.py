# ==========================================================
# Project : Enterprise Banking Fraud Analytics
# Sprint 6 : Fraud by Category Visualization
# ==========================================================

import pandas as pd
import matplotlib.pyplot as plt

# Load Clean Dataset
dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)

print("Dataset loaded successfully.")


# FRAUD BY CATEGORY


fraud_by_category = (
    df[df["is_fraud"] == 1]
      .groupby("category")
      .size()
      .sort_values(ascending=False)
      .head(10)
)

print(fraud_by_category)

# ==========================================================
# FRAUD BY CATEGORY
# ==========================================================

fraud_by_category = (
    df[df["is_fraud"] == 1]
      .groupby("category")
      .size()
      .sort_values(ascending=False)
      .head(10)
)


# BAR CHART

plt.figure(figsize=(10,6))

plt.bar(
    fraud_by_category.index,
    fraud_by_category.values
)

plt.title("Top 10 Fraud Categories")

plt.xlabel("Merchant Category")

plt.ylabel("Fraud Transactions")

plt.xticks(rotation=45)

plt.tight_layout()

plt.show()