-- =========================================================
-- SQL Fundamentals: Window Functions
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. ROW_NUMBER()
-- Number transactions within each customer
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    merchant,
    amt,
    ROW_NUMBER() OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Transaction_Number
FROM Transactions
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 2. RANK()
-- Rank fraud transactions by amount
-- =========================================================

SELECT TOP 100
    trans_date_trans_time,
    merchant,
    category,
    amt,
    RANK() OVER
    (
        ORDER BY amt DESC
    ) AS Amount_Rank
FROM Transactions
WHERE is_fraud = 1
ORDER BY Amount_Rank;
GO


-- =========================================================
-- 3. DENSE_RANK()
-- Rank categories by fraud amount
-- =========================================================

WITH CategoryFraud AS
(
    SELECT
        category,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
)
SELECT
    category,
    Fraud_Amount,
    DENSE_RANK() OVER
    (
        ORDER BY Fraud_Amount DESC
    ) AS Fraud_Amount_Rank
FROM CategoryFraud
ORDER BY Fraud_Amount_Rank;
GO


-- =========================================================
-- 4. NTILE()
-- Divide fraud transactions into four amount groups
-- =========================================================

SELECT TOP 100
    trans_date_trans_time,
    merchant,
    amt,
    NTILE(4) OVER
    (
        ORDER BY amt
    ) AS Amount_Quartile
FROM Transactions
WHERE is_fraud = 1
ORDER BY amt;
GO


-- =========================================================
-- 5. LAG()
-- Compare current transaction with previous transaction
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    amt,
    LAG(amt) OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Previous_Transaction_Amount
FROM Transactions
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 6. LEAD()
-- Compare current transaction with next transaction
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    amt,
    LEAD(amt) OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Next_Transaction_Amount
FROM Transactions
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 7. Running Total
-- Cumulative transaction amount by customer
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    amt,
    SUM(amt) OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Running_Total
FROM Transactions
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 8. Moving Average
-- Three-transaction moving average
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    amt,
    AVG(amt) OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Moving_Average
FROM Transactions
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 9. FIRST_VALUE()
-- First transaction amount for each customer
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    amt,
    FIRST_VALUE(amt) OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS First_Transaction_Amount
FROM Transactions
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 10. LAST_VALUE()
-- Latest transaction amount for each customer
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    amt,
    LAST_VALUE(amt) OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS Last_Transaction_Amount
FROM Transactions
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 11. Fraud Transactions with LAG()
-- =========================================================

SELECT TOP 100
    cc_num,
    trans_date_trans_time,
    merchant,
    amt,
    LAG(amt) OVER
    (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Previous_Amount,
    is_fraud
FROM Transactions
WHERE is_fraud = 1
ORDER BY cc_num, trans_date_trans_time;
GO


-- =========================================================
-- 12. Fraud Category Ranking
-- =========================================================

WITH CategoryFraud AS
(
    SELECT
        category,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
)
SELECT
    category,
    Fraud_Transactions,
    Fraud_Amount,
    RANK() OVER
    (
        ORDER BY Fraud_Amount DESC
    ) AS Fraud_Amount_Rank
FROM CategoryFraud
ORDER BY Fraud_Amount_Rank;
GO


-- =========================================================
-- Fundamentals Completed
-- Window Functions
--
-- Topics Covered:
-- ✓ ROW_NUMBER()
-- ✓ RANK()
-- ✓ DENSE_RANK()
-- ✓ NTILE()
-- ✓ LAG()
-- ✓ LEAD()
-- ✓ FIRST_VALUE()
-- ✓ LAST_VALUE()
-- ✓ Running Total
-- ✓ Moving Average
-- ✓ Fraud Ranking
-- =========================================================