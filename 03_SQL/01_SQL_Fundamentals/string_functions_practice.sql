-- =========================================================
-- SQL Fundamentals: String Functions
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. UPPER()
-- Convert category to uppercase
-- =========================================================

SELECT TOP 20
    category,
    UPPER(category) AS Category_Upper
FROM Transactions;
GO


-- =========================================================
-- 2. LOWER()
-- Convert category to lowercase
-- =========================================================

SELECT TOP 20
    category,
    LOWER(category) AS Category_Lower
FROM Transactions;
GO


-- =========================================================
-- 3. LEN()
-- Find length of merchant names
-- =========================================================

SELECT TOP 20
    merchant,
    LEN(merchant) AS Merchant_Name_Length
FROM Transactions
ORDER BY Merchant_Name_Length DESC;
GO


-- =========================================================
-- 4. LEFT()
-- Extract first characters from merchant name
-- =========================================================

SELECT TOP 20
    merchant,
    LEFT(merchant, 10) AS Merchant_Prefix
FROM Transactions;
GO


-- =========================================================
-- 5. RIGHT()
-- Extract last characters from merchant name
-- =========================================================

SELECT TOP 20
    merchant,
    RIGHT(merchant, 10) AS Merchant_Suffix
FROM Transactions;
GO


-- =========================================================
-- 6. SUBSTRING()
-- Extract part of a merchant name
-- =========================================================

SELECT TOP 20
    merchant,
    SUBSTRING(merchant, 1, 15) AS Merchant_Part
FROM Transactions;
GO


-- =========================================================
-- 7. CHARINDEX()
-- Find the position of a character
-- =========================================================

SELECT TOP 20
    merchant,
    CHARINDEX(' ', merchant) AS First_Space_Position
FROM Transactions;
GO


-- =========================================================
-- 8. REPLACE()
-- Replace text inside a category value
-- =========================================================

SELECT TOP 20
    category,
    REPLACE(category, '_', ' ') AS Category_Display
FROM Transactions;
GO


-- =========================================================
-- 9. CONCAT()
-- Combine category and state
-- =========================================================

SELECT TOP 20
    CONCAT(category, ' - ', state) AS Category_State
FROM Transactions;
GO


-- =========================================================
-- 10. TRIM()
-- Remove leading and trailing spaces
-- =========================================================

SELECT TOP 20
    merchant,
    TRIM(merchant) AS Clean_Merchant
FROM Transactions;
GO


-- =========================================================
-- 11. LTRIM() and RTRIM()
-- =========================================================

SELECT TOP 20
    merchant,
    LTRIM(merchant) AS Left_Cleaned,
    RTRIM(merchant) AS Right_Cleaned
FROM Transactions;
GO


-- =========================================================
-- 12. String Functions with CASE
-- Create a readable fraud label
-- =========================================================

SELECT TOP 50
    merchant,
    category,
    CASE
        WHEN is_fraud = 1 THEN 'Fraud'
        ELSE 'Genuine'
    END AS Fraud_Label
FROM Transactions;
GO


-- =========================================================
-- 13. String Functions with Fraud Analysis
-- =========================================================

SELECT
    REPLACE(category, '_', ' ') AS Category_Display,
    COUNT(*) AS Fraud_Transactions,
    SUM(amt) AS Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY REPLACE(category, '_', ' ')
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 14. Search Using CHARINDEX()
-- Find merchants containing a text pattern
-- =========================================================

SELECT TOP 50
    merchant,
    category,
    amt,
    is_fraud
FROM Transactions
WHERE CHARINDEX('market', LOWER(merchant)) > 0;
GO


-- =========================================================
-- Fundamentals Completed
-- String Functions
--
-- Topics Covered:
-- ✓ UPPER()
-- ✓ LOWER()
-- ✓ LEN()
-- ✓ LEFT()
-- ✓ RIGHT()
-- ✓ SUBSTRING()
-- ✓ CHARINDEX()
-- ✓ REPLACE()
-- ✓ CONCAT()
-- ✓ TRIM()
-- ✓ LTRIM()
-- ✓ RTRIM()
-- ✓ CASE
-- ✓ String-Based Fraud Analysis
-- =========================================================