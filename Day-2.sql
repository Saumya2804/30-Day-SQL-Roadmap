--Easy Level Queries

--Find all students who are 18 years old

SELECT * 
FROM Students
WHERE Age = 18;

--Show unique ages of students

SELECT DISTINCT Age
FROM Students;

--List students in ascending order of their JoinDate

SELECT * 
FROM Students
ORDER BY JoinDate ASC;


--Medium Level Queries


--Find students who joined in 2024

SELECT * 
FROM Students
WHERE JoinDate BETWEEN '2024-01-01' AND '2024-12-31';


--Count how many students are of each age

SELECT Age, COUNT(*) AS TotalStudents
FROM Students
GROUP BY Age;


--Get top 3 oldest students

SELECT TOP 3 *
FROM Students
ORDER BY Age DESC;

--Hard Level Queries

--Find the second highest age among students

SELECT MAX(Age) AS SecondHighestAge
FROM Students
WHERE Age < (SELECT MAX(Age) FROM Students);


--Find students whose name starts with ‘S’ and age > average age

SELECT *
FROM Students
WHERE Name LIKE 'S%' 
  AND Age > (SELECT AVG(Age) FROM Students);


F--ind duplicate student names (if any)

SELECT Name, COUNT(*) AS Occurrences
FROM Students
GROUP BY Name
HAVING COUNT(*) > 1;

--Interview Questions with Answers
--1. What is the difference between WHERE and HAVING?
--WHERE → filters rows before grouping
--HAVING → filters groups after grouping


SELECT Age, COUNT(*) 
FROM Students
WHERE Age > 18
GROUP BY Age
HAVING COUNT(*) > 2;

--2. How do you find the nth highest salary (or age)?


SELECT TOP 1 Age
FROM (
   SELECT DISTINCT TOP 2 Age
   FROM Students
   ORDER BY Age DESC
) AS Temp
ORDER BY Age ASC;