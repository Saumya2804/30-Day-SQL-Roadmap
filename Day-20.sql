use school

--Q1: Basic Setup for PIVOT
--Write a query using a CTE to prepare the data for pivoting. The CTE should select Department and Salary from the Employees table, 
--renaming Salary to DepartmentSalary for clarity.
with emp as(
select department , salary as departmentsalary
from employees)
select * from emp;

--Q2: Basic PIVOT (Counting Employees by Department)
--Using the Employees table, PIVOT the data to show the count of employees for each unique Department as a separate column (IT, HR, Finance).

SELECT [IT], [HR], [Finance]
FROM Employees
PIVOT
(   
    COUNT(EmpID) 
    FOR Department IN ([IT], [HR], [Finance])
) AS PivotTable

--Q3: Basic PIVOT with AVG
--Using the Employees table, PIVOT the data to show the average Salary for each Department as a separate column (IT, HR, Finance).
SELECT [IT], [HR], [Finance]
FROM Employees
pivot
(
AVG(salary) for department In ([IT], [HR], [Finance])
) pt


--Q4: Basic UNPIVOT Setup
--Simulate a small table named MonthlySales that stores sales figures for three months in separate columns (Jan, Feb, Mar). 
--Write a SELECT statement to prepare this data for UNPIVOTING.
-- Simulated data setup (not run, just for context)
-- CREATE TABLE MonthlySales (ProductID INT, Jan INT, Feb INT, Mar INT);

SELECT ProductID, [Jan], [Feb], [Mar]
FROM MonthlySales;

--Q5: Basic UNPIVOT Execution
--Using the simulated MonthlySales table from Q4, apply the UNPIVOT operator to transform the month columns (Jan, Feb, Mar)
--into two new columns: MonthName (for the column names) and SalesValue (for the sales figures).
select Monthname , SalesValue
from Monthlysales
Unpivot(
SalesValue FOR MonthName IN ([Jan], [Feb], [Mar])
) AS UnpivotTable;

--Q6: PIVOT with a WHERE Clause
--PIVOT the Orders table to find the total Quantity ordered for the Product 'Laptop', 'Phone', and 'Monitor' only 
--for Customers with CustomerID 'C1' or 'C3'.
with cust as(
select product,quantity
from orders
where customerid IN ('C1','C3'))
select [Laptop], [Phone], [Monitor] from cust
pivot(
sum(quantity) for product in ([Laptop], [Phone], [Monitor])) as pivottabe

--Q7: PIVOT on Non-Numeric Data (MIN or MAX)
--PIVOT the Learners table to find the MAX FirstName (alphabetically last) for each CourseID (e.g., 201, 202, 203).
SELECT [201], [202], [203]
FROM Learners
PIVOT
(
    MAX(FirstName)
    FOR CourseID IN ([201], [202], [203])
) AS MaxNamePivot;


--Q9: PIVOT with Row Headers
--PIVOT the Orders table to display the total Quantity ordered for 'Laptop', 'Phone', and 'Monitor' for each CustomerID (C1, C2, C3, C4, etc.)
select [Laptop], [Phone], [Monitor] from orders
pivot
(sum(quantity) for product in ([Laptop], [Phone], [Monitor]) ) as pvt

--Q10: Using CTE to Clean Data for PIVOT
--Use a CTE to group Learners into two categories: 'High' (Marks?90) and 'Low' (Marks<90). Then, PIVOT this CTE to show the count of learners in 'High' and 
--'Low' groups for CourseID 201, 202, and 203.
with grplearner as (
select courseid,
case 
	when marks >= 90 Then 'High'
	else 'Low'
END as performance
from learners
)
select [High], [Low]
from grplearner
pivot (
count(courseid) for performance in ([High], [Low] ) ) as pvt 


--Q12: PIVOT with Two Row Headers (Complex Aggregation)
--PIVOT the Orders table to show the total Quantity of 'Laptop' and 'Phone' per CustomerID and per Product. (Hint: You need a CTE to group the data first, 
--keeping only the pivoting and aggregating columns, plus the necessary row headers).
with grpdata as (
select customerid, quantity , product from orders
where product in ('Laptop','Phone') )
select customerid ,[laptop],[phone] from grpdata
pivot(
sum(quantity) for product in ([laptop],[phone])) as pvt
order by customerid

    