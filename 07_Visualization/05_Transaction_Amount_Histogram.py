import pandas as pd

import matplotlib.pyplot as plt

dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)


plt.figure(figsize=(10, 6))

plt.hist(
    df["amt"],
    bins=30
)

plt.title("Transaction Amount Distribution")

plt.xlabel("Transaction Amount ($)")

plt.ylabel("Number of Transactions")

plt.grid(axis="y")

plt.tight_layout()

# Save chart
plt.savefig(
    "images/transaction_amount_distribution.png",
    dpi=300,
    bbox_inches="tight"
)

# Display chart
plt.show()