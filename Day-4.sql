
select * from students;
select * from classes;

--Show all students with their class names (show only those who enrolled in a class)
select s.FirstName, c.ClassName
from students s
inner join Classes c
on s.ClassID = c.ClassID ;

--List all classes even if no students are enrolled
select s.FirstName, c.ClassName
from  Classes c
left join students s
on s.ClassID = c.ClassID ;

--Find all students who don’t belong to any class (means class is null)
SELECT s.FirstName
FROM Students s
LEFT JOIN Classes c
ON s.ClassID = c.ClassID
WHERE c.ClassID IS NULL;

--Find the average marks of students in each class
select c.ClassName ,AVG(s.Marks)
from students s
join classes c
on s.ClassID = c.ClassID
group by c.ClassName;

--List classes along with the number of students enrolled.

select c.ClassName,count(StudentID) as StudNum
from Students s
inner join classes c
on s.ClassID = c.ClassID
group by ClassName;

--Perfect Approach

SELECT c.ClassName, COUNT(s.StudentID) AS StudentCount
FROM Classes c
LEFT JOIN Students s
ON c.ClassID = s.ClassID
GROUP BY c.ClassName;


--Show students whose marks are above 80 along with their class names.
Select s.FirstName ,c.className, s.marks
from Students s
left join classes c
on c.ClassID = s.ClassID
where s.marks > 80;

--Find the class with the highest average marks.
select TOP 1 c.ClassName , AVG(s.Marks) as avgmark
from students s
right join classes c
on c.ClassID = s.ClassID
group by ClassName 
order by avgmark desc;

--List pairs of students who are in the same class.

SELECT s1.FirstName AS Student1, s2.FirstName AS Student2, c.ClassName
FROM Students s1
INNER JOIN Students s2
ON s1.ClassID = s2.ClassID AND s1.StudentID < s2.StudentID
INNER JOIN Classes c
ON s1.ClassID = c.ClassID;

--Find students who scored above the average marks of their class.
select s.FirstName , s.marks, c.ClassName
from students s
inner join classes c
on c.ClassID = s.ClassID
where s.marks > (
    SELECT AVG(s2.Marks)
    FROM Students s2
    WHERE s2.ClassID = s.ClassID )

--Find classes that have less than 2 students enrolled
select c.className ,count(s.studentID) as StdNum
from students s
inner join classes c
on c.ClassID = s.ClassID
group by c.className
having count(s.studentID) < 2;


