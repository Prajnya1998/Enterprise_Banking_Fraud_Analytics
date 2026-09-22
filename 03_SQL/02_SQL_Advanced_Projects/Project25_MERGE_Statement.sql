-- =========================================================
-- Project 25: MERGE Statement
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Create a Target Table for Fraud Category Summary
-- =========================================================

IF OBJECT_ID('dbo.Fraud_Category_Summary', 'U') IS NOT NULL
    DROP TABLE dbo.Fraud_Category_Summary;
GO

CREATE TABLE dbo.Fraud_Category_Summary
(
    category VARCHAR(100) PRIMARY KEY,
    fraud_transactions INT,
    fraud_amount DECIMAL(18,2),
    last_updated DATETIME
);
GO


-- =========================================================
-- 2. Load Initial Summary Data
-- =========================================================

INSERT INTO dbo.Fraud_Category_Summary
(
    category,
    fraud_transactions,
    fraud_amount,
    last_updated
)
SELECT
    category,
    COUNT(*) AS fraud_transactions,
    SUM(amt) AS fraud_amount,
    GETDATE()
FROM Transactions
WHERE is_fraud = 1
GROUP BY category;
GO


-- =========================================================
-- 3. View Initial Target Data
-- =========================================================

SELECT *
FROM dbo.Fraud_Category_Summary
ORDER BY fraud_amount DESC;
GO


-- =========================================================
-- 4. MERGE Source Data into Target Table
-- =========================================================

MERGE dbo.Fraud_Category_Summary AS Target
USING
(
    SELECT
        category,
        COUNT(*) AS fraud_transactions,
        SUM(amt) AS fraud_amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
) AS Source
ON Target.category = Source.category

WHEN MATCHED THEN
    UPDATE SET
        Target.fraud_transactions = Source.fraud_transactions,
        Target.fraud_amount = Source.fraud_amount,
        Target.last_updated = GETDATE()

WHEN NOT MATCHED BY TARGET THEN
    INSERT
    (
        category,
        fraud_transactions,
        fraud_amount,
        last_updated
    )
    VALUES
    (
        Source.category,
        Source.fraud_transactions,
        Source.fraud_amount,
        GETDATE()
    );

GO


-- =========================================================
-- 5. Verify MERGE Result
-- =========================================================

SELECT *
FROM dbo.Fraud_Category_Summary
ORDER BY fraud_amount DESC;
GO


-- =========================================================
-- 6. MERGE with OUTPUT
-- =========================================================

MERGE dbo.Fraud_Category_Summary AS Target
USING
(
    SELECT
        category,
        COUNT(*) AS fraud_transactions,
        SUM(amt) AS fraud_amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
) AS Source
ON Target.category = Source.category

WHEN MATCHED THEN
    UPDATE SET
        Target.fraud_transactions = Source.fraud_transactions,
        Target.fraud_amount = Source.fraud_amount,
        Target.last_updated = GETDATE()

WHEN NOT MATCHED BY TARGET THEN
    INSERT
    (
        category,
        fraud_transactions,
        fraud_amount,
        last_updated
    )
    VALUES
    (
        Source.category,
        Source.fraud_transactions,
        Source.fraud_amount,
        GETDATE()
    )

OUTPUT
    $action AS Merge_Action,
    inserted.category,
    inserted.fraud_transactions,
    inserted.fraud_amount;

GO


-- =========================================================
-- 7. Final Validation
-- =========================================================

SELECT
    category,
    fraud_transactions,
    fraud_amount,
    last_updated
FROM dbo.Fraud_Category_Summary
ORDER BY fraud_amount DESC;
GO


-- =========================================================
-- Project 25 Completed
-- MERGE Statement
--
-- Topics Covered:
-- ✓ MERGE
-- ✓ WHEN MATCHED
-- ✓ WHEN NOT MATCHED BY TARGET
-- ✓ INSERT
-- ✓ UPDATE
-- ✓ OUTPUT / $action
-- ✓ Fraud Category Summary
-- =========================================================