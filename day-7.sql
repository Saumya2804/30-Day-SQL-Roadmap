use school
go

--Q1. Show all learners with their course name using INNER JOIN
Select l.Firstname, c.coursename 
from learners l 
inner join course c
on l.courseid = c.courseid

--Q2. Find learners who are not enrolled in any course (use LEFT JOIN)
select l.firstname
from learners l
left join course c
on l.courseid = c.CourseID
where c.CourseID Is NULL; 

--Q3. Find the highest marks in each course using a subquery

SELECT L.FirstName, L.CourseID, L.Marks
FROM Learners L
WHERE L.Marks = (
    SELECT MAX(Marks)
    FROM Learners
    WHERE CourseID = L.CourseID
);

--Alternate method

SELECT CourseID, MAX(Marks) AS HighestMarks
FROM Learners
GROUP BY CourseID;

--Q4. Show learners who scored above their course average.
select l.FirstName, l.marks, l.courseid from learners l 
inner join course c 
on l.courseid = c.courseid
where marks > (select AVG(l2.marks) from learners l2 where courseid = c.CourseID )


--Q5. Find the learners who scored the second-highest marks in each course.
select firstname,marks  from 
	( select firstname ,marks , DENSE_RANK() over (order by marks desc) as SecondHighestMarks from learners ) as t
where SecondHighestMarks = 2;


--Q6. Find learners who joined after the average joining date.
select firstname , Join_Date from learners
where Join_Date > (select CAST(AVG(CAST(Join_Date as Float))as DATETIME) from learners ) ;


--Q7. Retrieve the top 2 learners from each course using a subquery with DENSE_RANK().
SELECT FirstName, CourseID, Marks
FROM (
   SELECT FirstName, CourseID, Marks,
          DENSE_RANK() OVER (PARTITION BY CourseID ORDER BY Marks DESC) AS RankOfLearner
   FROM Learners
) AS Ranked
WHERE RankOfLearner <= 2;











