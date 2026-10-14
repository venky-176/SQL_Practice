use company_db; 
show Tables;
-- select emloyees who are hired after the date 2023-01-01
SELECT * 
from employees
WHERE hire_date>"2023-01-01";
-- SELECT employees whose names start with letter "A". we us elike to get the names and % for strating or before to get the desired queries
SELECT * FROM employees
where first_name LIKE "A%";
-- select emloyees who are before the date 2023-01-01( use the date in " ");
SELECT * 
from employees
WHERE hire_date<"2023-01-01";
-- Find orders with status Shipped.
SELECT *
from orders
WHERE order_status = "shipped";
-- Find products whose price is between 5000 and 30000.
SELECT *
from products
where price >=5000 and price<=30000;
-- where salary between 5000 and 30000
-- Find employees whose salary is not 50000.
select * 
from employees
where salary != 50000;
-- Find customers who are from either Bangalore or Chennai.
select *
from customers
where city="Bangalore" or city= "Chennai";
-- Sort employees by salary ascending.
select *
from employees
order by salary Asc;
-- Sort employees by salary descending.
select *
from employees
order by salary desc;
-- Find the highest-paid employee.
SELECT * 
FROM employees 
ORDER BY salary DESC 
LIMIT 3;
-- Find the top 3 highest-paid employees.
SELECT * 
FROM employees 
ORDER BY salary DESC 
limit 3;
-- Find the 3 highest-paid employees.(use offset to skip the first 2 rows.)
SELECT * 
FROM employees 
ORDER BY salary DESC 
limit 1 Offset 2;
-- Find the most expensive product.
SELECT product_name as Expensive, price
from products
ORDER BY price
LIMIT 1;
-- Sort customers alphabetically by name.
SELECT *
from customers
ORDER BY customer_name ASC;
-- Sort employees by hire date, oldest first.
SELECT * 
FROM employees 
ORDER BY hire_date ASC ;
-- Find the total number of employees.
SELECT COUNT(*) as total_employees
from employees;
-- Find the total value of all orders.
SELECT SUM(total_amount) as total_value
from orders;

select * from orders;
-- Find the number of delivered orders.
select COUNT(*) as Delivered
FROM orders
where order_status="Delivered";
-- ******************************************* Group By *********************************************************
-- Count employees in each department.
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;
-- Find the average salary of each department.(here we use round off to round off decimals , used innr join to get depatment id , nme)
SELECT department_name, ROUND(avg(salary),2) as highest_salary
from employees
join departments
on employees.department_id=departments.department_id
group by department_name;
-- Count employees for each job title.
SELECT job_title,  COUNT(*) as people
from employees
GROUP BY job_title;
-- Find the average product price for each category.
select category, round(AVG(price),0) as average_price
from products
GROUP BY category;

SELECT * FROM orders;
-- Find the number of orders  and total amount placed by each customer.
SELECT customer_name,COUNT(*)as no_of_orders,sum(total_amount) as totalAmount
from orders
JOIN customers
on orders.customer_id=customers.customer_id
GROUP BY customer_name;
-- **************************************** Having ***************************************************
-- Find departments having more than 3 employees
SELECT department_id,count(*)
from employees
GROUP BY department_id
HAVING COUNT(*)>3;
-- Find departments whose average salary is greater than 60000.
SELECT department_name, ROUND(avg(salary),2) as average_salary
from employees
join departments
on employees.department_id=departments.department_id
group by department_name
having AVG(salary)>60000;
-- Find job titles having more than one employee.
SELECT job_title,count(*)
from employees
GROUP BY job_title
HAVING COUNT(*)>1;
-- Find product categories having more than 3 products.
SELECT category, COUNT(*) as total
from products 
GROUP by category
having COUNT(*)>3;
