create database QUANLYDIEMTHI;
use QUANLYDIEMTHI;
create table STUDENT(
studentId varchar(4) primary key,
studentName varchar(100) not null,
birthday date not null,
gender bit(1) not null,
address text not null,
phoneNumber varchar(45) unique
);

create table Subjects(
subjectId varchar(4) primary key,
subjectName varchar(45) not null,
priority int (11) not null
);

create table Mark(
subjectid varchar(4) not null,
studentId varchar(4) not null,
point int(11) not null,
foreign key (subjectid) references Subjects(subjectId),
foreign key (studentId) references STUDENT(studentId)
);


#Bài 2: Thêm , sửa , xoá dữ liệu 
#1.Thêm dữ liệu vào các bảng
insert into STUDENT(studentId,studentName,birthday,gender,address,phonenumber) values
('S001','Nguyễn Thế Anh','1999-01-11',1,'Hà Nội','984678082'),
('S002','Đặng Bảo Trâm','1998-12-22',0,'Lào cai','904982654'),
('S003','Trần Hà Phương','2000-05-05',0,'Nghệ An','947645363'),
('S004','Đỗ Tiến Mạnh','1999-03-26',1,'Hà Nội','983665353'),
('S005','Phạm Duy Nhất','1998-10-04',1,'Tuyên Quang','987242678'),
('S006','Mai Văn Thái','2002-06-22',1,'Nam Định','982654268'),
('S007','Giang Gia Hân','1996-11-10',0,'Phú Thọ','982364753'),
('S008','Nguyễn Ngọc Bảo My','1999-01-22',0,'Hà Nam','927867453'),
('S009','Nguyến Tiến Đạt','1998-08-07',1,'Tuyên Quang','989274673'),
('S010','Nguyễn Thiều Quang','2000-09-08',1,'Hà Nội','984378219');

insert into Subjects(subjectId,subjectName,priority) values
('MH01','Toán',2),
('MH02','Vật Lý',2),
('MH03','Hoá Học',1),
('MH04','Ngữ Văn',1),
('MH05','Tiếng Anh',2);

insert into Mark (studentId,SubjectID,point) values
('S001','MH01',8.5),
('S001','MH02',7),
('S001','MH03',9),
('S001','MH04',9),
('S001','MH05',5),
('S002','MH01',9),
('S002','MH02',8),
('S002','MH03',6.5),
('S002','MH04',8),
('S002','MH05',6),
('S003','MH01',7.5),
('S003','MH02',6.5),
('S003','MH03',8),
('S003','MH04',7),
('S003','MH05',7),
('S004','MH01',6),
('S004','MH02',7),
('S004','MH03',5),
('S004','MH04',6.5),
('S004','MH05',8),
('S005','MH01',5.5),
('S005','MH02',8),
('S005','MH03',7.5),
('S005','MH04',8.5),
('S005','MH05',9),
('S006','MH01',8),
('S006','MH02',10),
('S006','MH03',9),
('S006','MH04',7.5),
('S006','MH05',6.5),
('S007','MH01',9.5),
('S007','MH02',9),
('S007','MH03',6),
('S007','MH04',9),
('S007','MH05',4),
('S008','MH01',10),
('S008','MH02',8.5),
('S008','MH03',8.5),
('S008','MH04',6),
('S008','MH05',9.5),
('S009','MH01',7.5),
('S009','MH02',7),
('S009','MH03',9),
('S009','MH04',5),
('S009','MH05',10),
('S010','MH01',6.5),
('S010','MH02',8),
('S010','MH03',5.5),
('S010','MH04',4),
('S010','MH05',7);
#2. Cập nhật dữ liệu
#Sửa tên sinh viên có mã S004 thành "Đỗ Đức Mạnh":
UPDATE STUDENT
SET studentName = 'Đỗ Đức Mạnh'
WHERE studentId = 'S004';

#Sửa tên và hệ số môn học có mã MH05 thành "Ngoại Ngữ" và hệ số là 1:
UPDATE Subjects
SET subjectName = 'Ngoại Ngữ', priority = 1
WHERE subjectId = 'MH05';

#Cập nhật lại điểm của học sinh có mã S009 thành (MH01 : 8.5, MH02 : 7, MH03 : 5.5, MH04 : 6, MH05 : 9):
UPDATE Mark
SET point = CASE
    WHEN subjectid = 'MH01' THEN 8.5
    WHEN subjectid = 'MH02' THEN 7
    WHEN subjectid = 'MH03' THEN 5.5
    WHEN subjectid = 'MH04' THEN 6
    WHEN subjectid = 'MH05' THEN 9
END
WHERE studentId = 'S009';


#3. Xoá dữ liệu
#Xoá toàn bộ thông tin của học sinh có mã S010 bao gồm điểm thi ở bảng MARK và thông tin học sinh này ở bảng STUDENT:
DELETE FROM Mark WHERE studentId = 'S010';
DELETE FROM STUDENT WHERE studentId = 'S010';

#Bài 3: Truy vấn dữ liệu :
#1. Lấy ra tất cả thông tin của sinh viên trong bảng Student
SELECT * FROM Student;

#2. Hiển thị tên và mã môn học của những môn có hệ số bằng 
SELECT subjectName, subjectId, priority
FROM Subjects
WHERE priority = 1;

#3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ năm sinh) ,
# giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh
SELECT studentId, studentName, YEAR(CURRENT_DATE()) - YEAR(birthday) AS age,
       CASE
           WHEN gender = 1 THEN 'Nam'
           ELSE 'Nữ'
       END AS gender,
       address
FROM Student;

#4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , 
#điểm thi của tất cả học sinh của môn Toán và sắp xếp theo điểm giảm dần

SELECT s.studentName, su.subjectName, m.point
FROM Mark m
JOIN Student s ON m.studentId = s.studentId
JOIN Subjects su ON m.subjectId = su.subjectId
WHERE su.subjectName = 'Toán'
ORDER BY m.point DESC;

#5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).

SELECT
    CASE
        WHEN gender = 1 THEN 'Nam'
        ELSE 'Nữ'
    END AS gender,
    COUNT(*) AS count
FROM Student
GROUP BY gender;

#6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm để tính toán)
# , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình.

SELECT 
    m.studentId,
    s.studentName,
    SUM(m.point) AS totalPoint,
    AVG(m.point) AS averagePoint
FROM Mark m
JOIN Student s ON m.studentId = s.studentId
GROUP BY m.studentId, s.studentName;

#Bài 4: Tạo View, Index, Procedure 
#1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học sinh, giới tính , quê quán
CREATE VIEW STUDENT_VIEW AS
SELECT StudentID, StudentName, CASE
        WHEN gender = 1 THEN 'Nam'
        ELSE 'Nữ'
    END AS gender, address
FROM STUDENT;


#2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh, điểm trung bình các môn học
CREATE VIEW AVERAGE_MARK_VIEW AS
SELECT s.StudentID, s.StudentName, AVG(m.point) AS AverageMark
FROM STUDENT s
JOIN MARK m ON s.StudentID = m.StudentID
GROUP BY s.StudentID, s.StudentName;


#3. Đánh Index cho trường `phoneNumber` của bảng STUDENT

CREATE INDEX idx_phoneNumber ON STUDENT (phoneNumber);

#4. Tạo các PROCEDURE sau:- Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả thông tin học sinh đó.

DELIMITER //
CREATE PROCEDURE PROC_INSERTSTUDENT(
    IN p_StudentID VARCHAR(4),
    IN p_StudentName VARCHAR(100),
    IN p_Gender BIT(1),
    IN p_birthday date,
    IN p_Address VARCHAR(100),
    IN p_PhoneNumber VARCHAR(45)
)
BEGIN
    INSERT INTO STUDENT (StudentID, StudentName, Gender,birthday, Address, phoneNumber)
    VALUES (p_StudentID, p_StudentName, p_Gender,p_birthday, p_Address, p_PhoneNumber);
END//
DELIMITER ;

call PROC_INSERTSTUDENT('S011','Trần Văn Thịnh', 1,'1997-02-02','Hà Nội','987654321');
#Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
DELIMITER //
CREATE PROCEDURE PROC_UPDATESUBJECT(
    IN p_SubjectID INT,
    IN p_NewSubjectName VARCHAR(100)
)
BEGIN
    UPDATE SUBJECTS
    SET SubjectName = p_NewSubjectName
    WHERE SubjectID = p_SubjectID;
END//
DELIMITER ;
call PROC_UPDATESUBJECT(1,'Toán Tử');

#Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học sinh. 
DELIMITER //
CREATE PROCEDURE PROC_DELETEMARK(
    IN p_StudentID INT
)
BEGIN
    DELETE FROM MARK
    WHERE StudentID = p_StudentID;
END//
DELIMITER ;

call PROC_DELETEMARK(9);
