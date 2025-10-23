/*1) What is it?

Authentication = who you are (login).

Authorization = what you can do (permissions).*/

/*
2) Create a login & user (very simple)

--Requires server rights — only run if you have permission.

Create a server login (SQL auth)
CREATE LOGIN MyLogin WITH PASSWORD = 'StrongP@ss123!';

Create a database user mapped to that login
USE YourDatabase;
CREATE USER MyUser FOR LOGIN MyLogin;
*/

--3) Give read-only access (best for reporting)
-- Create a role for readers (if not exists)
CREATE ROLE report_reader;
GO

-- Give role permission to read the Students table
GRANT SELECT ON dbo.Students TO report_reader;
GO

--4) Prevent SQL injection — use parameters (very important)

--Bad (unsafe) example — do not use:

-- Unsafe: DO NOT USE (demonstration only)
DECLARE @sql NVARCHAR(MAX) = 'SELECT * FROM dbo.Students WHERE Email = ''' + @email + '''';
EXEC(@sql);


--Good (safe) example — use this:

CREATE PROCEDURE Safe_GetStudentByAge
    @Age NVARCHAR(255)
AS
BEGIN
    SELECT * FROM dbo.Students WHERE Age = @Age;
END;

--5) Quick permission revoke
-- Revoke SELECT from a user or role
REVOKE SELECT ON dbo.Students FROM report_reader;

/*
7) Short checklist — do these always

Use least privilege (give minimum rights).

Use parameterized queries / stored procedures (avoid injection).

Use roles not individual grants where possible.

Log errors and suspicious actions.

Protect backups and use strong passwords.
*/