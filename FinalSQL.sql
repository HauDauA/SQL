--1
CREATE DATABASE AZBank
GO
USE AZBank
GO
--2
CREATE TABLE Customer 
(
	CustomerId INT PRIMARY KEY
	,Name NVARCHAR(50)
	,City NVARCHAR(50)
	,Country NVARCHAR(50)
	,Phone NVARCHAR(15)
	,Email NVARCHAR(50)
)
GO
CREATE TABLE CustomerAccount
(
	AccountNumber CHAR(9) PRIMARY KEY
	,CustomerId INT REFERENCES Customer(CustomerId) 
	,Balance MONEY NOT NULL
	,MinAccount MONEY
)
GO
CREATE TABLE CustomerTransaction
(
	TransacionId INT PRIMARY KEY
	,AccountNumber CHAR(9) REFERENCES CustomerAccount(AccountNumber)
	,TransactionDate SMALLDATETIME
	,Amount MONEY
	,DepositorWithDraw BIT
)
GO
--3
INSERT INTO Customer VALUES
	(1, N'Hậu', N'Hà Nội', N'Việt Nam', N'0912345678', N'haudtd@gmail.com')
	,(2, N'Tuân', N'Hà Nội', N'Việt Nam', N'0912345675', N'tuandtd@gmail.com')
	,(3, N'Huy', N'Hà Nội', N'Việt Nam', N'0912345672', N'huydtd@gmail.com')
GO
INSERT INTO CustomerAccount VALUES
	('CC01', 1, 1234567890, 1000)
	,('CC02', 2, 12345678901, 10000)
	,('CC03', 3, 12345678902, 100000)
GO
INSERT INTO CustomerTransaction VALUES
	(1, 'CC01', '2020-12-21 12:40:53', 200000, 1)
	,(2, 'CC02', '2020-12-21 12:40:53', 300000, 1)
	,(3, 'CC03', '2020-12-21 12:40:53', 400000, 1)
GO
--4
SELECT c.Name, c.City, c.Country, c.Phone, c.Email
 FROM Customer c WHERE c.City = 'Hanoi'
GO
--5
SELECT c.Name, c.Phone, c.Email, ca.AccountNumber, ca.Balance
FROM Customer c 
JOIN CustomerAccount ca ON c.CustomerId = ca.CustomerId
GO
--6
ALTER TABLE CustomerTransaction
ADD CHECK (Amount > 0  AND Amount <= 1000000);
GO
--7
CREATE VIEW vCustomerTransactions 
AS 
SELECT c.Name, ca.AccountNumber, ct.TransactionDate, ct.Amount, ct.DepositorWithDraw FROM Customer c
JOIN CustomerAccount  ca  ON c.CustomerId = ca.CustomerId
JOIN CustomerTransaction  ct ON ca.AccountNumber = ct.AccountNumber
GO
SELECT * FROM vCustomerTransactions
GO