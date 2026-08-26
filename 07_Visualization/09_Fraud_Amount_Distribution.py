"""
Enterprise Banking Fraud Analytics
Seaborn - Step 4: Fraud Amount Distribution

Business Purpose:
Analyze how transaction amounts are distributed between
genuine and fraudulent transactions.
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
# Step 2: Create fraud labels
# ---------------------------------------------------------

df["Fraud_Label"] = df["is_fraud"].map({
    0: "Genuine",
    1: "Fraud"
})


# ---------------------------------------------------------
# Step 3: Limit extreme values for visualization
# ---------------------------------------------------------
# Business purpose:
# Extremely large transactions can compress the chart
# and make normal transaction patterns difficult to see.

amount_limit = df["amt"].quantile(0.99)

plot_df = df[
    df["amt"] <= amount_limit
].copy()


# ---------------------------------------------------------
# Step 4: Create distribution plot
# ---------------------------------------------------------

plt.figure(figsize=(12, 6))

sns.histplot(
    data=plot_df,
    x="amt",
    hue="Fraud_Label",
    bins=50,
    kde=True,
    element="step"
)

plt.title(
    "Transaction Amount Distribution by Fraud Status"
)

plt.xlabel("Transaction Amount")
plt.ylabel("Transaction Count")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Fraud_Amount_Distribution.png",
    dpi=300
)

plt.show()


# ---------------------------------------------------------
# Step 5: Create boxplot
# ---------------------------------------------------------

plt.figure(figsize=(8, 6))

sns.boxplot(
    data=plot_df,
    x="Fraud_Label",
    y="amt"
)

plt.title(
    "Transaction Amount Comparison: Genuine vs Fraud"
)

plt.xlabel("Transaction Type")
plt.ylabel("Transaction Amount")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Fraud_Amount_Comparison.png",
    dpi=300
)

plt.show()


print("\n[SUCCESS] Fraud amount distribution analysis completed.")

print(
    "Output 1: images/Seaborn_Fraud_Amount_Distribution.png"
)

print(
    "Output 2: images/Seaborn_Fraud_Amount_Comparison.png"
)