"""
Enterprise Banking Fraud Analytics
NumPy - Step 2: Array Operations

Business Purpose:
Understand how NumPy arrays can be created, indexed,
sliced, modified, and filtered for transaction analysis.
"""

import numpy as np


# ---------------------------------------------------------
# Step 1: Create transaction amount array
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
# Step 2: Access individual transactions
# ---------------------------------------------------------

print("INDIVIDUAL TRANSACTIONS")
print("=======================")

print("First Transaction :", transaction_amounts[0])
print("Second Transaction:", transaction_amounts[1])
print("Last Transaction  :", transaction_amounts[-1])


# ---------------------------------------------------------
# Step 3: Slice the array
# ---------------------------------------------------------

print("\nARRAY SLICING")
print("=============")

print("First 5 Transactions :", transaction_amounts[:5])
print("Last 5 Transactions  :", transaction_amounts[5:])
print("Transactions 3 to 6  :", transaction_amounts[2:6])


# ---------------------------------------------------------
# Step 4: Perform arithmetic operations
# ---------------------------------------------------------

print("\nARRAY ARITHMETIC")
print("================")

print("Original Amounts :", transaction_amounts)

print("Amounts + $10    :", transaction_amounts + 10)

print("Amounts * 2      :", transaction_amounts * 2)

print("Amounts / 2      :", transaction_amounts / 2)


# ---------------------------------------------------------
# Step 5: Identify transactions above a threshold
# ---------------------------------------------------------

high_value = transaction_amounts > 200

print("\nBOOLEAN FILTER")
print("=============")

print("Above $200 :", high_value)

print(
    "High-Value Transactions :",
    transaction_amounts[high_value]
)


# ---------------------------------------------------------
# Step 6: Identify transactions within a range
# ---------------------------------------------------------

medium_transactions = transaction_amounts[
    (transaction_amounts >= 100) &
    (transaction_amounts <= 500)
]

print("\nTRANSACTIONS BETWEEN $100 AND $500")
print("==================================")

print(medium_transactions)


# ---------------------------------------------------------
# Step 7: Sort transaction amounts
# ---------------------------------------------------------

sorted_amounts = np.sort(transaction_amounts)

print("\nSORTED TRANSACTION AMOUNTS")
print("==========================")

print(sorted_amounts)


# ---------------------------------------------------------
# Step 8: Reverse the sorted array
# ---------------------------------------------------------

descending_amounts = sorted_amounts[::-1]

print("\nTRANSACTIONS — HIGHEST TO LOWEST")
print("================================")

print(descending_amounts)