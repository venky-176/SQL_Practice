use company_db;
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

-- ________________________________ Aggregrate Window function ___________________________________________
-- count no.of employees in each departmrnt, total, avg, max, min salary of exag departmrnt
SELECT
    e.employee_id,
    CONCAT(e.first_name," ",e.last_name) as full_name,
    e.department_id,
    count(*) over(partition by e.department_id) as emp_per_dep,
    e.salary,
    sum(salary) over(partition by e.department_id) as total_salary,
    round(avg(salary) over(partition by e.department_id),0) as avg_salary,
    min(salary) over(partition by e.department_id) as min_salary,
    max(salary) over(partition by e.department_id) as max_salary
from employees as e;

-- ____________________________ Ranking Window Function ________________________________________________
-- Row_number()- Assign unique number to each row but can't handle ties
-- Rank()- Assign rank , handle ties but skips/gaps the number
-- Dense_rank()- Assign rank , handle ties but don't skips/gaps the number
-- rank() over(order by row) is must

SELECT
    e.employee_id,
    CONCAT(e.first_name," ",e.last_name) as full_name,
    e.department_id,
    e.salary,
   ROW_NUMBER() over(order by salary desc) as row_rank,
   rank() over(order by salary desc) as norm_rank,
   dense_rank() over(order by salary desc) as den_rank
from employees as e;

SELECT
    e.employee_id,
    CONCAT(e.first_name," ",e.last_name) as full_name,
    e.department_id,
    e.salary,
   ROW_NUMBER() over(partition by department_id order by salary desc) as row_rank
   from employees as e;
  
-- find the highest sales on each product category
select *
from (select category,
    product_name,
    RANK() over(partition by category order by price desc) as top
from products)t where top=1;

-- find least 2 budgeted departments
select * from(select 
    department_id,
    round(sum(salary),0) as totl_budg,
    ROW_NUMBER() over(order by sum(salary)) as least
from employees
GROUP by department_id)t where least<3;

-- -- Rank customers based on their orders and their VALUES
select 
     customer_id,
     sum(total_amount),
     rank() OVER(order by sum(total_amount) desc) as most_loyal
from orders
group by customer_id;

-- _______________________VALUE WINDOW FUNCTION ______________________________
-- lead(exp, offset, default) returns the next row , order by is must
-- lag(exp, offset, default) returns the previous row , order by is must
-- default and offset is optional

-- find employee over employee performance by finding changes in their salary b/w currrent and previous emplyee
SELECT
    CONCAT(e.first_name," ",e.last_name) as full_name,
    salary,
    department_id,
    LAG(salary,1,0) over(order by salary desc) as sal_dif,
    lead(salary,1,0) over(order by salary desc) as sal_dif_up

from employees as e;

SELECT
    CONCAT(e.first_name," ",e.last_name) as full_name,
    salary,
    department_id,
    LAG(salary,1,0) over(partition by department_id order by salary desc) as sal_dif,
    lead(salary,1,0) over(order by salary desc) as sal_dif_up
    from employees as e;




