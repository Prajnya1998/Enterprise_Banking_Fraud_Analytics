# ==========================================================
# Project : Enterprise Banking Fraud Analytics
# Sprint 4 : Exploratory Data Analysis
# Assignment : Fraud Distribution
# Author : Prajnya Paramita Bhol
# ==========================================================

import pandas as pd

# Load Clean Dataset
dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)

print("Clean dataset loaded successfully.")


# FRAUD DISTRIBUTION

print("\n=============== FRAUD DISTRIBUTION ===============")

fraud_distribution = df["is_fraud"].value_counts()

genuine_transactions = fraud_distribution[0]
fraud_transactions = fraud_distribution[1]

print(f" Genuine Transactions : {genuine_transactions:,}")
print(f" Fraud Transactions   : {fraud_transactions:,}")


# ==========================================================
# FRAUD RATE (%)
# ==========================================================

print("\n=============== FRAUD RATE ===============")

# Total Transactions
total_transactions = len(df)

# Fraud Transactions
fraud_transactions = df["is_fraud"].sum()

# Fraud Percentage
fraud_rate = (fraud_transactions / total_transactions) * 100

print(f"Total Transactions : {total_transactions:,}")
print(f"Fraud Transactions : {fraud_transactions:,}")
print(f"Fraud Rate (%)     : {fraud_rate:.2f}%")


# FRAUD BY CATEGORY
print("\n" + "=" * 15 + " FRAUD BY CATEGORY " + "=" * 15)

fraud_by_category = (
    df.groupby("category")["is_fraud"]
      .sum()
      .sort_values(ascending=False)
)

print(fraud_by_category)


# FRAUD BY STATE
print("\n" + "=" * 15 + " FRAUD BY STATE " + "=" * 15)

fraud_by_state = (
    df.groupby("state")["is_fraud"]
      .sum()
      .sort_values(ascending=False)
)

print(fraud_by_state.head(10))



# FRAUD RATE BY CATEGORY

print("\n" + "=" * 15 + " FRAUD RATE BY CATEGORY " + "=" * 15)

fraud_rate_by_category = (
    df.groupby("category")["is_fraud"]
    .mean()
    .sort_values(ascending=False)
    *100
)

print(fraud_rate_by_category.round(2))


