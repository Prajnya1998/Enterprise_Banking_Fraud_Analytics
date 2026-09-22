-- ==========================================
-- Project 17 : Dynamic SQL
-- Enterprise Banking Fraud Analytics
-- ==========================================

USE CreditCardFraudDB;
GO

-- ==========================================
-- 1. Basic Dynamic SQL
-- ==========================================

DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT TOP 10
    trans_date_trans_time,
    category,
    state,
    amt,
    is_fraud
FROM Transactions
ORDER BY amt DESC;
';

EXEC sp_executesql @SQL;
GO


-- ==========================================
-- 2. Dynamic SQL with Parameter
-- ==========================================

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


-- ==========================================
-- 3. Dynamic Fraud Analysis
-- ==========================================

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


-- ==========================================
-- 4. Dynamic State Filter
-- ==========================================

DECLARE @State NVARCHAR(50) = N'NY';
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
    N'@State NVARCHAR(50)',
    @State = @State;
GO


-- ==========================================
-- 5. Dynamic Minimum Amount
-- ==========================================

DECLARE @MinAmount DECIMAL(18,2) = 500.00;
DECLARE @SQL NVARCHAR(MAX);

SET @SQL = N'
SELECT
    trans_date_trans_time,
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


-- ==========================================
-- 6. Dynamic Fraud Amount Analysis
-- ==========================================

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


-- ==========================================
-- 7. Dynamic ORDER BY
-- ==========================================

DECLARE @SortColumn SYSNAME = N'amt';
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


-- ==========================================
-- Project 17 Completed
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
--
-- Status : Completed
-- ==========================================