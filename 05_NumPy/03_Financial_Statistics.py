"""
Enterprise Banking Fraud Analytics
NumPy - Step 3: Financial Statistics

Business Purpose:
Calculate financial statistics from transaction amounts
using NumPy.
"""

import numpy as np
import pandas as pd


# ---------------------------------------------------------
# Step 1: Load the cleaned transaction dataset
# ---------------------------------------------------------

dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)


# ---------------------------------------------------------
# Step 2: Convert transaction amounts to NumPy array
# ---------------------------------------------------------

transaction_amounts = df["amt"].to_numpy()


# ---------------------------------------------------------
# Step 3: Calculate central tendency
# ---------------------------------------------------------

mean_amount = np.mean(transaction_amounts)
median_amount = np.median(transaction_amounts)


print("FINANCIAL STATISTICS")
print("====================")

print("Total Transactions :", transaction_amounts.size)
print("Mean Amount        :", round(mean_amount, 2))
print("Median Amount      :", round(median_amount, 2))


# ---------------------------------------------------------
# Step 4: Calculate transaction variability
# ---------------------------------------------------------

standard_deviation = np.std(transaction_amounts)
variance = np.var(transaction_amounts)

print("\nTRANSACTION VARIABILITY")
print("=======================")

print("Standard Deviation :", round(standard_deviation, 2))
print("Variance           :", round(variance, 2))


# ---------------------------------------------------------
# Step 5: Calculate percentiles
# ---------------------------------------------------------

percentile_25 = np.percentile(transaction_amounts, 25)
percentile_50 = np.percentile(transaction_amounts, 50)
percentile_75 = np.percentile(transaction_amounts, 75)
percentile_90 = np.percentile(transaction_amounts, 90)
percentile_95 = np.percentile(transaction_amounts, 95)
percentile_99 = np.percentile(transaction_amounts, 99)


print("\nTRANSACTION AMOUNT PERCENTILES")
print("==============================")

print("25th Percentile :", round(percentile_25, 2))
print("50th Percentile :", round(percentile_50, 2))
print("75th Percentile :", round(percentile_75, 2))
print("90th Percentile :", round(percentile_90, 2))
print("95th Percentile :", round(percentile_95, 2))
print("99th Percentile :", round(percentile_99, 2))


# ---------------------------------------------------------
# Step 6: Identify high-value transactions
# ---------------------------------------------------------

high_value_threshold = percentile_95

high_value_transactions = transaction_amounts[
    transaction_amounts >= high_value_threshold
]


print("\nHIGH-VALUE TRANSACTIONS")
print("=======================")

print(
    "95th Percentile Threshold :",
    round(high_value_threshold, 2)
)

print(
    "High-Value Transactions   :",
    high_value_transactions.size
)

print(
    "Average High-Value Amount :",
    round(np.mean(high_value_transactions), 2)
)

print(
    "Maximum High-Value Amount :",
    round(np.max(high_value_transactions), 2)
)