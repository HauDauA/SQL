--2.
CREATE DATABASE SQL_EXAM2
GO
USE DATABASE SQL_EXAM2
GO
CREATE TABLE CATEGORY
(
	category_id INT IDENTITY PRIMARY KEY
	,category_name VARCHAR(255) NOT NULL
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
	
	
	
