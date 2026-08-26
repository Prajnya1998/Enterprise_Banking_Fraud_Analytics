# ==========================================================
# Project : Enterprise Banking Fraud Analytics
# Sprint 6 : Fraud Distribution Visualization
# ==========================================================


import pandas as pd
import matplotlib.pyplot as plt


# Load Clean Dataset
dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)

# Count Fraud vs Genuine Transactions
fraud_distribution = df["is_fraud"].value_counts()

print(fraud_distribution)


# BAR CHART

fraud_distribution.index = ["Genuine", "Fraud"]
plt.figure(figsize=(8, 5))
plt.bar(
    fraud_distribution.index,
    fraud_distribution.values
)

plt.title("Fraud vs Genuine Transactions")

plt.xlabel("Transaction Type")

plt.ylabel("Number of Transactions")

plt.show()

