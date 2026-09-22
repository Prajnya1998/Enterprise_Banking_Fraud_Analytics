-- =========================================================
-- SQL Fundamentals: Filtering and Sorting
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Basic WHERE Filter
-- Transactions from one category
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt,
    is_fraud
FROM Transactions
WHERE category = 'grocery_pos';
GO


-- =========================================================
-- 2. Filter Fraud Transactions
-- =========================================================

SELECT
    trans_date_trans_time,
    merchant,
    category,
    state,
    amt
FROM Transactions
WHERE is_fraud = 1;
GO


-- =========================================================
-- 3. Filter by Transaction Amount
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE amt >= 500
ORDER BY amt DESC;
GO


-- =========================================================
-- 4. Multiple Conditions with AND
-- =========================================================

SELECT
    trans_date_trans_time,
    merchant,
    category,
    state,
    amt
FROM Transactions
WHERE is_fraud = 1
  AND amt >= 500
ORDER BY amt DESC;
GO


-- =========================================================
-- 5. Multiple Conditions with OR
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE category = 'grocery_pos'
   OR category = 'shopping_net';
GO


-- =========================================================
-- 6. BETWEEN
-- Transactions within an amount range
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE amt BETWEEN 100 AND 500
ORDER BY amt DESC;
GO


-- =========================================================
-- 7. IN
-- Filter multiple states
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE state IN ('NY', 'CA', 'TX')
ORDER BY state, amt DESC;
GO


-- =========================================================
-- 8. NOT IN
-- Exclude selected states
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE state NOT IN ('NY', 'CA', 'TX');
GO


-- =========================================================
-- 9. LIKE
-- Search merchant names by pattern
-- =========================================================

SELECT
    merchant,
    category,
    state,
    amt
FROM Transactions
WHERE merchant LIKE '%market%';
GO


-- =========================================================
-- 10. IS NULL
-- Check missing values
-- =========================================================

SELECT
    COUNT(*) AS Missing_Category_Count
FROM Transactions
WHERE category IS NULL;
GO


-- =========================================================
-- 11. NOT NULL
-- Transactions with a known category
-- =========================================================

SELECT
    COUNT(*) AS Valid_Category_Count
FROM Transactions
WHERE category IS NOT NULL;
GO


-- =========================================================
-- 12. ORDER BY Ascending
-- =========================================================

SELECT TOP 20
    trans_date_trans_time,
    category,
    amt
FROM Transactions
ORDER BY amt ASC;
GO


-- =========================================================
-- 13. ORDER BY Descending
-- =========================================================

SELECT TOP 20
    trans_date_trans_time,
    category,
    amt
FROM Transactions
ORDER BY amt DESC;
GO


-- =========================================================
-- 14. Sort by Multiple Columns
-- =========================================================

SELECT TOP 50
    category,
    state,
    amt,
    is_fraud
FROM Transactions
ORDER BY
    category ASC,
    amt DESC;
GO


-- =========================================================
-- 15. TOP with Filtering
-- Top 10 highest-value fraud transactions
-- =========================================================

SELECT TOP 10
    trans_date_trans_time,
    merchant,
    category,
    state,
    amt
FROM Transactions
WHERE is_fraud = 1
ORDER BY amt DESC;
GO


-- =========================================================
-- 16. CASE with Sorting
-- Fraud first, then amount
-- =========================================================

SELECT TOP 50
    trans_date_trans_time,
    merchant,
    category,
    amt,
    is_fraud
FROM Transactions
ORDER BY
    CASE
        WHEN is_fraud = 1 THEN 1
        ELSE 2
    END,
    amt DESC;
GO


-- =========================================================
-- Fundamentals Completed
-- Filtering and Sorting
--
-- Topics Covered:
-- ✓ WHERE
-- ✓ AND / OR
-- ✓ BETWEEN
-- ✓ IN / NOT IN
-- ✓ LIKE
-- ✓ IS NULL / IS NOT NULL
-- ✓ ORDER BY
-- ✓ TOP
-- ✓ Multiple-column Sorting
-- ✓ CASE in ORDER BY
-- =========================================================