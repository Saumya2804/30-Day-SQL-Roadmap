use school
go

--Easy

--Q1. Insert a new learner into the Learners table.

INSERT INTO Learners (LearnerID, FirstName, CourseID)
VALUES (101, 'Rahul', 'C1');


--Q2. Insert a new course into the Courses table.

INSERT INTO Course(CourseID, CourseName)
VALUES ('C4', 'Power BI');


--Q3. Update a learner’s course to C2 where LearnerID = 101.

UPDATE Learners
SET CourseID = 'C2'
WHERE LearnerID = 101;


--Q4. Delete a learner record with LearnerID = 101.

DELETE FROM Learners
WHERE LearnerID = 101;

--Medium

--Q5. Insert multiple learners at once.

INSERT INTO Learners (LearnerID, FirstName, CourseID)
VALUES (102, 'Priya', 'C2'),
       (103, 'Ankit', 'C3'),
       (104, 'Neha', NULL);


--Q6. Update all learners with NULL CourseID to C1.

UPDATE Learners
SET CourseID = 'C1'
WHERE CourseID IS NULL;


--Q7. Delete all learners who are not enrolled in any course (CourseID IS NULL).

DELETE FROM Learners
WHERE CourseID IS NULL;

--Hard

--Q8. Increase the salary of all employees in IT department by 10%.

UPDATE Employees
SET Salary = Salary + (Salary * 0.1)
WHERE Department = 'IT';


--Q9. Delete all orders where quantity = 0.

DELETE FROM Orders
WHERE Quantity = 0;


--Q10. Insert a new movie only if it does not already exist.

INSERT INTO Movies (MovieID, Title, Genre, Rating)
SELECT 7, '3 Idiots', 'Drama', 8.7
WHERE NOT EXISTS (
    SELECT 1 FROM Movies WHERE Title = '3 Idiots'
);