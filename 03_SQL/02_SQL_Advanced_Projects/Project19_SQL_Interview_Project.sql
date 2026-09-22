-- ==========================================
-- Project 19 : SQL Interview Project
-- Enterprise Banking Fraud Analytics
-- ==========================================

USE CreditCardFraudDB;
GO

-- ==========================================
-- Q1. Find total number of transactions
-- ==========================================

SELECT
    COUNT(*) AS Total_Transactions
FROM Transactions;
GO


-- ==========================================
-- Q2. Find total fraud transactions
-- ==========================================

SELECT
    COUNT(*) AS Fraud_Transactions
FROM Transactions
WHERE is_fraud = 1;
GO


-- ==========================================
-- Q3. Calculate fraud rate
-- ==========================================

SELECT
    CAST(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM Transactions;
GO


-- ==========================================
-- Q4. Find total fraud amount
-- ==========================================

SELECT
    SUM(amt) AS Total_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1;
GO


-- ==========================================
-- Q5. Find average fraud transaction amount
-- ==========================================

SELECT
    AVG(amt) AS Average_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1;
GO


-- ==========================================
-- Q6. Find top 10 merchants by fraud transactions
-- ==========================================

SELECT TOP 10
    merchant,
    COUNT(*) AS Fraud_Transactions
FROM Transactions
WHERE is_fraud = 1
GROUP BY merchant
ORDER BY Fraud_Transactions DESC;
GO


-- ==========================================
-- Q7. Find top 10 merchants by fraud amount
-- ==========================================

SELECT TOP 10
    merchant,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY merchant
ORDER BY Fraud_Amount DESC;
GO


-- ==========================================
-- Q8. Find fraud transactions by category
-- ==========================================

SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY Fraud_Transactions DESC;
GO


-- ==========================================
-- Q9. Find fraud rate by category
-- ==========================================

SELECT
    category,
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
GROUP BY category
ORDER BY Fraud_Rate_Percent DESC;
GO


-- ==========================================
-- Q10. Find top 10 states by fraud transactions
-- ==========================================

SELECT TOP 10
    state,
    COUNT(*) AS Fraud_Transactions
FROM Transactions
WHERE is_fraud = 1
GROUP BY state
ORDER BY Fraud_Transactions DESC;
GO


-- ==========================================
-- Q11. Find fraud activity by transaction hour
-- ==========================================

SELECT
    DATEPART(HOUR, trans_date_trans_time) AS Transaction_Hour,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY DATEPART(HOUR, trans_date_trans_time)
ORDER BY Transaction_Hour;
GO


-- ==========================================
-- Q12. Find high-value fraud transactions
-- ==========================================

SELECT TOP 50
    trans_date_trans_time,
    merchant,
    category,
    state,
    amt
FROM Transactions
WHERE is_fraud = 1
ORDER BY amt DESC;
GO


-- ==========================================
-- Q13. Find customers with multiple fraud transactions
-- ==========================================

SELECT
    cc_num,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY cc_num
HAVING COUNT(*) > 1
ORDER BY Fraud_Transactions DESC;
GO


-- ==========================================
-- Q14. Rank categories by fraud amount
-- ==========================================

SELECT
    category,
    SUM(amt) AS Fraud_Amount,
    DENSE_RANK() OVER (
        ORDER BY SUM(amt) DESC
    ) AS Fraud_Amount_Rank
FROM Transactions
WHERE is_fraud = 1
GROUP BY category;
GO


-- ==========================================
-- Q15. Compare each fraud transaction
-- with the previous transaction for the customer
-- ==========================================

SELECT
    cc_num,
    trans_date_trans_time,
    amt,
    LAG(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Previous_Transaction_Amount
FROM Transactions
WHERE is_fraud = 1;
GO


-- ==========================================
-- Q16. Find categories with above-average
-- fraud transaction amounts
-- ==========================================

SELECT
    category,
    AVG(amt) AS Average_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY category
HAVING AVG(amt) >
(
    SELECT AVG(amt)
    FROM Transactions
    WHERE is_fraud = 1
)
ORDER BY Average_Fraud_Amount DESC;
GO


-- ==========================================
-- Q17. Find duplicate transaction records
-- ==========================================

SELECT
    trans_date_trans_time,
    cc_num,
    merchant,
    amt,
    COUNT(*) AS Duplicate_Count
FROM Transactions
GROUP BY
    trans_date_trans_time,
    cc_num,
    merchant,
    amt
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;
GO


-- ==========================================
-- Q18. Executive Fraud Summary
-- ==========================================

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
FROM Transactions;
GO


-- ==========================================
-- Interview Questions
-- ==========================================

-- 1. What is the difference between WHERE and HAVING?
--
-- WHERE filters rows before aggregation.
-- HAVING filters grouped results after aggregation.

------------------------------------------------------------

-- 2. What is a CTE?
--
-- A Common Table Expression (CTE) is a temporary named
-- result set that can be referenced by a following query.

------------------------------------------------------------

-- 3. What is a window function?
--
-- A window function performs calculations across related
-- rows without collapsing the result into grouped rows.

------------------------------------------------------------

-- 4. What is the difference between RANK() and DENSE_RANK()?
--
-- RANK() leaves gaps after ties.
-- DENSE_RANK() does not leave gaps.

------------------------------------------------------------

-- 5. What is an index?
--
-- An index is a database structure that can improve
-- data retrieval performance.

------------------------------------------------------------

-- 6. What is a transaction?
--
-- A transaction is a logical unit of work that can be
-- committed or rolled back.

------------------------------------------------------------

-- 7. What is the purpose of TRY...CATCH?
--
-- TRY...CATCH provides structured error handling
-- for T-SQL operations.

------------------------------------------------------------

-- 8. What is Dynamic SQL?
--
-- Dynamic SQL is SQL constructed and executed at runtime.

------------------------------------------------------------

-- ==========================================
-- Project 19 Completed
-- SQL Interview Project
--
-- Topics Covered:
-- ✓ Aggregate Functions
-- ✓ WHERE / HAVING
-- ✓ GROUP BY
-- ✓ Subqueries
-- ✓ Window Functions
-- ✓ LAG()
-- ✓ DENSE_RANK()
-- ✓ Duplicate Detection
-- ✓ Fraud Analysis
-- ✓ Transaction Analysis
-- ✓ SQL Interview Questions
--
-- Status : Completed
-- ==========================================