-- =========================================================
-- SQL Fundamentals: Employee Queries
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. View Employee/Job Information
-- =========================================================

SELECT
    job,
    COUNT(*) AS Transaction_Count
FROM Transactions
GROUP BY job
ORDER BY Transaction_Count DESC;
GO


-- =========================================================
-- 2. Jobs with Fraud Transactions
-- =========================================================

SELECT
    job,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY job
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 3. Top 10 Jobs by Fraud Amount
-- =========================================================

SELECT TOP 10
    job,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY job
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 4. Job-Level Fraud Rate
-- =========================================================

SELECT
    job,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    CAST(
        100.0 *
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM Transactions
GROUP BY job
ORDER BY Fraud_Rate_Percent DESC;
GO


-- =========================================================
-- 5. High-Value Fraud by Job
-- =========================================================

SELECT
    job,
    COUNT(*) AS High_Value_Fraud_Transactions,
    SUM(amt) AS High_Value_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
  AND amt >= 500
GROUP BY job
ORDER BY High_Value_Fraud_Amount DESC;
GO


-- =========================================================
-- 6. Job and Gender Fraud Analysis
-- =========================================================

SELECT
    job,
    gender,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY
    job,
    gender
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 7. Jobs with More Than 10 Fraud Transactions
-- =========================================================

SELECT
    job,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY job
HAVING COUNT(*) > 10
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 8. Compare Fraud Amount by Job
-- =========================================================

SELECT
    job,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Fraud_Amount,
    SUM(CASE WHEN is_fraud = 0 THEN amt ELSE 0 END)
        AS Genuine_Amount
FROM Transactions
GROUP BY job
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- Fundamentals Completed
-- Employee / Job Queries
--
-- Topics Covered:
-- ✓ GROUP BY
-- ✓ HAVING
-- ✓ CASE
-- ✓ COUNT()
-- ✓ SUM()
-- ✓ AVG()
-- ✓ Fraud Rate
-- ✓ Job-Level Analysis
-- ✓ Gender Comparison
-- =========================================================