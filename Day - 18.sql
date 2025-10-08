--Q1: Basic INSERT Trigger (Auditing)
--Create an imaginary audit table named Learners_Audit (with columns LID, Operation, OpDate). 
--Then, create an AFTER INSERT trigger named trg_LearnerInsertAudit on the Learners table to log every new learner's LearnerID into the audit table.
create table Learners_Audit
(columns_LID int primary key,
Operation varchar(255), 
OpDate date)

create trigger trg_LearnerInsertAudit on learners 
after insert
AS
begin
insert into Learners_Audit(columns_LID,Operation,OpDate)
select 
learnerid,'Value Inserted',GETDATE()
from inserted
end

select * from Learners_Audit

--Q.2 Execute an INSERT statement on the Learners table to test the trigger created in Q1.
insert into Learners Values(11,'Jack',23,98,'2022-09-11',201)

select * from Learners

--Q3: Basic DELETE Trigger
--Create an AFTER DELETE trigger named trg_EmployeeDeleteLog on the Employees table to log the EmpID of the employee being deleted 
--into the Learners_Audit table (reusing it for simplicity).
create trigger trg_EmployeeDeleteLog on employees
after delete 
as
begin
INSERT INTO Learners_Audit (columns_LID, Operation, OpDate)
    SELECT EmpID, 'DELETE', GETDATE()
    FROM deleted
END

--Q4: Testing the DELETE Trigger
--Execute a DELETE statement on the Employees table to test the trigger created in Q3 (e.g., delete EmpID 1).

delete from Employees
where Empid = 1

select * from Learners_Audit where Operation = 'DELETE'

--Q5: Dropping a Trigger
--Write the SQL command to remove the trigger created in Q3.
DROP TRIGGER trg_EmployeeDeleteLog

--Medium Questions 
--Q6: AFTER UPDATE Trigger (Data Change Log)
--Create an AFTER UPDATE trigger named trg_SalaryChange on the Employees table. This trigger should log the EmpID, the OldSalary
--(from deleted table), and the NewSalary (from inserted table) into the Learners_Audit table. (Use LID for EmpID, Operation for 
--old/new salary concatenation).
CREATE TRIGGER trg_SalaryChange ON Employees
AFTER UPDATE 
AS
BEGIN
IF UPDATE(SALARY)
	BEGIN
	INSERT into Learners_Audit(columns_LID,Operation,OpDate)
	SELECT
	d.EmpID,
	'Old: ' + CAST(d.Salary AS VARCHAR) + ' -> New: ' + CAST(i.Salary AS VARCHAR),
	GETDATE()
	FROM deleted d
	JOIN inserted i
	ON d.EmpID = i.EmpID
	END
END

--Q7: Testing the UPDATE Trigger
--Execute an UPDATE statement on the Employees table to test the trigger created in Q6 (e.g., update EmpID 3's salary).
UPDATE EMPLOYEES
SET SALARY = 890000
WHERE EMPID = 3

SELECT * FROM Learners_Audit WHERE Operation LIKE 'Old: %';

--Q8: Simple INSTEAD OF Trigger (Security)
--Create an INSTEAD OF DELETE trigger named trg_PreventMovieDelete on the Movies table. This trigger should block any DELETE operation and print a message 
--that movie deletion is prohibited.
CREATE TRIGGER trg_PreventMovieDelete
ON Movies
INSTEAD OF DELETE
AS
BEGIN
    -- This code runs instead of the actual DELETE command
    PRINT 'SECURITY ALERT: Direct deletion of Movies is prohibited!';
END
GO
-- Test the trigger
DELETE FROM Movies WHERE MovieID = 1;

SELECT * FROM MOVIES