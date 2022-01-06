CREATE DATABASE VIEW_SQL
GO
USE VIEW_SQL
GO
CREATE TABLE CLASS
(
	classCode VARCHAR(10) PRIMARY KEY
	,headTeacher VARCHAR(30)
	,room VARCHAR(30)
	,timeSlot CHAR
	,closeDate DATETIME
)
GO

CREATE TABLE STUDENT
(
	rollNo VARCHAR(10)PRIMARY KEY
	,classCode VARCHAR(10) REFERENCES CLASS(classCode)
	,fullName VARCHAR(30)
	,male BIT
	,birthDate DATETIME
	,address VARCHAR(30)
	,province CHAR(2)
	,email VARCHAR(30)
)
GO
CREATE TABLE SUBJECT
(
	subjectCode VARCHAR(10) PRIMARY KEY
	,subjectName VARCHAR(40)
	,WTest BIT
	,PTest BIT
	,Wtest_per INT
	,PTest_per INT
)
GO
CREATE TABLE MARK
(
	rollNo VARCHAR(10) REFERENCES STUDENT(rollNo)
	,subjectCode VARCHAR(10) REFERENCES SUBJECT(subjectCode)
	,WMark FLOAT
	,PMark FLOAT
	,Mark FLOAT
	PRIMARY KEY(rollNo, subjectCode)
)
GO
INSERT INTO CLASS VALUES
	('C1000', 'Peter','T1908M', 'F', '2022-12-12')
	,('C1001', 'Yasuo','T1909M', 'M', '2022-12-12')
	,('C1002', 'Jax','T2000M', 'L','2022-12-12')
	,('C1003', 'Vii','T2001M', 'G' ,'2022-12-12')
	,('C1004', 'Yii','T2002M', 'I', '2022-12-12')
GO
INSERT INTO STUDENT VALUES
	('A2001', 'C1000', 'Leona', 0, '2001-01-02', '1 Ngo 1 Tan My', 'HN', 'leona@lol.com.vn')
	,('A2002', 'C1000', 'Jinx', 0, '2001-02-02', '2 Ngo 1 Tan My', 'HN', 'jinx@lol.com.vn')
	,('A2003', 'C1000', 'Darius', 1, '2001-03-02', '3 Ngo 1 Tan My', 'HN', 'darius@lol.com.vn')
	,('A2004', 'C1000', 'Kathus', 1, '2001-04-02', '4 Ngo 1 Tan My', 'HN', 'kathus@lol.com.vn')
	,('A2005', 'C1000', 'Ashe', 0, '2001-05-02', '5 Ngo 1 Tan My', 'HN', 'ashe@lol.com.vn')
GO
INSERT INTO SUBJECT VALUES
	('QWER', 'Learn Play Lol With RYBY', 1, 1, 10, 10)
	,('TYUI', 'Learn Play Lol With JAVA', 1, 1, 10, 10)
	,('ASDF', 'Learn Play Lol With C', 1, 1, 10, 10)
	,('GHJK', 'Learn Play Lol With PYTHON', 1, 1, 10, 10)
	,('ZXCV', 'Learn Play Lol With PHP', 1, 1, 10, 10)
GO
INSERT INTO MARK VALUES
	('A2001', 'QWER', 6, 6, 6)
	,('A2001', 'TYUI', 7, 7, 7)
	,('A2001', 'ASDF', 8, 8, 8)
	,('A2001', 'GHJK', 9, 9, 9)
	,('A2001', 'ZXCV', 10, 10, 10)
GO
CREATE VIEW LIST_STUDENT as 
	SELECT s.rollNo, s.fullName FROM MARK m JOIN STUDENT s 
	ON s.rollNo = m.rollNo
	GROUP BY m.rollNo, m.subjectCode
	HAVING COUNT(m.subjectCode) >= 2 
	AND COUNT(s.rollNo) >= 2
GO
CREATE VIEW LIST_FAIL_STUDENT as
	SELECT s.rollNo, s.fullName FROM MARK m JOIN STUDENT s
	ON s.rollNo = m.rollNo
	WHERE m.WMark < 5 OR m.PMark < 5
GO
CREATE VIEW STUDENT_G as
	SELECT s.rollNo, s.fullName FROM STUDENT s
	JOIN CLASS c ON s.classCode = c.classCode
	WHERE c.timeSlot = 'G'
GO
CREATE VIEW LIST_TEACHER_FAIL as
	SELECT c.headTeacher FROM CLASS c JOIN STUDENT s 
	ON c.classCode = s.classCode
	JOIN MARK m ON m.rollNo = s.rollNO
	GROUP BY s.classCode 
	HAVING COUNT(s.rollNo) > 3
	AND (m.WMark < 5 OR m.PMark <5 )
GO
CREATE VIEW LIST_EPC_FAIL as
	SELECT c.headTeacher FROM CLASS c JOIN STUDENT s 
	ON c.classCode = s.classCode
	JOIN MARK m ON m.rollNo = s.rollNO
	JOIN SUBJECT su ON su.subjectCode = m.subjectCode
	WHERE su.subjectName = 'EPC' 
	AND (m.WMark < 5 OR m.PMark <5 )