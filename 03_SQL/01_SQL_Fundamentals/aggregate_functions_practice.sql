-- =========================================================
-- SQL Fundamentals: Aggregate Functions
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. COUNT()
-- Total number of transactions
-- =========================================================

SELECT
    COUNT(*) AS Total_Transactions
FROM Transactions;
GO


-- =========================================================
-- 2. COUNT() for Fraud Transactions
-- =========================================================

SELECT
    COUNT(*) AS Fraud_Transactions
FROM Transactions
WHERE is_fraud = 1;
GO


-- =========================================================
-- 3. SUM()
-- Total transaction amount
-- =========================================================

SELECT
    SUM(amt) AS Total_Transaction_Amount
FROM Transactions;
GO


-- =========================================================
-- 4. SUM() for Fraud Amount
-- =========================================================

SELECT
    SUM(amt) AS Total_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1;
GO


-- =========================================================
-- 5. AVG()
-- Average transaction amount
-- =========================================================

SELECT
    AVG(amt) AS Average_Transaction_Amount
FROM Transactions;
GO


-- =========================================================
-- 6. AVG() for Fraud Transactions
-- =========================================================

SELECT
    AVG(amt) AS Average_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1;
GO


-- =========================================================
-- 7. MIN() and MAX()
-- Minimum and maximum transaction amounts
-- =========================================================

SELECT
    MIN(amt) AS Minimum_Transaction_Amount,
    MAX(amt) AS Maximum_Transaction_Amount
FROM Transactions;
GO


-- =========================================================
-- 8. Aggregate Functions with GROUP BY
-- Transaction summary by category
-- =========================================================

SELECT
    category,
    COUNT(*) AS Transaction_Count,
    SUM(amt) AS Total_Amount,
    AVG(amt) AS Average_Amount,
    MIN(amt) AS Minimum_Amount,
    MAX(amt) AS Maximum_Amount
FROM Transactions
GROUP BY category
ORDER BY Total_Amount DESC;
GO


-- =========================================================
-- 9. Fraud Summary by Category
-- =========================================================

SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 10. Fraud Summary by State
-- =========================================================

SELECT
    state,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY state
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 11. Fraud vs Genuine Summary
-- =========================================================

SELECT
    CASE
        WHEN is_fraud = 1 THEN 'Fraud'
        ELSE 'Genuine'
    END AS Transaction_Type,
    COUNT(*) AS Transaction_Count,
    SUM(amt) AS Total_Amount,
    AVG(amt) AS Average_Amount
FROM Transactions
GROUP BY is_fraud
ORDER BY is_fraud;
GO


-- =========================================================
-- Fundamentals Completed
-- Aggregate Functions
--
-- Topics Covered:
-- ✓ COUNT()
-- ✓ SUM()
-- ✓ AVG()
-- ✓ MIN()
-- ✓ MAX()
-- ✓ GROUP BY
-- ✓ Fraud Aggregation
-- ✓ Category Analysis
-- ✓ State Analysis
-- =========================================================