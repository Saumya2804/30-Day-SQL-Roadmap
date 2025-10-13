use school
--Q1: Basic Transaction Structure
--Write a block of SQL that starts a transaction, inserts a new employee (use EmpID 9), and then permanently saves the change.
-- Start the transaction
BEGIN TRANSACTION;

-- Insert a new employee
INSERT INTO Employees (EmpID, Name, Department, Salary)
VALUES (9, 'Tara', 'Marketing', 60000);

-- Save the change permanently
COMMIT TRANSACTION;

--Q2: Basic ROLLBACK
--Write a block of SQL that starts a transaction, attempts to delete an employee (EmpID 5, Karan),
--but then immediately ROLLBACK the change. Verify that the employee still exists afterward.


-- Start the transaction
BEGIN TRANSACTION;

-- Attempt to delete Karan
DELETE FROM Employees WHERE EmpID = 5;

-- Undo the deletion
ROLLBACK TRANSACTION;

-- Verification (Karan should still exist)
SELECT * FROM Employees WHERE EmpID = 5;

--Q3: Testing ROLLBACK on Update
--Start a transaction, increase all salaries by 10%, and then immediately ROLLBACK the transaction.
Begin transaction;

update Employees
set salary = salary*1.10;

rollback transaction;

select * from employees

--Q.5 Write the SQL command to check the current nesting level of active transactions in the session.
-- Check the current transaction count
SELECT @@TRANCOUNT AS CurrentTransactionCount;

--Q6: SAVEPOINT for Partial Rollback
--Write a transaction that inserts three rows into Learners_audit. Set a SAVEPOINT after the second insertion, 
--and then ROLLBACK to that SAVEPOINT.

BEGIN TRANSACTION;

-- Insert 1
INSERT INTO Learners_Audit  VALUES (104, 'Stage 1', GETDATE());

-- Insert 2
INSERT INTO Learners_Audit  VALUES (105, 'Stage 2', GETDATE());

-- Set a point to return to
SAVE TRANSACTION BeforeStage3;

-- Insert 3 (This row will be undone)
INSERT INTO Learners_Audit  VALUES (106, 'Stage 3', GETDATE());

-- Partial Rollback (undoes only Stage 3)
ROLLBACK TRANSACTION BeforeStage3;

-- Final Commit (Stages 1 and 2 are saved)
COMMIT TRANSACTION;

-- Verification (Should see 101 and 102, but NOT 103)
SELECT * FROM Learners_Audit WHERE columns_LID IN (104, 105, 106);


--Q7: Atomicity Principle
--Demonstrate the Atomicity principle by attempting to insert two new employees (EmpID 90 and EmpID 91) in one transaction, 
--where EmpID 90 is valid, but EmpID 91 will cause an error (e.g., trying to insert a duplicate LearnerID instead).
Begin transaction;
begin try
--Valid insertion
insert into employees Values(1001,'Ankit','HR',90000)
--Invalid insertion
insert into employees Values(1,'Priya','IT',60000)
commit transaction;
END try

Begin Catch 
--Due to atomicity but insertion will undone
IF @@TRANCOUNT > 0 Rollback transaction;
PRINT 'Transaction failed and rolled back due to error.'; 
END CATCH

SELECT * FROM Employees WHERE EmpID = 1001;