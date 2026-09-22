-- =========================================================
-- Project 28: End-to-End Credit Card Fraud Analysis
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Dataset Overview
-- =========================================================

SELECT
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 0 THEN 1 ELSE 0 END) AS Genuine_Transactions,
    SUM(amt) AS Total_Transaction_Amount,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END) AS Total_Fraud_Amount
FROM dbo.Transactions;
GO


-- =========================================================
-- 2. Fraud Rate
-- =========================================================

SELECT
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS Fraud_Transactions,
    CAST(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM dbo.Transactions;
GO


-- =========================================================
-- 3. Transaction Amount KPIs
-- =========================================================

SELECT
    AVG(amt) AS Average_Transaction_Amount,
    MAX(amt) AS Maximum_Transaction_Amount,
    MIN(amt) AS Minimum_Transaction_Amount,
    AVG(CASE WHEN is_fraud = 1 THEN amt END)
        AS Average_Fraud_Amount,
    MAX(CASE WHEN is_fraud = 1 THEN amt END)
        AS Maximum_Fraud_Amount
FROM dbo.Transactions;
GO


-- =========================================================
-- 4. Fraud Analysis by Category
-- =========================================================

SELECT
    category,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Fraud_Amount,
    CAST(
        100.0 *
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM dbo.Transactions
GROUP BY category
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 5. Fraud Analysis by State
-- =========================================================

SELECT
    state,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Fraud_Amount,
    CAST(
        100.0 *
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM dbo.Transactions
GROUP BY state
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 6. Top 10 Cities by Fraud Transactions
-- =========================================================

SELECT TOP 10
    city,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
GROUP BY city
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 7. Top 10 Merchants by Fraud Transactions
-- =========================================================

SELECT TOP 10
    merchant,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
GROUP BY merchant
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 8. Top 10 Merchants by Fraud Amount
-- =========================================================

SELECT TOP 10
    merchant,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
GROUP BY merchant
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 9. Fraud Analysis by Gender
-- =========================================================

SELECT
    gender,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Fraud_Amount
FROM dbo.Transactions
GROUP BY gender
ORDER BY Fraud_Transactions DESC;
GO


-- =========================================================
-- 10. Fraud Analysis by Job
-- =========================================================

SELECT TOP 10
    job,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
GROUP BY job
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 11. Fraud Analysis by Transaction Hour
-- =========================================================

SELECT
    DATEPART(HOUR, trans_date_trans_time) AS Transaction_Hour,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Fraud_Amount,
    CAST(
        100.0 *
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM dbo.Transactions
GROUP BY DATEPART(HOUR, trans_date_trans_time)
ORDER BY Transaction_Hour;
GO


-- =========================================================
-- 12. High-Value Fraud Transactions
-- =========================================================

SELECT TOP 100
    trans_date_trans_time,
    merchant,
    category,
    state,
    city,
    job,
    gender,
    amt
FROM dbo.Transactions
WHERE is_fraud = 1
ORDER BY amt DESC;
GO


-- =========================================================
-- 13. Daily Fraud Trend
-- =========================================================

SELECT
    CAST(trans_date_trans_time AS DATE) AS Transaction_Date,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Fraud_Amount
FROM dbo.Transactions
GROUP BY CAST(trans_date_trans_time AS DATE)
ORDER BY Transaction_Date;
GO


-- =========================================================
-- 14. Fraud vs Genuine Amount
-- =========================================================

SELECT
    CASE
        WHEN is_fraud = 1 THEN 'Fraud'
        ELSE 'Genuine'
    END AS Transaction_Type,
    COUNT(*) AS Transaction_Count,
    SUM(amt) AS Transaction_Amount,
    AVG(amt) AS Average_Amount
FROM dbo.Transactions
GROUP BY is_fraud
ORDER BY is_fraud;
GO


-- =========================================================
-- 15. Fraud Amount by Category - Ranking
-- =========================================================

WITH CategoryFraud AS
(
    SELECT
        category,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM dbo.Transactions
    WHERE is_fraud = 1
    GROUP BY category
)
SELECT
    category,
    Fraud_Transactions,
    Fraud_Amount,
    DENSE_RANK() OVER (
        ORDER BY Fraud_Amount DESC
    ) AS Fraud_Amount_Rank
FROM CategoryFraud
ORDER BY Fraud_Amount_Rank;
GO


-- =========================================================
-- 16. Customer-Level Fraud Analysis
-- =========================================================

SELECT TOP 20
    cc_num,
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Fraud_Amount
FROM dbo.Transactions
GROUP BY cc_num
HAVING SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) > 0
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 17. Executive Fraud Summary
-- =========================================================

SELECT
    COUNT(*) AS Total_Transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        AS Fraud_Transactions,
    SUM(CASE WHEN is_fraud = 0 THEN 1 ELSE 0 END)
        AS Genuine_Transactions,
    CAST(
        100.0 *
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent,
    SUM(amt) AS Total_Transaction_Amount,
    SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
        AS Total_Fraud_Amount,
    AVG(amt) AS Average_Transaction_Amount,
    AVG(CASE WHEN is_fraud = 1 THEN amt END)
        AS Average_Fraud_Amount
FROM dbo.Transactions;
GO


-- =========================================================
-- Project 28 Completed
-- End-to-End Credit Card Fraud Analysis
--
-- Topics Covered:
-- ✓ Transaction KPIs
-- ✓ Fraud Rate
-- ✓ Fraud Amount
-- ✓ Category Analysis
-- ✓ State Analysis
-- ✓ City Analysis
-- ✓ Merchant Analysis
-- ✓ Gender Analysis
-- ✓ Job Analysis
-- ✓ Hourly Analysis
-- ✓ Daily Fraud Trend
-- ✓ High-Value Fraud Detection
-- ✓ Customer-Level Analysis
-- ✓ CTE
-- ✓ Ranking Functions
-- ✓ Executive Summary
-- =========================================================