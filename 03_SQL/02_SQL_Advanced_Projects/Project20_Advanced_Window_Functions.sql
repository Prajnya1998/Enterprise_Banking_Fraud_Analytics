-- =========================================================
-- Project 20: Advanced Window Functions
-- Enterprise Banking Fraud Analytics
-- =========================================================

USE CreditCardFraudDB;
GO

-- =========================================================
-- 1. LAG()
-- Compare each transaction with the previous transaction
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    LAG(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Previous_Transaction_Amount
FROM Transactions;
GO


-- =========================================================
-- 2. LEAD()
-- Compare each transaction with the next transaction
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    LEAD(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Next_Transaction_Amount
FROM Transactions;
GO


-- =========================================================
-- 3. FIRST_VALUE()
-- Find the first transaction amount for each customer
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    FIRST_VALUE(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS First_Transaction_Amount
FROM Transactions;
GO


-- =========================================================
-- 4. LAST_VALUE()
-- Find the latest transaction amount for each customer
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    LAST_VALUE(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS Last_Transaction_Amount
FROM Transactions;
GO


-- =========================================================
-- 5. NTILE()
-- Divide transactions into amount-based groups
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    NTILE(4) OVER (
        ORDER BY amt
    ) AS Amount_Quartile
FROM Transactions;
GO


-- =========================================================
-- 6. Running Total
-- Calculate cumulative transaction amount by customer
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    SUM(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS Running_Total
FROM Transactions;
GO


-- =========================================================
-- 7. Moving Average
-- Calculate a 3-transaction moving average
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    AVG(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Moving_Average
FROM Transactions;
GO


-- =========================================================
-- 8. Fraud Transaction Analysis
-- Compare current fraud amount with previous transaction
-- =========================================================

SELECT
    trans_date_trans_time,
    cc_num,
    amt,
    is_fraud,
    LAG(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Previous_Amount,
    LEAD(amt) OVER (
        PARTITION BY cc_num
        ORDER BY trans_date_trans_time
    ) AS Next_Amount
FROM Transactions
WHERE is_fraud = 1;
GO


-- =========================================================
-- Project 20 Completed
-- Advanced Window Functions
--
-- Topics Covered:
-- ✓ LAG()
-- ✓ LEAD()
-- ✓ FIRST_VALUE()
-- ✓ LAST_VALUE()
-- ✓ NTILE()
-- ✓ Running Total
-- ✓ Moving Average
-- ✓ Fraud Transaction Analysis
-- =========================================================