use school
go


--Q1: Create a Non-Clustered Index
--Create a Non-Clustered Index named IX_Learners_Name on the FirstName column of the Learners table.
create NONCLUSTERED index IX_Learners_Name on learners(firstname);

--Q2: Check Index Usage (Initial Query)
--Write a query to search for a specific learner by name. 
--Execute this query with the Display Actual Execution Plan feature turned on in your SQL tool to see if the new index is used.
SELECT Marks, CourseID
FROM Learners
WHERE FirstName = 'Alice'; 

--Q3: Creating a Clustered Index
--What command would you use to create a Clustered Index on the LearnerID column? (Assuming it is not already the PK).
-- Note: This command will fail if LearnerID is already the Primary Key (PK)
-- because SQL Server creates a Clustered Index automatically for PKs.
CREATE CLUSTERED INDEX CIX_Learners_ID
ON Learners (LearnerID);

--Q4: Dropping an Index
--Write the SQL command to remove the Non-Clustered Index created in Q1.
DROP INDEX IX_Learners_Name ON Learners;

--Q5: Creating a Composite Index
--Create a Non-Clustered Index named IX_Orders_ProdCust on the Product and CustomerID columns of the Orders table. 
--(This is useful when searching by both criteria together).
create nonclustered index IX_Orders_ProdCust on Orders(Product, CustomerID);


--Q6: Unique Index for Data Integrity
--Create a Unique Non-Clustered Index named UIX_Movies_Title on the Title column of the Movies table to enforce that no two movies can have the exact same title.
CREATE UNIQUE NONCLUSTERED INDEX UIX_Movies_Title
ON Movies (Title);