-- =========================================================
-- Project 22: Temporary Tables
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Create a Local Temporary Table
-- =========================================================

CREATE TABLE #FraudTransactions
(
    trans_date_trans_time DATETIME,
    cc_num BIGINT,
    category VARCHAR(100),
    state VARCHAR(50),
    amt DECIMAL(18,2),
    is_fraud INT
);
GO

-- =========================================================
-- 2. Insert Fraud Transactions
-- =========================================================

INSERT INTO #FraudTransactions
(
    trans_date_trans_time,
    cc_num,
    category,
    state,
    amt,
    is_fraud
)
SELECT
    trans_date_trans_time,
    cc_num,
    category,
    state,
    amt,
    is_fraud
FROM Transactions
WHERE is_fraud = 1;
GO

-- =========================================================
-- 3. View Temporary Table Data
-- =========================================================

SELECT *
FROM #FraudTransactions;
GO

-- =========================================================
-- 4. Fraud Summary by Category
-- =========================================================

SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM #FraudTransactions
GROUP BY category
ORDER BY Fraud_Transactions DESC;
GO

-- =========================================================
-- 5. Fraud Summary by State
-- =========================================================

SELECT
    state,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM #FraudTransactions
GROUP BY state
ORDER BY Fraud_Amount DESC;
GO

-- =========================================================
-- 6. High-Value Fraud Transactions
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    category,
    state,
    amt
FROM #FraudTransactions
WHERE amt >= 500
ORDER BY amt DESC;
GO

-- =========================================================
-- 7. Create an Aggregated Temporary Table
-- =========================================================

CREATE TABLE #CategoryFraudSummary
(
    category VARCHAR(100),
    fraud_transactions INT,
    fraud_amount DECIMAL(18,2),
    average_fraud_amount DECIMAL(18,2)
);
GO

INSERT INTO #CategoryFraudSummary
(
    category,
    fraud_transactions,
    fraud_amount,
    average_fraud_amount
)
SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM #FraudTransactions
GROUP BY category;
GO

SELECT *
FROM #CategoryFraudSummary
ORDER BY fraud_amount DESC;
GO

-- =========================================================
-- 8. Cleanup Temporary Tables
-- =========================================================

DROP TABLE #CategoryFraudSummary;
DROP TABLE #FraudTransactions;
GO

-- =========================================================
-- Project 22 Completed
-- Temporary Tables
--
-- Topics Covered:
-- ✓ CREATE TABLE #
-- ✓ INSERT INTO #
-- ✓ Temporary Data Analysis
-- ✓ Aggregation
-- ✓ GROUP BY
-- ✓ Temporary Table Cleanup
-- =========================================================