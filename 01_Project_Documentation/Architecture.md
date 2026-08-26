# Enterprise Banking Fraud Analytics Platform

## System Architecture

The project follows an end-to-end analytics architecture that processes credit card transaction data from raw ingestion through validation, analysis, visualization, reporting, and executive dashboard generation.

---

## Data Flow

Raw Dataset
    ↓
Data Loading
    ↓
Data Validation
    ↓
Data Cleaning
    ↓
KPI Calculation
    ↓
Fraud Analysis
    ↓
Visualization
    ↓
Excel Report
    ↓
Executive Dashboard

---

## 1. Data Source

The project uses a large credit card transaction dataset containing approximately 1.3 million transactions.

Key business fields include:

- Transaction date and time
- Credit card number
- Merchant
- Transaction category
- Transaction amount
- Customer information
- Location information
- Transaction number
- Fraud indicator

The complete dataset is maintained locally because of its large file size.

A representative sample dataset is provided in the GitHub repository.

---

## 2. Data Loading

Python Pandas is used to load the transaction dataset.

Main module:

`data_loader.py`

Responsibilities:

- Load the dataset
- Handle file-not-found errors
- Log the loading process
- Return the dataset as a Pandas DataFrame

---

## 3. Data Validation

Main module:

`validation.py`

Responsibilities:

- Validate that the dataset is available
- Check required business columns
- Confirm that the dataset can be processed
- Prevent processing when required data is missing

---

## 4. Data Cleaning

Initial cleaning is performed using:

`02_Data_Cleaning.py`

Key activities include:

- Removing unnecessary columns
- Converting transaction date/time fields
- Preparing the dataset for analysis
- Saving the cleaned dataset

---

## 5. KPI Calculation

Main module:

`kpi_calculator.py`

The application calculates executive-level fraud KPIs including:

- Total Transactions
- Fraud Transactions
- Genuine Transactions
- Fraud Rate
- Average Transaction Amount
- Maximum Transaction Amount
- Total Fraud Amount

---

## 6. Fraud Analysis

Main module:

`fraud_analysis.py`

The project analyzes fraud patterns across multiple business dimensions:

- Fraud by category
- Fraud by state
- Fraud by merchant
- Fraud by transaction hour

This provides insight into high-risk transaction patterns.

---

## 7. Visualization

Main module:

`charts.py`

Python visualization libraries are used to create charts for:

- Fraud by category
- Fraud by state
- Fraud by hour

Generated visualizations are stored in the `images` folder.

---

## 8. Excel Reporting

Main module:

`report_generator.py`

The application generates an Excel report containing executive KPI information.

Supporting module:

`excel_formatter.py`

Responsibilities include:

- Excel formatting
- Header styling
- Borders
- Column sizing
- Worksheet formatting

---

## 9. Executive Dashboard

Main module:

`dashboard.py`

The project generates an executive dashboard containing key fraud indicators and visual analysis.

The dashboard is included in:

`Enterprise_Fraud_Report.xlsx`

---

## 10. Application Controller

Main module:

`main.py`

The main program coordinates the complete workflow:

1. Start application
2. Load dataset
3. Validate dataset
4. Calculate KPIs
5. Perform fraud analysis
6. Generate Excel report
7. Log application status
8. Complete execution

---

## 11. Logging and Error Handling

Main module:

`logger.py`

The application uses Python logging to track:

- Application start
- Dataset loading
- Validation
- Report generation
- Application completion

Error handling is implemented to manage issues such as:

- Missing dataset
- Missing required columns
- Empty dataset
- Excel file access errors
- Unexpected application errors

---

## Technology Stack

- Python
- Pandas
- OpenPyXL
- Matplotlib
- Excel
- GitHub

---

## Project Architecture Summary

The architecture separates the application into reusable modules rather than placing the complete workflow inside a single Python script.

This modular design improves:

- Maintainability
- Reusability
- Error handling
- Testing
- Scalability
- Business reporting
