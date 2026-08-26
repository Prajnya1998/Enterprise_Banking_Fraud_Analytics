"""
Enterprise Banking Fraud Analytics
NumPy - Step 4: Fraud Amount Analysis

Business Purpose:
Use NumPy to analyze transaction amounts specifically
for fraudulent transactions and identify high-value fraud.
"""

import numpy as np
import pandas as pd


# ---------------------------------------------------------
# Step 1: Load cleaned transaction data
# ---------------------------------------------------------

dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)


# ---------------------------------------------------------
# Step 2: Extract fraud transaction amounts
# ---------------------------------------------------------

fraud_amounts = df.loc[
    df["is_fraud"] == 1,
    "amt"
].to_numpy()


# ---------------------------------------------------------
# Step 3: Calculate fraud amount statistics
# ---------------------------------------------------------

total_fraud_transactions = fraud_amounts.size
total_fraud_amount = np.sum(fraud_amounts)
average_fraud_amount = np.mean(fraud_amounts)
median_fraud_amount = np.median(fraud_amounts)
minimum_fraud_amount = np.min(fraud_amounts)
maximum_fraud_amount = np.max(fraud_amounts)


print("FRAUD AMOUNT ANALYSIS")
print("=====================")

print(
    "Fraud Transactions :",
    total_fraud_transactions
)

print(
    "Total Fraud Amount :",
    round(total_fraud_amount, 2)
)

print(
    "Average Fraud Amt  :",
    round(average_fraud_amount, 2)
)

print(
    "Median Fraud Amt   :",
    round(median_fraud_amount, 2)
)

print(
    "Minimum Fraud Amt  :",
    round(minimum_fraud_amount, 2)
)

print(
    "Maximum Fraud Amt  :",
    round(maximum_fraud_amount, 2)
)


# ---------------------------------------------------------
# Step 4: Calculate fraud amount percentiles
# ---------------------------------------------------------

fraud_75th = np.percentile(fraud_amounts, 75)
fraud_90th = np.percentile(fraud_amounts, 90)
fraud_95th = np.percentile(fraud_amounts, 95)
fraud_99th = np.percentile(fraud_amounts, 99)


print("\nFRAUD AMOUNT PERCENTILES")
print("========================")

print("75th Percentile :", round(fraud_75th, 2))
print("90th Percentile :", round(fraud_90th, 2))
print("95th Percentile :", round(fraud_95th, 2))
print("99th Percentile :", round(fraud_99th, 2))


# ---------------------------------------------------------
# Step 5: Identify high-value fraud
# ---------------------------------------------------------

high_value_fraud = fraud_amounts[
    fraud_amounts >= fraud_95th
]


print("\nHIGH-VALUE FRAUD")
print("================")

print(
    "95th Percentile Threshold :",
    round(fraud_95th, 2)
)

print(
    "High-Value Fraud Count    :",
    high_value_fraud.size
)

print(
    "High-Value Fraud Amount   :",
    round(np.sum(high_value_fraud), 2)
)

print(
    "Average High-Value Fraud  :",
    round(np.mean(high_value_fraud), 2)
)

print(
    "Maximum High-Value Fraud  :",
    round(np.max(high_value_fraud), 2)
)