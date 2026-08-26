"""
Enterprise Banking Fraud Analytics
Pandas - Step 6: Merge and Join

Business Purpose:
Demonstrate how transaction data can be combined with
additional business reference data using Pandas merge and join operations.
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
# Step 2: Create a small merchant reference dataset
# ---------------------------------------------------------
# Business scenario:
# A bank may maintain a separate reference table containing
# merchant risk classifications.

merchant_reference = pd.DataFrame({
    "category": [
        "grocery_pos",
        "shopping_net",
        "misc_net",
        "shopping_pos",
        "gas_transport"
    ],
    "risk_level": [
        "Medium",
        "High",
        "High",
        "Medium",
        "Medium"
    ]
})


print("MERCHANT RISK REFERENCE")
print("=======================")

print(merchant_reference)


# ---------------------------------------------------------
# Step 3: Merge transaction data with reference data
# ---------------------------------------------------------

merged_df = df.merge(
    merchant_reference,
    on="category",
    how="left"
)


print("\nMERGED DATASET")
print("==============")

print(
    merged_df[
        ["category", "risk_level"]
    ].head(10)
)


# ---------------------------------------------------------
# Step 4: Check risk-level distribution
# ---------------------------------------------------------

risk_distribution = (
    merged_df["risk_level"]
    .value_counts(dropna=False)
)


print("\nRISK LEVEL DISTRIBUTION")
print("=======================")

print(risk_distribution)


# ---------------------------------------------------------
# Step 5: Analyze fraud by risk level
# ---------------------------------------------------------

fraud_risk_analysis = (
    merged_df[
        merged_df["is_fraud"] == 1
    ]
    .groupby("risk_level", dropna=False)
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


print("\nFRAUD ANALYSIS BY RISK LEVEL")
print("============================")

print(fraud_risk_analysis)


# ---------------------------------------------------------
# Step 6: Demonstrate DataFrame Join
# ---------------------------------------------------------

category_summary = (
    df.groupby("category")
    .agg(
        Total_Transactions=("category", "count"),
        Total_Amount=("amt", "sum")
    )
)


category_summary = category_summary.join(
    merchant_reference.set_index("category"),
    how="left"
)


print("\nCATEGORY SUMMARY WITH RISK LEVEL")
print("================================")

print(category_summary)


# ---------------------------------------------------------
# Step 7: Save merged analysis
# ---------------------------------------------------------

output_path = (
    "09_Reports/"
    "Pandas_Merged_Fraud_Analysis.csv"
)

fraud_risk_analysis.to_csv(
    output_path
)


print("\n[SUCCESS] Merged fraud analysis saved.")
print("Output :", output_path)