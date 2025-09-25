use school
go

--Easy Level

--Q1. Find the total number of learners in each course.
select c.coursename ,COUNT(l.learnerid) AS TotalLearners
from course c
left join 
learners l
on l.courseid= c.courseid
group by c.coursename

--Q2. Find the average marks of learners in each course.
SELECT c.CourseName, AVG(l.Marks) AS AvgMarks
FROM Course c
INNER JOIN Learners l ON c.CourseID = l.CourseID
GROUP BY c.CourseName;


--Medium Level

--Q3. Find courses with more than 2 learners enrolled.

select c.coursename ,COUNT(l1.learnerid) AS TotalLearners from learners l1
inner join course c
on l1.courseid = c.courseid
group by c.coursename 
having COUNT(l1.learnerid) > 2

--Q4. Find the highest marks scored in each course.
SELECT c.CourseName, MAX(l.Marks) AS HighestMarks
FROM Course c
INNER JOIN Learners l ON c.CourseID = l.CourseID
GROUP BY c.CourseName;

--Hard Level

--Q5. Find courses where the average marks of learners is greater than 80.
select c.coursename , AVG(marks) as average_marks from course c
inner join learners l
on c.CourseID = l.CourseID
GROUP BY c.CourseName
having AVG(l.marks)>80;

--Q6. Find the number of learners in each course who scored above 70 marks.

SELECT c.CourseName, COUNT(l.LearnerID) AS LearnersAbove70
FROM Course c
INNER JOIN Learners l ON c.CourseID = l.CourseID
WHERE l.Marks > 70
GROUP BY c.CourseName;

--Q7. Find the course(s) with the maximum number of learners. (works even if there’s a tie between multiple courses) 
SELECT CourseName, TotalLearners
FROM (
    SELECT 
        c.CourseName,
        COUNT(l.LearnerID) AS TotalLearners,
        RANK() OVER (partition by c.CourseName ORDER BY COUNT(l.LearnerID) DESC) AS rnk
    FROM Course c
    INNER JOIN Learners l ON c.CourseID = l.CourseID
    GROUP BY c.CourseName
) AS Ranked
WHERE rnk = 1;


--Q8. Find the top 2 courses with the highest average marks.
SELECT TOP 2 c.CourseName, AVG(l.Marks) AS AvgMarks
FROM Course c
INNER JOIN Learners l ON c.CourseID = l.CourseID
GROUP BY c.CourseName
ORDER BY AVG(l.Marks) DESC;





















