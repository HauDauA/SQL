
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber, Name,SafetyStockLevel FROM Production. Product;
GO
--Syntax With Join
--CREATE VIEW <view_name> AS
--SELECT * FROM table_namel JOIN table_name2
--ON table namel. column name = table natne2. column name
--GO
CREATE VIEW vwSortedPersonDetails AS
SELECT p.Title, p.[FirstName], p.MiddleName , p.[LastName], e.[JobTitle]
FROM [HumanResources].[Employee] e 
INNER JOIN [Person].[Person] p 
ON p.[BusinessEntitylD] = e.[BusinessEntitylD] ORDER BY p.FirstName 
GO
CREATE VIEW vwSortedPersonDetails AS
SELECT COALESCE(p.Title, ' ') AS Title, p.[FirstName], COALESCE(p.MiddleName, ' ') AS MiddleName, p.[LastName], e.[JobTitle]
FROM [HumanResources].[Employee] e 
INNER JOIN [Person].[Person] p 
ON p.[BusinessEntitylD] = e.[BusinessEntitylD] ORDER BY p.FirstName 
GO
CREATE VIEW vwSortedPersonDetails AS
SELECT TOP 10 COALESCE(p.Title, ' ') AS Title, p.[FirstName], COALESCE(p.MiddleName, ' ') AS MiddleName, p.[LastName], e.[JobTitle]
FROM [HumanResources].[Employee] e 
INNER JOIN [Person].[Person] p 
ON p.[BusinessEntitylD] = e.[BusinessEntitylD] ORDER BY p.FirstName 
GO
SELECT * FROM vwSortedPersonDetails
GO
CREATE TABLE I_Details
 (
	EmpID int NOT NULL,
	FirstName varchar(30) NOTNULL,
	LastName varchar(30) NOTNULL, 
	Address varchar(30)
)
GO
CREATE TABLE Employee_Sa1ary_Details 
(
 EmpID int NOT NULL, 
 Designationvarchar(30), 
 Salary int NOT NULL
)
GO
CREATE VIEW vwEmployee_Personal_Details
AS
SELECT el .EmpID, FirstName, Last Name, Designation, Salary
FROMEmployee_Personal_Details el
JOIN Employee_Salary_Details e2
ON el .EmpID = e2,EmpID
GO
INSERT INTO vwEmployee Personal Details VALUES (2, 'Jack', 'Wilson', 'Software Developer',16000)
GO
CREATE VIEW vwEir.pDetails AS SELECT FirstName, Address FROM Employee_Personal_Details
GO
INSERT INTO vwEir.pDetails VALUES ('Jack', 'NYC')
GO
CREATE TABLE Product_Details
(
	ProductId int,
	ProductName varchar(30)
	,Rate Money
)
GO
CREATE VIEW vwProduct_Details AS
SELECT ProductName, Rate FROM Product_Details
GO
UPDATE vwProduct_Details
SET Rate=3000
WHERE ProductName =' DVDWriter'
GO
column_name.WRITE(expression, @Offset, @Length)
GO
CREATE VIEW vwProduct_Details AS 
SELECT ProductName, Description, Rate FROM Product_Details
GO
UPDATE vwProduct_Details
SET Description.WRITE (N'Ex',0,2)
WHERE ProductName='Portable Hard Drive'
GO
--syntax is used to delete data from a view
--DELETE FROM <view_name>
--WHERE <search_condition>

DELETE FROM vwCustDetails WHERE CustID='C0004'
GO
--syntax is used to alter a view
--ALTER VIEW <view_name> AS <select_statement>
ALTER VIEW vwProductinfo AS
SELECT ProductID, ProductNumber, Name,SafetyStockLevel, ReOrderPoint FROM Production.Product
GO
--syntax is used to drop a view:
--DROP VIEW <view name>
DROP VIEW vwProductInfo
--syntax is used to view the definition information of a view
--sp_help<view_name>
EXEC sp_helptext vwEmployee_Personal_Details
GO
CREATE VIEW vwProduct_Details AS
SELECT ProductName, AVG (Rate) AS AverageRate 
FROM Product_Details GROUP BY ProductName
GO
--syntax creates a view using the check OPTION:
--CREATE VIEW <view_name>
--AS select statement [ WITH CHECK OPTION ]
CREATE VIEW vwProductInfo AS
SELECT ProductID, ProductNumber,Name,SafetyStockLevel,ReOrderPoint
FROM Production. Product
WHERE SafetyStockLevel<=1000
WITH CHECK OPTION;
GO
UPDATE vwProductlnfo SET SafetyStockLevel= 2500
WHERE ProductID =221
GO
--syntax is used to create a view with the schemabinding option:
--CREATE VIEW <view_name> WITH SCHEMABINDING
CREATE VIEW vwNewProductlnfo WITH SCHEMABINDING AS
SELECT ProductID, ProductNumber, Name, SafetyStockLevel FROM Product ion.Product;
GO
CREATE TABLE Customers
(
	CustlD int,
	CustName varchar (50),
	Address varchar(60)
)
GO
CREATE VIEW vwCustomers
AS
SELECT * FROM Customers
GO
SELECT * FROM vwCustomers
GO
ALTER TABLE Customers ADD Age int
GO
SELECT * FROM vwCustomers
GO
EXEC sp_refreshview 'vwCustomers'
GO
ALTER TABLE Production.Product ALTER COLUMN ProductlD varchar(7)
GO
EXECUTE xp_fileexist 'c:\MyTest.txt'
GO
--syntax is used to create a custom stored procedure:
--CREATE ( PROC | PROCEDURE ) procedure_name
--	[{@parameterdata_type}]
--AS <sql statement>
CREATE PROCEDURE uspGetCustTerritory
AS
SELECT TOP 10 CustomerID, Customer.TerritorylD, Sales.SalesTerritory.Name 
FROM Sales.Customer JOIN Sales.SalesTerritory 
ON Sales.Customer.TerritorylD = Sales.Sales.TerritorylD
GO
EXEC uspGetCustTerritory
GO
CREATE PROCEDURE uspGetSa les @territoryvarchar(40) AS 
SELECT BusinessEntitylD, B.SalesYTD, B.SalesLastYear 
FROM Sales.Salesperson A
JOIN Sales.SalesTerritory B
ON A.TerritorylD = B.TerritorylD WHERE
B.Name = @territory
Execute the storedprocedure EXEC uspGetSales'Northwest'








