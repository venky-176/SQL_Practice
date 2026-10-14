-- ------------------------------- WINDOW FUNCTIONS ------------------------------
-- Perform calculations on specific set of data without loosing the level of rows
-- It performs ROW level calculations, returns a result for each row
-- RULE 1: It can perform only in SELECT and ORDER BY clauses
-- RULE 2: nesting window is not allowed.
-- RULE 3: WHERE clause is executed first and then window
-- Find total employees from each department, aditionally provide details of employees
SELECT 
    employee_id,
    first_name,
    count(*) OVER(partition by department_id) as total_employees_per_department
from employees;
/* SELECT 
    employee_id,
    first_name,
    department_id,
    count(*) 
from employees
GROUP by department_id;*/
-- It gives error cause we can't group by and get the result bydifferent column
-- Syntax of window function:- function over(partition by or order by or frame)
-- **partition by- divides rows into groups, based on the columns. We can parition nothing, single columns or multiple columns at a time
-- Find total employees from each department,by each manager, aditionally provide details of employees
SELECT 
    employee_id,
    first_name,
    count(*) OVER(partition by department_id) as total_employees_per_department,
    count(*) OVER(partition by department_id,manager_id) as total_employees_per_department_manager
from employees;
-- **Order By- sort the datawithin the window, It is must for Rank and Value functions
SELECT
     product_name,
     category,
     stock_quantity,
     RANK() OVER(order BY stock_quantity) as highest_quantity
     -- RANK() OVER(partition by category order BY stock_quantity) as highest_net_quantity
from products;
-- **rows unbound preceding- define a subset of rows in a window.
-- It can be only used with order by only
-- SYNTAX:  ROWS BETWEEN CURRENT ROW AND UNBOUNDED PRECEDING
-- frame types- rows, range
-- frame boundary(lower boundary):- CURRENT ROW, N PRECEDING and UNBOUNDED PRECEDING
-- frame boundary(Upper boundary):- CURRENT ROW, N FOLLOWING and UNBOUNDED FOLLOWING
-- find total quantity for each product_id only for 2 products 1 and 4
SELECT 
    order_id,
    product_id,
    SUM(quantity) over(partition by product_id order by product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as total_quantity
from order_items
WHERE product_id in (1,4);






