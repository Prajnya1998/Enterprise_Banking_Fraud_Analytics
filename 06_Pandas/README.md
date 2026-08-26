# Pandas — Enterprise Banking Fraud Analytics

## Project Overview

This module applies Pandas to transaction data loading, inspection, cleaning, fraud analysis, aggregation, and dataset merging.

The objective is to demonstrate practical Pandas techniques through a real-world banking fraud analytics scenario.

---

## Business Objective

The bank needs to analyze large volumes of credit card transactions to identify fraudulent activity, understand transaction patterns, and produce useful business metrics.

Pandas is used to transform and analyze the transaction dataset efficiently.

---

## Files

### 01_Pandas_Basics.py

Introduces fundamental Pandas concepts:

- Series
- DataFrame
- Rows and columns
- Column selection
- Basic statistics
- Conditional filtering

### 02_Data_Loading_and_Inspection.py

Covers:

- CSV loading
- Dataset dimensions
- Column inspection
- Data types
- Missing-value checks
- Duplicate checks
- Statistical summaries
- Fraud distribution

### 03_Data_Cleaning.py

Performs:

- Removal of unnecessary columns
- Duplicate detection and removal
- Date/time conversion
- Missing-value validation
- Fraud flag validation
- Transaction amount validation
- Clean dataset export

### 04_Fraud_Data_Analysis.py

Analyzes:

- Fraud transactions
- Fraud rate
- Fraud by category
- Fraud by state
- Fraud by merchant
- Fraud transaction amounts
- High-value fraud
- Fraud by gender

### 05_GroupBy_and_Aggregation.py

Demonstrates:

- GroupBy
- Aggregation
- Count
- Sum
- Mean
- Maximum
- Sorting aggregated results
- Fraud analysis by category
- Fraud analysis by state
- Fraud analysis by merchant
- Fraud analysis by transaction hour

### 06_Merge_and_Join.py

Demonstrates:

- DataFrame merge
- DataFrame join
- Reference data integration
- Risk-level analysis
- Fraud analysis after dataset integration

---

## Dataset

The analysis uses the cleaned credit card transaction dataset:

```text
02_Data/Clean_Data/credit_card_transactions_clean.csv