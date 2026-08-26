"""
Enterprise Banking Fraud Analytics
Pandas - Step 5: GroupBy and Aggregation

Business Purpose:
Use Pandas GroupBy and aggregation functions to create
business-level fraud metrics by category, state, merchant,
and transaction hour.
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
# Step 2: Create fraud-only dataset
# ---------------------------------------------------------

fraud_df = df[
    df["is_fraud"] == 1
].copy()


# ---------------------------------------------------------
# Step 3: Fraud transactions by category
# ---------------------------------------------------------

category_analysis = (
    fraud_df
    .groupby("category")
    .agg(
        Fraud_Transactions=("is_fraud", "count"),
        Total_Fraud_Amount=("amt", "sum"),
        Average_Fraud_Amount=("amt", "mean")
    )
    .sort_values(
        "Fraud_Transactions",
        ascending=False
    )
)


print("FRAUD ANALYSIS BY CATEGORY")
print("==========================")

print(
    category_analysis.head(10)
)


# ---------------------------------------------------------
# Step 4: Fraud transactions by state
# ---------------------------------------------------------

state_analysis = (
    fraud_df
    .groupby("state")
    .agg(
        Fraud_Transactions=("is_fraud", "count"),
        Total_Fraud_Amount=("amt", "sum"),
        Average_Fraud_Amount=("amt", "mean")
    )
    .sort_values(
        "Fraud_Transactions",
        ascending=False
    )
)


print("\nFRAUD ANALYSIS BY STATE")
print("=======================")

print(
    state_analysis.head(10)
)


# ---------------------------------------------------------
# Step 5: Fraud transactions by merchant
# ---------------------------------------------------------

merchant_analysis = (
    fraud_df
    .groupby("merchant")
    .agg(
        Fraud_Transactions=("is_fraud", "count"),
        Total_Fraud_Amount=("amt", "sum"),
        Average_Fraud_Amount=("amt", "mean")
    )
    .sort_values(
        "Fraud_Transactions",
        ascending=False
    )
)


print("\nFRAUD ANALYSIS BY MERCHANT")
print("==========================")

print(
    merchant_analysis.head(10)
)


# ---------------------------------------------------------
# Step 6: Create transaction hour
# ---------------------------------------------------------

df["trans_date_trans_time"] = pd.to_datetime(
    df["trans_date_trans_time"],
    errors="coerce"
)

df["Hour"] = (
    df["trans_date_trans_time"]
    .dt.hour
)


# ---------------------------------------------------------
# Step 7: Fraud analysis by transaction hour
# ---------------------------------------------------------

hour_analysis = (
    df[df["is_fraud"] == 1]
    .groupby("Hour")
    .agg(
        Fraud_Transactions=("is_fraud", "count"),
        Total_Fraud_Amount=("amt", "sum"),
        Average_Fraud_Amount=("amt", "mean")
    )
    .sort_values(
        "Fraud_Transactions",
        ascending=False
    )
)


print("\nFRAUD ANALYSIS BY HOUR")
print("======================")

print(
    hour_analysis.head(10)
)


# ---------------------------------------------------------
# Step 8: Overall fraud KPIs using aggregation
# ---------------------------------------------------------

overall_fraud = (
    fraud_df
    .agg(
        Fraud_Transactions=("is_fraud", "count"),
        Total_Fraud_Amount=("amt", "sum"),
        Average_Fraud_Amount=("amt", "mean"),
        Maximum_Fraud_Amount=("amt", "max")
    )
)


print("\nOVERALL FRAUD KPIs")
print("==================")

print(
    overall_fraud
)