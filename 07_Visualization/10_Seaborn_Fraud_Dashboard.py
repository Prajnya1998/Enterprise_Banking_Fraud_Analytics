"""
Enterprise Banking Fraud Analytics
Seaborn - Step 5: Seaborn Fraud Dashboard

Business Purpose:
Create a consolidated fraud analytics visualization
using multiple Seaborn charts.
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
# Step 2: Prepare transaction date/time
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
# Step 3: Create fraud label
# ---------------------------------------------------------

df["Fraud_Label"] = df["is_fraud"].map({
    0: "Genuine",
    1: "Fraud"
})


# ---------------------------------------------------------
# Step 4: Create fraud-only dataset
# ---------------------------------------------------------

fraud_df = df[
    df["is_fraud"] == 1
].copy()


# ---------------------------------------------------------
# Step 5: Fraud by category
# ---------------------------------------------------------

category_data = (
    fraud_df["category"]
    .value_counts()
    .head(10)
    .reset_index()
)

category_data.columns = [
    "category",
    "Fraud_Count"
]


plt.figure(figsize=(12, 6))

sns.barplot(
    data=category_data,
    x="Fraud_Count",
    y="category"
)

plt.title("Top 10 Fraud Categories")
plt.xlabel("Fraud Transactions")
plt.ylabel("Category")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Dashboard_Fraud_Category.png",
    dpi=300
)

plt.show()


# ---------------------------------------------------------
# Step 6: Fraud by hour
# ---------------------------------------------------------

hour_data = (
    fraud_df["Hour"]
    .value_counts()
    .sort_index()
    .reset_index()
)

hour_data.columns = [
    "Hour",
    "Fraud_Count"
]


plt.figure(figsize=(12, 6))

sns.lineplot(
    data=hour_data,
    x="Hour",
    y="Fraud_Count",
    marker="o"
)

plt.title("Fraud Transactions by Hour")
plt.xlabel("Transaction Hour")
plt.ylabel("Fraud Transactions")

plt.xticks(range(24))

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Dashboard_Fraud_By_Hour.png",
    dpi=300
)

plt.show()


# ---------------------------------------------------------
# Step 7: Fraud amount distribution
# ---------------------------------------------------------

amount_limit = df["amt"].quantile(0.99)

amount_data = df[
    df["amt"] <= amount_limit
].copy()


plt.figure(figsize=(12, 6))

sns.histplot(
    data=amount_data,
    x="amt",
    hue="Fraud_Label",
    bins=40,
    kde=True
)

plt.title("Transaction Amount Distribution")
plt.xlabel("Transaction Amount")
plt.ylabel("Transaction Count")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Dashboard_Amount_Distribution.png",
    dpi=300
)

plt.show()


# ---------------------------------------------------------
# Step 8: Fraud by state
# ---------------------------------------------------------

state_data = (
    fraud_df["state"]
    .value_counts()
    .head(10)
    .reset_index()
)

state_data.columns = [
    "state",
    "Fraud_Count"
]


plt.figure(figsize=(12, 6))

sns.barplot(
    data=state_data,
    x="Fraud_Count",
    y="state"
)

plt.title("Top 10 States by Fraud Transactions")
plt.xlabel("Fraud Transactions")
plt.ylabel("State")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Dashboard_Fraud_By_State.png",
    dpi=300
)

plt.show()


print("\n[SUCCESS] Seaborn fraud dashboard analysis completed.")

print("\nGenerated visualizations:")

print(
    "1. images/Seaborn_Dashboard_Fraud_Category.png"
)

print(
    "2. images/Seaborn_Dashboard_Fraud_By_Hour.png"
)

print(
    "3. images/Seaborn_Dashboard_Amount_Distribution.png"
)

print(
    "4. images/Seaborn_Dashboard_Fraud_By_State.png"
)