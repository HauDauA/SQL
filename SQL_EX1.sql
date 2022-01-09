CREATE DATABASE SQL_EX1
GO
USE SQL_EX1
GO
--2.
CREATE TABLE [USER]
(
	user_id   IDENTITY PRIMARY KEY
	,user_name NVARCHAR(255) NOT NULL
	,user_address NVARCHAR(255) NOT NULL
	,phone_number VARCHAR(10) NOT NULL
	,status INT NOT NULL
)
GO

CREATE TABLE [PRODUCT]
(
	product_id INT IDENTITY PRIMARY KEY
	,product_name NVARCHAR(255) NOT NULL
	,description NVARCHAR(255) NOT NULL
	,util NVARCHAR(255) NOT NULL
	,price FLOAT NOT NULL
	,quantity INT NOT NULL
	,status INT NOT NULL
)
GO

CREATE TABLE [ORDER]
(
	order_id INT IDENTITY PRIMARY KEY
	,user_id INT REFERENCES [USER](user_id)
	,date_order DATE NOT NULL
	,total_money FLOAT NOT NULL
	,status INT NOT NULL
)
GO

CREATE TABLE [ORDER_DETAIL]
(
	order_detail_id INT IDENTITY PRIMARY KEY
	,product_id INT REFERENCES PRODUCT(product_id)
	,product_quantity INT NOT NULL
	,order_id INT REFERENCES [ORDER](order_id)
)
GO

--3.
INSERT INTO [USER] VALUES
	(N'Nguyễn Văn An', N'111 Nguyễn Trãi, Thanh Xuân, Hà Nội', '987654321', '2001-01-01',1)
GO

INSERT INTO [PRODUCT] VALUES
	(N'Máy Tính T450', N'Máy nhập mới', N'Chiếc', 1000, 100, 1)
	,(N'Điện Thoại Nokia5670', N'Điện thoại đang hot',N'Chiếc', 200, 100, 1)
	,(N'Máy In Samsung450', N'Máy in đang ế', N'Chiếc', 100, 100 ,1)
GO

INSERT INTO [ORDER] VALUES
	(1, '2009-11-18',1500, 1)
GO

INSERT INTO [ORDER_DETAIL] VALUES
	(1,1,1)
	,(2,2,1)
	,(3,1,1)
GO

--4.
 SELECT * FROM [USER] u JOIN [ORDER] o ON u.user_id = o.user_id
 SELECT * FROM [PRODUCT]
 SELECT * FROM [ORDER]

--5.
 SELECT * FROM [USER] ORDER BY user_name ASC
 SELECT * FROM  [PRODUCT] ORDER BY price DESC
 SELECT * FROM [ORDER_DETAIL] od 
	JOIN [ORDER] o ON od.order_id = o.order_id 
	JOIN [USER] u ON u.user_id = o.user_id 
	WHERE u.user_name = N'Nguyễn Văn An'
--6.
 SELECT COUNT(*) AS NUMBER_USER FROM [USER] u 
	JOIN [ORDER] o ON u.user_id = o.user_id 
 SELECT COUNT(*) AS NUMBER_PRODUCT FROM [PRODUCT]
 SELECT o.order_id, o.total_money AS TOTAL_MONEY FROM [ORDER] o

--7.
 UPDATE [PRODUCT]  SET price = ABS(price)+1 
	WHERE price <= 0
 UPDATE [ORDER]  SET date_order = DATEADD(day, -1, convert(date, GETDATE()))
	WHERE date_order >= convert(date, GETDATE())
 ALTER TABLE [PRODUCT]
	ADD date_display DATE NOT NULL;

--8
CREATE INDEX _PRODUCT_NAME ON PRODUCT(product_name)
	GO
CREATE INDEX _USER_NAME ON [USER](user_name)
	GO
CREATE VIEW _KhachHang as
	SELECT u.username, u.user_address, u.phone_number FROM [USER] u
	GO
CREATE VIEW _SanPham as
	SELECT p.product_name, p.price FROM PRODUCT p
	GO
CREATE VIEW _KhachHang_SanPham as
	SELECT u.user_name, u.phone_number, p.product_name, od.product_quantity, o.date_order
	FROM [USER] u 
	JOIN [ORDER] o ON u.user_id = o.user_id
	JOIN PRODUCT p ON p.product_id = o.product_id
	JOIN ORDER_DETAIL od ON od.order_id = o.order_id
	GO
CREATE PROC SP_TimKH_MaKH 
	@MaKH INT
	AS
	SELECT u.user_name, u.address, u.phone_number
	FROM [USER] u WHERE u.user_id = @MaKH
GO
EXEC SP_TimKH_MaKH @MaKH = 1
GO
CREATE PROC SP_TimKH_MaHD
	@Ma_HD INT
	AS
	SELECT u.user_name, u.address, u.phone_number FROM [USER] u 
	JOIN ORDER o ON u.user_id = o.user_id 
	WHERE o.order_id = @MaHD
GO
EXEC  SP_TimKH_MaHD @MaHd = 1
GO
CREATE PROC SP_SanPham_MaKH
	@MaKH INT
	AS
	SELECT p.product_name, od.product_quantity FROM [USER] u 
	JOIN ORDER o ON u.user_id = o.order_id 
	JOIN ORDER_DETAIL od ON od.order_id = o.order_id
	JOIN PRODUCT p ON p.product_id = od.product_id
	WHERE u.user_id = @MaKH
	GO
EXEC SP_SanPham_MaKH @MaKH = 1