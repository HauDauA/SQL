CREATE DATABASE Lab10
GO
USE Lab10
GO
CREATE TABLE Toys
(
 ProductCode varchar(5),
 Name varchar(30),
 Category varchar(30),
 Manufacturer varchar(40),
 AgeRange varchar(15),
 UnitPrice money,
 Netweight int,
 QtyOnHand int,
 constraint kt_ProductCode primary key (ProductCode)
)
/* 1. Tạo bảng Toys với cấu trúc giống như trên. Thêm dữ liệu (15 bản ghi) vào bảng với giá trị của 
trường QtyOnHand ít nhất là 20 cho mỗi sản phẩm đồ chơi.*/
INSERT INTO Toys VALUES ('DC001','Rubic','Do choi','Marvel','3-10 tuoi',50000,50,50)
INSERT INTO Toys VALUES ('DC002','Logo tau thuy','Lap giap','Tap doan LOGO','8-13 tuoi',150000,3000,20)
INSERT INTO Toys VALUES ('DC003','Xe dieu khien','Dieu khien','Tap doan Xe DK','10-15 tuoi',90000,2000,30)
INSERT INTO Toys VALUES ('DC004','May bay dieu khien','Dieu Khien','Tap doan may bay DK','10-15 tuoi',250000,3000,30)
INSERT INTO Toys VALUES ('DC005','Logo toa nha','Lap giap','Tap doan logo','8-13 tuoi',150000,300,20)
INSERT INTO Toys VALUES ('DC006','Rubic 2','Bo game','Marvel','3-11 tuoi',350000,500,150)
INSERT INTO Toys VALUES ('DC007','Rubic  3','Bo game','Marvel','4-12 tuoi',450000,60,250)
INSERT INTO Toys VALUES ('DC008','Rubic  4','Bo game','Marvel','5-13 tuoi',550000,100,350)
INSERT INTO Toys VALUES ('DC009','Rubic  5','Bo game','Marvel','6-14 tuoi',650000,5000,450)
INSERT INTO Toys VALUES ('DC010','Rubic  6','Bo game','Marvel','7-15 tuoi',150000,900,550)
INSERT INTO Toys VALUES ('DC011','Rubic  7','Bo game','Marvel','8-15 tuoi',250000,200,650)
INSERT INTO Toys VALUES ('DC012','Rubic  8','Bo game','Marvel','9-15 tuoi',350000,300,150)
INSERT INTO Toys VALUES ('DC013','Rubic  9','Bo game','Marvel','10-15 tuoi',450000,400,250)
INSERT INTO Toys VALUES ('DC014','Rubic  10','Bo game','Marvel','11-16 tuoi',550000,600,350)
INSERT INTO Toys VALUES ('DC015','Rubic  11','Bo game','Marvel','12-17 tuoi',250000,90,450)

SELECT * FROM Toys
GO
/*2. Viết câu lệnh tạo Thủ tục lưu trữ có tên là HeavyToys cho phép liệt kê tất cả các loại đồ chơi có
trọng lượng lớn hơn 500g.*/
CREATE PROC HeavyToys AS
SELECT ProductCode,Name,Category FROM Toys
WHERE Netweight > 500
GO
/*3. Viết câu lệnh tạo Thủ tục lưu trữ có tên là PriceIncreasecho phép tăng giá của tất cả các loại đồ 
chơi lên thêm 10 đơn vị giá.*/
CREATE PROCEDURE PriceIncreasecho AS
SELECT ProductCode,Name,UnitPrice+10 AS SauKhiTangGia FROM Toys
GO
/*4. Viết câu lệnh tạo Thủ tục lưu trữ có tên là QtyOnHand làm giảm số lượng đồ chơi còn trong của 
hàng mỗi thứ 5 đơn vị.*/
CREATE PROCEDURE QtyOnHand AS
SELECT ProductCode,Name,QtyOnHand-5 AS SauKhiGiamSoLuong FROM Toys
GO
--5. Thực thi 3 thủ tục lưu trữ trên.
EXECUTE HeavyToys
GO
EXECUTE PriceIncreasecho
GO
EXECUTE QtyOnHand
GO
/*1. Ta đã có 3 thủ tục lưu trữ tên là HeavyToys,PriceIncrease, QtyOnHand. Viết các câu lệnh xem 
định nghĩa củacác thủ tục trên dùng 3 cách sau:
- Thủ tục lưu trữ hệ thống sp_helptext
- Khung nhìn hệ thống sys.sql_modules
- Hàm OBJECT_DEFINITION()*/
sp_helptext HeavyToys
GO
sp_helptext PriceIncreasecho
GO
sp_helptext QtyOnHand
GO

SELECT OBJECT_DEFINITION (OBJECT_ID(N'HeavyToys')) AS [ThucHienLenh]; 
SELECT OBJECT_DEFINITION (OBJECT_ID(N'PriceIncreasecho')) AS [ThucHienLenh]; 
SELECT OBJECT_DEFINITION (OBJECT_ID(N'QtyOnHand')) AS [ThucHienLenh]; 
--2. Viết câu lệnh hiển thị các đối tượng phụ thuộc của mỗi thủ tục lưu trữ trên
EXECUTE sp_depends HeavyToys
EXECUTE sp_depends PriceIncreasecho
EXECUTE sp_depends QtyOnHand
GO
/*3. Chỉnh sửa thủ tục PriceIncreasevà QtyOnHandthêm câu lệnh cho phép hiển thị giá trị mới đã
được cập nhật của các trường (UnitPrice,QtyOnHand).*/
ALTER PROCEDURE PriceIncreasecho AS
UPDATE Toys SET UnitPrice=UnitPrice+5000
GO
SELECT *FROM Toys
GO
ALTER PROCEDURE QtyOnHand AS
UPDATE Toys SET QtyOnHand=QtyOnHand-5
GO
SELECT *FROM Toys
GO
/*4. Viết câu lệnh tạo thủ tục lưu trữ có tên là SpecificPriceIncrease thực hiện cộng thêm tổng số sản 
phẩm (giá trị trường QtyOnHand)vào giá của sản phẩm đồ chơi tương ứng.*/
CREATE PROCEDURE SpecificPriceIncrease AS
UPDATE Toys SET UnitPrice=UnitPrice+QtyOnHand
GO
SELECT *FROM Toys
GO
/*5. Chỉnh sửa thủ tục lưu trữ SpecificPriceIncrease cho thêm tính năng trả lại tổng số các bản ghi 
được cập nhật.*/
ALTER PROCEDURE SpecificPriceIncrease @number int OUTPUT AS
UPDATE Toys SET UnitPrice=UnitPrice+QtyOnHand
SELECT ProductCode,Name,UnitPrice as Price,QtyOnHand FROM Toys
WHERE QtyOnHand>0
SELECT @number = @@Rowcount
GO
DECLARE @num int
EXECUTE SpecificPriceIncrease @num OUTPUT
PRINT @num
GO
--6. Chỉnh sửa thủ tục lưu trữ SpecificPriceIncrease cho phép gọi thủ tục HeavyToysbên trong nó
ALTER PROCEDURE SpecificPriceIncrease @number int OUTPUT AS
UPDATE Toys SET UnitPrice=UnitPrice+QtyOnHand
SELECT ProductCode,Name,UnitPrice as Price,QtyOnHand FROM Toys
WHERE QtyOnHand>0
SELECT @number = @@Rowcount
execute HeavyToys
--8. Xóa bỏ tất cả các thủ tục lưu trữ đã được tạo ra
DROP PROCEDURE HeavyToys
DROP PROCEDURE PriceIncreasecho
DROP PROCEDURE QtyOnHand