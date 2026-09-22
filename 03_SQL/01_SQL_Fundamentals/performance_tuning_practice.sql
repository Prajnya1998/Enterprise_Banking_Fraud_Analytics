-- =========================================================
-- SQL Fundamentals: Performance Tuning Practice
-- =========================================================

USE GlobalSuperstore;
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
FROM [dbo].[Global_Superstore(CSV)]
WHERE Category = 'Technology';
GO


-- =========================================================
-- 3. Select Only Required Columns
-- =========================================================

SELECT
    Category,
    Sales,
    Profit
FROM [dbo].[Global_Superstore(CSV)]
WHERE Category = 'Technology';
GO


-- =========================================================
-- 4. Non-SARGable Query
-- Function applied to the column
-- =========================================================

SELECT
    Category,
    Sales,
    Profit
FROM [dbo].[Global_Superstore(CSV)]
WHERE UPPER(Category) = 'TECHNOLOGY';
GO


-- =========================================================
-- 5. SARGable Query
-- Direct column comparison
-- =========================================================

SELECT
    Category,
    Sales,
    Profit
FROM [dbo].[Global_Superstore(CSV)]
WHERE Category = 'Technology';
GO


-- =========================================================
-- 6. Filter and Sort
-- =========================================================

SELECT TOP 20
    Category,
    Sub_Category,
    Sales,
    Profit
FROM [dbo].[Global_Superstore(CSV)]
WHERE Category = 'Technology'
ORDER BY Sales DESC;
GO


-- =========================================================
-- 7. Aggregation Performance
-- =========================================================

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Category
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 8. Filter Before Aggregation
-- =========================================================

SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
WHERE Sales >= 500
GROUP BY Category
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 9. Execution Plan Reminder
-- =========================================================

-- In SSMS, enable:
-- Query → Include Actual Execution Plan
--
-- Shortcut:
-- Ctrl + M
--
-- Review:
-- ✓ Table Scan
-- ✓ Index Scan
-- ✓ Index Seek
-- ✓ Sort
-- ✓ Estimated Cost


-- =========================================================
-- 10. Performance Tuning Notes
-- =========================================================

-- Avoid SELECT * when unnecessary.
--
-- Select only the columns required by the analysis.
--
-- Prefer SARGable predicates.
--
-- Avoid applying functions directly to filtered columns
-- when an equivalent direct comparison is possible.
--
-- Review execution plans for expensive operators.
--
-- Use SET STATISTICS IO to review logical reads.
--
-- Use SET STATISTICS TIME to review CPU and elapsed time.


-- =========================================================
-- 11. Disable Performance Statistics
-- =========================================================

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO


-- =========================================================
-- Fundamentals Completed
-- Performance Tuning Practice
--
-- Topics Covered:
-- ✓ STATISTICS IO
-- ✓ STATISTICS TIME
-- ✓ SELECT * Optimization
-- ✓ SARGable Queries
-- ✓ Non-SARGable Queries
-- ✓ Execution Plans
-- ✓ Filtering
-- ✓ Aggregation
-- ✓ Query Optimization
-- =========================================================