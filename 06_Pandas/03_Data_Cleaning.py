"""
Enterprise Banking Fraud Analytics
Pandas - Step 3: Data Cleaning

Business Purpose:
Clean and validate transaction data before fraud analysis.
"""

import pandas as pd


# ---------------------------------------------------------
# Step 1: Load the raw transaction dataset
# ---------------------------------------------------------

dataset_path = (
    "02_Data/Raw_Data/"
    "credit_card_transactions.csv"
)

df = pd.read_csv(dataset_path)


print("RAW DATASET")
print("===========")

print("Rows    :", df.shape[0])
print("Columns :", df.shape[1])


# ---------------------------------------------------------
# Step 2: Remove unnecessary index column
# ---------------------------------------------------------

if "Unnamed: 0" in df.columns:
    df.drop(
        columns=["Unnamed: 0"],
        inplace=True
    )


# ---------------------------------------------------------
# Step 3: Check duplicate records
# ---------------------------------------------------------

duplicate_count = df.duplicated().sum()

print("\nDUPLICATE CHECK")
print("===============")

print("Duplicate Rows :", duplicate_count)


# ---------------------------------------------------------
# Step 4: Remove duplicate records
# ---------------------------------------------------------

if duplicate_count > 0:
    df.drop_duplicates(
        inplace=True
    )


# ---------------------------------------------------------
# Step 5: Convert transaction date/time
# ---------------------------------------------------------

df["trans_date_trans_time"] = pd.to_datetime(
    df["trans_date_trans_time"],
    errors="coerce"
)


# ---------------------------------------------------------
# Step 6: Check missing values
# ---------------------------------------------------------

missing_values = df.isnull().sum()

print("\nMISSING VALUE CHECK")
print("===================")

missing_columns = missing_values[
    missing_values > 0
]

if missing_columns.empty:
    print("No missing values found.")
else:
    print(missing_columns)


# ---------------------------------------------------------
# Step 7: Validate fraud indicator
# ---------------------------------------------------------

invalid_fraud_values = df[
    ~df["is_fraud"].isin([0, 1])
]

print("\nFRAUD FLAG VALIDATION")
print("=====================")

print(
    "Invalid Fraud Flags :",
    len(invalid_fraud_values)
)


# ---------------------------------------------------------
# Step 8: Validate transaction amounts
# ---------------------------------------------------------

invalid_amounts = df[
    df["amt"] < 0
]

print("\nTRANSACTION AMOUNT VALIDATION")
print("=============================")

print(
    "Negative Amount Records :",
    len(invalid_amounts)
)


# ---------------------------------------------------------
# Step 9: Final dataset summary
# ---------------------------------------------------------

print("\nCLEAN DATASET SUMMARY")
print("=====================")

print("Rows    :", df.shape[0])
print("Columns :", df.shape[1])


# ---------------------------------------------------------
# Step 10: Save cleaned dataset
# ---------------------------------------------------------

output_path = (
    "02_Data/Clean_Data/"
    "credit_card_transactions_clean.csv"
)

df.to_csv(
    output_path,
    index=False
)

print("\n[SUCCESS] Cleaned dataset saved.")
print("Output :", output_path)