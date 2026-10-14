use company_db;
-- If we wanna combine 2 tables and their columns we use joins using the key relation b/w the tables

-- Inner join- reeturns only matching rows from both tables
-- Display employee names along with their department names.
Select  e.first_name,e.Last_name,d.department_name -- *
from employees as e
inner join departments as d
on e.department_id=d.department_id;
-- where d.department_name = "Engineering";
-- display employee name, project name ,role
Select e.first_name, e.last_name,p.project_name,ep.role
from employees as e
inner JOIN employee_projects as ep 
inner join projects as p
on e.employee_id=ep.employee_id and ep.project_id=p.project_id;
-- where p.project-name ="banking Portal"

-- --------------------LEFT JOIN --------------------------------------------
-- returns all the rows from left table and only matching rows from right table.
-- Display every employee and the projects they are assigned to. employees w/o project should also appear
SELECT * from employees as e
LEFT JOIN employee_projects as ep
on e.employee_id=ep.employee_id;
-- Find employees who aren't assigned to any project.
SELECT * from employees as e
LEFT JOIN employee_projects as ep
on e.employee_id=ep.employee_id
where project_id is  NULL;

-- ---------------------------------- Full Join ----------------------------
-- returns all rows from both tables
-- MySQL doesn't support Full join and full outer join. If we wanna use full join then we need to union the left and right join
SELECT *
FROM employees as e
LEFT join employee_projects as ep
on e.employee_id=ep.employee_id
UNION
SELECT * from employee_projects as ep
RIGHT JOIN employees as e
on e.employee_id=ep.employee_id;


-- Employee project count
SELECT e.employee_id, COUNT(project_id) as total_projects
from employees as e
LEFT JOIN employee_projects as ep
on ep.employee_id=e.employee_id
GROUP BY e.employee_id;
-- Find employees who are assigned to more than one project.
SELECT e.employee_id, e.first_name,COUNT(project_id) as total_projects
from employees as e
LEFT JOIN employee_projects as ep
on ep.employee_id=e.employee_id
GROUP BY e.employee_id
HAVING COUNT(project_id)>1;

-- Display every project and the number of employees assigned to it, including projects that have zero employees.
SELECT ep.project_id,COUNT(e.employee_id) as total_members
from employee_projects as ep
LEFT JOIN employees as e
on ep.employee_id=e.employee_id
GROUP BY ep.project_id;
-- ------------------------------ SELF JOIN --------------------------------------------
SELECT *
from employees as e
JOIN employees as m
on e.manager_id=m.employee_id;

-- Employee and manager
SELECT e.first_name, m.first_name as manager
from employees as e
JOIN employees as m
on e.manager_id=m.employee_id
where e.manager_id is  not null;
-- GEt the managers names
SELECT distinct m.first_name as manager
from employees as e
JOIN employees as m
on e.manager_id=m.employee_id
where m.manager_id is null;
-- Manager and number of employees
SELECT  m.first_name as manager, count(*) as under
from employees as e
JOIN employees as m
on e.manager_id=m.employee_id
where m.manager_id is  null
GROUP by m.employee_id;
-- Managers with more than 2 employees
SELECT  m.first_name as manager
from employees as e
JOIN employees as m
on e.manager_id=m.employee_id
where m.manager_id is  null
GROUP by m.employee_id
having COUNT(*)>2;
-- Employee + Department + Manager
SELECT e.first_name, m.first_name as manager, d.department_name
from employees as e
JOIN employees as m
join departments as d
on e.manager_id=m.employee_id AND d.department_id=e.department_id
where e.manager_id is  not null;
-- Order details order_id, prod name, quantity
select * from orders;
SELECT * from order_items;
SELECT o.order_id, p.product_name,ot.quantity
from orders as o
join products as p
join order_items as ot
on o.order_id=ot.order_id and ot.product_id=p.product_id;
-- Customer order details
SELECT c.customer_name, o.order_id, p.product_name,ot.quantity
from orders as o
join products as p
join order_items as ot
join customers as c
on o.order_id=ot.order_id and ot.product_id=p.product_id and c.customer_id=o.customer_id;
-- Product sales
SELECT p.product_name,sum(ot.quantity) as quantity
from order_items as ot
join products as p
on p.product_id = ot.product_id
GROUP BY p.product_name;
-- Customer spending customer name, total Spent
SELECT c.customer_name, sum(ot.quantity*ot.unit_price) as total
from customers as c
join orders as o
join order_items as ot
on c.customer_id=o.customer_id and o.order_id=ot.order_id
GROUP by c.customer_name;
-- Find the department with the highest average employee salary.
select d.department_name, ROUND(avg(e.salary),0) as highest_salary
from employees as e
join departments as d
on d.department_id=e.department_id
GROUP BY d.department_name
LIMIT 1;
-- Display each  department_name, employee_count, average_salary, maximum_salary, minimum_salary
select d.department_name, ROUND(AVG(e.salary)) as Avg_salary, COUNT(*) as employee_count, MAX(e.salary), MIN(e.salary)
from employees as e
join departments as d
on d.department_id=e.department_id
GROUP BY d.department_name;
-- Find employees whose salary is greater than their department's average salary.
SELECT * FROM employees as e
join (select department_id, AVG(salary) as average FROM employees GROUP BY department_id) as avg_table
on e.department_id=avg_table.department_id
WHERE salary>avg_table.average;
-- Manager's team salary( manager, employees, total salary,avg salary)
SELECT distinct m.first_name as manager,count(*) as under_employees,Round(avg(e.salary),0) as AVG_SALARY, ROUND(sum(e.salary),0) as total_intake
from employees as e
JOIN employees as m
on e.manager_id=m.employee_id
GROUP by e.manager_id
ORDER BY total_intake DESC;
-- Company-wide employee analysis emp name, dep name,manager name , project count 
SELECT e.first_name, d.department_name,m.first_name 
from employees as e
 left join employees as m
on e.manager_id=m.employee_id
 join departments as d
on d.department_id=e.department_id
 join employee_projects as ep
on e.employee_id=ep.employee_id;
GROUP by ep.employee_id;


SELECT * from departments; 

select department_id, count(*)
from employees
group by department_id 
having count(*)>3;






