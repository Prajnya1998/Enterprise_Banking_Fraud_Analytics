-- =========================================================
-- SQL Fundamentals: Subqueries
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Scalar Subquery
-- Find transactions above the overall average amount
-- =========================================================

SELECT TOP 50
    trans_date_trans_time,
    merchant,
    category,
    amt,
    is_fraud
FROM Transactions
WHERE amt >
(
    SELECT AVG(amt)
    FROM Transactions
)
ORDER BY amt DESC;
GO


-- =========================================================
-- 2. Fraud Transactions Above Average Fraud Amount
-- =========================================================

SELECT TOP 50
    trans_date_trans_time,
    merchant,
    category,
    state,
    amt
FROM Transactions
WHERE is_fraud = 1
  AND amt >
(
    SELECT AVG(amt)
    FROM Transactions
    WHERE is_fraud = 1
)
ORDER BY amt DESC;
GO


-- =========================================================
-- 3. IN Subquery
-- Customers who have committed fraud
-- =========================================================

SELECT
    cc_num,
    COUNT(*) AS Total_Transactions,
    SUM(amt) AS Total_Amount
FROM Transactions
WHERE cc_num IN
(
    SELECT DISTINCT cc_num
    FROM Transactions
    WHERE is_fraud = 1
)
GROUP BY cc_num
ORDER BY Total_Amount DESC;
GO


-- =========================================================
-- 4. NOT IN Subquery
-- Customers with no recorded fraud transactions
-- =========================================================

SELECT
    cc_num,
    COUNT(*) AS Total_Transactions,
    SUM(amt) AS Total_Amount
FROM Transactions
WHERE cc_num NOT IN
(
    SELECT DISTINCT cc_num
    FROM Transactions
    WHERE is_fraud = 1
)
GROUP BY cc_num
ORDER BY Total_Amount DESC;
GO


-- =========================================================
-- 5. EXISTS
-- Categories that contain fraud transactions
-- =========================================================

SELECT DISTINCT
    t1.category
FROM Transactions AS t1
WHERE EXISTS
(
    SELECT 1
    FROM Transactions AS t2
    WHERE t2.category = t1.category
      AND t2.is_fraud = 1
)
ORDER BY t1.category;
GO


-- =========================================================
-- 6. NOT EXISTS
-- Categories without fraud transactions
-- =========================================================

SELECT DISTINCT
    t1.category
FROM Transactions AS t1
WHERE NOT EXISTS
(
    SELECT 1
    FROM Transactions AS t2
    WHERE t2.category = t1.category
      AND t2.is_fraud = 1
)
ORDER BY t1.category;
GO


-- =========================================================
-- 7. Correlated Subquery
-- Transactions above the average amount of their category
-- =========================================================

SELECT TOP 100
    t1.trans_date_trans_time,
    t1.merchant,
    t1.category,
    t1.amt,
    t1.is_fraud
FROM Transactions AS t1
WHERE t1.amt >
(
    SELECT AVG(t2.amt)
    FROM Transactions AS t2
    WHERE t2.category = t1.category
)
ORDER BY t1.amt DESC;
GO


-- =========================================================
-- 8. Correlated Subquery for Fraud Transactions
-- =========================================================

SELECT TOP 100
    t1.trans_date_trans_time,
    t1.merchant,
    t1.category,
    t1.state,
    t1.amt
FROM Transactions AS t1
WHERE t1.is_fraud = 1
  AND t1.amt >
(
    SELECT AVG(t2.amt)
    FROM Transactions AS t2
    WHERE t2.category = t1.category
      AND t2.is_fraud = 1
)
ORDER BY t1.amt DESC;
GO


-- =========================================================
-- 9. Subquery in FROM
-- Category fraud summary
-- =========================================================

SELECT
    CategorySummary.category,
    CategorySummary.Fraud_Transactions,
    CategorySummary.Fraud_Amount
FROM
(
    SELECT
        category,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
) AS CategorySummary
ORDER BY CategorySummary.Fraud_Amount DESC;
GO


-- =========================================================
-- 10. Subquery in SELECT
-- Add overall fraud transaction count to every row
-- =========================================================

SELECT TOP 20
    trans_date_trans_time,
    merchant,
    category,
    amt,
    is_fraud,
    (
        SELECT COUNT(*)
        FROM Transactions
        WHERE is_fraud = 1
    ) AS Total_Fraud_Transactions
FROM Transactions
ORDER BY amt DESC;
GO


-- =========================================================
-- 11. Categories Above Overall Average Fraud Amount
-- =========================================================

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


-- =========================================================
-- 12. Highest Fraud Amount by Category
-- =========================================================

SELECT
    t.category,
    t.amt,
    t.merchant,
    t.state
FROM Transactions AS t
WHERE t.is_fraud = 1
  AND t.amt =
(
    SELECT MAX(t2.amt)
    FROM Transactions AS t2
    WHERE t2.category = t.category
      AND t2.is_fraud = 1
)
ORDER BY t.amt DESC;
GO


-- =========================================================
-- Fundamentals Completed
-- Subqueries
--
-- Topics Covered:
-- ✓ Scalar Subquery
-- ✓ IN
-- ✓ NOT IN
-- ✓ EXISTS
-- ✓ NOT EXISTS
-- ✓ Correlated Subquery
-- ✓ Subquery in FROM
-- ✓ Subquery in SELECT
-- ✓ HAVING with Subquery
-- ✓ Fraud Analysis
-- =========================================================