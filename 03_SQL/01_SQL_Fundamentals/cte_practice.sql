-- =========================================================
-- SQL Fundamentals: Common Table Expressions (CTE)
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. Basic CTE
-- Fraud transactions by category
-- =========================================================

WITH FraudByCategory AS
(
    SELECT
        category,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
)
SELECT
    category,
    Fraud_Transactions,
    Fraud_Amount
FROM FraudByCategory
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 2. CTE with Fraud Rate
-- =========================================================

WITH CategorySummary AS
(
    SELECT
        category,
        COUNT(*) AS Total_Transactions,
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
            AS Fraud_Transactions
    FROM Transactions
    GROUP BY category
)
SELECT
    category,
    Total_Transactions,
    Fraud_Transactions,
    CAST(
        100.0 * Fraud_Transactions
        / NULLIF(Total_Transactions, 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM CategorySummary
ORDER BY Fraud_Rate_Percent DESC;
GO


-- =========================================================
-- 3. CTE with High-Value Fraud Transactions
-- =========================================================

WITH HighValueFraud AS
(
    SELECT
        trans_date_trans_time,
        merchant,
        category,
        state,
        amt
    FROM Transactions
    WHERE is_fraud = 1
      AND amt >= 500
)
SELECT
    trans_date_trans_time,
    merchant,
    category,
    state,
    amt
FROM HighValueFraud
ORDER BY amt DESC;
GO


-- =========================================================
-- 4. CTE with Customer Fraud Summary
-- =========================================================

WITH CustomerFraud AS
(
    SELECT
        cc_num,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount,
        AVG(amt) AS Average_Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY cc_num
)
SELECT TOP 20
    cc_num,
    Fraud_Transactions,
    Fraud_Amount,
    Average_Fraud_Amount
FROM CustomerFraud
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 5. Multiple CTEs
-- Category and state fraud analysis
-- =========================================================

WITH CategoryFraud AS
(
    SELECT
        category,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
),
StateFraud AS
(
    SELECT
        state,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY state
)
SELECT
    category,
    Fraud_Transactions,
    Fraud_Amount
FROM CategoryFraud
ORDER BY Fraud_Amount DESC;
GO

SELECT
    state,
    Fraud_Transactions,
    Fraud_Amount
FROM StateFraud
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 6. CTE for Above-Average Fraud Categories
-- =========================================================

WITH CategoryAverage AS
(
    SELECT
        category,
        AVG(amt) AS Average_Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY category
)
SELECT
    category,
    Average_Fraud_Amount
FROM CategoryAverage
WHERE Average_Fraud_Amount >
(
    SELECT AVG(amt)
    FROM Transactions
    WHERE is_fraud = 1
)
ORDER BY Average_Fraud_Amount DESC;
GO


-- =========================================================
-- Fundamentals Completed
-- Common Table Expressions (CTE)
--
-- Topics Covered:
-- ✓ Basic CTE
-- ✓ Aggregation with CTE
-- ✓ Fraud Rate
-- ✓ Multiple CTEs
-- ✓ Customer Analysis
-- ✓ High-Value Fraud Analysis
-- ✓ CTE with Subquery
-- =========================================================