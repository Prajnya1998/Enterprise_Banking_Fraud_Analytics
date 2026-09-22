-- =========================================================
-- Project 21: Dynamic SQL
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Basic Dynamic SQL
-- =========================================================

DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT TOP 10
    *
FROM Transactions;
';

EXEC sp_executesql @SQL;
GO


-- =========================================================
-- 2. Dynamic Column Filtering
-- =========================================================

DECLARE @Category NVARCHAR(100) = N'grocery_pos';
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT
    category,
    COUNT(*) AS Transaction_Count,
    SUM(amt) AS Total_Amount
FROM Transactions
WHERE category = @Category
GROUP BY category;
';

EXEC sp_executesql
    @SQL,
    N'@Category NVARCHAR(100)',
    @Category = @Category;
GO


-- =========================================================
-- 3. Dynamic Fraud Analysis by Category
-- =========================================================

DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY Fraud_Transactions DESC;
';

EXEC sp_executesql @SQL;
GO


-- =========================================================
-- 4. Dynamic State Analysis
-- =========================================================

DECLARE @State NVARCHAR(100) = N'NY';
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT
    state,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE state = @State
  AND is_fraud = 1
GROUP BY state;
';

EXEC sp_executesql
    @SQL,
    N'@State NVARCHAR(100)',
    @State = @State;
GO


-- =========================================================
-- 5. Dynamic SQL with Parameters
-- Parameters are preferred over string concatenation
-- =========================================================

DECLARE @MinAmount DECIMAL(18,2) = 500.00;
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT
    trans_date_trans_time,
    cc_num,
    category,
    state,
    amt,
    is_fraud
FROM Transactions
WHERE amt >= @MinAmount
ORDER BY amt DESC;
';

EXEC sp_executesql
    @SQL,
    N'@MinAmount DECIMAL(18,2)',
    @MinAmount = @MinAmount;
GO


-- =========================================================
-- 6. Dynamic Fraud Amount Analysis
-- =========================================================

DECLARE @MinFraudAmount DECIMAL(18,2) = 500.00;
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount,
    AVG(amt) AS Average_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
  AND amt >= @MinFraudAmount
GROUP BY category
ORDER BY Fraud_Amount DESC;
';

EXEC sp_executesql
    @SQL,
    N'@MinFraudAmount DECIMAL(18,2)',
    @MinFraudAmount = @MinFraudAmount;
GO


-- =========================================================
-- 7. Dynamic SQL with ORDER BY
-- =========================================================

DECLARE @SortColumn NVARCHAR(50) = N'amt';
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT TOP 20
    trans_date_trans_time,
    category,
    state,
    amt,
    is_fraud
FROM Transactions
WHERE is_fraud = 1
ORDER BY ' + QUOTENAME(@SortColumn) + N' DESC;
';

EXEC sp_executesql @SQL;
GO


-- =========================================================
-- 8. Interview Notes
-- =========================================================

-- Dynamic SQL allows SQL statements to be constructed and
-- executed dynamically at runtime.
--
-- sp_executesql supports parameterized dynamic SQL.
--
-- Parameterization helps reduce SQL injection risk and
-- improves plan reuse.
--
-- QUOTENAME() can be used when dynamically handling
-- object or column identifiers.
--
-- Dynamic SQL should be used only when dynamic behavior
-- is actually required.


-- =========================================================
-- Project 21 Completed
-- Dynamic SQL
--
-- Topics Covered:
-- ✓ Dynamic SQL
-- ✓ sp_executesql
-- ✓ Parameterized Queries
-- ✓ Dynamic Filtering
-- ✓ Dynamic Ordering
-- ✓ QUOTENAME()
-- ✓ Fraud Analysis
-- =========================================================