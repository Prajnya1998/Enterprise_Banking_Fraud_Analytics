-- =========================================================
-- Project 27: SQL Performance Tuning
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Enable Performance Statistics
-- =========================================================

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO


-- =========================================================
-- 2. Baseline Query
-- SELECT * returns all columns
-- =========================================================

SELECT *
FROM Transactions
WHERE category = 'grocery_pos';
GO


-- =========================================================
-- 3. Optimized Query
-- Select only required columns
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
-- 4. Non-SARGable Query
-- Function applied to the column
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE UPPER(category) = 'GROCERY_POS';
GO


-- =========================================================
-- 5. SARGable Query
-- Direct comparison allows better index usage
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE category = 'grocery_pos';
GO


-- =========================================================
-- 6. Filter Fraud Transactions
-- =========================================================

SELECT
    trans_date_trans_time,
    category,
    state,
    amt
FROM Transactions
WHERE is_fraud = 1
  AND amt >= 500
ORDER BY amt DESC;
GO


-- =========================================================
-- 7. Aggregation Performance
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
-- 8. Create an Index for Category Filtering
-- =========================================================

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Transactions_Category'
      AND object_id = OBJECT_ID('dbo.Transactions')
)
BEGIN

    CREATE INDEX IX_Transactions_Category
    ON dbo.Transactions(category);

END;
GO


-- =========================================================
-- 9. Create an Index for Fraud Filtering
-- =========================================================

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Transactions_IsFraud'
      AND object_id = OBJECT_ID('dbo.Transactions')
)
BEGIN

    CREATE INDEX IX_Transactions_IsFraud
    ON dbo.Transactions(is_fraud);

END;
GO


-- =========================================================
-- 10. Query After Index Creation
-- =========================================================

SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 11. Composite Index
-- =========================================================

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Transactions_Fraud_Category'
      AND object_id = OBJECT_ID('dbo.Transactions')
)
BEGIN

    CREATE INDEX IX_Transactions_Fraud_Category
    ON dbo.Transactions(is_fraud, category);

END;
GO


-- =========================================================
-- 12. Query Using Composite Filter
-- =========================================================

SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
  AND category = 'grocery_pos'
GROUP BY category;
GO


-- =========================================================
-- 13. View Existing Indexes
-- =========================================================

SELECT
    i.name AS Index_Name,
    i.type_desc AS Index_Type,
    c.name AS Column_Name
FROM sys.indexes AS i
INNER JOIN sys.index_columns AS ic
    ON i.object_id = ic.object_id
   AND i.index_id = ic.index_id
INNER JOIN sys.columns AS c
    ON ic.object_id = c.object_id
   AND ic.column_id = c.column_id
WHERE i.object_id = OBJECT_ID('dbo.Transactions')
ORDER BY i.name, ic.key_ordinal;
GO


-- =========================================================
-- 14. Performance Tuning Notes
-- =========================================================

-- Avoid SELECT * when only specific columns are required.
--
-- Prefer SARGable predicates.
--
-- Use execution plans to identify scans, seeks,
-- expensive joins and other costly operations.
--
-- SET STATISTICS IO ON shows logical and physical reads.
--
-- SET STATISTICS TIME ON shows CPU time and elapsed time.
--
-- Indexes should be created based on actual query patterns.
--
-- Too many indexes can increase INSERT, UPDATE and DELETE cost.


-- =========================================================
-- 15. Disable Performance Statistics
-- =========================================================

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO


-- =========================================================
-- Project 27 Completed
-- SQL Performance Tuning
--
-- Topics Covered:
-- ✓ SET STATISTICS IO
-- ✓ SET STATISTICS TIME
-- ✓ SELECT * Optimization
-- ✓ SARGable Queries
-- ✓ Non-SARGable Queries
-- ✓ Index Creation
-- ✓ Composite Indexes
-- ✓ Query Optimization
-- ✓ Index Inspection
-- ✓ Performance Analysis
-- =========================================================