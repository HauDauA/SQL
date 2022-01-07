CREATE DATABASE SQL_EX3
GO
USE SQL_EX3
GO
--2
CREATE TABLE CUSTOMER
(
	customer_id INT IDENTITY PRIMARY KEY
	,customer_name NVARCHAR(255)
	,address NVARCHAR(255)
	,identity_card VARCHAR(12)
	,status INT
)
GO

CREATE TABLE SERVICE
(
	service_id INT IDENTITY PRIMARY KEY
	,service_number VARCHAR(10)
	,service_type NVARCHAR(255)	
	,date_register DATE
	,customer_id INT REFERENCES CUSTOMER(customer_id)
	,status INT
)
GO
--3
INSERT INTO CUSTOMER VALUES
	(N'Nguyễn NGuyệt Nga', N'Hà Nội', '123456789654',1)
GO

INSERT INTO SERVICE VALUES
	('1234567890', N'Trả trước','2002-12-12', 1,1)
GO
--4
SELECT * FROM CUSTOMER
GO
SELECT * FROM SERVICE
GO
--5
SELECT cu.customer_name, cu.address, cu.identity_card
	 FROM CUSTOMER cu JOIN SERVICE s 
		ON cu.customer_id = s.customer_id
		WHERE s.service_number = '0123456789'
GO
SELECT cu.customer_name, cu.address FROM CUSTOMER cu
	WHERE cu.identity_card = '123456789'
GO
SELECT s.service_number FROM SERVICE s JOIN CUSTOMER cu 
	ON s.customer_id = cu.customer_id
	WHERE cu.identity_card = '123456789'
GO
SELECT s.service_number FROM SERVICE s
	WHERE s.date_register = '2009-12-12'
GO
SELECT s.service_number FROM SERVICE s JOIN CUSTOMER cu 
	ON s.customer_id = cu.customer_id
	WHERE cu.address = N'Hà Nội'
GO
--6
SELECT COUNT(customer_id) AS TOTAL_CUSTOMER 
	FROM CUSTOMER
GO
SELECT COUNT(service_id) AS TOTAL_SERVICE_NUMBER
	FROM SERVICE
GO
SELECT COUNT(s.service_id) AS TOTAL_SERVICE_NUMBER
	FROM SERVICE s WHERE s.date_register = '2009-12-12'
GO
SELECT * FROM CUSTOMER cu JOIN SERVICE s
	ON cu.customer_id = s.customer_id

--8
CREATE INDEX _CUSTOMER_NAME ON CUSTOMER(customer_name)
	GO
CREATE VIEW _KhachHang as
	SELECT c.customer_name, c.address, c.customer_id FROM CUSTOMER c
	GO
CREATE VIEW _KhachHang_ThueBao as
	SELECT c.customer_id, c.customer_name, s.service_number
	FROM CUSTOMER c JOIN SERVICE s 
	ON c.customer_id = s.customer_id