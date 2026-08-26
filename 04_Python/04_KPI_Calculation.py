# ==========================================================
# Project : Enterprise Banking Fraud Analytics
# Sprint 5 : KPI Calculation
# ==========================================================

import pandas as pd

# Load Clean Dataset
dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)

print("Clean dataset loaded successfully.")


# EXECUTIVE KPIs

print("\n=============== EXECUTIVE KPI DASHBOARD ===============")

# Total Transactions
total_transactions = len(df)

# Fraud Transactions
fraud_transactions = df["is_fraud"].sum()

# Genuine Transactions
genuine_transactions = total_transactions - fraud_transactions

# Fraud Rate
fraud_rate = (fraud_transactions / total_transactions) * 100

# Average Transaction Amount
average_amount = df["amt"].mean()

# Maximum Transaction Amount
maximum_amount = df["amt"].max()

print(f"Total Transactions      : {total_transactions:,}")
print(f"Genuine Transactions    : {genuine_transactions:,}")
print(f"Fraud Transactions      : {fraud_transactions:,}")
print(f"Fraud Rate (%)          : {fraud_rate:.2f}%")
print(f"Average Amount ($)      : {average_amount:.2f}")
print(f"Maximum Amount ($)      : {maximum_amount:.2f}")


# TOP 10 FRAUD MERCHANTS

print("\n" + "=" * 15 + " TOP 10 FRAUD MERCHANTS " + "=" * 15)

top_merchants = (
    df[df["is_fraud"] == 1]
      .groupby("merchant")
      .size()
      .sort_values(ascending=False)
      .head(10)
)

print(top_merchants)


# TOP 10 MERCHANTS BY FRAUD RATE
print("\n" + "=" * 15 + " TOP 10 MERCHANTS BY FRAUD RATE " + "=" * 15)
merchant_summary = (
    df.groupby("merchant")
      .agg(
          Total_Transactions=("merchant", "count"),
          Fraud_Transactions=("is_fraud","sum")
      )
)

merchant_summary["Fraud_Rate"] = (
    merchant_summary["Fraud_Transactions"]
    / merchant_summary["Total_Transactions"]
) * 100

top_fraud_rate = (
    merchant_summary
        .sort_values(by="Fraud_Rate", ascending=False)
        .head(10)
)

print(top_fraud_rate)
