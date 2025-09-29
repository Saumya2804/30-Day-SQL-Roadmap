use school
go


--Q1: CROSS JOIN (Full Pairing)

--Write a SQL query using a CROSS JOIN to list every learner from the Learners table paired with every course from the Courses table.

select l.firstname, c.coursename from learners as l
cross join course as c

--Use a CROSS JOIN to list every employee name from the Employees table paired with every movie Title from the Movies table.
select e.Name , m.Title from employees e 
cross join movies m

--Find all pairs of movies that have the same Genre using a Self Join. List the titles of the two movies. Exclude joining a movie with itself.
select m1.Title as Movie1 , m2.title as Movie2  
from Movies m1
join Movies m2
on m1.Genre = m2.Genre
AND  m1.MovieID < m2.MovieID

--How many unique pairings are possible between Learners and Courses? Write a query using CROSS JOIN to find this count.
SELECT
    count(*) as unique_paring
FROM
    Learners L
CROSS JOIN
    Course C;


--Q4: Self Join (Finding Distinct Departments)
--Use a Self Join on the Employees table to list all unique pairs of departments where at least one employee from each department exists.
SELECT DISTINCT
    E1.Department AS Department1,
    E2.Department AS Department2
FROM
    Employees E1
JOIN
    Employees E2 ON E1.Department < E2.Department;


--Q5: CROSS JOIN (Data Expansion)
--List every OrderID from the Orders table paired with every Department from the Employees table.

select o.orderid , e.Department from 
orders as o
cross join (select distinct department from Employees )  e




--Q6: Self Join (Hierarchy Use Case)

--Write a Self Join query to list the names of the employees and their manager 

select e1.Name as manager , e2.Name as employees, e1.department, e1.empid as managerid ,e2.empid as employeeid from employees e1
join employees e2
on e1.department = e2.department and e1.empid != e2.empid


--Q7: Self Join (Rating Comparison)
--Using a Self Join on the Movies table, find pairs of movies where the first movie has a strictly higher Rating than the second movie.

select m1.title as Movie1_title ,m1.rating as Movie1_rating , m2.title as Movie2_title , m2.rating as Movie2_Rating
from Movies as m1
join Movies as m2 
on m1.rating > m2.rating


--Q8: Self Join (Order Details Comparison)
--Use a Self Join on the Orders table to find pairs of orders that were placed by the same CustomerID but for different Products. 
--List the OrderIDs and the CustomerID.
select * from orders

select o1.orderid, o2.customerid 
from orders o1
join orders o2
on o1.customerid = o2.CustomerID and o2.orderid != o1.orderid



--Q9: Self Join (Age Proximity)
--Find pairs of learners in the Learners table whose ages are within 1 year of each other (i.e., absolute difference is 1). 
--List their names and ages. Exclude self-joins.

select l1.firstname , l1.age , l2.firstname, l2.age
from learners l1
join learners l2 
on ABS(l1.age - l2.age) = 1 AND l1.LearnerID < l2.LearnerID



--Q10: CROSS JOIN (Simulated Cartesian Product with Filter)
--Perform a CROSS JOIN between the Employees and Orders tables. Then, use a WHERE clause to filter the result to only show pairings 
--where the employee's Department is 'IT' and the order's Product is 'Laptop'.
select e.name , o.product from employees e
cross join orders o
where e.Department = 'IT' and o.Product = 'Laptop'


