--✅ Easy Level

--Q1. Show all learners and their course names (include learners without a course).
select l.firstname , c.coursename
from learners l
left join course c 
on l.courseid = c.courseid

--Q2. Show all courses and their learners (include courses with no learners).
select l.firstname , c.coursename
from learners l
right join course c 
on l.courseid = c.courseid

--Medium Level

--Q3. Show all learners and all courses (whether enrolled or not).
select l.firstname , c.coursename
from learners l
full outer join course c 
on l.courseid = c.courseid


--Q4. List learners who are not enrolled in any course.

select l.firstname , c.coursename
from learners l
left join course c 
on l.courseid = c.courseid
where c.coursename is null


--Q5. List courses that have no learners enrolled.
select l.firstname , c.coursename
from learners l
right join course c 
on l.courseid = c.courseid
where l.firstname is null


--Hard Level

--Q6. Show learners and their course names, but also include courses with no learners and learners with no course.
select 
coalesce(l.learnerId , 0) as learnerId,
coalesce(l.firstname , 'No learner') as Learnername,
coalesce(c.coursename, 'No course') as coursename
from Learners l
full outer join course c
on c.courseid = l.courseid


--Q7. Find the total number of learners per course, including courses with zero learners.

select  c.coursename, COUNT(l.learnerid) As student_count
from learners l
right join course c 
on l.courseid = c.courseid
group by c.coursename


--Q8. Retrieve a report of: learners without courses AND courses without learners.
SELECT 
    l.LearnerID,
    l.FirstName,
    c.CourseName
FROM Learners l
FULL OUTER JOIN Course c ON l.CourseID = c.CourseID
WHERE l.CourseID IS NULL OR c.CourseID IS NULL;


--Q9. Show learners and courses, but if a learner doesn’t have a course → display "Unassigned", and if a course has no learners → display "No Learner".
select l.learnerid ,
coalesce(l.firstname ,'No learner'),
coalesce(c.coursename ,'Unassigned')
from course c
full outer join learners l
on c.courseid = l.courseid