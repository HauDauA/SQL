--2.
CREATE DATABASE SQL_EXAM2
GO
USE DATABASE SQL_EXAM2
GO
CREATE TABLE CATEGORY
(
	category_id INT IDENTITY PRIMARY KEY
	,category_name NVARCHAR(255) NOT NULL
	,address NVARCHAR(255) NOT NULL
	,phone_number VARCHAR(10) NOT NULL
	,status INT
)
GO
CREATE TABLE PRODUCT
(
	product_id INT IDENTITY PRIMARY KEY
	,product_name NVARCHAR(255)
	,description NVARCHAR(255)
	,util NVARCHAR(255)
	,price FLOAT
	,quantity INT
	,category_id INT REFERENCES CATEGORY(category_id)
	,status INT
)
GO

--3.
INSERT INTO CATEGORY VALUES
	('Asus','USA','0933456789',1)
GO

INSERT INTO PRODUCT VALUES
	('May Tinh T450','May nhap cu','Chiec',1000,10,1,1)
	,('May Tinh T460','May nhap cu','Chiec',200,200,1,1)
	,('May Tinh T470','May nhap cu','Chiec',100,10,1,1)
GO
--4.
	SELECT c.category_name FROM CATEGORY c
	GO
	SELECT p.product_name FROM PRODUCT p
	GO
--5.
	SELECT c.category_name, c.address, c.phone_number 
	FROM CATEGORY c ORDER BY c.category_name DESC
	GO	
	SELECT p.product_name, p.price, p.quantity
	FROM PRODUCT p ORDER BY p.price DESC
	GO
	SELECT * FROM CATEGORY c  WHERE c.category_name = 'Asus'
	GO
	SELECT p.product_name, p.quantity FROM PRODUCT p WHERE p.quantity < 11
	GO
	SELECT p.product_name FROM PRODUCT p
				JOIN CATEGORY c ON p.category_id=c.category_id
				WHERE c.category_name='Asus'	
	GO
--6.
	SELECT COUNT(c.category_id) FROM CATEGORY c
	GO
	SELECT COUNT(p.product_id) FROM PRODUCT p
	GROUP BY p.product_id 
	HAVING p.quantity > 0
	GO
	SELECT COUNT(p.quantity),c.category_name
	FROM PRODUCT p JOIN CATEGORY c On 
	p.category_id = c.category_id
	GROUP BY p.category_id
	GO
	SELECT COUNT(p.product_id) FROM PRODUCT p
	GROUP BY p.product_id
	
--8
	CREATE INDEX _DESCRIPTION_PRODUCT ON PRODUCT(product_name, description)
	GO
	CREATE VIEW _SanPham as
		SELECT p.product_id, p.product_name, p.price FROM PRODUCT p
	GO
	CREATE VIEW _SanPham_Hang as
		SELECT p.product_id, p.product_name, c.category_name
		FROM PRODUCT p 
		JOIN CATEGORY c 
		ON p.category_id = c.category_id
	GO
	CREATE PROC SP_SanPham_TenHang 
		@TenHang NVARCHAR(255)
		AS
		SELECT p.product_name, p.address, p.phone_number FROM PRODUCT p
		JOIN CATEGORY c ON p.category_id = c.category_id
		WHERE p.product_name = @TenHang
	GO
	EXEC SP_SanPham_TenHang @TenHang = N''
	GO
	CREATE PROC SP_SanPham_Gia
		@Gia FLOAT
		AS
		SELECT p.product_name, p.description, p.util, p.price FROM PRODUCT p
		WHERE p.price >= @Gia
		GO
	EXEC SP_SanPham_Gia @Gia = 123.33
	GO
	CREATE PROC SP_SanPham_HetHang
		AS
		SELECT * FROM PRODUCT p
		WHERE p.quantity = 0
	GO
	EXEC SP_SanPham_HetHang
	GO
	