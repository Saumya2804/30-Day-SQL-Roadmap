--Find the names of employees whose salary is higher than the minimum salary in the 'IT' department.
select name, salary from Employees
where salary > ( select MIN(salary) from employees where Department = 'IT')


--List the Title and Genre of the movie with the lowest overall Rating.

SELECT
    Title,
    Genre
FROM
    Movies
WHERE
    Rating = (SELECT MIN(Rating) FROM Movies);

--Find the FirstName of learners who have a Marks score that is equal to any of the Salary amounts found in the Employees table 
--(ignoring data type differences for comparison).

SELECT
    FirstName
FROM
    Learners
WHERE
    Marks IN (SELECT Salary FROM Employees);

--List the OrderID, Product, and a new column showing the Quantity difference between that order and 
--the minimum Quantity ordered across all orders.
select orderID , Product , 
quantity - (select MIN(quantity) from Orders ) as Quantity_diff
from orders


--Find the EmpID and Name of employees whose Department is not 'IT' or 'HR'.
select empid , name ,Department
from employees
where Department NOT IN ('IT','HR');

--Find the Department names from the Employees table where at least one employee in that department earns less than $50,000.
SELECT DISTINCT
    Department
FROM
    Employees E1
WHERE
    EXISTS (
        SELECT 1
        FROM Employees E2
        WHERE E2.Department = E1.Department
        AND E2.Salary < 50000
    );

--Find the names of employees whose Salary is greater than all salaries in the 'HR' department.

SELECT
    Name
FROM
    Employees
WHERE
    Salary > ALL (
        SELECT Salary
        FROM Employees
        WHERE Department = 'HR'
    );

--List the Department and the total number of employees in that department, 
--but only include departments that have more than one employee.
select department ,Count(empid) as emp_count
from employees 
group by Department
having Count(empid) > 1

--Find the FirstName of learners who are enrolled in a course that has a CourseName ending with 'Science'.

select t.firstname , t.coursename
from (
	select c.coursename, l.firstname from course c
	join Learners l
	on c.courseid = l.CourseID
	where CourseName like '%Science') t

--Alternate method 
SELECT
    FirstName
FROM
    Learners
WHERE
    CourseID IN (
        SELECT
            CourseID
        FROM
            Course
        WHERE
            CourseName LIKE '%Science'
    );

--Find the Title and Rating of movies that have the highest Rating within their respective Genre.
select title ,rating
from (select title ,rating ,DENSE_RANK() over (partition by genre order by rating desc) as ranked from Movies ) t 
where ranked = 1

--Alternate method
select  title ,rating from movies m1
where rating = (select MAX(rating) from movies m2 
where m2.genre = m1.genre)

--Find the FirstName of students who enrolled in a course where the average marks for that course is greater than 80.

select firstname from learners 
where courseid in
	(select  courseid from learners 
	group by courseid 
	having AVG(marks) > 80)

--Find the Department that has no employee earning less than $50,000.
select department from employees E1
where NOT EXISTS (
select 1 from employees E2
where E2.department = E1.department and E2.salary < 50000 ) 

--Find the Name of employees who have a Salary greater than the maximum Price of any Product that has been ordered at least twice.
SELECT Name
FROM
    Employees
WHERE
    Salary > (
        SELECT
            MAX(Price)
        FROM
            Orders
        WHERE
            Product IN (
                SELECT
                    Product
                FROM
                    Orders
                GROUP BY
                    Product
                HAVING
                    COUNT(OrderID) >= 2
            )
    );