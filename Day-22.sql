-- 1) Procedure to fetch all records from Students
CREATE OR ALTER PROCEDURE StudentDetails
As 
Begin
SELECT * FROM Students
END 
Go

EXEC StudentDetails ;


-- 2) Procedure to fetch details of a student using StudentID
CREATE OR ALTER PROCEDURE Fetchdetails 
@Studentid INT
AS
BEGIN
SET NOCOUNT ON;
select * from students where Studentid = @Studentid
END
GO
exec Fetchdetails @Studentid = 1


-- 3) Procedure to update a student's age based on StudentID
CREATE OR ALTER PROCEDURE Updateage
@studentid int,
@NewAge INT
As
BEGIN
UPDATE students 
SET age = @NewAge
where studentid = @studentid
end

exec Updateage @studentid = 3 ,@newage = 25;
select * from students

-- 4) Procedure to delete a student record based on StudentID
create or alter procedure deleterecord
@studentid int
AS
begin
delete from StudentMarks
where studentid = @studentid
delete from students
where studentid = @studentid
IF @@ROWCOUNT = 0
        PRINT 'No student deleted (ID not found).';
end
exec deleterecord @studentid = 5

-- 5) Procedure to count total students and display it
CREATE OR ALTER Procedure Studentcount 
As
Begin
SET NOCOUNT ON;
Select count(*) as Student_count from Students
End
Exec Studentcount 


-- 6) Insert a new student only if StudentID doesn't exist
CREATE OR ALTER PROCEDURE NewStudent
@StudentID INT ,@firstname varchar(50) ,@Lastname VARCHAR(50) , @Age INT , @Department VARCHAR(50), @joinDate DATE, @grade Varchar(50) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (SELECT 1 FROM Students where studentid = @StudentID)
	BEGIN
		PRINT 'StudentID already exists. Insert skipped.';
		RETURN;
	END
		INSERT INTO Students VALUES(@StudentID  ,@firstname ,@Lastname  , @Age , @Department , @joinDate,@Grade )
		PRINT 'Student inserted successfully.';
END;

exec NewStudent @StudentID = 6, @FirstName='Karan', @LastName='Patel', @Age=19, @Department='CS', @JoinDate='2023-05-01';

select * from students

-- 7) Procedure that takes age and returns students older than that age
CREATE OR ALTER PROCEDURE StudentData  @Age INT
AS
BEGIN
SET NOCOUNT ON;
SELECT * FROM STUDENTS 
WHERE Age > @Age
END

EXEC StudentData @AGE = 23

-- 8) Procedure to return average marks for a department
CREATE OR ALTER PROCEDURE AverageMarks
@department varchar(50)
AS
BEGIN
SET NOCOUNT ON ;
SELECT AVG(sm.Marks) as AverageMarks from StudentMarks sm
JOIN Students s
on sm.StudentID = s.StudentID
where s.department = @department
END

EXEC AverageMarks @department = CS


-- 9) Procedure that accepts two dates and returns students who joined between those dates
CREATE OR ALTER PROCEDURE Studentinfo
@Date1 DATE , @Date2 DATE 
AS
BEGIN 
SET NOCOUNT ON;
SELECT * FROM STUDENTS 
WHERE JoinDate Between @Date1 AND @Date2
END 

EXEC Studentinfo @Date1 = '2023-01-01' ,@Date2 = '2023-03-31';

-- 10) Procedure to insert student data and show custom message on error (TRY-CATCH)
CREATE OR ALTER PROCEDURE AddDate
@StudentID INT ,@firstname varchar(50) ,@Lastname VARCHAR(50) , @Age INT , @Department VARCHAR(50), @joinDate DATE, @grade Varchar(50) = NULL
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
	Insert into Students values(@StudentID  ,@firstname ,@Lastname  , @Age , @Department , @joinDate,@Grade )
	END TRY
	BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_LINE();
        PRINT 'Custom Error: Could not insert student. ' + @ErrMsg;
    END CATCH
END


Exec AddDate 7,'Karan','Singh',24,'EE','2025-05-03'
select * from Students














