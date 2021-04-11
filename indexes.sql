USE AdventureWorks2019;
GO

--Task 1.1
DROP TABLE IF EXISTS dbo.Customer;
GO

CREATE TABLE dbo.Customer 
(
	CustomerID INT
	,FirstName VARCHAR(50)
	,LastName VARCHAR(50)
	,Email VARCHAR(100)
	,ModifiedDate DATE
	,CONSTRAINT PK_Customer_CustomerID PRIMARY KEY CLUSTERED (CustomerID)
);
GO

--Task 1.2
IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'NI_Customer_FirstName_LastName')   
    DROP INDEX NI_Customer_FirstName_LastName ON dbo.Customer;
GO

CREATE NONCLUSTERED INDEX NI_Customer_FirstName_LastName ON dbo.Customer (FirstName, LastName);
GO

--Task 1.3
IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'IX_Customer_ModifiedDate')   
    DROP INDEX IX_Customer_ModifiedDate ON dbo.Customer;
GO

CREATE INDEX IX_Customer_ModifiedDate ON dbo.Customer (ModifiedDate) INCLUDE
(FirstName, LastName);
GO

--Task 1.4
DROP TABLE IF EXISTS dbo.Customer2;
GO

CREATE TABLE dbo.Customer2 
(
	CustomerID INT
	,AccountNumber VARCHAR(10)
	,FirstName VARCHAR(50)
	,LastName VARCHAR(50)
	,Email VARCHAR(100)
	,ModifiedDate DATE
	,CONSTRAINT PK_Customer2_CustomerID PRIMARY KEY NONCLUSTERED (CustomerID)
);
GO

IF EXISTS (SELECT name FROM sys.indexes  
            WHERE name = N'CI_Customer2_CustomerID') -- 
    DROP INDEX CI_Customer2_CustomerID ON dbo.Customer2;
GO

CREATE CLUSTERED INDEX CI_Customer2_CustomerID ON dbo.Customer2(CustomerID);
GO

--Task 1.5
EXEC sp_rename N'dbo.Customer2.CI_Customer2_CustomerID', N'CI_Customer2_Customer_ID', N'INDEX';   
GO  

--Task 1.6
DROP INDEX CI_Customer2_Customer_ID   
    ON dbo.Customer2;  
GO  

--Task 1.7
CREATE UNIQUE NONCLUSTERED INDEX AK_Customer_Email ON dbo.Customer2 (Email);
GO

--Task 1.8
CREATE NONCLUSTERED INDEX NI_Customer2_ModifiedDate
ON dbo.Customer2 (ModifiedDate)
WITH (FILLFACTOR = 70);
GO
