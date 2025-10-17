Use School
--Q1: use FIRST VALUE find the name of the highest-paid employee across the entire company.
SELECT
    Name,
    Salary,
    FIRST_VALUE(name) OVER (ORDER BY Salary DESC) AS HighestPaidEmployee
FROM
    Employees;

--Use Last_value() to find the name of the lowest-paid employee across the entire company.
SELECT
    Name,
    Salary,DEPARTMENT,
    LAST_VALUE(Name) OVER ( ORDER BY Salary DESC
        -- Frame is needed to ensure it scans the entire partition/window
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LowestPaidEmployee
FROM
    Employees;

--Use NTILE to divide all ORDERS into four equally sized quartiles based on the PRICE
SELECT * , NTILE(4) OVER( ORDER BY PRICE desc) AS Quartiles FROM Orders

--Q4: USE CIME_DIST()  determine the relative position of each learner's MARKS within the entire group (e.g., to find the percentile rank).
SELECT
    FirstName,
    Marks,
    -- Returns the cumulative distribution (0 to 1)
    CUME_DIST() OVER (ORDER BY Marks ASC) AS PercentileRank
FROM
    Learners

--Q5: Simple Recursive CTE Setup
--Write the ANCHOR and RECURSIVE members of a CTE that simply counts from 1 up to 5.
with counterCTE as(
select 1 as n
union all
select n+1 
from counterCTE 
where n<5)
select * from counterCTE 

--Q6: FIRST_VALUE() per Partition For each DEPARTMENT 
--use FIRST_VALUE() to identify the name of the employee with the highest salary in that specific department.
SELECT Name,DEPARTMENT,SALARY, 
FIRST_VALUE(NAME) OVER(PARTItion BY DEPARTMENT ORDER BY SALARY DESC) AS HighestSalaryEmployee 
from Employees

USE SalesDB
select * from sales.Employees
--Q7: Recursive CTE with Data Retrieval (Managers) 
--Using the concept of a MANAGER table (with columns EmployeeID and ManagerID , use a Recursive CTE to find the name of the ultimate CEO/Top Manager 
With MANAGER As
(SELECT EMPLOYEEID,FIRSTNAME ,MANAGERID FROM SALES.Employees
WHERE EMPLOYEEID = 5
UNION ALL
SELECT E.EMPLOYEEID,E.FIRSTNAME,E.MANAGERID FROM SALES.Employees AS E
JOIN MANAGER M
ON E.EmployeeID = M.MANAGERID
)
SELECT TOP 1 FIRSTName AS UltimateCEO
FROM MANAGER
WHERE ManagerID IS NULL;

USE SCHOOL
--Q8: Window Frame for AVG (Sliding Window)
--Using the ORDERS table, calculate the average PRICE of the current order and the previous two orders (a 3-row sliding window), ordered by ORDERID
SELECT ORDERID, PRICE , 
AVG(PRICE) OVER (ORDER BY ORDERID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Slidingwindown
from orders 

--Q9: Recursive CTE for Calendar Generation
--Use a Recursive CTE to generate a list of all dates in the month of October 2025, starting from Oct 1st.
WITH DATES AS(
SELECT CAST('2025-10-01' AS DATE) AS Startdate
union all
SELECT DATEADD(DAY,1,Startdate)
FROM DATES
WHERE Startdate < '2025-10-31')
SELECT * FROM DATES

--Q10: DENSE_RANK() with a CTE for Top 2 Per Group
--Using a CTE and DENSE_DENSE() find the top 2 products (based on PRICE descending) for each CUSTOMERID in the ORDERS table.
WITH ORDERRNK AS(
SELECT CUSTOMERID, PRODUCT,price, DENSE_RANK() OVER (PARTITION BY CUSTOMERID ORDER BY PRICE DESC) AS RNK FROM Orders)
SELECT CUSTOMERID, PRODUCT,price FROM ORDERRNK
WHERE RNK <= 2;

