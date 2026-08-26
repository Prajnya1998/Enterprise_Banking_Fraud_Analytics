# Enterprise Banking Fraud Analytics

## Project Overview

Enterprise Banking Fraud Analytics is an end-to-end Python analytics project designed to analyze approximately 1.3 million credit card transactions and identify fraud patterns.

The project demonstrates how Python can be used to build a modular banking fraud analytics application covering:

- Data loading
- Data validation
- KPI calculation
- Fraud analysis
- Visualization
- Excel reporting
- Executive dashboard
- Logging
- Error handling

The project is designed as a practical portfolio project for Data Analyst, Fraud Analytics, Banking Analytics, and Risk Analytics roles.

---

## Business Objective

The objective is to analyze credit card transactions and provide business users with actionable insights into:

- Overall fraud volume
- Fraud rate
- Fraud transaction amount
- High-risk transaction categories
- High-risk states
- High-risk merchants
- Fraud activity by transaction hour

The final output is an Excel-based executive fraud report and dashboard.

---

## Dataset

Dataset:

`credit_card_transactions.csv`

Approximate transaction volume:

**1.3 million transactions**

Key fields include:

- trans_date_trans_time
- cc_num
- merchant
- category
- amt
- city
- state
- zip
- lat
- long
- job
- dob
- trans_num
- unix_time
- merch_lat
- merch_long
- is_fraud
- merch_zipcode

---

### GitHub Dataset Availability

The original dataset contains approximately 1.3 million transactions and is approximately 338 MB in raw form. Due to GitHub file-size limitations, the full raw and cleaned datasets are not included in this repository.

A 10,000-row representative sample is provided for demonstration purposes:

`02_Data/Sample_Data/credit_card_transactions_sample.csv`

The full datasets are maintained locally for analysis and application execution.

## Key Business KPIs

The current analysis produces:

| KPI | Result |
|---|---:|
| Total Transactions | 1,296,675 |
| Genuine Transactions | 1,289,169 |
| Fraud Transactions | 7,506 |
| Fraud Rate | 0.58% |
| Average Transaction Amount | $70.35 |
| Maximum Transaction Amount | $28,948.90 |
| Total Fraud Amount | $3,988,088.61 |

---

## Key Fraud Findings

### Fraud by Category

The highest fraud volumes were observed in:

1. grocery_pos
2. shopping_net
3. misc_net
4. shopping_pos
5. gas_transport

### Fraud by State

The highest fraud counts were observed in:

1. NY
2. TX
3. PA
4. CA
5. OH

### Fraud by Hour

Fraud activity shows a strong concentration during late-night hours.

The highest fraud activity was observed around:

- 22:00
- 23:00

---

## Technology Stack

- Python
- Pandas
- Matplotlib
- OpenPyXL
- VS Code
- Excel
- GitHub

---

## Project Architecture

The application follows a modular Python architecture.

```text
main.py
   |
   +-- data_loader.py
   |
   +-- validation.py
   |
   +-- kpi_calculator.py
   |
   +-- fraud_analysis.py
   |
   +-- charts.py
   |
   +-- report_generator.py
   |
   +-- dashboard.py
   |
   +-- excel_formatter.py
   |
   +-- logger.py