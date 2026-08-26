"""
Enterprise Banking Fraud Analytics
Pandas - Step 4: Fraud Data Analysis

Business Purpose:
Analyze fraudulent transactions using Pandas and
identify important fraud patterns.
"""

import pandas as pd


# ---------------------------------------------------------
# Step 1: Load cleaned transaction data
# ---------------------------------------------------------

dataset_path = (
    "02_Data/Clean_Data/"
    "credit_card_transactions_clean.csv"
)

df = pd.read_csv(dataset_path)


# ---------------------------------------------------------
# Step 2: Separate fraud transactions
# ---------------------------------------------------------

fraud_df = df[
    df["is_fraud"] == 1
].copy()


print("FRAUD DATASET")
print("=============")

print("Total Transactions :", len(df))
print("Fraud Transactions :", len(fraud_df))


# ---------------------------------------------------------
# Step 3: Calculate fraud rate
# ---------------------------------------------------------

fraud_rate = (
    len(fraud_df) / len(df)
) * 100


print("\nFRAUD RATE")
print("==========")

print(
    "Fraud Rate :",
    round(fraud_rate, 2),
    "%"
)


# ---------------------------------------------------------
# Step 4: Analyze fraud by category
# ---------------------------------------------------------

fraud_by_category = (
    fraud_df["category"]
    .value_counts()
)


print("\nTOP FRAUD CATEGORIES")
print("====================")

print(
    fraud_by_category.head(10)
)


# ---------------------------------------------------------
# Step 5: Analyze fraud by state
# ---------------------------------------------------------

fraud_by_state = (
    fraud_df["state"]
    .value_counts()
)


print("\nTOP FRAUD STATES")
print("================")

print(
    fraud_by_state.head(10)
)


# ---------------------------------------------------------
# Step 6: Analyze fraud by merchant
# ---------------------------------------------------------

fraud_by_merchant = (
    fraud_df["merchant"]
    .value_counts()
)


print("\nTOP FRAUD MERCHANTS")
print("===================")

print(
    fraud_by_merchant.head(10)
)


# ---------------------------------------------------------
# Step 7: Analyze fraud transaction amounts
# ---------------------------------------------------------

print("\nFRAUD AMOUNT ANALYSIS")
print("=====================")

print(
    "Average Fraud Amount :",
    round(fraud_df["amt"].mean(), 2)
)

print(
    "Median Fraud Amount  :",
    round(fraud_df["amt"].median(), 2)
)

print(
    "Maximum Fraud Amount :",
    round(fraud_df["amt"].max(), 2)
)

print(
    "Total Fraud Amount   :",
    round(fraud_df["amt"].sum(), 2)
)


# ---------------------------------------------------------
# Step 8: Identify high-value fraud transactions
# ---------------------------------------------------------

high_value_fraud = fraud_df[
    fraud_df["amt"] > 1000
]


print("\nHIGH-VALUE FRAUD")
print("================")

print(
    "Fraud Transactions > $1,000 :",
    len(high_value_fraud)
)


# ---------------------------------------------------------
# Step 9: Analyze fraud by gender
# ---------------------------------------------------------

fraud_by_gender = (
    fraud_df["gender"]
    .value_counts()
)


print("\nFRAUD BY GENDER")
print("===============")

print(
    fraud_by_gender
)