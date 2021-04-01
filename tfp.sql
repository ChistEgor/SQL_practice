USE AdventureWorks2019
GO


-- Task 4.1
CREATE TRIGGER notifier
ON HumanResources.Department
INSTEAD OF UPDATE, INSERT
AS
    THROW 50001, 'To insert or update the HumanResources.Department you have to drop the trigger "notifier"', 16;
GO


-- Task 4.2
CREATE TRIGGER notifier2
ON DATABASE
AFTER ALTER_TABLE
AS
    THROW 50002, 'To alter table you have to drop the trigger "notifier2"', 16;
GO


-- Task 4.3
IF OBJECT_ID (N'dbo.ufnConcatStrings', N'FN') IS NOT NULL  
    DROP FUNCTION dbo.ufnConcatStrings;
    
CREATE FUNCTION dbo.ufnConcatStrings (
    @column1 varchar(25)
    , @column2 varchar(25)
    )
RETURNS varchar(53)
AS
BEGIN
    DECLARE @concat_string varchar(53);
    SET @concat_string = CONCAT_WS(' - ', @column1, @column2);
    RETURN @concat_string;
END;
GO


-- Task 4.4
IF OBJECT_ID (N'HumanResources.ufnEmployeeByDepartment', N'IF') IS NOT NULL  
    DROP FUNCTION HumanResources.ufnEmployeeByDepartment;
    
CREATE FUNCTION HumanResources.ufnEmployeeByDepartment (@departmentID INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT HE.*
    FROM HumanResources.Employee AS HE
    JOIN HumanResources.EmployeeDepartmentHistory AS EH
        ON HE.BusinessEntityID = EH.BusinessEntityID
    WHERE EH.DepartmentID = @departmentID
);
GO


-- Task 4.5
CREATE PROC Person.uspSearchByName 
    @Name nvarchar(50)
AS
BEGIN
    DECLARE @ReturnName NVARCHAR(25)
    SET @ReturnName = '%' + @Name + '%'
    SELECT BusinessEntityId
	,FirstName
	,LastName
    FROM Person.Person
	WHERE FirstName LIKE @ReturnName
		OR LastName LIKE @ReturnName;
END 
GO
