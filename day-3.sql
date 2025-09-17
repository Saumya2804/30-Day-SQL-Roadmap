select * from std;

select count(*) AS TotalStudents from std;

SELECT MIN(Age) AS Youngest, MAX(Age) AS Oldest
FROM Std;

--Show only those classes with more than 2 students
select class, count(*) from std
group by class
having count(*) > 2;

--. Find average marks of students in each class
select class, AVG(Marks) as AvgMarks from std
group by class;

--Find the second highest mark
SELECT MAX(Marks) AS SecondHighest
FROM std
WHERE Marks < (SELECT MAX(Marks) FROM std);

select Marks
from ( select marks , DENSE_RANK() over (order by marks Desc) as MaxMarks from std) as t
where MaxMarks = 2;

--Find the class with maximum average marks
SELECT TOP 1 Class, AVG(Marks) AS AvgMarks
FROM Std
GROUP BY Class
ORDER BY AvgMarks DESC;

--Find number of students joined each year
select YEAR(JoinDate) AS YearJoined, count(StudentID) as StdJoinEveryYear from std
group by YEAR(JoinDate)