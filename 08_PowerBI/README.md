# Enterprise Banking Fraud Analytics — Power BI

## 1. Project Overview

This Power BI component provides an interactive fraud analytics solution for the Enterprise Banking Fraud Analytics project.

The dashboard analyzes banking transaction data to identify fraud patterns across:

- Overall transaction activity
- Fraud vs. genuine transactions
- Transaction categories
- Geographic locations
- Transaction time and trends
- Merchants
- Customer demographics and jobs

The objective is to provide business stakeholders with a clear view of fraud volume, fraud amount, fraud rates, and transaction patterns to support fraud monitoring and investigation.

---

## 2. Source Dataset

Source file:

`02_Data/Clean_Data/credit_card_transactions_clean.csv`

Validated dataset size:

- Total Transactions: 1,296,675
- Fraud Transactions: 7,506
- Genuine Transactions: 1,289,169

---

## 3. Power BI Workflow

The Power BI workflow followed these stages:

1. Data Import
2. Data Cleaning and Transformation
3. Data Modeling
4. DAX Measure Creation
5. KPI Dashboard Development
6. Fraud Analysis Dashboard Development
7. Geographic, Time, Category, Merchant and Customer Analysis
8. Validation and Quality Checks

---

## 4. Data Preparation

The dataset was imported into Power BI using:

`Get Data → Text/CSV → Transform Data`

The Power Query table was renamed to:

`Transactions`

Important transformations included:

- Validating column data types
- Creating `Transaction_Hour`
- Creating `Fraud_Label`
- Reviewing required fields
- Preserving fraud and genuine transactions
- Applying transformations before loading the data model

### Created Columns

#### Transaction_Hour

Extracts the transaction hour from:

`trans_date_trans_time`

The resulting value ranges from 0–23.

#### Fraud_Label

Classifies transactions as:

- `Fraud` when `is_fraud = 1`
- `Genuine` when `is_fraud = 0`

---

## 5. Data Model

The Power BI report uses a simple one-table model.

### Table

`Transactions`

### Relationships

No relationships are required because the report uses a single transaction table.

Important fields include:

- `trans_date_trans_time`
- `amt`
- `is_fraud`
- `Fraud_Label`
- `Transaction_Hour`
- `category`
- `state`
- `city`
- `merchant`
- `job`
- `gender`

---

## 6. DAX Measures

The following measures were created:

- Total Transactions
- Fraud Transactions
- Genuine Transactions
- Fraud Rate
- Total Transaction Amount
- Total Fraud Amount
- Average Transaction Amount
- Average Fraud Amount
- Fraud Transactions by Gender %

The measures are used across the report pages for KPI calculation and fraud analysis.

---

## 7. Validated KPI Results

| KPI | Value |
|---|---:|
| Total Transactions | 1,296,675 |
| Fraud Transactions | 7,506 |
| Genuine Transactions | 1,289,169 |
| Fraud Rate | 0.58% |
| Total Transaction Amount | $91,222,428.90 |
| Total Fraud Amount | $3,988,088.61 |
| Average Transaction Amount | $70.35 |
| Average Fraud Amount | $531.32 |

These values were validated against the Power BI report.

---

## 8. Power BI Report Pages

The completed Power BI report contains six analytical pages.

### Page 1 — KPI Dashboard

Provides executive-level fraud KPIs:

- Total Transactions
- Fraud Transactions
- Genuine Transactions
- Fraud Rate
- Total Transaction Amount
- Total Fraud Amount
- Average Transaction Amount
- Average Fraud Amount

---

### Page 2 — Fraud Analysis Dashboard

Analyzes the difference between fraud and genuine transactions.

Visuals include:

- Fraud vs Genuine Transactions
- Genuine vs Fraud Transaction Amount
- Transaction Amount Distribution

---

### Page 3 — Fraud by Category

Analyzes fraud activity across transaction categories.

Visuals include:

- Fraud Transactions by Category
- Fraud Amount by Category
- Fraud Rate by Category
- Average Transaction Amount by Category
- Average Fraud Amount by Category
- Fraud Transactions by Category — Treemap

---

### Page 4 — Geographic Analysis

Analyzes fraud activity geographically.

Visuals include:

- Fraud Transactions by State
- Top 10 States by Fraud Transactions
- Fraud Amount by State
- Fraud Rate by State
- Top 10 Cities by Fraud Transactions
- Top 10 Cities by Fraud Amount
- Average Fraud Amount by State
- Average Transaction Amount by State

---

### Page 5 — Time Analysis

Analyzes fraud activity across transaction hours and time periods.

Visuals include:

- Fraud Transactions by Hour
- Fraud Rate by Hour
- Fraud Amount by Hour
- Fraud Transactions Over Time
- Fraud Amount Over Time
- Transaction Amount vs Hour — Fraud Detection
- Fraud Transactions by Hour — Trend

The time-series visuals were validated using the detailed transaction date/time field rather than relying only on the Year level of the date hierarchy.

---

### Page 6 — Merchant / Customer Analysis

Analyzes fraud patterns across merchants, jobs and customer gender.

Visuals include:

- Top 10 Merchants by Fraud Transactions
- Top 10 Merchants by Fraud Amount
- Fraud Transactions by Job
- Top 10 Jobs by Fraud Amount
- Fraud Transactions by Gender
- Fraud Transactions by Gender (%)

The gender percentage calculation uses fraud transactions as the denominator across all gender categories.

---

## 9. Dashboard Design

The report was designed with a business-focused dashboard layout.

Key design principles:

- Clear KPI presentation
- Consistent visual formatting
- Logical grouping of related analysis
- Fraud-focused metrics
- Easy comparison between fraud and genuine activity
- Detailed geographic and time analysis
- Merchant and customer-level analysis

Duplicate or unnecessary visuals were reviewed and removed.

---

## 10. Technical Quality Checks

The following quality checks were completed:

- Dataset row count validated
- Fraud transaction count validated
- Genuine transaction count validated
- Fraud rate validated
- Transaction amount totals validated
- Fraud amount totals validated
- Average transaction values validated
- Data types reviewed
- Fraud classification validated
- Transaction hour extraction validated
- Time-series visuals reviewed
- Top 10 geographic analysis reviewed
- Gender percentage calculation validated
- Duplicate visuals removed
- Report pages reviewed for consistency

No fraud records were intentionally filtered out during the Power BI preparation process.

---

## 11. Documentation

Detailed Power BI documentation is available in this folder:

1. `01_Data_Import_and_Modeling.md`
2. `02_Data_Cleaning_and_Transformation.md`
3. `03_Data_Model.md`
4. `04_DAX_Measures.md`
5. `05_Fraud_KPI_Dashboard.md`
6. `06_Fraud_Analysis_Dashboard.md`

---

## 12. Power BI File

Power BI report file:

`Enterprise_Banking_Fraud_Analytics.pbix`

The PBIX file contains the completed data preparation, data model, DAX measures and six-page fraud analytics report.

---

## 13. Project Outcome

The Power BI component converts the cleaned banking transaction dataset into an interactive fraud analytics solution.

The completed report provides business stakeholders with visibility into:

- Fraud volume
- Fraud rate
- Fraud financial impact
- Fraud categories
- Geographic fraud patterns
- Time-based fraud patterns
- Merchant fraud activity
- Customer demographic patterns

This component forms the Power BI reporting layer of the broader Enterprise Banking Fraud Analytics project.
