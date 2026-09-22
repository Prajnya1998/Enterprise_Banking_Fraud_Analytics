-- =========================================================
-- SQL Fundamentals: Triggers
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Create Audit Table
-- =========================================================

IF OBJECT_ID('dbo.Fraud_Trigger_Audit', 'U') IS NOT NULL
    DROP TABLE dbo.Fraud_Trigger_Audit;
GO

CREATE TABLE dbo.Fraud_Trigger_Audit
(
    Audit_ID INT IDENTITY(1,1) PRIMARY KEY,
    Merchant VARCHAR(255),
    Category VARCHAR(100),
    Fraud_Amount DECIMAL(18,2),
    Action_Type VARCHAR(20),
    Audit_Date DATETIME DEFAULT GETDATE()
);
GO


-- =========================================================
-- 2. Create Source Table for Trigger Practice
-- =========================================================

IF OBJECT_ID('dbo.Fraud_Review_Queue', 'U') IS NOT NULL
    DROP TABLE dbo.Fraud_Review_Queue;
GO

CREATE TABLE dbo.Fraud_Review_Queue
(
    Review_ID INT IDENTITY(1,1) PRIMARY KEY,
    Merchant VARCHAR(255),
    Category VARCHAR(100),
    Fraud_Amount DECIMAL(18,2),
    Review_Status VARCHAR(30)
        DEFAULT 'Pending'
);
GO


-- =========================================================
-- 3. AFTER INSERT Trigger
-- Log newly inserted fraud-review records
-- =========================================================

CREATE OR ALTER TRIGGER dbo.trg_Fraud_Review_Insert
ON dbo.Fraud_Review_Queue
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Fraud_Trigger_Audit
    (
        Merchant,
        Category,
        Fraud_Amount,
        Action_Type
    )
    SELECT
        Merchant,
        Category,
        Fraud_Amount,
        'INSERT'
    FROM inserted;
END;
GO


-- =========================================================
-- 4. Test INSERT Trigger
-- =========================================================

INSERT INTO dbo.Fraud_Review_Queue
(
    Merchant,
    Category,
    Fraud_Amount
)
VALUES
(
    'Sample Merchant',
    'grocery_pos',
    750.00
);
GO


-- =========================================================
-- 5. Review Audit Record
-- =========================================================

SELECT
    Audit_ID,
    Merchant,
    Category,
    Fraud_Amount,
    Action_Type,
    Audit_Date
FROM dbo.Fraud_Trigger_Audit
ORDER BY Audit_ID DESC;
GO


-- =========================================================
-- 6. AFTER UPDATE Trigger
-- Log changes made to fraud-review records
-- =========================================================

CREATE OR ALTER TRIGGER dbo.trg_Fraud_Review_Update
ON dbo.Fraud_Review_Queue
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Fraud_Trigger_Audit
    (
        Merchant,
        Category,
        Fraud_Amount,
        Action_Type
    )
    SELECT
        i.Merchant,
        i.Category,
        i.Fraud_Amount,
        'UPDATE'
    FROM inserted AS i;
END;
GO


-- =========================================================
-- 7. Test UPDATE Trigger
-- =========================================================

UPDATE dbo.Fraud_Review_Queue
SET Review_Status = 'Under Review'
WHERE Review_ID = 1;
GO


-- =========================================================
-- 8. Review Update Audit
-- =========================================================

SELECT
    Audit_ID,
    Merchant,
    Category,
    Fraud_Amount,
    Action_Type,
    Audit_Date
FROM dbo.Fraud_Trigger_Audit
ORDER BY Audit_ID DESC;
GO


-- =========================================================
-- 9. Create AFTER DELETE Trigger
-- =========================================================

CREATE OR ALTER TRIGGER dbo.trg_Fraud_Review_Delete
ON dbo.Fraud_Review_Queue
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Fraud_Trigger_Audit
    (
        Merchant,
        Category,
        Fraud_Amount,
        Action_Type
    )
    SELECT
        Merchant,
        Category,
        Fraud_Amount,
        'DELETE'
    FROM deleted;
END;
GO


-- =========================================================
-- 10. Test DELETE Trigger
-- =========================================================

DELETE FROM dbo.Fraud_Review_Queue
WHERE Review_ID = 1;
GO


-- =========================================================
-- 11. Review All Trigger Activity
-- =========================================================

SELECT
    Audit_ID,
    Merchant,
    Category,
    Fraud_Amount,
    Action_Type,
    Audit_Date
FROM dbo.Fraud_Trigger_Audit
ORDER BY Audit_ID;
GO


-- =========================================================
-- 12. Review Trigger Metadata
-- =========================================================

SELECT
    name AS Trigger_Name,
    OBJECT_NAME(parent_id) AS Parent_Table,
    create_date,
    modify_date
FROM sys.triggers
WHERE name IN
(
    'trg_Fraud_Review_Insert',
    'trg_Fraud_Review_Update',
    'trg_Fraud_Review_Delete'
);
GO


-- =========================================================
-- 13. Cleanup
-- =========================================================

DROP TRIGGER IF EXISTS dbo.trg_Fraud_Review_Insert;
DROP TRIGGER IF EXISTS dbo.trg_Fraud_Review_Update;
DROP TRIGGER IF EXISTS dbo.trg_Fraud_Review_Delete;
GO

DROP TABLE IF EXISTS dbo.Fraud_Review_Queue;
DROP TABLE IF EXISTS dbo.Fraud_Trigger_Audit;
GO


-- =========================================================
-- Fundamentals Completed
-- Triggers
--
-- Topics Covered:
-- ✓ AFTER INSERT Trigger
-- ✓ AFTER UPDATE Trigger
-- ✓ AFTER DELETE Trigger
-- ✓ inserted Table
-- ✓ deleted Table
-- ✓ Audit Logging
-- ✓ Trigger Metadata
-- =========================================================