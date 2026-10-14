-- ============================================================
-- SQL PRACTICE DATABASE
-- Company Management Database
-- MySQL 8+
-- ============================================================

DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db;
-- to create a new database
USE company_db;
-- to use a new database999


-- ============================================================
-- 1. DEPARTMENTS
-- ============================================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100)
);

INSERT INTO departments (department_name, location) VALUES
('Engineering', 'Bangalore'),
('Human Resources', 'Bangalore'),
('Finance', 'Mumbai'),
('Marketing', 'Hyderabad'),
('Sales', 'Chennai'),
('IT Support', 'Pune');

-- ============================================================
-- 2. EMPLOYEES
-- ============================================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    job_title VARCHAR(100),
    salary DECIMAL(10,2),
    hire_date DATE,
    department_id INT,
    manager_id INT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

INSERT INTO employees
(first_name, last_name, email, job_title, salary, hire_date, department_id, manager_id)
VALUES
('Rahul', 'Sharma', 'rahul.sharma@company.com', 'Engineering Manager', 95000, '2020-01-15', 1, NULL),
('Priya', 'Nair', 'priya.nair@company.com', 'Senior Java Developer', 82000, '2021-03-10', 1, 1),
('Arjun', 'Kumar', 'arjun.kumar@company.com', 'Java Developer', 65000, '2022-06-20', 1, 1),
('Sneha', 'Reddy', 'sneha.reddy@company.com', 'Software Engineer', 62000, '2023-02-14', 1, 1),
('Vikram', 'Patel', 'vikram.patel@company.com', 'Junior Developer', 48000, '2024-07-01', 1, 2),
('Ananya', 'Iyer', 'ananya.iyer@company.com', 'HR Manager', 78000, '2020-08-12', 2, NULL),
('Kiran', 'Mehta', 'kiran.mehta@company.com', 'HR Executive', 52000, '2022-01-18', 2, 6),
('Divya', 'Rao', 'divya.rao@company.com', 'HR Executive', 50000, '2023-09-05', 2, 6),
('Amit', 'Verma', 'amit.verma@company.com', 'Finance Manager', 88000, '2019-11-25', 3, NULL),
('Neha', 'Joshi', 'neha.joshi@company.com', 'Financial Analyst', 60000, '2022-04-11', 3, 9),
('Rohan', 'Singh', 'rohan.singh@company.com', 'Accountant', 54000, '2023-05-22', 3, 9),
('Meera', 'Shah', 'meera.shah@company.com', 'Marketing Manager', 85000, '2020-05-19', 4, NULL),
('Sanjay', 'Das', 'sanjay.das@company.com', 'Marketing Executive', 55000, '2022-08-30', 4, 12),
('Pooja', 'Menon', 'pooja.menon@company.com', 'Content Specialist', 51000, '2024-01-08', 4, 12),
('Manish', 'Gupta', 'manish.gupta@company.com', 'Sales Manager', 90000, '2019-07-15', 5, NULL),
('Kavya', 'Shetty', 'kavya.shetty@company.com', 'Sales Executive', 58000, '2021-12-01', 5, 15),
('Nikhil', 'Bhat', 'nikhil.bhat@company.com', 'Sales Executive', 57000, '2023-03-17', 5, 15),
('Swati', 'Kulkarni', 'swati.kulkarni@company.com', 'Sales Executive', 56000, '2024-06-10', 5, 15),
('Ajay', 'Desai', 'ajay.desai@company.com', 'IT Manager', 83000, '2020-10-20', 6, NULL),
('Lakshmi', 'Krishnan', 'lakshmi.krishnan@company.com', 'System Administrator', 61000, '2022-02-28', 6, 19),
('Harish', 'Naik', 'harish.naik@company.com', 'Support Engineer', 53000, '2023-11-13', 6, 19);

-- ============================================================
-- 3. PROJECTS
-- ============================================================

CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(100) NOT NULL,
    client_name VARCHAR(100),
    budget DECIMAL(12,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(30)
);

INSERT INTO projects
(project_name, client_name, budget, start_date, end_date, status)
VALUES
('Banking Portal', 'ABC Bank', 1500000, '2023-01-10', '2024-06-30', 'Completed'),
('E-Commerce Platform', 'ShopEasy', 2200000, '2024-02-01', '2025-01-31', 'Completed'),
('HR Management System', 'PeopleFirst', 900000, '2024-04-15', '2025-03-31', 'Completed'),
('Mobile Banking App', 'ABC Bank', 1800000, '2025-01-10', '2026-02-28', 'Completed'),
('AI Recommendation Engine', 'ShopEasy', 2500000, '2025-03-01', '2026-12-31', 'Ongoing'),
('Customer Support Portal', 'TechWorld', 1200000, '2025-05-20', '2026-08-31', 'Ongoing'),
('Internal Training System', 'Company Internal', 500000, '2025-07-01', '2026-01-31', 'Completed'),
('Cloud Migration', 'TechWorld', 3000000, '2026-01-15', '2027-01-15', 'Ongoing');

-- ============================================================
-- 4. EMPLOYEE_PROJECTS
-- Many-to-many relationship between employees and projects
-- ============================================================

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(100),
    assigned_date DATE,
    hours_worked INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

INSERT INTO employee_projects
(employee_id, project_id, role, assigned_date, hours_worked)
VALUES
(1, 1, 'Project Manager', '2023-01-10', 900),
(2, 1, 'Senior Developer', '2023-01-15', 1200),
(3, 1, 'Developer', '2023-02-01', 1100),
(4, 2, 'Developer', '2024-02-05', 1000),
(5, 2, 'Junior Developer', '2024-03-01', 850),
(2, 2, 'Technical Lead', '2024-02-01', 700),
(6, 3, 'Project Manager', '2024-04-15', 600),
(7, 3, 'HR Analyst', '2024-04-20', 700),
(8, 3, 'HR Executive', '2024-05-01', 650),
(1, 4, 'Technical Manager', '2025-01-10', 500),
(2, 4, 'Senior Developer', '2025-01-15', 1000),
(3, 4, 'Developer', '2025-02-01', 950),
(4, 5, 'ML Engineer', '2025-03-10', 900),
(2, 5, 'Technical Lead', '2025-03-01', 850),
(5, 5, 'Developer', '2025-04-01', 700),
(19, 6, 'Project Manager', '2025-05-20', 600),
(20, 6, 'System Administrator', '2025-05-25', 800),
(21, 6, 'Support Engineer', '2025-06-01', 750),
(7, 7, 'HR Coordinator', '2025-07-01', 400),
(8, 7, 'HR Executive', '2025-07-01', 450),
(19, 8, 'Project Manager', '2026-01-15', 500),
(20, 8, 'System Administrator', '2026-01-20', 900);

-- ============================================================
-- 5. CUSTOMERS
-- ============================================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(100),
    country VARCHAR(100),
    registration_date DATE
);

INSERT INTO customers
(customer_name, email, city, country, registration_date)
VALUES
('Rajesh Enterprises', 'rajesh@enterprises.com', 'Bangalore', 'India', '2023-01-10'),
('Tech Solutions Ltd', 'contact@techsolutions.com', 'Mumbai', 'India', '2023-03-15'),
('Green Foods', 'info@greenfoods.com', 'Chennai', 'India', '2023-05-20'),
('Smart Retail', 'hello@smartretail.com', 'Hyderabad', 'India', '2023-07-12'),
('Global Traders', 'sales@globaltraders.com', 'Delhi', 'India', '2024-01-08'),
('Fresh Mart', 'contact@freshmart.com', 'Pune', 'India', '2024-02-17'),
('Urban Fashion', 'info@urbanfashion.com', 'Bangalore', 'India', '2024-04-22'),
('Home Essentials', 'support@homeessentials.com', 'Kochi', 'India', '2024-06-10'),
('Digital World', 'admin@digitalworld.com', 'Mysore', 'India', '2025-01-15'),
('Book House', 'books@bookhouse.com', 'Bangalore', 'India', '2025-02-25'),
('Fitness Hub', 'fitness@fitnesshub.com', 'Chennai', 'India', '2025-05-14'),
('Travel Point', 'travel@travelpoint.com', 'Goa', 'India', '2026-01-20');

-- ============================================================
-- 6. PRODUCTS
-- ============================================================

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT,
    supplier VARCHAR(100)
);

INSERT INTO products
(product_name, category, price, stock_quantity, supplier)
VALUES
('Laptop Pro 14', 'Electronics', 75000, 25, 'TechSupply'),
('Laptop Air 13', 'Electronics', 62000, 18, 'TechSupply'),
('Mechanical Keyboard', 'Accessories', 4500, 50, 'KeyWorld'),
('Wireless Mouse', 'Accessories', 1800, 75, 'KeyWorld'),
('Monitor 27 Inch', 'Electronics', 22000, 30, 'DisplayTech'),
('USB-C Hub', 'Accessories', 3500, 60, 'ConnectPro'),
('Office Chair', 'Furniture', 15000, 20, 'ComfortWorks'),
('Standing Desk', 'Furniture', 28000, 12, 'ComfortWorks'),
('Webcam HD', 'Accessories', 5000, 40, 'VisionTech'),
('Headphones', 'Accessories', 6500, 35, 'AudioTech'),
('Smartphone X', 'Electronics', 55000, 22, 'MobileWorld'),
('Tablet 11', 'Electronics', 32000, 15, 'MobileWorld'),
('Printer Laser', 'Office', 18000, 10, 'PrintTech'),
('Notebook Pack', 'Stationery', 800, 100, 'PaperHouse'),
('Pen Set', 'Stationery', 300, 200, 'PaperHouse');

-- ============================================================
-- 7. ORDERS
-- ============================================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE,
    order_status VARCHAR(30),
    total_amount DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders
(customer_id, order_date, order_status, total_amount)
VALUES
(1, '2024-01-15', 'Delivered', 97000),
(2, '2024-02-20', 'Delivered', 45000),
(3, '2024-03-10', 'Delivered', 18500),
(1, '2024-04-05', 'Delivered', 75000),
(4, '2024-05-18', 'Cancelled', 32000),
(5, '2024-07-22', 'Delivered', 28000),
(6, '2024-09-12', 'Delivered', 6500),
(7, '2024-10-30', 'Delivered', 55000),
(2, '2025-01-15', 'Delivered', 109500),
(8, '2025-02-11', 'Shipped', 28000),
(9, '2025-03-25', 'Delivered', 22000),
(10, '2025-04-17', 'Delivered', 35000),
(3, '2025-06-08', 'Delivered', 62000),
(11, '2025-07-19', 'Shipped', 15000),
(1, '2025-09-05', 'Delivered', 83000),
(4, '2025-10-12', 'Delivered', 50000),
(5, '2026-01-20', 'Processing', 75000),
(6, '2026-02-14', 'Delivered', 18000),
(7, '2026-03-02', 'Shipped', 32000),
(9, '2026-04-18', 'Delivered', 28000);

-- ============================================================
-- 8. ORDER_ITEMS
-- ============================================================

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 75000),
(1, 4, 1, 1800),
(1, 10, 1, 6500),
(1, 7, 1, 15000),
(2, 3, 2, 4500),
(2, 5, 1, 22000),
(2, 6, 1, 3500),
(3, 7, 1, 15000),
(3, 4, 1, 1800),
(3, 14, 2, 800),
(4, 2, 1, 62000),
(4, 4, 1, 1800),
(4, 9, 1, 5000),
(5, 12, 1, 32000),
(6, 8, 1, 28000),
(7, 10, 1, 6500),
(8, 11, 1, 55000),
(9, 1, 1, 75000),
(9, 5, 1, 22000),
(9, 3, 1, 4500),
(9, 4, 1, 1800),
(9, 6, 1, 3500),
(10, 8, 1, 28000),
(11, 5, 1, 22000),
(12, 12, 1, 32000),
(12, 4, 1, 1800),
(12, 6, 1, 3500),
(13, 2, 1, 62000),
(14, 7, 1, 15000),
(15, 1, 1, 75000),
(15, 4, 1, 1800),
(15, 3, 1, 4500),
(16, 10, 2, 6500),
(16, 9, 1, 5000),
(17, 1, 1, 75000),
(18, 13, 1, 18000),
(19, 12, 1, 32000),
(20, 8, 1, 28000);

-- ============================================================
-- QUICK CHECKS
-- ============================================================

SELECT 'Departments' AS table_name, COUNT(*) AS row_count FROM departments
UNION ALL
SELECT 'Employees', COUNT(*) FROM employees
UNION ALL
SELECT 'Projects', COUNT(*) FROM projects
UNION ALL
SELECT 'Employee Projects', COUNT(*) FROM employee_projects
UNION ALL
SELECT 'Customers', COUNT(*) FROM customers
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'Order Items', COUNT(*) FROM order_items;

-- ============================================================
-- RELATIONSHIPS
--
-- departments 1 ---- * employees
-- employees   1 ---- * employee_projects
-- projects    1 ---- * employee_projects
-- customers   1 ---- * orders
-- orders      1 ---- * order_items
-- products    1 ---- * order_items
-- employees   1 ---- * employees (manager_id)
-- ============================================================
-- Execution order
-- from-> where-> group by-> having-> SELECT,Distinct-> order by-> Top

-- ------------------------------DDL-----------(definition)
-- create- to create a table with columns
-- Alter- to change the table by adding or removing a new column
-- eg:- alter table add col_nam, type constraints;  alter table drop col_name
-- Drop to the whole table with structure also
-- -----------------------------DML------------(manipulation)
-- Insert- to add values to the table
-- eg:- Insert into Table_name(col_names) values(value,value,value)
-- update- to modify the row of the table
-- eg:- update table set col_name=value where condition()
-- -------------------------------------------------------
-- Like is used to check the pattern in the queries 