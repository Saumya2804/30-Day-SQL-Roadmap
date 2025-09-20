CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

INSERT INTO Course (CourseID, CourseName)
VALUES 
(201, 'Mathematics'),
(202, 'Science'),
(203, 'History'),
(204, 'Computer Science');

CREATE TABLE Learners (
    LearnerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    Age INT,
    Marks DECIMAL(5,2),
    Join_Date DATE,
    CourseID INT NULL,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Learners (LearnerID, FirstName, Age, Marks, Join_Date, CourseID)
VALUES
(1, 'Alice', 20, 85.50, '2024-01-15', 201),
(2, 'Bob', 22, 92.00, '2024-02-20', 201),
(3, 'Charlie', 21, 76.25, '2024-03-10', 202),
(4, 'David', 23, 88.75, '2023-11-05', 202),
(5, 'Eva', 20, 95.00, '2024-05-18', 203),
(6, 'Frank', 22, 67.00, '2023-09-12', 204),
(7, 'Grace', 21, 73.50, '2024-07-07', 203),
(8, 'Hannah', 23, 89.25, '2024-08-25', 204),
(9, 'Ian', 24, 91.00, '2024-12-01', NULL), -- no course assigned
(10, 'Jane', 20, 85.50, '2024-03-22', 201);

--Get all learners who joined in 2024
Select FirstNAme, join_date from Learners
where Join_date between '2024-01-01' AND '2024-12-31';

SELECT FirstName, Join_Date
FROM Learners
WHERE YEAR(Join_Date) = 2024;

--Find learners whose marks are between 80 and 90
Select FirstName , Marks 
from Learners
where Marks  between 80 and 90;

--Find learners who scored more than the average marks of all learners
Select FirstName , Marks from Learners
where Marks > (select AVG(Marks) from Learners )

--List learners whose marks are equal to the maximum marks
Select FirstName , Marks from Learners
where Marks = (select Max(Marks) from Learners )

--Find the youngest learner(s)
Select FirstName , Age from Learners
where Age = (select min(Age) from Learners )

--Find the learner(s) who scored the second-highest marks
select FirstName, marks
from (select FirstName ,marks, DENSE_RANK() over (order by marks desc) as Highestmarks from learners) as t
where Highestmarks = 2; 

--Find learners who scored above the average in their own course
select l.FirstName , l.marks, c.CourseID
from Learners l
join course c
on c.CourseID = l.CourseID 
where l.marks > (select AVG(l2.marks) from learners l2 where CourseID = c.CourseId) ;

--Alternate method

SELECT FirstName, Marks, CourseID
FROM Learners l
WHERE Marks > (
    SELECT AVG(Marks)
    FROM Learners
    WHERE CourseID = l.CourseID

--Find learners who scored above the average in their own course name

select l.FirstName , l.marks, c.CourseName
from Learners l
join course c
on c.CourseID = l.CourseID 
where l.marks > (select AVG(l2.marks) from learners l2 where CourseName = c.CourseName) ;
);

--Find learners whose marks are greater than at least 3 other learners
select FirstName, marks
from (select FirstName ,marks, DENSE_RANK() over (order by marks asc) as Highestmarks from learners) as t
where Highestmarks > 3; 

--Alternate method 

SELECT FirstName, Marks
FROM Learners l1
WHERE 3 <= (
    SELECT COUNT(*)
    FROM Learners l2
    WHERE l2.Marks < l1.Marks
);