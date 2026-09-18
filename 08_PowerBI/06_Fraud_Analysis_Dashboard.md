# Power BI — Step 6: Fraud Analysis Dashboard

## Business Objective

Analyze fraudulent transactions across categories, geography, time, merchants, and customer-related attributes.

The analysis dashboards provide detailed insights beyond the executive KPI dashboard.

---

# Report Structure

The Power BI report contains exactly 6 pages:

1. KPI Dashboard
2. Fraud Analysis Dashboard
3. Fraud by Category
4. Geographic Analysis
5. Time Analysis
6. Merchant / Customer Analysis

No duplicate report pages were retained.

---

# Page 2 — Fraud Analysis Dashboard

## Dashboard Title

Enterprise Banking Fraud Analytics — Fraud Analysis Dashboard

## Visuals

### Fraud vs Genuine Transactions

- Legend: `Fraud_Label`
- Values: `Total Transactions`

Purpose:

Compare the number of fraudulent and genuine transactions.

---

### Genuine vs Fraud Transaction Amount

- Legend: `Fraud_Label`
- Values: `Total Transaction Amount`

Purpose:

Compare the transaction value associated with genuine and fraudulent transactions.

---

### Transaction Amount Distribution

- X-axis: `amt`
- Y-axis: `Total Transactions`

Purpose:

Understand the distribution of transaction amounts across the dataset.

---

# Page 3 — Fraud by Category

## Dashboard Title

Enterprise Banking Fraud Analytics — Fraud by Category

## Visuals

- Fraud Transactions by Category
- Fraud Amount by Category
- Fraud Rate by Category
- Average Transaction Amount by Category
- Average Fraud Amount by Category
- Fraud Transactions by Category — Treemap

## Business Purpose

This page analyzes fraud patterns across transaction categories.

It helps identify differences in:

- Fraud transaction volume
- Fraud amount
- Fraud rate
- Average transaction value
- Average fraud transaction value

---

# Page 4 — Geographic Analysis

## Dashboard Title

Enterprise Banking Fraud Analytics — Geographic Analysis

## Visuals

- Fraud Transactions by State
- Top 10 States by Fraud Transactions
- Fraud Amount by State
- Fraud Rate by State
- Top 10 Cities by Fraud Transactions
- Top 10 Cities by Fraud Amount
- Average Fraud Amount by State
- Average Transaction Amount by State

## Business Purpose

This page provides geographic analysis of fraudulent transactions.

State- and city-level views allow geographic differences in fraud activity and transaction amounts to be analyzed.

The Top 10 Cities by Fraud Transactions visual was specifically validated as present in the completed report.

---

# Page 5 — Time Analysis

## Dashboard Title

Enterprise Banking Fraud Analytics — Time Analysis

## Visuals

- Fraud Transactions by Hour
- Fraud Rate by Hour
- Fraud Amount by Hour
- Fraud Transactions Over Time
- Fraud Amount Over Time
- Transaction Amount vs Hour — Fraud Detection
- Fraud Transactions by Hour — Trend

## Business Purpose

This page analyzes fraud patterns across transaction hours and over time.

The `Transaction_Hour` field is used for hour-level analysis.

Time-based analysis can help identify periods with higher fraud activity or transaction values.

---

## Time Analysis Quality Check

The completed report contains two "Over Time" visuals that currently show a relatively straight decline between 2019 and 2020.

This should be technically validated before treating the pattern as a meaningful business trend.

The date field and aggregation should be reviewed to confirm that the visualization represents the intended time-level analysis.

---

# Page 6 — Merchant / Customer Analysis

## Dashboard Title

Enterprise Banking Fraud Analytics — Merchant / Customer Analysis

## Visuals

- Top 10 Merchants by Fraud Transactions
- Top 10 Merchants by Fraud Amount
- Fraud Transactions by Job
- Top 10 Jobs by Fraud Amount
- Fraud Transactions by Gender
- Fraud Transactions by Gender (%)

## Business Purpose

This page analyzes fraud activity across merchants and customer-related attributes.

The analysis includes:

- Merchant-level fraud volume
- Merchant-level fraud amount
- Job-level fraud activity
- Job-level fraud amount
- Gender-level fraud activity

---

## Gender Percentage Quality Check

The `Fraud Transactions by Gender (%)` visual appeared unusually close to 100% during dashboard review.

The calculation should be technically validated before using the visual as a percentage-based business insight.

The intended calculation should clearly represent the proportion of fraudulent transactions by gender rather than the percentage of each gender's transactions that happen to be fraud, unless that alternative definition is explicitly intended.

---

# Dashboard Formatting

The completed report pages were reviewed for:

- Visual alignment
- Titles
- Readability
- Background and border consistency
- Chart labels
- Axis readability
- Duplicate visual cleanup

Duplicate visuals were reviewed and removed.

No additional report pages or duplicate visuals are required for the current project.

---

# Power BI Project Status

The Power BI report build is complete.

Completed components:

- Data import
- Power Query transformations
- Data model
- DAX measures
- KPI dashboard
- Fraud analysis
- Category analysis
- Geographic analysis
- Time analysis
- Merchant / customer analysis
- Visual formatting
- Duplicate cleanup

The PBIX file is:

```text
08_PowerBI/Enterprise_Banking_Fraud_Analytics.pbix