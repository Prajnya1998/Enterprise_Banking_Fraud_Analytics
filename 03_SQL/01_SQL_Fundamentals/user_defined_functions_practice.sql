-- =========================================================
-- SQL Fundamentals: User-Defined Functions
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Scalar Function
-- Calculate fraud rate from fraud and total transactions
-- =========================================================

CREATE OR ALTER FUNCTION dbo.fn_FraudRate
(
    @FraudTransactions INT,
    @TotalTransactions INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN

    DECLARE @FraudRate DECIMAL(10,2);

    SET @FraudRate =
        CASE
            WHEN @TotalTransactions = 0 THEN 0
            ELSE
                (100.0 * @FraudTransactions)
                / @TotalTransactions
        END;

    RETURN @FraudRate;

END;
GO


-- =========================================================
-- 2. Test Scalar Function
-- =========================================================

SELECT
    dbo.fn_FraudRate(7506, 1296675) AS Fraud_Rate_Percent;
GO


-- =========================================================
-- 3. Scalar Function for Fraud Risk Classification
-- =========================================================

CREATE OR ALTER FUNCTION dbo.fn_FraudRiskLevel
(
    @Amount DECIMAL(18,2)
)
RETURNS VARCHAR(20)
AS
BEGIN

    DECLARE @RiskLevel VARCHAR(20);

    SET @RiskLevel =
        CASE
            WHEN @Amount >= 1000 THEN 'High'
            WHEN @Amount >= 500 THEN 'Medium'
            ELSE 'Low'
        END;

    RETURN @RiskLevel;

END;
GO


-- =========================================================
-- 4. Apply Risk Function to Transactions
-- =========================================================

SELECT TOP 50
    trans_date_trans_time,
    merchant,
    category,
    amt,
    dbo.fn_FraudRiskLevel(amt) AS Risk_Level
FROM Transactions
WHERE is_fraud = 1
ORDER BY amt DESC;
GO


-- =========================================================
-- 5. Inline Table-Valued Function
-- Fraud Transactions by Category
-- =========================================================

CREATE OR ALTER FUNCTION dbo.fn_FraudByCategory
(
    @Category VARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        trans_date_trans_time,
        merchant,
        category,
        state,
        amt,
        is_fraud
    FROM Transactions
    WHERE category = @Category
      AND is_fraud = 1
);
GO


-- =========================================================
-- 6. Execute Table-Valued Function
-- =========================================================

SELECT *
FROM dbo.fn_FraudByCategory('grocery_pos')
ORDER BY amt DESC;
GO


-- =========================================================
-- 7. Inline Table-Valued Function
-- High-Value Fraud Transactions
-- =========================================================

CREATE OR ALTER FUNCTION dbo.fn_HighValueFraud
(
    @MinimumAmount DECIMAL(18,2)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        trans_date_trans_time,
        merchant,
        category,
        state,
        amt
    FROM Transactions
    WHERE is_fraud = 1
      AND amt >= @MinimumAmount
);
GO


-- =========================================================
-- 8. Execute High-Value Fraud Function
-- =========================================================

SELECT TOP 100
    *
FROM dbo.fn_HighValueFraud(500)
ORDER BY amt DESC;
GO


-- =========================================================
-- 9. Use Function in Aggregation
-- =========================================================

SELECT
    category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM dbo.fn_HighValueFraud(500)
GROUP BY category
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 10. Review User-Defined Functions
-- =========================================================

SELECT
    name,
    type_desc,
    create_date,
    modify_date
FROM sys.objects
WHERE type IN ('FN', 'IF', 'TF')
  AND name IN
  (
      'fn_FraudRate',
      'fn_FraudRiskLevel',
      'fn_FraudByCategory',
      'fn_HighValueFraud'
  )
ORDER BY name;
GO


-- =========================================================
-- Fundamentals Completed
-- User-Defined Functions
--
-- Topics Covered:
-- ✓ Scalar Function
-- ✓ Return Value
-- ✓ CASE Logic
-- ✓ Inline Table-Valued Function
-- ✓ Function Parameters
-- ✓ Functions in SELECT
-- ✓ Functions in FROM
-- ✓ Fraud Risk Classification
-- =========================================================