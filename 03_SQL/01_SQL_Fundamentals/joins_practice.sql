-- =========================================================
-- SQL Fundamentals: JOINs
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. INNER JOIN
-- Join fraud transactions with category-level summary
-- =========================================================

WITH CategorySummary AS
(
    SELECT
        category,
        COUNT(*) AS Total_Transactions,
        SUM(amt) AS Total_Amount
    FROM Transactions
    GROUP BY category
)
SELECT TOP 50
    t.trans_date_trans_time,
    t.merchant,
    t.category,
    t.amt,
    t.is_fraud,
    c.Total_Transactions,
    c.Total_Amount
FROM Transactions AS t
INNER JOIN CategorySummary AS c
    ON t.category = c.category
WHERE t.is_fraud = 1
ORDER BY t.amt DESC;
GO


-- =========================================================
-- 2. LEFT JOIN
-- Keep all category summaries and attach fraud metrics
-- =========================================================

WITH AllCategories AS
(
    SELECT
        category,
        COUNT(*) AS Total_Transactions,
        SUM(amt) AS Total_Amount
    FROM Transactions
    GROUP BY category
),
FraudCategories AS
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
    a.category,
    a.Total_Transactions,
    a.Total_Amount,
    COALESCE(f.Fraud_Transactions, 0) AS Fraud_Transactions,
    COALESCE(f.Fraud_Amount, 0) AS Fraud_Amount
FROM AllCategories AS a
LEFT JOIN FraudCategories AS f
    ON a.category = f.category
ORDER BY Fraud_Amount DESC;
GO


-- =========================================================
-- 3. JOIN with State-Level Summary
-- =========================================================

WITH StateSummary AS
(
    SELECT
        state,
        COUNT(*) AS Total_Transactions,
        SUM(amt) AS Total_Amount,
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
            AS Fraud_Transactions
    FROM Transactions
    GROUP BY state
)
SELECT TOP 20
    t.state,
    t.category,
    COUNT(*) AS Category_Transactions,
    s.Total_Transactions,
    s.Total_Amount,
    s.Fraud_Transactions
FROM Transactions AS t
INNER JOIN StateSummary AS s
    ON t.state = s.state
GROUP BY
    t.state,
    t.category,
    s.Total_Transactions,
    s.Total_Amount,
    s.Fraud_Transactions
ORDER BY s.Fraud_Transactions DESC;
GO


-- =========================================================
-- 4. SELF JOIN
-- Compare transactions from the same customer
-- =========================================================

SELECT TOP 50
    t1.cc_num,
    t1.trans_date_trans_time AS Transaction_1_Date,
    t1.amt AS Transaction_1_Amount,
    t2.trans_date_trans_time AS Transaction_2_Date,
    t2.amt AS Transaction_2_Amount
FROM Transactions AS t1
INNER JOIN Transactions AS t2
    ON t1.cc_num = t2.cc_num
   AND t1.trans_date_trans_time < t2.trans_date_trans_time
WHERE t1.is_fraud = 1
ORDER BY
    t1.cc_num,
    t1.trans_date_trans_time;
GO


-- =========================================================
-- 5. JOIN Using a Derived Table
-- Find merchants with their fraud totals
-- =========================================================

SELECT TOP 10
    m.merchant,
    m.Total_Transactions,
    f.Fraud_Transactions,
    f.Fraud_Amount
FROM
(
    SELECT
        merchant,
        COUNT(*) AS Total_Transactions
    FROM Transactions
    GROUP BY merchant
) AS m
INNER JOIN
(
    SELECT
        merchant,
        COUNT(*) AS Fraud_Transactions,
        SUM(amt) AS Fraud_Amount
    FROM Transactions
    WHERE is_fraud = 1
    GROUP BY merchant
) AS f
    ON m.merchant = f.merchant
ORDER BY f.Fraud_Amount DESC;
GO


-- =========================================================
-- 6. Multiple JOIN Logic
-- Customer + Category + State Analysis
-- =========================================================

WITH CustomerSummary AS
(
    SELECT
        cc_num,
        COUNT(*) AS Total_Transactions,
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
            AS Fraud_Transactions,
        SUM(CASE WHEN is_fraud = 1 THEN amt ELSE 0 END)
            AS Fraud_Amount
    FROM Transactions
    GROUP BY cc_num
),
CategorySummary AS
(
    SELECT
        category,
        COUNT(*) AS Category_Transactions
    FROM Transactions
    GROUP BY category
)
SELECT TOP 50
    t.cc_num,
    t.category,
    t.state,
    c.Total_Transactions,
    c.Fraud_Transactions,
    c.Fraud_Amount,
    cat.Category_Transactions
FROM Transactions AS t
INNER JOIN CustomerSummary AS c
    ON t.cc_num = c.cc_num
INNER JOIN CategorySummary AS cat
    ON t.category = cat.category
WHERE t.is_fraud = 1
ORDER BY c.Fraud_Amount DESC;
GO


-- =========================================================
-- 7. JOIN with Fraud Rate Calculation
-- =========================================================

WITH StateSummary AS
(
    SELECT
        state,
        COUNT(*) AS Total_Transactions,
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
            AS Fraud_Transactions
    FROM Transactions
    GROUP BY state
)
SELECT
    s.state,
    s.Total_Transactions,
    s.Fraud_Transactions,
    CAST(
        100.0 * s.Fraud_Transactions
        / NULLIF(s.Total_Transactions, 0)
        AS DECIMAL(10,2)
    ) AS Fraud_Rate_Percent
FROM StateSummary AS s
ORDER BY Fraud_Rate_Percent DESC;
GO


-- =========================================================
-- 8. JOIN Interview Notes
-- =========================================================

-- INNER JOIN:
-- Returns rows where a match exists in both result sets.
--
-- LEFT JOIN:
-- Returns all rows from the left side and matching rows
-- from the right side.
--
-- RIGHT JOIN:
-- Returns all rows from the right side and matching rows
-- from the left side.
--
-- FULL OUTER JOIN:
-- Returns matching and non-matching rows from both sides.
--
-- SELF JOIN:
-- Joins a table to itself using different aliases.
--
-- JOIN conditions are normally written in the ON clause.


-- =========================================================
-- Fundamentals Completed
-- JOINs
--
-- Topics Covered:
-- ✓ INNER JOIN
-- ✓ LEFT JOIN
-- ✓ SELF JOIN
-- ✓ Derived Table JOIN
-- ✓ Multiple JOINs
-- ✓ JOIN with Aggregation
-- ✓ Fraud Analysis
-- =========================================================