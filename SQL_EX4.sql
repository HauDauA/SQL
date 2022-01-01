CREATE DATABASE SQL_EX4
GO
USE SQL_EX4
GO

--2
CREATE TABLE CATEGORY
(
	category_id VARCHAR(255) PRIMARY KEY
	,category_name NVARCHAR(255)
	,status INT
)
GO
CREATE TABLE [USER]
(
	user_id VARCHAR(255) PRIMARY KEY
	,user_name NVARCHAR(255)
	,status INT 
)
GO
CREATE TABLE PRODUCT
(
	product_id VARCHAR(255)  PRIMARY KEY	
	,product_name NVARCHAR(255)
	,category_id VARCHAR(255) REFERENCES CATEGORY(category_id)
	,user_id VARCHAR(255) REFERENCES [USER](user_id)
	,date_import DATE
	,status INT
)
GO
--3
INSERT INTO CATEGORY VALUES
	('Z37E',N'Máy tính sách tay Z37',1)
GO
INSERT INTO [USER] VALUES
	('987688',N'Nguyễn Văn An',1)
GO
INSERT INTO PRODUCT VALUES
	('Z37111111', N'Máy tính', 'Z37E', '987688', '2009-12-12',1)
GO
--4
SELECT c.category_name FROM CATEGORY c 
GO
SELECT u.user_name FROM [USER] u
GO
SELECT p.product_name FROM PRODUCT p
GO
--5
SELECT c.category_name FROM CATEGORY c ORDER BY c.category_name ASC
GO
SELECT u.user_name FROM [USER] u ORDER BY u.user_name ASC
GO
SELECT p.product_name, p.date_import, c.category_name FROM PRODUCT p 
	JOIN CATEGORY c 
		ON c.category_id = p.category_id
		WHERE c.category_id = 'Z37E'
GO
SELECT p.product_name, p.date_import FROM PRODUCT p 
	JOIN [USER] u
		ON u.user_id = p.user_id
		WHERE u.user_name = N'Nguyễn Văn An'
		ORDER BY p.product_id DESC
GO
--6
SELECT COUNT(p.product_id), c.category_name FROM PRODUCT p
	JOIN CATEGORY c ON p.category_id = c.category_id
	GROUP BY p.category_id
GO
SELECT * FROM PRODUCT p JOIN CATEGORY c ON p.category_id = c.category_id
GO
SELECT * FROM PRODUCT p JOIN CATEGORY c ON p.category_id = c.category_id
			JOIN [USER] u ON u.user_id = p.user_id
GO