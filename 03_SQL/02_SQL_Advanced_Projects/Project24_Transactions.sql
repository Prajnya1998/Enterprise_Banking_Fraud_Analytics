-- =========================================================
-- Project 24: Transactions
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Start a Transaction
-- =========================================================

BEGIN TRANSACTION;

SELECT
    COUNT(*) AS Fraud_Transactions
FROM Transactions
WHERE is_fraud = 1;

COMMIT TRANSACTION;
GO


-- =========================================================
-- 2. Transaction with Temporary Audit Table
-- =========================================================

CREATE TABLE #TransactionAudit
(
    Audit_ID INT IDENTITY(1,1),
    Category VARCHAR(100),
    Fraud_Amount DECIMAL(18,2),
    Audit_Date DATETIME DEFAULT GETDATE()
);
GO


BEGIN TRANSACTION;

INSERT INTO #TransactionAudit
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
GO


-- =========================================================
-- 3. Verify Committed Data
-- =========================================================

SELECT *
FROM #TransactionAudit
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 4. ROLLBACK Demonstration
-- =========================================================

BEGIN TRANSACTION;

INSERT INTO #TransactionAudit
(
    Category,
    Fraud_Amount
)
VALUES
(
    'Rollback Test',
    999999.99
);

SELECT *
FROM #TransactionAudit
WHERE Category = 'Rollback Test';

ROLLBACK TRANSACTION;
GO


-- =========================================================
-- 5. Verify Rollback
-- =========================================================

SELECT *
FROM #TransactionAudit
WHERE Category = 'Rollback Test';
GO


-- =========================================================
-- 6. Transaction with TRY...CATCH
-- =========================================================

BEGIN TRY

    BEGIN TRANSACTION;

    INSERT INTO #TransactionAudit
    (
        Category,
        Fraud_Amount
    )
    VALUES
    (
        'Transaction Test',
        500.00
    );

    COMMIT TRANSACTION;

END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SELECT
        ERROR_NUMBER() AS Error_Number,
        ERROR_MESSAGE() AS Error_Message;

END CATCH;
GO


-- =========================================================
-- 7. Verify Successful Transaction
-- =========================================================

SELECT *
FROM #TransactionAudit
WHERE Category = 'Transaction Test';
GO


-- =========================================================
-- 8. Transaction Status
-- =========================================================

SELECT
    @@TRANCOUNT AS Active_Transaction_Count;
GO


-- =========================================================
-- 9. Cleanup
-- =========================================================

DROP TABLE #TransactionAudit;
GO


-- =========================================================
-- Project 24 Completed
-- Transactions
--
-- Topics Covered:
-- ✓ BEGIN TRANSACTION
-- ✓ COMMIT TRANSACTION
-- ✓ ROLLBACK TRANSACTION
-- ✓ TRY...CATCH
-- ✓ @@TRANCOUNT
-- ✓ Transaction Verification
-- ✓ Temporary Audit Data
-- =========================================================