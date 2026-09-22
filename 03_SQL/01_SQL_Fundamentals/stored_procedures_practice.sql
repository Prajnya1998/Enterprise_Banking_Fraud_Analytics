-- =========================================================
-- SQL Fundamentals: Stored Procedures
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Create Procedure: Overall Fraud Summary
-- =========================================================

CREATE OR ALTER PROCEDURE dbo.usp_Fraud_Summary
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        COUNT(*) AS Total_Transactions,
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
            AS Fraud_Transactions,
        SUM(CASE WHEN is_fraud = 0 THEN 1 ELSE 0 END)
            AS Genuine_Transactions,
        SUM(amt) AS Total_Transaction_Amount,
        SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
            AS Total_Fraud_Amount
    FROM dbo.Transactions;
END;
GO


-- =========================================================
-- 2. Execute Fraud Summary Procedure
-- =========================================================

EXEC dbo.usp_Fraud_Summary;
GO


-- =========================================================
-- 3. Create Procedure with Parameter
-- Fraud Analysis by Category
-- =========================================================

CREATE OR ALTER PROCEDURE dbo.usp_Fraud_By_Category
    @Category VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        category,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount,
        AVG(amt) AS Average_Fraud_Amount
    FROM dbo.Transactions
    WHERE is_fraud = 1
      AND category = @Category
    GROUP BY category;
END;
GO


-- =========================================================
-- 4. Execute Parameterized Procedure
-- =========================================================

EXEC dbo.usp_Fraud_By_Category
    @Category = 'grocery_pos';
GO


-- =========================================================
-- 5. Create Procedure with Amount Parameter
-- =========================================================

CREATE OR ALTER PROCEDURE dbo.usp_High_Value_Fraud
    @Minimum_Amount DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 100
        trans_date_trans_time,
        merchant,
        category,
        state,
        amt
    FROM dbo.Transactions
    WHERE is_fraud = 1
      AND amt >= @Minimum_Amount
    ORDER BY amt DESC;
END;
GO


-- =========================================================
-- 6. Execute High-Value Fraud Procedure
-- =========================================================

EXEC dbo.usp_High_Value_Fraud
    @Minimum_Amount = 500.00;
GO


-- =========================================================
-- 7. Create Procedure with Two Parameters
-- State + Fraud Flag
-- =========================================================

CREATE OR ALTER PROCEDURE dbo.usp_State_Fraud_Analysis
    @State VARCHAR(50),
    @Fraud_Flag INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        state,
        COUNT(*) AS Transaction_Count,
        SUM(amt) AS Total_Amount,
        AVG(amt) AS Average_Amount
    FROM dbo.Transactions
    WHERE state = @State
      AND is_fraud = @Fraud_Flag
    GROUP BY state;
END;
GO


-- =========================================================
-- 8. Execute State Fraud Procedure
-- =========================================================

EXEC dbo.usp_State_Fraud_Analysis
    @State = 'NY',
    @Fraud_Flag = 1;
GO


-- =========================================================
-- 9. Procedure Returning Top Merchants
-- =========================================================

CREATE OR ALTER PROCEDURE dbo.usp_Top_Fraud_Merchants
    @TopN INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@TopN)
        merchant,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount,
        AVG(amt) AS Average_Fraud_Amount
    FROM dbo.Transactions
    WHERE is_fraud = 1
    GROUP BY merchant
    ORDER BY Fraud_Amount DESC;
END;
GO


-- =========================================================
-- 10. Execute Top Merchant Procedure
-- =========================================================

EXEC dbo.usp_Top_Fraud_Merchants
    @TopN = 10;
GO


-- =========================================================
-- 11. Review Stored Procedures
-- =========================================================

SELECT
    name,
    create_date,
    modify_date
FROM sys.procedures
WHERE name IN
(
    'usp_Fraud_Summary',
    'usp_Fraud_By_Category',
    'usp_High_Value_Fraud',
    'usp_State_Fraud_Analysis',
    'usp_Top_Fraud_Merchants'
)
ORDER BY name;
GO


-- =========================================================
-- Fundamentals Completed
-- Stored Procedures
--
-- Topics Covered:
-- ✓ CREATE OR ALTER PROCEDURE
-- ✓ Procedure Parameters
-- ✓ Default Parameters
-- ✓ EXEC
-- ✓ Fraud Summary
-- ✓ Category Analysis
-- ✓ State Analysis
-- ✓ Merchant Analysis
-- =========================================================