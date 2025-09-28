--Easy Level

--Q1. Find learners whose marks are above the average marks.
select firstname , marks from learners 
where marks > (select AVG(marks) from learners )


--Q2. Show courses where at least one learner has marks > 90.

SELECT CourseName
FROM Course
WHERE CourseID IN (
    SELECT CourseID 
    FROM Learners 
    WHERE Marks > 90
);


--Medium Level

--Q3. List learners who are enrolled in the course with the maximum number of learners.

select courseid , firstname, learnerid from learners 
where courseid = (
select top 1 courseid from course
group by courseid 
order by COUNT(*) desc);


--Q4. Show courses that have more learners than the average learners per course.
SELECT CourseID, COUNT(*) AS TotalLearners
FROM Learners
GROUP BY CourseID
HAVING COUNT(*) > AVG(COUNT(*)) OVER();



--Hard / Interview Level

--Q5. Find learners who have the highest marks in their course.
select courseid, firstname, marks from
learners 
where marks in (select MAX(marks) from learners group by courseid)


--Q6. Retrieve courses where all learners scored above 50.

SELECT CourseID, CourseName
FROM Course c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Learners l
    WHERE l.CourseID = c.CourseID AND l.Marks <= 50
);

--Alternate method : 

SELECT CourseID, CourseName
FROM Course
WHERE CourseID NOT IN (
    SELECT DISTINCT CourseID 
    FROM Learners 
    WHERE Marks <= 50
);

