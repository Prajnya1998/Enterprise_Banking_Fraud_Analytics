"""
Enterprise Banking Fraud Analytics
Seaborn - Step 2: Fraud Heatmap

Business Purpose:
Identify fraud concentration across transaction
hours and merchant categories.
"""

import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


# ---------------------------------------------------------
# Step 1: Load cleaned transaction data
# ---------------------------------------------------------

dataset_path = (
    "02_Data/Clean_Data/"
    "credit_card_transactions_clean.csv"
)

df = pd.read_csv(dataset_path)


# ---------------------------------------------------------
# Step 2: Convert transaction date/time
# ---------------------------------------------------------

df["trans_date_trans_time"] = pd.to_datetime(
    df["trans_date_trans_time"],
    errors="coerce"
)


# ---------------------------------------------------------
# Step 3: Extract transaction hour
# ---------------------------------------------------------

df["Hour"] = (
    df["trans_date_trans_time"]
    .dt.hour
)


# ---------------------------------------------------------
# Step 4: Create fraud-only dataset
# ---------------------------------------------------------

fraud_df = df[
    df["is_fraud"] == 1
]


# ---------------------------------------------------------
# Step 5: Create hour/category fraud matrix
# ---------------------------------------------------------

fraud_heatmap = pd.crosstab(
    fraud_df["Hour"],
    fraud_df["category"]
)


# ---------------------------------------------------------
# Step 6: Create heatmap
# ---------------------------------------------------------

plt.figure(figsize=(14, 8))

sns.heatmap(
    fraud_heatmap,
    annot=False,
    cmap="YlOrRd"
)

plt.title(
    "Fraud Transactions by Hour and Category"
)

plt.xlabel("Transaction Category")
plt.ylabel("Transaction Hour")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Fraud_Heatmap.png",
    dpi=300
)

plt.show()


print("\n[SUCCESS] Fraud heatmap created.")
print("Output: images/Seaborn_Fraud_Heatmap.png")