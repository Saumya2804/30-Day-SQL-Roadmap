--Easy Questions 
--Q1: Creating a Simple View
--Create a view named IT_Employees_V that shows the EmpID, Name, and Salary of all employees in the 'IT' department.


-- Create a view named IT_Employees_V
CREATE VIEW IT_Employees_V AS
SELECT
    EmpID,
    Name,
    Salary
FROM
    Employees
WHERE
    Department = 'IT';

-- Check the view
SELECT * FROM IT_Employees_V;

-- Check the view
SELECT * FROM IT_Employees_V;

--Q2: Querying a View
--Write a query to find the Name of the highest-paid person from the IT_Employees_V view.

SELECT
    Name
FROM
    IT_Employees_V
WHERE
    Salary = (SELECT MAX(Salary) FROM IT_Employees_V);


--Q3: Creating a View with JOIN
--Create a view named Learner_Course_V that lists the FirstName and the corresponding CourseName.

CREATE VIEW Learner_Course_V AS
SELECT
    L.FirstName,
    C.CourseName
FROM
    Learners L
JOIN
    Course C ON L.CourseID = C.CourseID;

-- Check the view
SELECT * FROM Learner_Course_V WHERE CourseName = 'Mathematics';


--Q4: Dropping a View
--Write the SQL command to delete the IT_Employees_V view.

DROP VIEW IT_Employees_V;

--Q5: Creating a View with WITH CHECK OPTION
--Create a view named Low_Salary_V that includes employees with a Salary<50000. Include the WITH CHECK OPTION to enforce that any inserted or updated rows must still satisfy the view's WHERE clause.

CREATE VIEW Low_Salary_V AS
SELECT
    EmpID,
    Name,
    Salary,
    Department
FROM
    Employees
WHERE
    Salary < 50000
WITH CHECK OPTION;


--Medium Questions 
--Q6: Updatable View (Simple)
--Using the Low_Salary_V (created in Q5), write an UPDATE statement to give 'Priya' a 10% raise.


UPDATE Low_Salary_V
SET Salary = Salary * 1.10
WHERE Name = 'Priya';

-- Check the base table
SELECT Name, Salary FROM Employees WHERE Name = 'Priya';

--Q7: Non-Updatable View (Aggregate)
--Create a view named Dept_Salary_Summary_V that shows the Department and the AvgSalary. This view should be non-updatable.

CREATE VIEW Dept_Salary_Summary_V AS
SELECT
    Department,
    AVG(Salary) AS AvgSalary
FROM
    Employees
GROUP BY
    Department;

-- Check the view
SELECT * FROM Dept_Salary_Summary_V;


--Q8: Non-Updatable View (Function)
--Create a view named High_Rating_V that lists the Title and Genre, but also includes the UPPER case of the Title. (Views containing calculated fields like UPPER() are generally non-updatable).

CREATE VIEW High_Rating_V AS
SELECT
    Title,
    UPPER(Title) AS UpperTitle,
    Genre
FROM
    Movies
WHERE
    Rating >= 8.5;


--Q9: Testing WITH CHECK OPTION Failure
--Attempt to UPDATE a row in Low_Salary_V (where Salary<50000) to a value greater than 50000, which should cause the WITH CHECK OPTION to fail.

-- Karan's current salary is 49000
UPDATE Low_Salary_V
SET Salary = 55000
WHERE Name = 'Karan';


--Q10: Creating a View from Orders
--Create a view named High_Value_Orders_V that includes OrderID, Product, and total Revenue (Quantity×Price) for orders where Revenue>50000.


CREATE VIEW High_Value_Orders_V AS
SELECT
    OrderID,
    Product,
    (Quantity * Price) AS Revenue
FROM
    Orders
WHERE
    (Quantity * Price) > 50000;

-- Check the view
SELECT * FROM High_Value_Orders_V;

--Hard Questions (3)
--Q11: Nested Views
--Create a view named Top_Learners_V that lists the FirstName and CourseName for all learners with Marks>85. Then, create a second view named Sci_Tech_Learners_V that queries the first view, filtering only for courses containing 'Science' or 'Computer'.


-- Step 1: Create the base view for top learners
CREATE VIEW Top_Learners_V AS
SELECT
    L.FirstName,
    C.CourseName
FROM
    Learners L
JOIN
    Course C ON L.CourseID = C.CourseID
WHERE
    L.Marks > 85;

-- Step 2: Create the nested view
CREATE VIEW Sci_Tech_Learners_V AS
SELECT
    FirstName,
    CourseName
FROM
    Top_Learners_V
WHERE
    CourseName LIKE '%Science' OR CourseName LIKE '%Computer%';


--Q12: View Security Simulation (Filtering Rows)
--Create a view named Secure_Finance_V that only shows the EmpID and Name for the 'Finance' department. Crucially, do not include the Salary column, simulating data restriction for sensitive information.


CREATE VIEW Secure_Finance_V AS
SELECT
    EmpID,
    Name
FROM
    Employees
WHERE
    Department = 'Finance';


--Q13: Complex View with Self-Join
--Create a view named Successor_View that uses a Self Join on the Employees table to show the Employee name and their Successor (defined as EmpID+1) when they are in the same Department.


CREATE VIEW Successor_View AS
SELECT
    E1.Name AS Employee,
    E2.Name AS Successor,
    E1.Department
FROM
    Employees E1
JOIN
    Employees E2 ON E1.Department = E2.Department
                AND E2.EmpID = E1.EmpID + 1;
