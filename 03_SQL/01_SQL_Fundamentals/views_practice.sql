-- =========================================================
-- SQL Fundamentals: Views
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Basic View
-- Fraud transactions
-- =========================================================

CREATE OR ALTER VIEW dbo.vw_FraudTransactions
AS
SELECT
    trans_date_trans_time,
    merchant,
    category,
    state,
    city,
    job,
    gender,
    amt,
    is_fraud
FROM dbo.Transactions
WHERE is_fraud = 1;
GO


-- =========================================================
-- 2. Use the Fraud Transactions View
-- =========================================================

SELECT TOP 50
    *
FROM dbo.vw_FraudTransactions
ORDER BY amt DESC;
GO


-- =========================================================
-- 3. Category Fraud Summary View
-- =========================================================

CREATE OR ALTER VIEW dbo.vw_FraudCategorySummary
AS
SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
GROUP BY category;
GO


-- =========================================================
-- 4. Use Category Summary View
-- =========================================================

SELECT
    category,
    Fraud_Transactions,
    Fraud_Amount,
    Average_Fraud_Amount
FROM dbo.vw_FraudCategorySummary
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 5. State Fraud Summary View
-- =========================================================

CREATE OR ALTER VIEW dbo.vw_FraudStateSummary
AS
SELECT
    state,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
GROUP BY state;
GO


-- =========================================================
-- 6. Use State Summary View
-- =========================================================

SELECT TOP 20
    state,
    Fraud_Transactions,
    Fraud_Amount,
    Average_Fraud_Amount
FROM dbo.vw_FraudStateSummary
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 7. Merchant Fraud Summary View
-- =========================================================

CREATE OR ALTER VIEW dbo.vw_FraudMerchantSummary
AS
SELECT
    merchant,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
GROUP BY merchant;
GO


-- =========================================================
-- 8. Top Merchants Using the View
-- =========================================================

SELECT TOP 10
    merchant,
    Fraud_Transactions,
    Fraud_Amount,
    Average_Fraud_Amount
FROM dbo.vw_FraudMerchantSummary
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 9. High-Value Fraud View
-- =========================================================

CREATE OR ALTER VIEW dbo.vw_HighValueFraud
AS
SELECT
    trans_date_trans_time,
    merchant,
    category,
    state,
    city,
    amt
FROM dbo.Transactions
WHERE is_fraud = 1
  AND amt >= 500;
GO


-- =========================================================
-- 10. Use High-Value Fraud View
-- =========================================================

SELECT TOP 100
    *
FROM dbo.vw_HighValueFraud
ORDER BY amt DESC;
GO


-- =========================================================
-- 11. Review Created Views
-- =========================================================

SELECT
    name,
    create_date,
    modify_date
FROM sys.views
WHERE name IN
(
    'vw_FraudTransactions',
    'vw_FraudCategorySummary',
    'vw_FraudStateSummary',
    'vw_FraudMerchantSummary',
    'vw_HighValueFraud'
)
ORDER BY name;
GO


-- =========================================================
-- Fundamentals Completed
-- Views
--
-- Topics Covered:
-- ✓ CREATE OR ALTER VIEW
-- ✓ Fraud Transaction View
-- ✓ Category Summary View
-- ✓ State Summary View
-- ✓ Merchant Summary View
-- ✓ High-Value Fraud View
-- ✓ Querying Views
-- ✓ View Metadata
-- =========================================================