use school
CREATE TABLE StudentData (
    StudentID INT PRIMARY KEY,
    Info NVARCHAR(MAX)  -- JSON will be stored as text
);

INSERT INTO StudentData (StudentID, Info)
VALUES 
(1, '{"Name": "Saumya", "Age": 22, "Skills": ["SQL", "Power BI"]}'),
(2, '{"Name": "Rohan", "Age": 23, "Skills": ["Python", "Excel"]}');

--Convert SQL to JSON
select * from Students
for JSON AUTO

--Use of JSON_VALUE()
SELECT 
    StudentID,
    JSON_VALUE(Info, '$.Name') AS Name,
    JSON_VALUE(Info, '$.Age') AS Age
FROM StudentData;

select * from StudentData

--IsJSON
SELECT *
FROM StudentData
WHERE ISJSON(Info) = 1;

--Difference between JSON_VALUE() and JSON_QUERY()?
select JSON_VALUE(Info, '$.Age') from StudentData       -- returns 22
select JSON_QUERY(Info, '$.Skills') from StudentData     -- returns '["SQL","Power BI"]'

--Create a table Employees with a JSON column Details (City, Department, Skills).
CREATE TABLE EMP(
employeeid INT Primary key ,
Name Nvarchar(100),
Details nvarchar(MAX))

insert into EMP Values(1, 'Asha', '{"City":"Mumbai","Department":"Sales","Skills":["Excel","Negotiation"]}'),
(2, 'Ravi', '{"City":"Bengaluru","Department":"Engineering","Skills":["C#","SQL","Azure"]}');

SELECT * FROM EMP

--Query to fetch employee names and their departments from the JSON data.
SELECT EmployeeID ,NAME , JSON_VALUE(Details,'$.Department') as Department from EMP

--Use OPENJSON() to list each employee’s skills as separate rows.
select EmployeeID , Value as Skills
from EMP
Cross apply OpenJSON(Json_query(details,'$.Skills'))

--How can you verify if a column contains valid JSON data?
SELECT EmployeeID, Details
FROM Emp
WHERE ISJSON(Details) = 1;
