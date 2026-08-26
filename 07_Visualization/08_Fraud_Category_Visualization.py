"""
Enterprise Banking Fraud Analytics
Seaborn - Step 3: Fraud Category Visualization

Business Purpose:
Compare fraudulent transaction volume and amount
across merchant categories.
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
# Step 2: Create fraud-only dataset
# ---------------------------------------------------------

fraud_df = df[
    df["is_fraud"] == 1
].copy()


# ---------------------------------------------------------
# Step 3: Calculate fraud by category
# ---------------------------------------------------------

category_summary = (
    fraud_df
    .groupby("category")
    .agg(
        Fraud_Transactions=("is_fraud", "count"),
        Total_Fraud_Amount=("amt", "sum")
    )
    .reset_index()
)


# ---------------------------------------------------------
# Step 4: Sort categories by fraud transactions
# ---------------------------------------------------------

category_summary = category_summary.sort_values(
    "Fraud_Transactions",
    ascending=False
)


# ---------------------------------------------------------
# Step 5: Select top 10 categories
# ---------------------------------------------------------

top_categories = category_summary.head(10)


# ---------------------------------------------------------
# Step 6: Create fraud transaction count chart
# ---------------------------------------------------------

plt.figure(figsize=(12, 6))

sns.barplot(
    data=top_categories,
    x="Fraud_Transactions",
    y="category"
)

plt.title(
    "Top Fraud Categories by Transaction Count"
)

plt.xlabel("Fraud Transaction Count")
plt.ylabel("Transaction Category")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Fraud_Category_Count.png",
    dpi=300
)

plt.show()


# ---------------------------------------------------------
# Step 7: Create total fraud amount chart
# ---------------------------------------------------------

amount_sorted = category_summary.sort_values(
    "Total_Fraud_Amount",
    ascending=False
).head(10)


plt.figure(figsize=(12, 6))

sns.barplot(
    data=amount_sorted,
    x="Total_Fraud_Amount",
    y="category"
)

plt.title(
    "Top Fraud Categories by Total Fraud Amount"
)

plt.xlabel("Total Fraud Amount")
plt.ylabel("Transaction Category")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Fraud_Category_Amount.png",
    dpi=300
)

plt.show()


print("\n[SUCCESS] Fraud category visualizations created.")

print(
    "Output 1: images/Seaborn_Fraud_Category_Count.png"
)

print(
    "Output 2: images/Seaborn_Fraud_Category_Amount.png"
)