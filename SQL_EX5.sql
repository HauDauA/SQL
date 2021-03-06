CREATE DATABASE SQL_EX5
GO
USE SQL_EX5
GO

--2
CREATE TABLE [USER]
(
	user_id INT IDENTITY PRIMARY KEY
	,user_name NVARCHAR(255)
	,address NVARCHAR(255)
	,birthday DATE
	,status INT
)
CREATE TABLE PHONEBOOK
(
	phone_id INT IDENTITY PRIMARY KEY
	,phone_number VARCHAR(10)
	,user_id INT REFERENCES [USER](user_id)
	,status INT
)
GO
--3
INSERT INTO [USER] VALUES
	(N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '1987-11-18', 1)
GO
INSERT INTO PHONEBOOK VALUES
	('3425678643',1,1)
	,('3425678743',1,1)
	,('3425674643',1,1)
GO
--4
SELECT u.user_name FROM [USER] u
GO
SELECT p.phone_number FROM PHONEBOOK p
GO
--5
SELECT u.user_name FROM [USER] u ORDER BY u.user_name ASC
GO
SELECT p.phone_number FROM PHONEBOOK p 
	JOIN [USER] u ON p.user_id = u.user_id
	WHERE u.user_name = N'Nguyễn Văn An'
GO
SELECT u.user_name FROM [USER] u WHERE u.birthday = '2009-12-12'
GO
--6
SELECT COUNT(p.phone_id), u.user_name FROM PHONEBOOK p
	JOIN [USER] u ON p.user_id = u.user_id
	GROUP BY p.user_id
GO
SELECT COUNT(u.user_id) FROM [USER] u
	GROUP BY u.birthday
	HAVING EXTRACT(MONTH FROM u.birthday) = 12
GO
SELECT * FROM [USER] u JOIN PHONEBOOK p ON u.user_id = p.user_id
GO
SELECT * FROM [USER] u JOIN PHONEBOOK p ON u.user_id = p.user_id WHERE p.phone_number = '123456789'
GO
--8
CREATE INDEX IX_HOTEN ON [USER](user_name)
GO
CREATE INDEX IX_SoDienThoai ON [PHONEBOOK](phone_number)
GO
CREATE VIEW View_SoDienThoai
AS
	SELECT u.user_name, p.phone_number FROM [USER] u 
	JOIN [PHONEBOOK] p ON u.user_id = p.user_id
GO
CREATE VIEW View_SinhNhat
AS
	SELECT FROM [USER] u
	WHERE MONTH(u.birthday) = MONTH(GETDATE());
GO
CREATE PROC SP_Them_DanhBa
	@UserId INT
	,@PhoneNumber VARCHAR(10)
	AS
	IF EXIST(SELECT * FROM [USER] WHERE user_id = @UserId)
	INSERT INTO PHONEBOOK VALUES
	(@PhoneNumber, @UserId , 1)
	GO
EXEC SP_Them_DanhBa @UserId = 1, @PhoneNumber = '1234567890'
	GO
CREATE PROC SP_Tim_DanhBa
	@UserName NVARCHAR(255)
	AS
	SELECT p.phone_number FROM [USER] u 
	JOIN PHONEBOOK p ON u.user_id = p.user_id 
	WHERE u.user_name LIKE @UserName
	GO
EXEC SP_Tim_DanhBa @UserName = 'HA'
GO
			