import pandas as pd
import matplotlib.pyplot as plt

dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)

print("Dataset Loaded Successfully")

fraud_by_state = (
    df[df["is_fraud"] == 1]
      .groupby("state")
      .size()
      .sort_values(ascending=False)
      .head(10)
)

print(fraud_by_state)

plt.figure(figsize=(10,6))

plt.bar(
    fraud_by_state.index,
    fraud_by_state.values
)

plt.title("Top 10 States by Fraud Transactions")

plt.xlabel("State")

plt.ylabel("Fraud Transactions")

plt.tight_layout()

plt.show()