-- Lesson #5 Group by, Union, Subquery


-- --------------- Homework#4 ---------------------	
-- Part #1 classicmodels database 
-- write sql for #6, 8, 9, 10, 11, 14, 16, 17, 21

-- 6.which vendor sells 1966 Shelby Cobra?
SELECT prod.productVendor, prod.productName
FROM classicmodels.products prod
WHERE prod.productName LIKE '%1966 Shelby Cobra%';

-- 8.which product is the most and least expensive?
SELECT msrp as mostexp, productName 
FROM classicmodels.products
ORDER BY msrp desc
LIMIT 1; 

/*SELECT max(msrp) as mostexp, min(msrp) as leastexp
FROM classicmodels.products ;*/

SELECT msrp as leastexp, productName 
FROM classicmodels.products
ORDER BY msrp 
LIMIT 1;

-- 9.which product has the most quantityInStock?
SELECT productName, quantityInStock  -- select *
FROM classicmodels.products
ORDER BY quantityInStock desc
LIMIT 1;

-- 10.list all products that have quantity in stock less than 20
SELECT productName, quantityInStock
FROM classicmodels.products
WHERE quantityInStock < 20;

-- 11.which customer has the highest and lowest credit limit?
SELECT customerNumber, creditLimit as highestLimit
FROM classicmodels.customers
ORDER BY creditlimit desc
LIMIT 1;

SELECT customerNumber, creditLimit as lowestLimit
FROM classicmodels.customers
ORDER BY creditlimit
LIMIT 1;

-- 14
-- #1 customers in what city are the most profitable to the company? -- based on highest single payment
SELECT c.city, c.customerNumber, p.amount as payedAmount
FROM classicmodels.customers c
JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber 
ORDER BY p.amount desc
LIMIT 1;

-- 16
-- #1 who is the best customer? --based on single payment
SELECT c.customerName as BestCustomer, p.amount as amountPayed
FROM classicmodels.payments p
JOIN classicmodels.customers c ON p.customerNumber = c.customerNumber
ORDER BY amount desc
LIMIT 1;

-- 17
-- customers without payment
SELECT c.customerNumber, c.customerName, p.amount
FROM classicmodels.customers c
LEFT JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber
WHERE p.amount is Null;

-- 21
-- list all employees by their (full name: first + last) in alpabetical order
SELECT
CONCAT(lastName,' ', firstName) as fullName
FROM classicmodels.employees
ORDER BY fullName;

-- Part #2  -- library_simple database
-- find all information (query each table seporately for book_id = 252)
select * from library_simple.book c where id =252;
select * from library_simple.author_has_book b where book_id = 252;
select * from library_simple.author a where id in (750,770,794);
select * from library_simple.copy f where book_id = 252;
select * from library_simple.issuance g where copy_id = 252;
select * from library_simple.category_has_book d where book_id = 252;
select * from library_simple.category e where id in (46,142);
select * from library_simple.reader h where id = 234;
select * from library_simple.issuance g where reader_id = 234;

-- Which books did Van Parks write?
select a.id, a.first_name, a.last_name,
b.author_id, b.book_id, 
c.id, c.ISBN, c.name, c.page_num, c.pub_year
from library_simple.author a
join library_simple.author_has_book	b
on a.id = b.author_id
join library_simple.book c 
on b.book_id = c.id
where a.first_name = 'Van' and a.last_name = 'Parks'

-- Which books where published in 2003?
select a.id, a.first_name, a.last_name,
b.author_id, b.book_id, 
c.id, c.ISBN, c.name, c.page_num, c.pub_year
from library_simple.author a
join library_simple.author_has_book	b
on a.id = b.author_id
join library_simple.book c 
on b.book_id = c.id
where c.pub_year = '2003';
-- ----------------------------- End Homework #4 ------------------


-- -------------------------- Lesson #5 --------------------
-- GROUP BY (most common): COUNT, SUM, MAX, MIN, AVG

select * from  classicmodels.customers;

-- general analyses	(record counts, count of distinct values, min/max/avg)
SELECT COUNT(*) as Customer_Cnt, COUNT(distinct country), COUNT(distinct city), 
MAX(creditLimit), MIN(creditLimit), AVG(creditLimit)
FROM classicmodels.customers;

-- analysis by country
SELECT country, COUNT(*) as Customer_Cnt, COUNT(distinct city), 
MAX(creditLimit), MIN(creditLimit), AVG(creditLimit)
FROM classicmodels.customers
GROUP BY country;

-- --------------- employee table ----------------- 
-- general analyses	(record count, count of distinct values, min/max/avg)
SELECT COUNT(*) as Employee_Cnt, COUNT(distinct jobTitle)
FROM classicmodels.employees;

-- by job title
SELECT jobTitle, COUNT(*) as Employee_Cnt
FROM classicmodels.employees
GROUP BY jobTitle;

-- --------------- offices table ----------------- 
select * from classicmodels.offices;
-- general analyses	(record count, count of distinct values, min/max/avg)
SELECT COUNT(officeCode) as Offices_Cnt, COUNT(distinct city), COUNT(distinct country) 
FROM classicmodels.offices;

-- by country
SELECT country, COUNT(officeCode) as Offices_Cnt, COUNT(distinct city)
FROM classicmodels.offices
GROUP BY country;

-- --------------- products table ----------------- 
-- general analyses	(record count, count of distinct values, min/max/avg)
SELECT COUNT(productCode) as Product_Cnt, COUNT(distinct productLine),
MIN(buyPrice), MAX(buyPrice)
FROM classicmodels.products;
 
-- by productLine
SELECT productLine, COUNT(productCode) as Product_Cnt, 
MIN(buyPrice), MAX(buyPrice), AVG(buyPrice)
FROM classicmodels.products 
GROUP BY productLine;


-- ---------------  UNION vs UNION ALL ---------------------	
-- doesn't allow dups
select city
from classicmodels.customers
UNION 
select city
from classicmodels.customers
ORDER BY city;

-- allows dups
select city
from classicmodels.customers
UNION ALL
select city
from classicmodels.customers
ORDER BY city;

-- union can be from different DBs
-- 102 (record San Diego/SAN DIEGO)
select 'classicmodels' as db,  city
from classicmodels.customers
-- where city = 'San Diego'
UNION 
select 'mywork' as db,  city
from mywork.dept
-- where city = 'San Diego'
ORDER BY city;

-- 101
select  city
from classicmodels.customers
-- where city = 'San Diego'
UNION 
select  city
from mywork.dept
-- where city = 'San Diego'
ORDER BY city;

-- UNION can be used many times
-- 9 records
select customerNumber, customerName, city
from classicmodels.customers
where city = 'San Francisco'
UNION
select customerNumber, customerName, city
from classicmodels.customers
where city = 'NYC'
UNION
select customerNumber, customerName, city
from classicmodels.customers
where city = 'Boston';

-- SUBQUERY #1
SELECT COUNT(*) FROM
(select customerNumber, customerName, city
from classicmodels.customers
where city = 'San Francisco'
UNION
select customerNumber, customerName, city
from classicmodels.customers
where city = 'NYC'
UNION
select customerNumber, customerName, city
from classicmodels.customers
where city = 'Boston')as a;

-- SUBQUERY #2
select customerNumber, customerName, city, state, country
from classicmodels.customers
where customerNumber in 
(select customerNumber from classicmodels.payments 
group by customerNumber
having sum(amount) >70000);

-- HAVING (same as where but used in group by)
-- show all customers with payments >$70,000
-- 56
select customerNumber, sum(amount) 
from classicmodels.payments 
group by customerNumber
having sum(amount) >70000;

-- Group By  Example by Animation: https://dataschool.com/how-to-teach-people-sql/how-sql-aggregations-work/
-- Tableau for Students: https://www.tableau.com/academic/students

-- Homework #5
-- Part #1
-- sql statement (classicmodels db) using union: show products with buyPrice > 100 and <200
-- sql statement (classicmodels db) using subquery: show all customer names with employees in San Francisco office

-- Part #2
-- Keep working on these queries
-- write sql for #1,2,3,4,5,7
-- 1.how many vendors, product lines, and products exist in the database?
-- 2.what is the average price (buy price, MSRP) per vendor?
-- 3.what is the average price (buy price, MSRP) per customer?
-- 4.what product was sold the most?
-- 5.how much money was made between buyPrice and MSRP?
-- 6.which vendor sells 1966 Shelby Cobra?
-- 7.which vendor sells more products?
-- 8.which product is the most and least expensive?
-- 9.which product has the most quantityInStock?
-- 10.list all products that have quantity in stock less than 20
-- 11.which customer has the highest and lowest credit limit?
-- 12.rank customers by credit limit
-- 13.list the most sold product by city
-- 14.customers in what city are the most profitable to the company?
-- 15.what is the average number of orders per customer?
-- 16.who is the best customer?
-- 17.customers without payment
-- 18.what is the average number of days between the order date and ship date?
-- 19.sales by year
-- 20.how many orders are not shipped?
-- 21.list all employees by their (full name: first + last) in alpabetical order
-- 22.list of employees  by how much they sold in 2003?
-- 23.which city has the most number of employees?
-- 24.which office has the biggest sales?
-- Advanched homework: join all tables together 

-- Part #3 library_simple database
-- Find all release dates for book 'Dog With Money'