use company_db;
 DESCRIBE employees;

-- We use Set operator to combine to rows unlike joins which combines columns
-- It performs vertically and uses same columns names as a key.
-- Here we combinne 2 queries/tables by union, we use order by only at the last of 2 queries at once only
-- no.of colums in both tables must be same, and order also should be the same
-- ---------------------------------------UNION-----------------------------------------
-- returns all distinct rows from both sides, and remove duplicates
SELECT employee_id as ID,first_name as name from employees UNION
SELECT customer_id,customer_name from customers;
-- ----------------------------------------UNION ALL-------------------------------------
-- returns duplicates also from the both tables
-- EXCEPT :- returns all distinct rows from the 1st query that are not found in the 2 query
-- intersect:- returns common rows between 2 tables
-- ------------------------------ FUNCTION--------------------------------------
-- function:- It's a built in SQL code which accepts input , processes it and returns the output
-- ********************************* STRING****************************
-- Manipulation- CONCAT, LOWER, UPPER, TRIM, REPLACE
-- Calculation- LEN
-- Extraction- LEFT, RIGHT, SUBSTRING
SELECT CONCAT(e.first_name," ",e.last_name) as full_name from employees as e where e.employee_id=1;
SELECT UPPER(e.first_name) as upper , Lower(e.last_name) as lower from employees as e ;
SELECT UPPER(e.first_name) as upper , LENGTH(e.first_name) as length from employees as e ;
SELECT * from employees;
SELECT REPLACE(hire_date,'/','-') from employees;
SELECT first_name , LEFT(first_name,3) as left_, last_name, right(last_name,3) as right_ from employees;
Select substring(first_name,2,3) as sub_name from employees;-- substring(value,start, no.of characters)

-- Number function: Round(value, roundoff); ABS(value) gets value
-- ************************************ DATE & TIME **********************************************
-- Date- Year-month-day; Time: Hour:Min:Sec
-- Part extraction: DAY, MONTH, YEAR, DAYNAME, MONTHNAME, YEARNAME
-- format and casting: FORMAT, CONVERT, CAST 
-- calculations: DATEADD, DATEDIFF
-- validation: ISDATE
SELECT hire_date, DAY(hire_date) as day, MONTH(hire_date) as month, YEAR(hire_date) as year from employees;
SELECT hire_date, DAYNAME(hire_date) as day, MONTHNAME(hire_date) as month, YEAR(hire_date) as year from employees;
-- FORMAT changing the how value returns CASTING- Changing data from one type to another
-- FORMAT(value, format,); convert(data_type, value,)
select Hire_date, DATE_FORMAT(hire_date,'%Y/%m/%d') as full_year, DATE_FORMAT(hire_date,'%y/%m/%d') as just_year from employees;
SELECT CONVERT(salary, char) as string_value from employees;
-- DATEDIFF(part, start_date,end_date)
select start_date, end_date, DateDiff(end_date,start_date) as days,TimeSTAMPDIFF(month,start_date,end_date) as months from projects;

-- ---------------------------NULL------------------------------------
-- Null means nothing, unknown, means it not equal anything
-- Null is not zero, not empty String, not blank space
