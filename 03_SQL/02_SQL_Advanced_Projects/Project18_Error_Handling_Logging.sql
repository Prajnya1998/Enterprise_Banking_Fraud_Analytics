-- ==========================================
-- Project 18 : Error Handling & Logging
-- Enterprise Banking Fraud Analytics
-- ==========================================

USE CreditCardFraudDB;
GO

-- ==========================================
-- 1. Create Error Log Table
-- ==========================================

IF OBJECT_ID('dbo.SQL_Error_Log', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.SQL_Error_Log
    (
        Error_Log_ID INT IDENTITY(1,1) PRIMARY KEY,
        Error_Number INT,
        Error_Severity INT,
        Error_State INT,
        Error_Procedure NVARCHAR(255),
        Error_Line INT,
        Error_Message NVARCHAR(4000),
        Error_Date DATETIME DEFAULT GETDATE()
    );
END;
GO


-- ==========================================
-- 2. Basic TRY...CATCH
-- ==========================================

BEGIN TRY

    DECLARE @Result INT;

    SET @Result = 10 / 0;

END TRY
BEGIN CATCH

    INSERT INTO dbo.SQL_Error_Log
    (
        Error_Number,
        Error_Severity,
        Error_State,
        Error_Procedure,
        Error_Line,
        Error_Message
    )
    VALUES
    (
        ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        ERROR_PROCEDURE(),
        ERROR_LINE(),
        ERROR_MESSAGE()
    );

    SELECT
        ERROR_NUMBER() AS Error_Number,
        ERROR_MESSAGE() AS Error_Message,
        ERROR_LINE() AS Error_Line;

END CATCH;
GO


-- ==========================================
-- 3. Error Handling During Fraud Analysis
-- ==========================================

BEGIN TRY

    SELECT
        category,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
    ORDER BY Fraud_Amount DESC;

END TRY
BEGIN CATCH

    INSERT INTO dbo.SQL_Error_Log
    (
        Error_Number,
        Error_Severity,
        Error_State,
        Error_Procedure,
        Error_Line,
        Error_Message
    )
    VALUES
    (
        ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        ERROR_PROCEDURE(),
        ERROR_LINE(),
        ERROR_MESSAGE()
    );

END CATCH;
GO


-- ==========================================
-- 4. Transaction + Error Handling
-- ==========================================

BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO dbo.SQL_Error_Log
    (
        Error_Number,
        Error_Severity,
        Error_State,
        Error_Procedure,
        Error_Line,
        Error_Message
    )
    VALUES
    (
        NULL,
        NULL,
        NULL,
        'Transaction Test',
        NULL,
        'Successful transaction test entry'
    );

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    INSERT INTO dbo.SQL_Error_Log
    (
        Error_Number,
        Error_Severity,
        Error_State,
        Error_Procedure,
        Error_Line,
        Error_Message
    )
    VALUES
    (
        ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        ERROR_PROCEDURE(),
        ERROR_LINE(),
        ERROR_MESSAGE()
    );

END CATCH;
GO


-- ==========================================
-- 5. Business Validation with THROW
-- ==========================================

BEGIN TRY

    DECLARE @FraudAmount DECIMAL(18,2) = -100.00;

    IF @FraudAmount < 0
    BEGIN
        ;THROW 50001,
              'Fraud amount cannot be negative.',
              1;
    END;

END TRY
BEGIN CATCH

    INSERT INTO dbo.SQL_Error_Log
    (
        Error_Number,
        Error_Severity,
        Error_State,
        Error_Procedure,
        Error_Line,
        Error_Message
    )
    VALUES
    (
        ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        ERROR_PROCEDURE(),
        ERROR_LINE(),
        ERROR_MESSAGE()
    );

END CATCH;
GO


-- ==========================================
-- 6. Review Error Log
-- ==========================================

SELECT
    Error_Log_ID,
    Error_Number,
    Error_Severity,
    Error_State,
    Error_Procedure,
    Error_Line,
    Error_Message,
    Error_Date
FROM dbo.SQL_Error_Log
ORDER BY Error_Log_ID DESC;
GO


-- ==========================================
-- 7. Error Count by Error Number
-- ==========================================

SELECT
    Error_Number,
    COUNT(*) AS Error_Count
FROM dbo.SQL_Error_Log
WHERE Error_Number IS NOT NULL
GROUP BY Error_Number
ORDER BY Error_Count DESC;
GO


-- ==========================================
-- Project 18 Completed
-- Error Handling & Logging
--
-- Topics Covered:
-- ✓ TRY...CATCH
-- ✓ ERROR_NUMBER()
-- ✓ ERROR_SEVERITY()
-- ✓ ERROR_STATE()
-- ✓ ERROR_PROCEDURE()
-- ✓ ERROR_LINE()
-- ✓ ERROR_MESSAGE()
-- ✓ THROW
-- ✓ Transaction Error Handling
-- ✓ Error Logging
--
-- Status : Completed
-- ==========================================