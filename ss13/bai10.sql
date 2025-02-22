CREATE DATABASE ss13_10;

USE ss13_10;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    available_seats INT NOT NULL
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE transaction_log(
	history_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    action VARCHAR(50),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE student_status (
    student_id INT PRIMARY KEY,
    status ENUM('ACTIVE', 'GRADUATED', 'SUSPENDED') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_name) VALUES ('Nguyễn Văn An'), ('Trần Thị Ba');

INSERT INTO courses (course_name, available_seats) VALUES 
('Lập trình C', 25), 
('Cơ sở dữ liệu', 22);

-- 2
CREATE TABLE course_fees (
    course_id INT PRIMARY KEY,
    fee DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

CREATE TABLE student_wallets (
    student_id INT PRIMARY KEY,
    balance DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

-- 3
INSERT INTO course_fees (course_id, fee) VALUES
(1, 100.00), -- Lập trình C: 100$
(2, 150.00); -- Cơ sở dữ liệu: 150$

INSERT INTO student_wallets (student_id, balance) VALUES
(1, 200.00), -- Nguyễn Văn An có 200$
(2, 50.00);  -- Trần Thị Ba chỉ có 50$

-- 4
DELIMITER //
CREATE PROCEDURE RegisterCourse(
    IN p_student_name VARCHAR(50),
    IN p_course_name VARCHAR(100)
)
BEGIN
    DECLARE v_student_id INT;
    DECLARE v_course_id INT;
    DECLARE v_available_seats INT;
    DECLARE v_balance DECIMAL(10,2);
    DECLARE v_course_fee DECIMAL(10,2);
    DECLARE v_already_enrolled INT;
    
    -- Start transaction
    START TRANSACTION;
    
    -- Kiểm tra sinh viên có tồn tại không
    SELECT student_id INTO v_student_id FROM students WHERE student_name = p_student_name;
    IF v_student_id IS NULL THEN
        INSERT INTO transaction_log (student_id, course_id, action) 
        VALUES (NULL, NULL, 'FAILED: Student does not exist');
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student does not exist';
    END IF;
    
    -- Kiểm tra môn học có tồn tại không
    SELECT course_id, available_seats INTO v_course_id, v_available_seats FROM courses WHERE course_name = p_course_name;
    IF v_course_id IS NULL THEN
        INSERT INTO transaction_log (student_id, course_id, action) 
        VALUES (v_student_id, NULL, 'FAILED: Course does not exist');
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course does not exist';
    END IF;
    
    -- Kiểm tra sinh viên đã đăng ký môn học này chưa
    SELECT COUNT(*) INTO v_already_enrolled FROM enrollments WHERE student_id = v_student_id AND course_id = v_course_id;
    IF v_already_enrolled > 0 THEN
        INSERT INTO transaction_log (student_id, course_id, action) 
        VALUES (v_student_id, v_course_id, 'FAILED: Already enrolled');
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Already enrolled';
    END IF;
    
    -- Kiểm tra môn học còn chỗ trống không
    IF v_available_seats <= 0 THEN
        INSERT INTO transaction_log (student_id, course_id, action) 
        VALUES (v_student_id, v_course_id, 'FAILED: No available seats');
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No available seats';
    END IF;
    
    -- Kiểm tra số dư tài khoản
    SELECT balance INTO v_balance FROM student_wallets WHERE student_id = v_student_id;
    SELECT fee INTO v_course_fee FROM course_fees WHERE course_id = v_course_id;
    
    IF v_balance < v_course_fee THEN
        INSERT INTO transaction_log (student_id, course_id, action) 
        VALUES (v_student_id, v_course_id, 'FAILED: Insufficient balance');
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient balance';
    END IF;
    
    -- Đăng ký học phần
    INSERT INTO enrollments (student_id, course_id) VALUES (v_student_id, v_course_id);
    
    -- Trừ tiền từ tài khoản sinh viên
    UPDATE student_wallets SET balance = balance - v_course_fee WHERE student_id = v_student_id;
    
    -- Giảm số lượng chỗ trống của môn học
    UPDATE courses SET available_seats = available_seats - 1 WHERE course_id = v_course_id;
    
    -- Ghi nhận giao dịch thành công
    INSERT INTO transaction_log (student_id, course_id, action) 
    VALUES (v_student_id, v_course_id, 'REGISTERED');
    
    -- Commit transaction
    COMMIT;
END;
// DELIMITER ;

-- 5
CALL RegisterCourse('Nguyễn Văn An', 'Lập trình C');
CALL RegisterCourse('Trần Thị Ba', 'Cơ sở dữ liệu'); 

-- 6
SELECT * FROM student_wallets;