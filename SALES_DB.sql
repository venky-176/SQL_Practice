-- =============================================================
-- MySQL Database Creation and Table Setup Script
-- =============================================================
-- RUN IN: MySQL Workbench (or any MySQL client).
-- Not for SQL Server Management Studio: for SQL Server use 01_datasets/00_sql-server/.
--
-- WARNING:
-- This script assumes you are connected with a user that has
-- privileges to drop/create databases and tables.

-- DROP AND CREATE DATABASE
DROP DATABASE IF EXISTS `salesdb`;
CREATE DATABASE `salesdb` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `salesdb`;

-- ======================================================
-- Table: customers
-- ======================================================

CREATE TABLE `customers` (
  `customerid` INT NOT NULL PRIMARY KEY,
  `firstname` VARCHAR(50),
  `lastname` VARCHAR(50),
  `country` VARCHAR(50),
  `score` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `customers` (`customerid`,`firstname`,`lastname`,`country`,`score`) VALUES
  (1, 'Jossef', 'Goldberg', 'Germany', 350),
  (2, 'Kevin', 'Brown', 'USA', 900),
  (3, 'Mary', NULL, 'USA', 750),
  (4, 'Mark', 'Schwarz', 'Germany', 500),
  (5, 'Anna', 'Adams', 'USA', NULL);

-- ======================================================
-- Table: employees
-- ======================================================

CREATE TABLE `employees` (
  `employeeid` INT NOT NULL PRIMARY KEY,
  `firstname` VARCHAR(50),
  `lastname` VARCHAR(50),
  `department` VARCHAR(50),
  `birthdate` DATE,
  `gender` CHAR(1),
  `salary` INT,
  `managerid` INT,
  INDEX (`managerid`),
  CONSTRAINT `fk_employees_manager`
    FOREIGN KEY (`managerid`)
    REFERENCES `employees` (`employeeid`)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `employees` (`employeeid`,`firstname`,`lastname`,`department`,`birthdate`,`gender`,`salary`,`managerid`) VALUES
  (1, 'Frank', 'Lee', 'Marketing', '1988-12-05', 'M', 55000, NULL),
  (2, 'Kevin', 'Brown', 'Marketing', '1972-11-25', 'M', 65000, 1),
  (3, 'Mary', NULL, 'Sales', '1986-01-05', 'F', 75000, 1),
  (4, 'Michael', 'Ray', 'Sales', '1977-02-10', 'M', 90000, 2),
  (5, 'Carol', 'Baker', 'Sales', '1982-02-11', 'F', 55000, 3);

-- ======================================================
-- Table: products
-- ======================================================

CREATE TABLE `products` (
  `productid` INT NOT NULL PRIMARY KEY,
  `product` VARCHAR(50),
  `category` VARCHAR(50),
  `price` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `products` (`productid`,`product`,`category`,`price`) VALUES
  (101, 'Bottle', 'Accessories', 10),
  (102, 'Tire', 'Accessories', 15),
  (103, 'Socks', 'Clothing', 20),
  (104, 'Caps', 'Clothing', 25),
  (105, 'Gloves', 'Clothing', 30);

-- ======================================================
-- Table: orders
-- ======================================================

CREATE TABLE `orders` (
  `orderid` INT NOT NULL PRIMARY KEY,
  `productid` INT,
  `customerid` INT,
  `salespersonid` INT,
  `orderdate` DATE,
  `shipdate` DATE,
  `orderstatus` VARCHAR(50),
  `shipaddress` VARCHAR(255),
  `billaddress` VARCHAR(255),
  `quantity` INT,
  `sales` INT,
  `creationtime` TIMESTAMP,
  INDEX (`productid`),
  INDEX (`customerid`),
  INDEX (`salespersonid`),
  CONSTRAINT `fk_orders_product`
    FOREIGN KEY (`productid`)
    REFERENCES `products` (`productid`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_orders_customer`
    FOREIGN KEY (`customerid`)
    REFERENCES `customers` (`customerid`)
    ON DELETE SET NULL,
  CONSTRAINT `fk_orders_employee`
    FOREIGN KEY (`salespersonid`)
    REFERENCES `employees` (`employeeid`)
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `orders` (
  `orderid`,`productid`,`customerid`,`salespersonid`,
  `orderdate`,`shipdate`,`orderstatus`,`shipaddress`,
  `billaddress`,`quantity`,`sales`,`creationtime`
) VALUES
  (1, 101, 2, 3, '2025-01-01', '2025-01-05', 'Delivered', '9833 Mt. Dias Blv.', '1226 Shoe St.', 1, 10, '2025-01-01 12:34:56'),
  (2, 102, 3, 3, '2025-01-05', '2025-01-10', 'Shipped', '250 Race Court', NULL, 1, 15, '2025-01-05 23:22:04'),
  (3, 101, 1, 5, '2025-01-10', '2025-01-25', 'Delivered', '8157 W. Book', '8157 W. Book', 2, 20, '2025-01-10 18:24:08'),
  (4, 105, 1, 3, '2025-01-20', '2025-01-25', 'Shipped', '5724 Victory Lane', '', 2, 60, '2025-01-20 05:50:33'),
  (5, 104, 2, 5, '2025-02-01', '2025-02-05', 'Delivered', NULL, NULL, 1, 25, '2025-02-01 14:02:41'),
  (6, 104, 3, 5, '2025-02-05', '2025-02-10', 'Delivered', '1792 Belmont Rd.', NULL, 2, 50, '2025-02-06 15:34:57'),
  (7, 102, 1, 1, '2025-02-15', '2025-02-27', 'Delivered', '136 Balboa Court', '', 2, 30, '2025-02-16 06:22:01'),
  (8, 101, 4, 3, '2025-02-18', '2025-02-27', 'Shipped', '2947 Vine Lane', '4311 Clay Rd', 3, 90, '2025-02-18 10:45:22'),
  (9, 101, 2, 3, '2025-03-10', '2025-03-15', 'Shipped', '3768 Door Way', '', 2, 20, '2025-03-10 12:59:04'),
  (10, 102, 3, 5, '2025-03-15', '2025-03-20', 'Shipped', NULL, NULL, 0, 60, '2025-03-16 23:25:15');

-- ======================================================
-- Table: orders_archive
-- ======================================================

CREATE TABLE `orders_archive` (
  `orderid` INT,
  `productid` INT,
  `customerid` INT,
  `salespersonid` INT,
  `orderdate` DATE,
  `shipdate` DATE,
  `orderstatus` VARCHAR(50),
  `shipaddress` VARCHAR(255),
  `billaddress` VARCHAR(255),
  `quantity` INT,
  `sales` INT,
  `creationtime` TIMESTAMP,
  INDEX (`productid`),
  INDEX (`customerid`),
  INDEX (`salespersonid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `orders_archive` (
  `orderid`,`productid`,`customerid`,`salespersonid`,
  `orderdate`,`shipdate`,`orderstatus`,`shipaddress`,
  `billaddress`,`quantity`,`sales`,`creationtime`
) VALUES
  (1, 101, 2, 3, '2024-04-01', '2024-04-05', 'Shipped', '123 Main St', '456 Billing St', 1, 10, '2024-04-01 12:34:56'),
  (2, 102, 3, 3, '2024-04-05', '2024-04-10', 'Shipped', '456 Elm St', '789 Billing St', 1, 15, '2024-04-05 23:22:04'),
  (3, 101, 1, 4, '2024-04-10', '2024-04-25', 'Shipped', '789 Maple St', '789 Maple St', 2, 20, '2024-04-10 18:24:08'),
  (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Shipped', '987 Victory Lane', '', 2, 60, '2024-04-20 05:50:33'),
  (4, 105, 1, 3, '2024-04-20', '2024-04-25', 'Delivered', '987 Victory Lane', '', 2, 60, '2024-04-20 14:50:33'),
  (5, 104, 2, 5, '2024-05-01', '2024-05-05', 'Shipped', '345 Oak St', '678 Pine St', 1, 25, '2024-05-01 14:02:41'),
  (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', NULL, 2, 50, '2024-05-06 15:34:57'),
  (6, 104, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50, '2024-05-07 13:22:05'),
  (6, 101, 3, 5, '2024-05-05', '2024-05-10', 'Delivered', '543 Belmont Rd.', '3768 Door Way', 2, 50, '2024-05-12 20:36:55'),
  (7, 102, 3, 5, '2024-06-15', '2024-06-20', 'Shipped', '111 Main St', '222 Billing St', 0, 60, '2024-06-16 23:25:15');



  USE salesdb;

-- =========================================
-- 1. ADD CUSTOMERS (30 additional rows)
-- =========================================

INSERT INTO customers
(customerid, firstname, lastname, country, score)
VALUES
(6,'Aarav','Sharma','India',620),
(7,'Sophia','Miller','USA',NULL),
(8,'Liam','Wilson','Canada',480),
(9,'Olivia','Taylor','UK',810),
(10,'Noah','Anderson','Germany',300),
(11,'Emma','Thomas','India',750),
(12,'Oliver','Jackson','Australia',NULL),
(13,'Ava','White','USA',950),
(14,'Elijah','Harris','France',410),
(15,'Isabella','Martin','Spain',670),
(16,'Lucas','Thompson','Canada',0),
(17,'Mia','Garcia','Mexico',520),
(18,'Amir','Khan','India',880),
(19,'Charlotte','Clark','UK',350),
(20,'Ethan','Lewis','USA',720),
(21,'Amelia','Robinson','Australia',610),
(22,'James','Walker','Germany',NULL),
(23,'Harper','Hall','France',430),
(24,'Benjamin','Allen','India',990),
(25,'Evelyn','Young','USA',200),
(26,'Henry','King','Canada',560),
(27,'Abigail','Wright','Spain',640),
(28,'Daniel','Scott','UK',NULL),
(29,'Ella','Green','India',780),
(30,'Matthew','Baker','USA',100),
(31,'Sofia','Adams','Mexico',490),
(32,'Jackson','Nelson','Germany',860),
(33,'Luna','Carter','Australia',0),
(34,'Sebastian','Mitchell','France',710),
(35,'Grace',NULL,'India',330);


-- =========================================
-- 2. ADD EMPLOYEES (25 additional rows)
-- =========================================

INSERT INTO employees
(employeeid, firstname, lastname, department,
 birthdate, gender, salary, managerid)
VALUES
(6,'Priya','Rao','Engineering','1995-03-12','F',72000,1),
(7,'Arjun','Nair','Engineering','1992-07-24','M',85000,2),
(8,'Meera','Iyer','Sales','1998-11-02','F',55000,3),
(9,'Rohan','Das','Support','1990-05-18','M',62000,2),
(10,'Isha','Patel','Marketing','1997-09-09','F',65000,1),
(11,'Aditya','Menon','Engineering','1989-01-27','M',105000,2),
(12,'Zara','Khan','Finance','1994-06-14','F',78000,4),
(13,'Vikram','Shah','Sales','1985-12-30','M',90000,3),
(14,'Ananya','Joshi','HR','1996-04-21','F',58000,1),
(15,'Kiran','Reddy','Support','1993-08-16','M',62000,5),
(16,'Neha','Kulkarni','Engineering','2000-02-29','F',48000,2),
(17,'Rahul','Verma','Finance','1987-10-05','M',95000,4),
(18,'Diya','Pillai','Marketing','1999-07-07','F',55000,1),
(19,'Sanjay','Bose','Sales','1982-03-03','M',110000,3),
(20,'Tara','Srinivasan','HR','1991-01-19','F',70000,5),
(21,'Dev','Chopra','Engineering','1998-12-11','M',72000,2),
(22,'Nina','Fernandes','Support','1995-05-25','F',NULL,5),
(23,'Kabir','Malhotra','Sales','1988-09-17','M',90000,3),
(24,'Pooja','Bhat','Finance','1997-02-08','F',64000,4),
(25,'Manav','Ghosh','Marketing','1993-06-22','M',68000,1),
(26,'Aditi','Shetty','Engineering','2001-10-31','F',45000,2),
(27,'Varun','Jain','Support','1986-04-13','M',62000,5),
(28,'Simran','Kaur','HR','1994-12-01','F',NULL,1),
(29,'Yash','Desai','Sales',NULL,'M',75000,3),
(30,'Reva',NULL,'Engineering','1999-08-20',NULL,72000,NULL);


-- =========================================
-- 3. ADD PRODUCTS (25 additional rows)
-- =========================================

INSERT INTO products
(productid, product, category, price)
VALUES
(106,'Travel Mug','Accessories',18),
(107,'Backpack','Accessories',45),
(108,'Belt','Accessories',22),
(109,'Wallet','Accessories',35),
(110,'Scarf','Clothing',16),
(111,'Jacket','Clothing',80),
(112,'T-Shirt','Clothing',20),
(113,'Jeans','Clothing',55),
(114,'Sneakers','Footwear',75),
(115,'Boots','Footwear',110),
(116,'Sandals','Footwear',30),
(117,'Running Shoes','Footwear',95),
(118,'Desk Lamp','Home',28),
(119,'Notebook','Stationery',4),
(120,'Pen Set','Stationery',0),
(121,'Water Bottle','Accessories',12),
(122,'Hoodie','Clothing',40),
(123,'Sunglasses','Accessories',25),
(124,'Watch','Accessories',150),
(125,'Keyboard','Electronics',45),
(126,'Mouse','Electronics',20),
(127,'Headphones','Electronics',65),
(128,'USB Cable','Electronics',8),
(129,'Gift Card','Other',0),
(130,'Raincoat','Clothing',38);


-- =========================================
-- 4. ADD ORDERS (30 additional rows)
-- =========================================

INSERT INTO orders
(orderid, productid, customerid, salespersonid,
 orderdate, shipdate, orderstatus, shipaddress,
 billaddress, quantity, sales, creationtime)
VALUES
(11,101,1,1,'2025-01-01','2025-01-05','Delivered','14 Lake Road','',1,10,'2025-01-01 08:00:00'),
(12,102,2,2,'2025-02-04','2025-02-08','Shipped','88 Market Street','PO Box 125',2,30,'2025-02-04 09:07:00'),
(13,103,3,3,'2025-03-07',NULL,'Pending',NULL,'88 Market Street',3,60,'2025-03-07 10:14:00'),
(14,104,4,4,'2025-04-10','2025-04-14','Cancelled','','5 Garden Lane',1,25,'2025-04-10 11:21:00'),
(15,105,5,5,'2025-05-13','2025-05-17','Returned','27 Hill View','14 Lake Road',0,0,'2025-05-13 12:28:00'),
(16,106,6,6,'2025-06-16','2025-06-20','Delivered','5 Garden Lane',NULL,5,90,'2025-06-16 13:35:00'),
(17,107,7,7,'2025-07-19','2025-07-23','Shipped','14 Lake Road','',NULL,45,'2025-07-19 14:42:00'),
(18,108,8,8,'2025-08-22','2025-08-26','Pending','88 Market Street','PO Box 125',2,NULL,'2025-08-22 15:49:00'),
(19,109,9,9,'2025-09-25','2025-09-28','Cancelled',NULL,'88 Market Street',1,35,'2025-09-25 16:56:00'),
(20,110,10,10,'2025-10-01','2025-10-05','Returned','','5 Garden Lane',4,64,'2025-10-01 17:03:00'),
(21,111,11,11,'2025-11-04','2025-11-08','Delivered','27 Hill View','14 Lake Road',1,80,'2025-11-04 18:10:00'),
(22,112,12,12,'2025-12-07',NULL,'Shipped','5 Garden Lane',NULL,2,40,'2025-12-07 19:17:00'),
(23,113,13,13,'2025-01-10','2025-01-14','Pending','14 Lake Road','',3,165,'2025-01-10 08:24:00'),
(24,114,14,14,'2025-02-13','2025-02-17','Cancelled','88 Market Street','PO Box 125',1,75,'2025-02-13 09:31:00'),
(25,115,15,15,'2025-03-16','2025-03-20','Returned',NULL,'88 Market Street',0,0,'2025-03-16 10:38:00'),
(26,116,16,16,'2025-04-19','2025-04-23','Delivered','','5 Garden Lane',5,150,'2025-04-19 11:45:00'),
(27,117,17,17,'2025-05-22','2025-05-26','Shipped','27 Hill View','14 Lake Road',NULL,95,'2025-05-22 12:52:00'),
(28,118,18,18,'2025-06-25','2025-06-28','Pending','5 Garden Lane',NULL,2,56,'2025-06-25 13:59:00'),
(29,119,19,19,'2025-07-01','2025-07-05','Cancelled','14 Lake Road','',1,0,'2025-07-01 14:06:00'),
(30,120,20,20,'2025-08-04','2025-08-08','Returned','88 Market Street','PO Box 125',4,0,'2025-08-04 15:13:00'),
(31,121,21,21,'2026-09-07','2026-09-11','Delivered',NULL,'88 Market Street',1,12,'2026-09-07 16:20:00'),
(32,122,22,22,'2026-10-10','2026-10-14','Shipped','','5 Garden Lane',2,80,'2026-10-10 17:27:00'),
(33,123,23,23,'2026-11-13','2026-11-17','Pending','27 Hill View','14 Lake Road',3,75,'2026-11-13 18:34:00'),
(34,124,24,24,'2026-12-16','2026-12-20','Cancelled','5 Garden Lane',NULL,1,150,'2026-12-16 19:41:00'),
(35,125,25,25,'2026-01-19','2026-01-23','Returned','14 Lake Road','',0,NULL,'2026-01-19 08:48:00'),
(36,126,26,26,'2026-02-22','2026-02-26','Delivered','88 Market Street','PO Box 125',5,100,'2026-02-22 09:55:00'),
(37,127,27,27,'2026-03-25',NULL,'Shipped',NULL,'88 Market Street',NULL,65,'2026-03-25 10:02:00'),
(38,128,28,28,'2026-04-01','2026-04-05','Pending','','5 Garden Lane',2,16,'2026-04-01 11:09:00'),
(39,129,29,29,'2026-05-04','2026-05-08','Cancelled','27 Hill View','14 Lake Road',1,0,'2026-05-04 12:16:00'),
(40,130,30,30,'2026-06-07','2026-06-11','Returned','5 Garden Lane',NULL,4,152,'2026-06-07 13:23:00');


-- =========================================
-- 5. ADD ARCHIVED ORDERS (34 additional rows)
-- Duplicate order IDs are intentional.
-- =========================================

INSERT INTO orders_archive
(orderid, productid, customerid, salespersonid,
 orderdate, shipdate, orderstatus, shipaddress,
 billaddress, quantity, sales, creationtime)
VALUES
(11,101,1,3,'2024-01-01','2024-01-06','Shipped',NULL,NULL,1,10,'2024-01-01 09:00:00'),
(12,102,2,3,'2024-02-03','2024-02-08','Delivered','','',2,30,'2024-02-03 10:11:00'),
(13,103,3,4,'2024-03-05','2024-03-10','Pending','12 Old Road','12 Old Road',0,0,'2024-03-05 11:22:00'),
(14,104,4,3,'2024-04-07',NULL,'Cancelled','74 Archive Ave','Different Billing Address',3,75,'2024-04-07 12:33:00'),
(15,105,5,5,'2024-05-09','2024-05-14','Shipped','9 Pine Street',NULL,NULL,30,'2024-05-09 13:44:00'),
(16,106,6,5,'2024-06-11','2024-06-16','Delivered',NULL,'',2,36,'2024-06-11 14:55:00'),
(17,107,7,1,'2024-07-13','2024-07-18','Pending','','12 Old Road',1,45,'2024-07-13 15:06:00'),
(18,108,8,3,'2024-08-15','2024-08-20','Cancelled','12 Old Road','Different Billing Address',2,44,'2024-08-15 16:17:00'),
(19,109,9,3,'2024-09-17','2024-09-22','Shipped','74 Archive Ave',NULL,0,NULL,'2024-09-17 17:28:00'),
(20,110,10,5,'2024-10-19','2024-10-24','Delivered','9 Pine Street','',3,48,'2024-10-19 18:39:00'),
(21,111,11,6,'2024-11-21','2024-11-26','Pending',NULL,'12 Old Road',NULL,80,'2024-11-21 09:50:00'),
(22,112,12,7,'2024-12-23','2024-12-28','Cancelled','','Different Billing Address',2,40,'2024-12-23 10:01:00'),
(23,113,13,8,'2024-01-25','2024-01-28','Shipped','12 Old Road',NULL,1,55,'2024-01-25 11:12:00'),
(24,114,14,9,'2024-02-27','2024-02-28','Delivered','74 Archive Ave','',2,150,'2024-02-27 12:23:00'),
(25,115,15,10,'2024-03-02','2024-03-07','Pending','9 Pine Street','12 Old Road',0,0,'2024-03-02 13:34:00'),
(26,116,16,11,'2024-04-04','2024-04-09','Cancelled',NULL,'Different Billing Address',3,90,'2024-04-04 14:45:00'),
(27,117,17,12,'2024-05-06','2024-05-11','Shipped','',NULL,NULL,0,'2024-05-06 15:56:00'),
(28,118,18,13,'2024-06-08','2024-06-13','Delivered','12 Old Road','',2,56,'2024-06-08 16:07:00'),
(29,119,19,14,'2024-07-10','2024-07-15','Pending','74 Archive Ave','12 Old Road',1,4,'2024-07-10 17:18:00'),
(30,120,20,15,'2024-08-12','2024-08-17','Cancelled','9 Pine Street','Different Billing Address',2,0,'2024-08-12 18:29:00'),
(31,121,21,16,'2024-09-14',NULL,'Shipped',NULL,NULL,0,0,'2024-09-14 09:40:00'),
(32,122,22,17,'2024-10-16','2024-10-21','Delivered','','',3,120,'2024-10-16 10:51:00'),
(33,123,23,18,'2024-11-18','2024-11-23','Pending','12 Old Road','12 Old Road',NULL,25,'2024-11-18 11:02:00'),
(34,124,24,19,'2024-12-20','2024-12-25','Cancelled','74 Archive Ave','Different Billing Address',2,300,'2024-12-20 12:13:00'),
(35,125,25,20,'2024-01-22','2024-01-27','Shipped','9 Pine Street',NULL,1,45,'2024-01-22 13:24:00'),
(36,126,26,21,'2024-02-24','2024-02-28','Delivered',NULL,'',2,NULL,'2024-02-24 14:35:00'),
(37,127,27,22,'2024-03-26','2024-03-28','Pending','','12 Old Road',0,0,'2024-03-26 15:46:00'),
(38,128,28,23,'2024-04-01','2024-04-06','Cancelled','12 Old Road','Different Billing Address',3,24,'2024-04-01 16:57:00'),
(39,129,29,24,'2024-05-03','2024-05-08','Shipped','74 Archive Ave',NULL,NULL,0,'2024-05-03 17:08:00'),
(40,130,30,25,'2024-06-05','2024-06-10','Delivered','9 Pine Street','',2,76,'2024-06-05 18:19:00'),

-- Intentional duplicate order IDs with conflicting versions
(12,102,2,3,'2024-02-03','2024-02-08','Delivered','456 Elm St','456 Elm St',1,15,'2024-02-03 16:45:00'),
(18,108,8,9,'2024-08-15',NULL,'Returned',NULL,'',2,110,'2024-08-16 10:20:00'),
(25,115,15,17,'2024-03-22','2024-03-27','Shipped','9 Pine Street',NULL,0,0,'2024-03-22 11:11:11'),
(33,123,23,25,'2024-09-12','2024-09-18','Delivered','12 Old Road','12 Old Road',3,24,'2024-09-12 20:10:00');


-- =========================================
-- 6. VERIFY ROW COUNTS
-- =========================================

SELECT 'customers' AS table_name, COUNT(*) AS total_rows
FROM customers
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'orders_archive', COUNT(*) FROM orders_archive;