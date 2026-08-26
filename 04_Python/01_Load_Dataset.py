# ===========================================================
# Project : Enterprise banking Fraud Analytics
# Sprint 2 : Load Dataset
# Author : Prajnya Paramita Bhol
# ===========================================================

# Import Required Libraries
import pandas as pd

# Dataset Location
dataset_path = "02_Data/Raw_Data/credit_card_transactions.csv"

# Read Dataset
df = pd.read_csv(dataset_path)

# Display First Five Records
print(df.head())


# FIRST 5 RECORDS
print("\n=============== FIRST 5 RECORDS ===============")
print(df.head())

# Dataset Shape
print("\n" + "=" * 15 + " DATASET SHAPE " + "=" * 15)
print(df.shape)


# Column Names
print("\n" + "=" * 15 + " COLUMN NAMES " + "=" * 15)
for column in df.columns:
    print(column)

# Data Types
print("\n" + "=" * 15 + " DATA TYPES " + "=" * 15)
print(df.dtypes)


# MISSING VALUES
print("\n=============== MISSING VALUES =============")
print(df.isnull().sum())


# DUPLICATE RECORDS
print("\n=============== DUPLICATE RECORDS ===============")
duplicate_count = df.duplicated().sum()
print("Total Duplicate Records :", duplicate_count)


# STATISTICAL SUMMARY
print("\n" + "=" * 15 + "STATISTICAL SUMMARY" + "=" * 15)
print(df.describe())


# UNIQUE VALUES
print("\n" + "=" * 15 + "UNIQUE VALUES" + "=" * 15)

print("Unique Merchants :", df["merchant"].nunique())
print("Unique Categories :", df["category"].nunique())
print("Unique Cities :", df["city"].nunique())
print("Unique States :", df["state"].nunique())
print("Unique Genders :", df["gender"].nunique())

