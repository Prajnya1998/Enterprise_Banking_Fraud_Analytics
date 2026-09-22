-- =========================================================
-- Project 26: XML & JSON
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Generate Fraud Data as JSON
-- =========================================================

SELECT TOP 20
    trans_date_trans_time,
    category,
    state,
    amt,
    is_fraud
FROM Transactions
WHERE is_fraud = 1
ORDER BY amt DESC
FOR JSON PATH;
GO


-- =========================================================
-- 2. Generate Fraud Summary as JSON
-- =========================================================

SELECT
    category,
    COUNT(*) AS fraud_transactions,
    SUM(amt) AS fraud_amount,
    AVG(amt) AS average_fraud_amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY fraud_transactions DESC
FOR JSON PATH;
GO


-- =========================================================
-- 3. Store JSON Result in a Variable
-- =========================================================

DECLARE @FraudJSON NVARCHAR(MAX);

SET @FraudJSON =
(
    SELECT TOP 10
        category,
        state,
        amt,
        is_fraud
    FROM Transactions
    WHERE is_fraud = 1
    ORDER BY amt DESC
    FOR JSON PATH
);

SELECT @FraudJSON AS Fraud_JSON;
GO


-- =========================================================
-- 4. Read JSON Using OPENJSON
-- =========================================================

DECLARE @FraudJSON NVARCHAR(MAX);

SET @FraudJSON =
(
    SELECT TOP 10
        category,
        state,
        amt,
        is_fraud
    FROM Transactions
    WHERE is_fraud = 1
    ORDER BY amt DESC
    FOR JSON PATH
);

SELECT
    category,
    state,
    amt,
    is_fraud
FROM OPENJSON(@FraudJSON)
WITH
(
    category VARCHAR(100) '$.category',
    state VARCHAR(50) '$.state',
    amt DECIMAL(18,2) '$.amt',
    is_fraud INT '$.is_fraud'
);
GO


-- =========================================================
-- 5. JSON_VALUE()
-- Extract a Value from JSON
-- =========================================================

DECLARE @TransactionJSON NVARCHAR(MAX);

SET @TransactionJSON = N'
{
    "category": "grocery_pos",
    "state": "NY",
    "amount": 525.50,
    "is_fraud": 1
}';

SELECT
    JSON_VALUE(@TransactionJSON, '$.category') AS Category,
    JSON_VALUE(@TransactionJSON, '$.state') AS State,
    JSON_VALUE(@TransactionJSON, '$.amount') AS Amount,
    JSON_VALUE(@TransactionJSON, '$.is_fraud') AS Is_Fraud;
GO


-- =========================================================
-- 6. JSON_QUERY()
-- Extract a JSON Object
-- =========================================================

DECLARE @FraudObject NVARCHAR(MAX);

SET @FraudObject = N'
{
    "transaction": {
        "category": "grocery_pos",
        "state": "NY",
        "amount": 525.50
    }
}';

SELECT
    JSON_QUERY(@FraudObject, '$.transaction') AS Transaction_Object;
GO


-- =========================================================
-- 7. JSON_MODIFY()
-- Update a JSON Value
-- =========================================================

DECLARE @ModifiedJSON NVARCHAR(MAX);

SET @ModifiedJSON = N'
{
    "category": "grocery_pos",
    "state": "NY",
    "amount": 525.50
}';

SET @ModifiedJSON =
    JSON_MODIFY(
        @ModifiedJSON,
        '$.amount',
        600.00
    );

SELECT @ModifiedJSON AS Modified_JSON;
GO


-- =========================================================
-- 8. Generate Fraud Data as XML
-- =========================================================

SELECT TOP 20
    category,
    state,
    amt,
    is_fraud
FROM Transactions
WHERE is_fraud = 1
ORDER BY amt DESC
FOR XML PATH('Transaction'), ROOT('FraudTransactions');
GO


-- =========================================================
-- 9. Store XML Result
-- =========================================================

DECLARE @FraudXML XML;

SET @FraudXML =
(
    SELECT TOP 10
        category,
        state,
        amt,
        is_fraud
    FROM Transactions
    WHERE is_fraud = 1
    ORDER BY amt DESC
    FOR XML PATH('Transaction'),
    ROOT('FraudTransactions')
);

SELECT @FraudXML AS Fraud_XML;
GO


-- =========================================================
-- 10. XML Value Extraction
-- =========================================================

DECLARE @FraudXML XML;

SET @FraudXML =
(
    SELECT TOP 1
        category,
        state,
        amt,
        is_fraud
    FROM Transactions
    WHERE is_fraud = 1
    ORDER BY amt DESC
    FOR XML PATH('Transaction'),
    ROOT('FraudTransactions')
);

SELECT
    @FraudXML.value(
        '(/FraudTransactions/Transaction/category/text())[1]',
        'VARCHAR(100)'
    ) AS Category,
    @FraudXML.value(
        '(/FraudTransactions/Transaction/state/text())[1]',
        'VARCHAR(50)'
    ) AS State,
    @FraudXML.value(
        '(/FraudTransactions/Transaction/amt/text())[1]',
        'DECIMAL(18,2)'
    ) AS Amount;
GO


-- =========================================================
-- 11. JSON Fraud Summary
-- =========================================================

SELECT
    category AS Category,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY Fraud_Amount DESC
FOR JSON PATH, ROOT('FraudSummary');
GO


-- =========================================================
-- Project 26 Completed
-- XML & JSON
--
-- Topics Covered:
-- ✓ FOR JSON PATH
-- ✓ OPENJSON()
-- ✓ JSON_VALUE()
-- ✓ JSON_QUERY()
-- ✓ JSON_MODIFY()
-- ✓ FOR XML PATH()
-- ✓ XML Data Type
-- ✓ XML.value()
-- ✓ Fraud Data Serialization
-- =========================================================