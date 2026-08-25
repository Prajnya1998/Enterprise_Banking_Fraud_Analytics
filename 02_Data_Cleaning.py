# ==========================================================
# Project : Enterprise Banking Fraud Analytics
# Sprint 3 : Data Cleaning
# Author : Prajnya Paramita Bhol
# ==========================================================

# Import Library
import pandas as pd

# Load Dataset
dataset_path = "02_Data/Raw_Data/credit_card_transactions.csv"

df = pd.read_csv(dataset_path)

print("Dataset Loaded Successfully")


# REMOVE UNNECESSARY COLUMN
# Remove 'Unnamed: 0' column if it exists
if "Unnamed: 0" in df.columns:
    df.drop(columns=["Unnamed: 0"], inplace=True)
    print("Column 'Unnamed: 0' removed successfully.")
else:
    print("Column 'Unnamed: 0' not found.")


# CONVERT DATE COLUMN

print("\n=============== DATE CONVERSION ===============")

df["trans_date_trans_time"] = pd.to_datetime(df["trans_date_trans_time"])

print("Date column converted successfully.")


# ==========================================================
# SAVE CLEAN DATASET
# ==========================================================

clean_file_path = "02_Data/Clean_Data/credit_card_transactions_clean.csv"

df.to_csv(clean_file_path, index=False)

print("\nClean dataset saved successfully.")
print("Location :", clean_file_path)