"""
Enterprise Banking Fraud Analytics
Pandas - Step 1: Pandas Basics

Business Purpose:
Understand Pandas Series and DataFrames and perform
basic operations on transaction data.
"""

import pandas as pd


# ---------------------------------------------------------
# Step 1: Create a Pandas Series
# ---------------------------------------------------------

transaction_amounts = pd.Series([
    25.50,
    100.00,
    75.25,
    250.00,
    500.75
])


print("TRANSACTION AMOUNT SERIES")
print("=========================")

print(transaction_amounts)


# ---------------------------------------------------------
# Step 2: Create a Pandas DataFrame
# ---------------------------------------------------------

transactions = pd.DataFrame({
    "transaction_id": [1001, 1002, 1003, 1004, 1005],
    "amount": [25.50, 100.00, 75.25, 250.00, 500.75],
    "is_fraud": [0, 0, 1, 0, 1]
})


print("\nTRANSACTION DATAFRAME")
print("=====================")

print(transactions)


# ---------------------------------------------------------
# Step 3: Inspect DataFrame
# ---------------------------------------------------------

print("\nDATAFRAME INFORMATION")
print("=====================")

print("Rows    :", transactions.shape[0])
print("Columns :", transactions.shape[1])

print("\nColumn Names:")
print(transactions.columns.tolist())


# ---------------------------------------------------------
# Step 4: Access individual columns
# ---------------------------------------------------------

print("\nAMOUNT COLUMN")
print("=============")

print(transactions["amount"])


print("\nFRAUD COLUMN")
print("============")

print(transactions["is_fraud"])


# ---------------------------------------------------------
# Step 5: Calculate basic statistics
# ---------------------------------------------------------

print("\nTRANSACTION STATISTICS")
print("======================")

print(
    "Average Amount :",
    transactions["amount"].mean()
)

print(
    "Maximum Amount :",
    transactions["amount"].max()
)

print(
    "Minimum Amount :",
    transactions["amount"].min()
)

print(
    "Total Amount   :",
    transactions["amount"].sum()
)


# ---------------------------------------------------------
# Step 6: Filter fraudulent transactions
# ---------------------------------------------------------

fraud_transactions = transactions[
    transactions["is_fraud"] == 1
]


print("\nFRAUDULENT TRANSACTIONS")
print("=======================")

print(fraud_transactions)


# ---------------------------------------------------------
# Step 7: Count fraud transactions
# ---------------------------------------------------------

fraud_count = (
    transactions["is_fraud"] == 1
).sum()


print("\nFRAUD COUNT")
print("===========")

print("Fraud Transactions :", fraud_count)