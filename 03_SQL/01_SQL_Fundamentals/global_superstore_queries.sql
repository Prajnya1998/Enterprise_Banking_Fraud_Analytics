-- =========================================================
-- SQL Fundamentals: Global Superstore Queries
-- =========================================================

USE GlobalSuperstore;
GO

-- =========================================================
-- 1. View Sample Records
-- =========================================================

SELECT TOP 20 *
FROM [dbo].[Global_Superstore(CSV)];
GO


-- =========================================================
-- 2. Total Sales
-- =========================================================

SELECT
    SUM(Sales) AS Total_Sales
FROM [dbo].[Global_Superstore(CSV)];
GO


-- =========================================================
-- 3. Total Profit
-- =========================================================

SELECT
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)];
GO


-- =========================================================
-- 4. Sales by Category
-- =========================================================

SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Category
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 5. Profit by Category
-- =========================================================

SELECT
    Category,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Category
ORDER BY Total_Profit DESC;
GO


-- =========================================================
-- 6. Sales by Region
-- =========================================================

SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Region
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 7. Top 10 Customers by Sales
-- =========================================================

SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 8. Top 10 Customers by Profit
-- =========================================================

SELECT TOP 10
    Customer_Name,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Customer_Name
ORDER BY Total_Profit DESC;
GO


-- =========================================================
-- 9. Top 10 Products by Sales
-- =========================================================

SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Product_Name
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 10. Top 10 Products by Profit
-- =========================================================

SELECT TOP 10
    Product_Name,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Product_Name
ORDER BY Total_Profit DESC;
GO


-- =========================================================
-- 11. Loss-Making Products
-- =========================================================

SELECT
    Product_Name,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;
GO


-- =========================================================
-- 12. Sales by Segment
-- =========================================================

SELECT
    Segment,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY Segment
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 13. Sales by State
-- =========================================================

SELECT
    State,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM [dbo].[Global_Superstore(CSV)]
GROUP BY State
ORDER BY Total_Sales DESC;
GO


-- =========================================================
-- 14. Average Sales per Order
-- =========================================================

SELECT
    AVG(Sales) AS Average_Sales
FROM [dbo].[Global_Superstore(CSV)];
GO


-- =========================================================
-- 15. High-Value Sales Transactions
-- =========================================================

SELECT TOP 20
    Customer_Name,
    Product_Name,
    Category,
    Sales,
    Profit
FROM [dbo].[Global_Superstore(CSV)]
WHERE Sales >= 1000
ORDER BY Sales DESC;
GO


-- =========================================================
-- Fundamentals Completed
-- Global Superstore Queries
--
-- Topics Covered:
-- ✓ SUM()
-- ✓ AVG()
-- ✓ GROUP BY
-- ✓ HAVING
-- ✓ TOP
-- ✓ ORDER BY
-- ✓ Sales Analysis
-- ✓ Profit Analysis
-- ✓ Customer Analysis
-- ✓ Product Analysis
-- ✓ Regional Analysis
-- =========================================================