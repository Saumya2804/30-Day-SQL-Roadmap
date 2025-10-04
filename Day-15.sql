--Easy Questions 
--Q1: UNION ALL (Combining Data)
--List all name an from the Employees table combined with all firstname and Marks from the Learners table. Allow duplicates.


SELECT Name, Salary
FROM Employees
UNION ALL
SELECT FirstName, Marks
FROM Learners;


--Q2: UNION (Combining and Deduplicating)
--Combine the Department names from the Employees table with the unique Genre names from the Movies table.


SELECT Department
FROM Employees
UNION
SELECT Genre
FROM Movies;

--Q3: INTERSECT (Finding Commonality)
--Find the EmpId from the Employees table that also exist as LearnerIDin the Learners table.

SELECT EmpID
FROM Employees
INTERSECT
SELECT LearnerID
FROM Learners;


--Q4: EXCEPT/MINUS (Finding Exclusions)
--Find the MovieID that are not equal to the CourseID in the Courses table.


SELECT MovieID
FROM Movies
EXCEPT
SELECT CourseID
FROM Course;

--Q5: UNION ALL (Simulated Data)
--Combine all CustomerID from the Orders table with all FirstName from the Learners table. (Use NULL for the second column to match structure).

SELECT CustomerID, NULL AS ExtraColumn
FROM Orders
UNION ALL
SELECT FirstName, NULL
FROM Learners;


--Medium Questions (5)
--Q6: UNION ALL with Filtering
--List all employees who earn >70000 and all learners who scored >90.00. Include a column to indicate if the result is an 'Employee' or a 'Learner'.


SELECT Name, Salary, 'Employee' AS Type
FROM Employees
WHERE Salary > 70000
UNION ALL
SELECT FirstName, Marks, 'Learner' AS Type
FROM Learners
WHERE Marks > 90.00;


--Q7: INTERSECT with Subquery
--Find the Department that have employees AND the Genre that have a rating >8.5. Intersect the resulting names.

SELECT Department AS Name
FROM Employees
INTERSECT
SELECT Genre AS Name
FROM Movies
WHERE Rating > 8.5;


--Q8: EXCEPT/MINUS with Multiple Conditions
--Find the EmpID of employees who do not work in the 'IT' department.


SELECT EmpID
FROM Employees
EXCEPT
SELECT EmpID
FROM Employees
WHERE Department = 'IT';


--Q9: INTERSECT and Filtering in Subqueries
--Find the $\text{OrderID}$s that were placed for a Quantity=1 AND were placed for a Price?40000.


SELECT OrderID
FROM Orders
WHERE Quantity = 1
INTERSECT
SELECT OrderID
FROM Orders
WHERE Price >= 40000;


--Q10: UNION with Ordering
--List all distinct salaries and marks in one column, sorted in ascending order. (Align the data types).

SELECT CAST(Salary AS DECIMAL(7,2)) AS Value  -- Increased precision from 5 to 7
FROM Employees
UNION
SELECT Marks
FROM Learners
ORDER BY
    Value ASC;


--Hard Questions (3)
--Q11: Set Operation for Practice: Math OR Science but NOT BOTH
--Find the FirstName of learners who are enrolled in 'Mathematics' or 'Science', but are NOT enrolled in both. (This is equivalent to finding the UNION of the two groups, and then EXCEPT those in the INTERSECT).


(
    SELECT L.FirstName
    FROM Learners L
    JOIN Course C ON L.CourseID = C.CourseID
    WHERE C.CourseName IN ('Mathematics', 'Science')
)
EXCEPT
(
    -- Students in BOTH Math AND Science (which is impossible with current 1:1 mapping, but tests the logic)
    -- Since a student is only in one course, this intersect set will be empty.
    SELECT FirstName
    FROM Learners
    WHERE CourseID = (SELECT CourseID FROM Course WHERE CourseName = 'Mathematics')
    INTERSECT
    SELECT FirstName
    FROM Learners
    WHERE CourseID = (SELECT CourseID FROM Course WHERE CourseName = 'Science')
);


--Q12: Finding Data Gaps (Complex EXCEPT)
--Find the $\text{EmpID}$s in the Employees table that are not represented by any CustomerID (C1, C2, C3, C4) in the Orders table. (Simulate C5, C6 as missing customers).

SELECT EmpID
FROM Employees
EXCEPT
SELECT CAST(SUBSTRING(CustomerID, 2, 1) AS INT) -- FIX: Added '1' for the length
FROM Orders;

--Q13: Combining Aggregates Across Tables (UNION of Aggregates)
--List the maximum salary, the maximum marks, and the maximum movie rating, each on a separate row with a column identifying the type of maximum value.

SELECT 'Max_Salary' AS Max_Type, MAX(Salary) AS Max_Value
FROM Employees
UNION ALL
SELECT 'Max_Marks' AS Max_Type, MAX(Marks) AS Max_Value
FROM Learners
UNION ALL
SELECT 'Max_Rating' AS Max_Type, MAX(Rating) AS Max_Value
FROM Movies;