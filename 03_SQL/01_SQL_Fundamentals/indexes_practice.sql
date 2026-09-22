-- =========================================================
-- SQL Fundamentals: Indexes
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. View Existing Indexes
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
-- 2. Create Index on Category
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
-- 3. Create Index on State
-- =========================================================

IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Transactions_State'
      AND object_id = OBJECT_ID('dbo.Transactions')
)
BEGIN
    CREATE INDEX IX_Transactions_State
    ON dbo.Transactions(state);
END;
GO


-- =========================================================
-- 4. Create Index on Fraud Flag
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
-- 5. Create Composite Index
-- Fraud Flag + Category
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
-- 6. Query Using Category Index
-- =========================================================

SELECT
    category,
    COUNT(*) AS Transaction_Count,
    SUM(amt) AS Total_Amount
FROM dbo.Transactions
WHERE category = 'grocery_pos'
GROUP BY category;
GO


-- =========================================================
-- 7. Query Using Fraud Index
-- =========================================================

SELECT
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1;
GO


-- =========================================================
-- 8. Query Using Composite Index
-- =========================================================

SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM dbo.Transactions
WHERE is_fraud = 1
  AND category = 'grocery_pos'
GROUP BY category;
GO


-- =========================================================
-- 9. Check Index Usage Information
-- =========================================================

SELECT
    OBJECT_NAME(i.object_id) AS Table_Name,
    i.name AS Index_Name,
    i.type_desc AS Index_Type
FROM sys.indexes AS i
WHERE i.object_id = OBJECT_ID('dbo.Transactions')
ORDER BY i.name;
GO


-- =========================================================
-- 10. Interview Notes
-- =========================================================

-- Indexes can improve data retrieval performance.
--
-- Indexes may increase storage requirements.
--
-- INSERT, UPDATE and DELETE operations can become more
-- expensive because indexes also need to be maintained.
--
-- Composite indexes contain more than one column.
--
-- Index design should be based on actual query patterns.
--
-- Execution plans should be reviewed when evaluating
-- index effectiveness.


-- =========================================================
-- Fundamentals Completed
-- Indexes
--
-- Topics Covered:
-- ✓ CREATE INDEX
-- ✓ IF NOT EXISTS
-- ✓ Single-Column Index
-- ✓ Composite Index
-- ✓ Index Metadata
-- ✓ Fraud Query Optimization
-- ✓ Index Trade-offs
-- =========================================================