/*
-----------------------------------------------------------------------------------------------------
| Tiêu chí               | MyISAM                             | InnoDB                              |
-----------------------------------------------------------------------------------------------------
| Hỗ trợ giao dịch (ACID)| Không                              | Có                                  |
-----------------------------------------------------------------------------------------------------
| Khóa (Locking)         | Khóa bảng                          | Khóa dòng                           |
-----------------------------------------------------------------------------------------------------
| Tốc độ đọc             | Nhanh hơn với truy vấn SELECT      | Ghi nhanh hơn                       |
-----------------------------------------------------------------------------------------------------
| Tốc độ ghi             | Chậm hơn do không hỗ trợ giao dịch | Nhanh hơn khi có nhiều thao tác ghi |
-----------------------------------------------------------------------------------------------------
| Khóa ngoại             | Không hỗ trợ                       | Hỗ trợ                              |
-----------------------------------------------------------------------------------------------------
| Rollback               | Không có                           | Có thể rollback                     |

*/

CREATE DATABASE sosanh;

USE sosanh;

-- ========================== HỖ TRỢ GIAO DỊCH (ACID) ===========================
-- Với MyISAM (Không hỗ trợ giao dịch)
CREATE TABLE transactions_myisam (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    amount DECIMAL(10,2)
) ENGINE=MyISAM;

START TRANSACTION;
INSERT INTO transactions_myisam (description, amount) VALUES ('Mua hàng', 100.00);
ROLLBACK; -- Không có tác dụng, dữ liệu vẫn được lưu

-- Với InnoDB (Có hỗ trợ giao dịch)
CREATE TABLE transactions_innodb (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255),
    amount DECIMAL(10,2)
) ENGINE=InnoDB;

START TRANSACTION;
INSERT INTO transactions_innodb (description, amount) VALUES ('Mua hàng', 100.00);
ROLLBACK; -- Dữ liệu không được lưu vào bảng

-- ========================== KHÓA (LOCKING) ===========================
-- MyISAM khóa bảng
CREATE TABLE users_myisam (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
) ENGINE=MyISAM;

START TRANSACTION;
UPDATE users_myisam SET age = 30 WHERE id = 1;
-- Cả bảng bị khóa, không thể cập nhật dòng khác

-- InnoDB khóa dòng
CREATE TABLE users_innodb (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
) ENGINE=InnoDB;

START TRANSACTION;
UPDATE users_innodb SET age = 30 WHERE id = 1;
-- Chỉ khóa dòng có id = 1, các dòng khác vẫn có thể cập nhật

-- ========================== TỐC ĐỘ ĐỌC ===========================
-- MyISAM nhanh hơn với SELECT do dùng chỉ mục FULLTEXT
CREATE TABLE posts_myisam (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    FULLTEXT(title, content)
) ENGINE=MyISAM;

SELECT * FROM posts_myisam WHERE MATCH(title, content) AGAINST ('database');

-- InnoDB hỗ trợ tìm kiếm nhưng không tối ưu cho FULLTEXT
CREATE TABLE posts_innodb (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT
) ENGINE=InnoDB;

SELECT * FROM posts_innodb WHERE title LIKE '%database%';

-- ========================== TỐC ĐỘ GHI ===========================
-- MyISAM ghi chậm hơn do không hỗ trợ giao dịch
INSERT INTO users_myisam (name, age) VALUES ('Nguyen Van A', 25);
-- Không có cơ chế rollback nếu lỗi xảy ra

-- InnoDB ghi nhanh hơn khi có nhiều thao tác nhờ hỗ trợ giao dịch
START TRANSACTION;
INSERT INTO users_innodb (name, age) VALUES ('Nguyen Van B', 28);
COMMIT;

-- ========================== KHÓA NGOẠI ===========================
-- MyISAM không hỗ trợ khóa ngoại
CREATE TABLE orders_myisam (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users_myisam(id) -- Lỗi, MyISAM không hỗ trợ
) ENGINE=MyISAM;

-- InnoDB hỗ trợ khóa ngoại
CREATE TABLE orders_innodb (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users_innodb(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ========================== ROLLBACK ===========================
-- MyISAM không hỗ trợ rollback
START TRANSACTION;
INSERT INTO transactions_myisam (description, amount) VALUES ('Refund', 50.00);
ROLLBACK; -- Không có tác dụng

-- InnoDB có thể rollback
START TRANSACTION;
INSERT INTO transactions_innodb (description, amount) VALUES ('Refund', 50.00);
ROLLBACK; -- Dữ liệu không được lưu

-- ========================== KẾT LUẬN ===========================
-- MyISAM nhanh hơn trong SELECT, nhưng không hỗ trợ giao dịch và khóa ngoại.
-- InnoDB hỗ trợ ACID, khóa ngoại, rollback và ghi nhanh hơn khi có nhiều thao tác ghi.

