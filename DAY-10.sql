select * from learners 
select * from course

--Q1. Show all learners with their course names.
select l.firstname , c.coursename 
from learners l 
inner join course c
on l.courseid = c.courseid

--Q2. Find all learners enrolled in “History”.
select * from course

select l.firstname , c.coursename 
from learners as l
inner join course as c
on l.courseid = c.courseid
where c.coursename = 'History'; 

--Medium Questions

--Q3. Count number of learners in each course.
select c.coursename ,COUNT(l.LearnerID) as StdCount
from learners as l
inner join course c
on l.courseid = c.courseid
group by c.coursename 

--Q4. Show courses that have more than 1 learner.
select c.coursename ,COUNT(l.LearnerID) as StdCount
from learners as l
inner join course c
on l.courseid = c.courseid
group by c.coursename 
having COUNT(l.LearnerID) > 1;

--Hard / Interview Style Questions
--Q5. Find learners who share the same course with at least one other learner.

SELECT l.FirstName, c.CourseName
FROM Learners l
INNER JOIN Course c
ON l.CourseID = c.CourseID
WHERE c.CourseID IN (
    SELECT CourseID
    FROM Learners
    GROUP BY CourseID
    HAVING COUNT(LearnerID) > 1
);

--Q6. Show all learners and their course, but exclude learners without a course.
select l.firstname , c.coursename from  --inner join automatically remove null columns 
learners as l 
inner join course as c
on l.courseid = c.courseid

--Q7. Find the course with the maximum number of learners enrolled.
select TOP 1 c.coursename, COUNT(l.Learnerid) as MAX_STD_NO 
from learners as l
inner join course as c
on l.courseid = c.courseid
group by c.coursename
order by COUNT(l.Learnerid) DESC






















