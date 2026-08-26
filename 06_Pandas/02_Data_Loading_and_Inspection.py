"""
Enterprise Banking Fraud Analytics
Pandas - Step 2: Data Loading and Inspection

Business Purpose:
Load the cleaned fraud transaction dataset and inspect
its structure, data types, missing values, and duplicates.
"""

import pandas as pd


# ---------------------------------------------------------
# Step 1: Define dataset path
# ---------------------------------------------------------

dataset_path = (
    "02_Data/Clean_Data/"
    "credit_card_transactions_clean.csv"
)


# ---------------------------------------------------------
# Step 2: Load the dataset
# ---------------------------------------------------------

df = pd.read_csv(dataset_path)


print("DATASET LOADED SUCCESSFULLY")
print("==========================")

print("Total Rows    :", df.shape[0])
print("Total Columns :", df.shape[1])


# ---------------------------------------------------------
# Step 3: Display first records
# ---------------------------------------------------------

print("\nFIRST 5 RECORDS")
print("===============")

print(df.head())


# ---------------------------------------------------------
# Step 4: Display column names
# ---------------------------------------------------------

print("\nCOLUMN NAMES")
print("============")

for column in df.columns:
    print(column)


# ---------------------------------------------------------
# Step 5: Check data types
# ---------------------------------------------------------

print("\nDATA TYPES")
print("==========")

print(df.dtypes)


# ---------------------------------------------------------
# Step 6: Check missing values
# ---------------------------------------------------------

missing_values = df.isnull().sum()

print("\nMISSING VALUES")
print("==============")

print(missing_values[missing_values > 0])


# ---------------------------------------------------------
# Step 7: Check duplicate records
# ---------------------------------------------------------

duplicate_count = df.duplicated().sum()

print("\nDUPLICATE RECORDS")
print("=================")

print("Duplicate Rows :", duplicate_count)


# ---------------------------------------------------------
# Step 8: Basic statistical summary
# ---------------------------------------------------------

print("\nNUMERICAL SUMMARY")
print("=================")

print(df.describe())


# ---------------------------------------------------------
# Step 9: Check fraud distribution
# ---------------------------------------------------------

fraud_distribution = df["is_fraud"].value_counts()

print("\nFRAUD DISTRIBUTION")
print("==================")

print(fraud_distribution)