use salesdb;
DESCRIBE customers;
DESCRIBE employees;
DESCRIBE orders;
DESCRIBE orders_archive;
DESCRIBE products;
-- _______________________SUB-QUERY_______________________________
-- Query inside a query called as subquery
-- find products that have price higher than avg of all products
select product, productid,price
from (select product, productid,price, avg(price) over() as avg_price 
from products)t
where price>avg_price;

select product, productid,price, avg(price) over() as avg_price 
from products;
-- Rank customers based on their total amount of sales.
select *
, RANK() over(order by totalSales desc) from(
SELECT customerid,sum(sales) as totalSales from orders
GROUP by customerid)t;
-- in join clause
-- show all customer detail and total order of each customer
SELECT customers.*,ordert.total from customers left join(select customerid, count(*) as total from orders GROUP by customerid) as ordert
on customers.customerid=ordert.customerid;

-- in where clause
-- find products that have price higher than avg of all products
select  
    productid,  
    price,
    (select avg(price)from products)as  avg_price
from products 
where price>(select avg(price) from products);

-- IN- operator check whether a value matches any value from list 
select * from customers;
select * from customers where country in('UK','USA','India');



