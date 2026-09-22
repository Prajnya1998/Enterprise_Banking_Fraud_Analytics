-- =========================================================
-- Project 23: Error Handling
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Basic TRY...CATCH
-- =========================================================

BEGIN TRY

    DECLARE @Result INT;

    SET @Result = 10 / 0;

END TRY
BEGIN CATCH

    SELECT
        ERROR_NUMBER() AS Error_Number,
        ERROR_MESSAGE() AS Error_Message,
        ERROR_LINE() AS Error_Line,
        ERROR_PROCEDURE() AS Error_Procedure,
        ERROR_SEVERITY() AS Error_Severity,
        ERROR_STATE() AS Error_State;

END CATCH;
GO


-- =========================================================
-- 2. Error Handling with a Transaction
-- =========================================================

CREATE TABLE #FraudAudit
(
    Audit_ID INT IDENTITY(1,1),
    Category VARCHAR(100),
    Fraud_Amount DECIMAL(18,2),
    Created_Date DATETIME DEFAULT GETDATE()
);
GO

BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO #FraudAudit
    (
        Category,
        Fraud_Amount
    )
    SELECT TOP 10
        category,
        amt
    FROM Transactions
    WHERE is_fraud = 1
    ORDER BY amt DESC;

    COMMIT TRANSACTION;

    PRINT 'Transaction completed successfully.';

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER() AS Error_Number,
        ERROR_MESSAGE() AS Error_Message,
        ERROR_LINE() AS Error_Line;

END CATCH;
GO


-- =========================================================
-- 3. Validate the Inserted Audit Data
-- =========================================================

SELECT *
FROM #FraudAudit
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 4. Handling a Business Validation Error
-- =========================================================

BEGIN TRY

    DECLARE @FraudAmount DECIMAL(18,2) = -100;

    IF @FraudAmount < 0
        THROW 50001, 'Fraud amount cannot be negative.', 1;

END TRY
BEGIN CATCH

    SELECT
        ERROR_NUMBER() AS Error_Number,
        ERROR_MESSAGE() AS Error_Message,
        ERROR_LINE() AS Error_Line;

END CATCH;
GO


-- =========================================================
-- 5. Error Handling with Multiple Operations
-- =========================================================

BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO #FraudAudit
    (
        Category,
        Fraud_Amount
    )
    VALUES
    ('Fraud Monitoring', 500.00);

    -- Intentional error for demonstration
    DECLARE @Value INT = 1 / 0;

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER() AS Error_Number,
        ERROR_MESSAGE() AS Error_Message,
        ERROR_LINE() AS Error_Line;

END CATCH;
GO


-- =========================================================
-- 6. Verify Final Audit Data
-- =========================================================

SELECT *
FROM #FraudAudit
ORDER BY Audit_ID;
GO


-- =========================================================
-- 7. Cleanup
-- =========================================================

DROP TABLE #FraudAudit;
GO


-- =========================================================
-- Project 23 Completed
-- Error Handling
--
-- Topics Covered:
-- ✓ TRY...CATCH
-- ✓ ERROR_NUMBER()
-- ✓ ERROR_MESSAGE()
-- ✓ ERROR_LINE()
-- ✓ ERROR_PROCEDURE()
-- ✓ ERROR_SEVERITY()
-- ✓ ERROR_STATE()
-- ✓ THROW
-- ✓ Transaction Rollback
-- ✓ Business Validation
-- =========================================================