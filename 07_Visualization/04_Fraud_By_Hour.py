import pandas as pd
import matplotlib.pyplot as plt


dataset_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df = pd.read_csv(dataset_path)


df["trans_date_trans_time"] = pd.to_datetime(
    df["trans_date_trans_time"]
)


df["Hour"] = df["trans_date_trans_time"].dt.hour

fraud_by_hour = (
    df[df["is_fraud"] == 1]
      .groupby("Hour")
      .size()
      .sort_index()
)

print(fraud_by_hour)



plt.figure(figsize=(12,6))
 
plt.bar(
    fraud_by_hour.index,
    fraud_by_hour.values
)

plt.title("Fraud Transactions by Hour")

plt.xlabel("Hour of Day")

plt.ylabel("Fraud Transactions")

plt.xticks(range(24))

plt.grid(axis="y")

plt.tight_layout()

plt.show()


