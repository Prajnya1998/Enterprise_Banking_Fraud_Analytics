-- Project 16 : SQL Performance Tuning

USE GlobalSuperstore;
GO

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

SELECT *
FROM [dbo].[Global_Superstore(CSV)]
WHERE UPPER(Category) = 'TECHNOLOGY'
ORDER BY Sales DESC;
GO

-- ==========================================
-- Project 16 : Interview Questions
-- ==========================================

-- Q1. What is SQL Performance Tuning?

-- Answer:
-- SQL Performance Tuning is the process of optimizing SQL queries
-- to reduce execution time, CPU usage, memory usage and logical reads
-- while returning the same result.

------------------------------------------------------------

-- Q2. Which tools are used for Performance Tuning?

-- Answer:
-- 1. Actual Execution Plan
-- 2. SET STATISTICS IO ON
-- 3. SET STATISTICS TIME ON

------------------------------------------------------------

-- Q3. Why should we avoid SELECT * ?

-- Answer:
-- SELECT * returns every column even if they are not required.
-- It increases I/O, memory usage and network traffic.

------------------------------------------------------------

-- Q4. What is a SARGable Query?

-- Answer:
-- A SARGable query allows SQL Server to efficiently use an index.
-- Example:
-- WHERE Category='Technology'

------------------------------------------------------------

-- Q5. What is a Non-SARGable Query?

-- Answer:
-- A query that applies functions or calculations on indexed columns.
-- Example:
-- WHERE UPPER(Category)='TECHNOLOGY'

------------------------------------------------------------

-- Q6. What is Logical Read?

-- Answer:
-- Logical Reads indicate how many data pages SQL Server
-- reads from memory while executing a query.

------------------------------------------------------------

-- Q7. What is an Execution Plan?

-- Answer:
-- It is a graphical representation of how SQL Server
-- executes a query.

------------------------------------------------------------

-- Q8. Which is better?

-- Index Seek

-- or

-- Table Scan?

-- Answer:
-- Index Seek is generally better because it reads only
-- the required rows instead of scanning the whole table.

GO

-- ==========================================
-- Project 16 Completed
-- SQL Performance Tuning
--
-- Topics Covered:
-- ✓ Execution Plans
-- ✓ SET STATISTICS IO
-- ✓ SET STATISTICS TIME
-- ✓ Avoid SELECT *
-- ✓ SARGable Queries
-- ✓ Optimizing JOINs
-- ✓ Optimizing WHERE Clause
-- ✓ Performance Tuning Scenario
-- ✓ Interview Questions
--
-- Status : Completed
-- ==========================================