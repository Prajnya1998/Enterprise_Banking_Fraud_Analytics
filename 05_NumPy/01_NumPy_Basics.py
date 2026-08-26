"""
Enterprise Banking Fraud Analytics
NumPy - Step 1: NumPy Basics

Business Purpose:
Understand how NumPy arrays can be used to store
and analyze transaction amounts efficiently.
"""

import numpy as np


# ---------------------------------------------------------
# Step 1: Create a NumPy array
# ---------------------------------------------------------

transaction_amounts = np.array([
    25.50,
    100.00,
    75.25,
    250.00,
    500.75,
    45.00,
    120.50,
    80.25,
    150.00,
    1000.00
])


# ---------------------------------------------------------
# Step 2: Display transaction amounts
# ---------------------------------------------------------

print("TRANSACTION AMOUNTS")
print("===================")

print(transaction_amounts)


# ---------------------------------------------------------
# Step 3: Understand the NumPy array
# ---------------------------------------------------------

print("\nARRAY INFORMATION")
print("=================")

print("Number of Transactions :", transaction_amounts.size)
print("Number of Dimensions   :", transaction_amounts.ndim)
print("Array Shape            :", transaction_amounts.shape)
print("Data Type              :", transaction_amounts.dtype)


# ---------------------------------------------------------
# Step 4: Basic transaction statistics
# ---------------------------------------------------------

print("\nTRANSACTION STATISTICS")
print("======================")

print("Minimum Amount          :", np.min(transaction_amounts))
print("Maximum Amount          :", np.max(transaction_amounts))
print("Average Amount          :", np.mean(transaction_amounts))
print("Total Transaction Value :", np.sum(transaction_amounts))


# ---------------------------------------------------------
# Step 5: Identify high-value transactions
# ---------------------------------------------------------

high_value_transactions = transaction_amounts[
    transaction_amounts > 200
]


print("\nHIGH-VALUE TRANSACTIONS")
print("=======================")

print("Transactions above $200 :", high_value_transactions)

print(
    "High-Value Count        :",
    high_value_transactions.size
)