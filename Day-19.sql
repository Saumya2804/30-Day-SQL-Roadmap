use school 
go

--Q1: ROW_NUMBER()
--Use the ROW_NUMBER() window function to assign a sequential number to each employee, ordered by their EmpID.
select *, ROW_NUMBER() OVER(ORDER BY EMPID) ROWNO from employees


--Q2: RANK()
--Use the RANK() window function to rank all learners based on their Marks (highest marks get rank 1).
SELECT * , RANK() OVER(ORDER BY Marks DESC) AS MARKS_RANKING FROM Learners


--Q3: Basic CTE
--Write a CTE named IT_Salaries that selects the Name and Salary of all employees in the 'IT' department. Then, select all data from the CTE
with IT_Salaries as(
select name,salary
from employees
where Department = 'IT'
)
select * from IT_Salaries


--Q4: PARTITION BY
--Use the ROW_NUMBER() function, partitioned by Department, to assign a unique, sequential number to employees within each department, 
--ordered by Salary (ascending).
SELECT *, ROW_NUMBER() OVER(PARTITION BY department order by salary asc) as RNK from Employees


--Q5: CTE and Filter
--Write a CTE named High_Ratings that selects movies with a Rating≥8.8. Use the CTE to find the number of 'Sci-Fi' movies.
with High_Ratings as(
select *
from Movies
where rating > = 8.8
)
SELECT COUNT(*) AS SciFiCount
FROM High_Ratings
WHERE Genre = 'Sci-Fi';


--Q6: DENSE_RANK() vs RANK()
--Use both RANK() and DENSE_RANK() to rank learners by their Marks. Explain the difference if two learners have the exact same marks.

SELECT
    FirstName,
    Marks,
    RANK() OVER (ORDER BY Marks DESC) AS StandardRank,
    DENSE_RANK() OVER (ORDER BY Marks DESC) AS DenseRank
FROM
    Learners
ORDER BY Marks DESC;


--RANK() assigns the same rank to ties but skips the next rank number. (e.g., 1, 2, 2, 4)

--DENSE_RANK() assigns the same rank to ties and does not skip the next rank number. (e.g., 1, 2, 2, 3)


--Q7: LAG()
--Use the LAG() window function, ordered by OrderID, to find the Price of the previous order placed by the same CustomerID.
select * from Orders

select * , LAG(Price,1,0) over(partition by customerid order by orderid) as previous_price from orders


--Q8: Running Total (Windowed SUM)
--Use the windowed SUM() function to calculate a Running Total of the Revenue (Quantity×Price) for all orders, ordered by OrderID.
select (Quantity*Price) as revenue ,SUM(Quantity*Price) over(order by orderid) as running_tatal
from orders



--Q9: CTE for Top N Per Group
--Using a CTE and a ranking function, find the employee with the highest salary in each Department.
with highest_salary as(
select name, salary,Department
from Employees)
select name, salary,Department FROM (SELECT * , DENSE_RANK() OVER(PARTITION BY Department ORDER BY SALARY DESC) AS RNK from highest_salary) AS T 
WHERE RNK = 1;

--OR

WITH RankedEmployees AS (
    SELECT
        Name,
        Department,
        Salary,
        RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
    FROM
        Employees
)
SELECT Name, Department, Salary
FROM RankedEmployees
WHERE DeptRank = 1;


--Q10: LEAD() and Percentage Difference
--Use the LEAD() function, ordered by Marks, to find the Marks of the next highest scoring learner

SELECT
    FirstName,
    Marks AS CurrentMarks,
    LEAD(Marks) OVER (ORDER BY Marks DESC) AS NextHighestMarks
FROM
    Learners
ORDER BY Marks DESC;


--Q11: CTE to UPDATE (Conditional UPDATE)
--Use a CTE to identify all employees in the 'Finance' department whose Salary is below 60000. Then, outside the CTE,
--write an UPDATE statement to give those identified employees a 10% raise.

WITH LowFinance AS (
    SELECT
        EmpID,
        Salary
    FROM
        Employees
    WHERE
        Department = 'Finance' AND Salary < 60000
)

UPDATE E
SET Salary = E.Salary * 1.10
FROM Employees E
JOIN LowFinance LF ON E.EmpID = LF.EmpID
where Department = 'Finace';


SELECT Name, Salary FROM Employees 
WHERE EmpID = 4

--Q12: Ntile() (Grouping)
--Use the NTILE() window function to divide all learners into 3 equal groups (tertiles) based on their Marks.
SELECT
    FirstName,
    Marks,
    NTILE(3) OVER (ORDER BY Marks DESC) AS MarkGroup
FROM
    Learners
ORDER BY Marks DESC;


