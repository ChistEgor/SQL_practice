USE AdventureWorks2019
GO


-- Task 4.1
CREATE TRIGGER notifier
ON HumanResources.Department
AFTER INSERT, UPDATE
AS
    THROW 50001, 'To insert or update the HumanResources.Department you have to drop the trigger "notifier"', 1; -- lof
    ROLLBACK;
GO


-- Task 4.2
CREATE TRIGGER notifier2
ON DATABASE
AFTER ALTER_TABLE
AS
    THROW 50002, 'To alter table you have to drop the trigger "notifier2"', 1; -- lof
    ROLLBACK;
GO


-- Task 4.3
CREATE FUNCTION dbo.ufnConcatStrings (
    @column1 varchar(255)
    , @column2 varchar(255)
    )
RETURNS varchar(255)
AS
BEGIN
    DECLARE @concat_string varchar(255)

    SET @concat_string = CONCAT_WS(' - ', @column1, @column2);

    RETURN @concat_string;
END;
GO


-- Task 4.4
CREATE FUNCTION HumanResources.ufnEmployeeByDepartment (@departmentID INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT EH.DepartmentID, HE.*
    FROM HumanResources.Employee AS HE
    JOIN HumanResources.EmployeeDepartmentHistory AS EH
        ON HE.BusinessEntityID = EH.BusinessEntityID
    WHERE EH.DepartmentID = @departmentID
);
GO


-- Task 4.5
CREATE PROC Person.uspSearchByName 
    @Name nvarchar(50) = '%'
AS
BEGIN
    SELECT BusinessEntityId
        , FirstName
        , LastName
    FROM Person.Person
    WHERE FirstName LIKE @Name OR LastName LIKE @Name;
END 
GO
