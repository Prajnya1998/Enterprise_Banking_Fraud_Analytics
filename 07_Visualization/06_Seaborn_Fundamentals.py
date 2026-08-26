"""
Enterprise Banking Fraud Analytics
Seaborn - Step 1: Seaborn Fundamentals

Business Purpose:
Create basic statistical visualizations to understand
fraud transaction patterns.
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
# Step 2: Create fraud label
# ---------------------------------------------------------

df["Fraud_Label"] = df["is_fraud"].map({
    0: "Genuine",
    1: "Fraud"
})


# ---------------------------------------------------------
# Step 3: Prepare fraud distribution
# ---------------------------------------------------------

fraud_distribution = (
    df["Fraud_Label"]
    .value_counts()
    .reset_index()
)

fraud_distribution.columns = [
    "Fraud_Label",
    "Transaction_Count"
]


# ---------------------------------------------------------
# Step 4: Create Seaborn bar chart
# ---------------------------------------------------------

plt.figure(figsize=(8, 5))

sns.barplot(
    data=fraud_distribution,
    x="Fraud_Label",
    y="Transaction_Count"
)

plt.title("Genuine vs Fraudulent Transactions")
plt.xlabel("Transaction Type")
plt.ylabel("Transaction Count")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Fraud_Distribution.png",
    dpi=300
)

plt.show()


# ---------------------------------------------------------
# Step 5: Create fraud amount boxplot
# ---------------------------------------------------------

plt.figure(figsize=(8, 5))

sns.boxplot(
    data=df,
    x="Fraud_Label",
    y="amt"
)

plt.title("Transaction Amount Distribution by Fraud Status")
plt.xlabel("Transaction Type")
plt.ylabel("Transaction Amount")

plt.tight_layout()

plt.savefig(
    "images/Seaborn_Fraud_Amount_Boxplot.png",
    dpi=300
)

plt.show()


print("\n[SUCCESS] Seaborn fundamentals completed.")
print("Charts saved to the images folder.")