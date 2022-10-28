-- ------------------  HOMEWORK #6  ------------------------

-- 			Part 1   classicmodels db: finish queries (24)
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

/* 					Homework - Part #2 
Find any dataset you want to analyze (csv, xls, etc.) and import the data 
https://www.dataquest.io/blog/free-datasets-for-projects/
https://www.kaggle.com/datasets
https://catalog.data.gov/dataset
https://data.world
https://datasf.org/opendata/

Import this dataset to mysql database: 
1. create a database
2. right click on that database - Table Data Import Wizard - next - next - next ...
*/

/*Film Locations in San Francisco
-- https://data.sfgov.org/Culture-and-Recreation/Film-Locations-in-San-Francisco/yitu-d5am
-- import csv file Film_Locations_in_San_Francisco.csv
-- in MySQL Workbanch: create database Film
-- right click on Film database - Import Table - Wizard - Next ...
-- select * from film.film_locations_in_san_francisco;
Queries:
count distinct movies
count of all films by release year
count of all films by 'production company'
count of all films directed by Woody Allen
how many movies have/don't have fun facts?
in how many movies were Keanu Reeves and Robin Williams?
*/
-- ---------------------------------------------------------------------------------------------
-- 			Part 1.   classicmodels db: finish queries (24)
-- 1.how many vendors, product lines, and products exist in the database?
-- SELECT productCode FROM classicmodels.products;
SELECT COUNT(DISTINCT p.productCode) AS productCode,
	COUNT(DISTINCT p.productVendor) AS productVendor,
    COUNT(DISTINCT pl.productLine) AS productLine
FROM classicmodels.products AS p, classicmodels.productlines AS pl;

-- 2.what is the average price (buy price, MSRP) per vendor?
-- SELECT * FROM classicmodels.products;
SELECT productVendor, AVG(buyPrice), AVG(MSRP)
FROM classicmodels.products
GROUP BY productVendor;

-- 3.what is the average price (buy price, MSRP) per customer?
SELECT c.customerName, AVG(det.priceEach) AS avg_priceEach, AVG(p.buyPrice) AS avg_buyPrice, AVG(p.MSRP) AS avg_MSRP
FROM classicmodels.products p
JOIN classicmodels.orderdetails det ON p.productCode = det.productCode
JOIN classicmodels.orders o ON det.orderNumber = o.orderNumber
JOIN classicmodels.customers c ON o.customerNumber = c.customerNumber
GROUP BY c.customerName
ORDER BY c.customerName;

-- 4.what product was sold the most?
-- SELECT * FROM classicmodels.orderdetails;
SELECT COUNT(cod.productCode) AS count_product, cp.productName, MAX(cod.quantityOrdered) AS count_order
FROM classicmodels.orderdetails AS cod
INNER JOIN classicmodels.products AS cp ON cod.productCode = cp.productCode
GROUP BY cod.productCode
ORDER BY count_product DESC
LIMIT 1;

-- 5.how much money was made between buyPrice and MSRP?
SELECT
SUM(buyPrice * det.quantityOrdered) AS quantity_buyPrice,
SUM(MSRP * det.quantityOrdered) AS quantity_MSRP,
SUM(MSRP * det.quantityOrdered) - (SUM(buyPrice * det.quantityOrdered)) AS difference_in_sales
FROM classicmodels.orderdetails det
JOIN classicmodels.products prod ON det.productCode = prod.productCode;

-- 6.which vendor sells 1966 Shelby Cobra?
SELECT productVendor, productName
FROM classicmodels.products
WHERE productName LIKE '%1966 Shelby Cobra%';

-- 7.which vendor sells more products?
SELECT prod.productVendor, COUNT(prod.productCode) AS quantity, SUM(det.quantityOrdered) AS quantityOrdered
FROM classicmodels.orderdetails det
JOIN classicmodels.products prod ON det.productCode = prod.productCode
GROUP BY prod.productVendor
ORDER BY det.quantityOrdered DESC
LIMIT 1;

-- 8.which product is the most and least expensive?
SELECT productName, productVendor, MSRP AS mostExpensive
FROM classicmodels.products
ORDER BY MSRP DESC
LIMIT 1;

SELECT productName, productVendor, MSRP AS leastExpensive
FROM classicmodels.products
ORDER BY MSRP
LIMIT 1;

-- 9.which product has the most quantityInStock?
SELECT productCode, productName, quantityInStock
FROM classicmodels.products
ORDER BY quantityInStock DESC
LIMIT 1;

-- 10.list all products that have quantity in stock less than 20
SELECT productName, quantityInStock
FROM classicmodels.products
WHERE quantityInStock < 20;
-- ORDER BY quantityInStock DESC;

-- 11.which customer has the highest and lowest credit limit?
-- Highest credit limit
SELECT customerNumber, customerName, creditLimit AS maxCreditLimit
FROM classicmodels.customers
WHERE creditLimit IN (SELECT MAX(creditLimit) FROM classicmodels.customers);

SELECT customerNumber, customerName, creditLimit AS maxCreditLimit
FROM classicmodels.customers
ORDER BY creditLimit DESC
LIMIT 1;

-- Lowest credit limit
SELECT customerNumber, customerName, creditLimit AS minCreditLimit
FROM classicmodels.customers
WHERE creditLimit IN (SELECT MIN(creditLimit) FROM classicmodels.customers);

SELECT customerNumber, customerName, creditLimit AS minCreditLimit
FROM classicmodels.customers
WHERE creditLimit <= 0;

-- 12.rank customers by credit limit
SELECT customerNumber, customerName, creditLimit,
RANK() OVER (ORDER BY creditLimit DESC) as `rank`
FROM classicmodels.customers;

-- 13.list the most sold product by city
/* SELECT c.city, p.productCode, p.productName, det.quantityOrdered
FROM classicmodels.customers c
JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber
JOIN classicmodels.orderdetails det ON o.orderNumber = det.orderNumber
JOIN classicmodels.products p ON det.productCode = p.productCode
WHERE det.quantityOrdered IN (SELECT MAX(det.quantityOrdered) FROM classicmodels.orderdetails)
GROUP BY c.city;*/

WITH a AS (
SELECT c.city, det.productCode, p.productName, SUM(quantityOrdered) AS quantitySold,
(ROW_NUMBER() OVER (PARTITION BY c.city ORDER BY SUM(quantityOrdered) DESC)) AS rowNum
FROM classicmodels.orderdetails det
JOIN classicmodels.orders o ON o.orderNumber = det.orderNumber
JOIN classicmodels.customers c on c.customerNumber = o.customerNumber
JOIN classicmodels.products p ON det.productCode = p.productCode
GROUP BY c.city, det.productCode
) 
SELECT a.city, a.productCode, a.productName, a.quantitySold
FROM a
WHERE rowNum = 1;

-- 14.customers in what city are the most profitable to the company?
-- 		#1
SELECT c.city, p.amount as payedAmount
FROM classicmodels.customers c
JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber 
ORDER BY p.amount DESC
LIMIT 1;
-- 		#2
SELECT  c.city, SUM(quantityordered*priceeach) AS revenue 
FROM classicmodels.customers c 
JOIN classicmodels.orders o ON c.customernumber=o.customernumber
JOIN classicmodels.orderdetails od ON o.ordernumber=od.ordernumber
GROUP BY c.city 
ORDER BY revenue DESC 
LIMIT 1;

-- 15.what is the average number of orders per customer?
-- 		#1
SELECT c.customerName, AVG(quantityOrdered)
FROM classicmodels.customers c
JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber
JOIN classicmodels.orderdetails det ON o.orderNumber = det.orderNumber
GROUP BY c.customerName
ORDER BY AVG(quantityOrdered) DESC;
-- 		#2
SELECT (COUNT(orderNumber)/COUNT(DISTINCT customerNumber)) AS avgPerCust
FROM classicmodels.orders;

-- 16.who is the best customer?
-- #1
SELECT c.customerNumber, c.customerName AS bestCustomer, SUM(quantityOrdered * priceEach) AS amountOfPurchases
FROM classicmodels.customers c
JOIN classicmodels.orders o ON c.customerNumber = o.customerNumber
JOIN classicmodels.orderdetails det ON o.orderNumber = det.orderNumber
GROUP BY c.customerNumber
ORDER BY amountOfPurchases DESC;
-- #2
SELECT c.customerName as BestCustomer, p.amount as amountPayed
FROM classicmodels.payments p
JOIN classicmodels.customers c ON p.customerNumber = c.customerNumber
ORDER BY amount DESC
LIMIT 1;

-- 17.customers without payment
SELECT c.customerNumber, c.customerName, p.amount
FROM classicmodels.customers c
LEFT JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber
WHERE amount is NULL;

-- 18.what is the average number of days between the order date and ship date?
-- #1
SELECT SUM(DATEDIFF(shippedDate,orderDate))/COUNT(*) AS averageDays -- 3.5951
FROM classicmodels.orders;
-- #2
SELECT AVG(DATEDIFF(shippedDate,orderDate)) AS averageDays -- 3.7564
FROM classicmodels.orders;

-- 19.sales by year
SELECT
YEAR(paymentDate) AS years, SUM(amount) AS sales 
FROM classicmodels.payments
GROUP BY years
ORDER BY years;

-- 20.how many orders are not shipped?
SELECT COUNT(*) AS count_notShipped -- SELECT *
FROM classicmodels.orders
WHERE shippedDate IS NULL;

SELECT orderNumber, shippedDate, `status` -- wrong because there customers that are in 'Disputed' status
FROM classicmodels.orders
WHERE `status` NOT LIKE 'Shipped';

-- 21.list all employees by their (full name: first + last) in alpabetical order
SELECT CONCAT(lastName, ' ', firstName) AS fullName
FROM classicmodels.employees
ORDER BY fullName;

-- 22.list of employees by how much they sold in 2003?
SELECT e.employeeNumber, COUNT(p.paymentDate)
FROM classicmodels.payments p
JOIN classicmodels.customers c ON p.customerNumber = c.customerNumber
JOIN classicmodels.employees e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE YEAR(p.paymentDate) = 2003
GROUP BY e.employeeNumber;

SELECT CONCAT(e.lastName, ' ',e.firstName) as fullName, YEAR(p.paymentDate) as Year_sold, YEAR(o.orderdate) as Year_ordered, sum(p.amount) as sold
FROM classicmodels.employees e
JOIN classicmodels.customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN classicmodels.payments p ON c.customerNumber = p.customerNumber
-- for payments
-- where YEAR(p.paymentDate) = 2003
-- for orders: 
JOIN classicmodels.orders o on o.customernumber=c.customernumber
WHERE o.orderDate BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY fullName
ORDER BY fullName, p.amount;

-- 23.which city has the most number of employees?
SELECT o.city, COUNT(e.employeeNumber) AS count_employee
FROM classicmodels.employees e
JOIN classicmodels.offices o ON e.officeCode = o.officeCode
GROUP BY o.city
ORDER BY count_employee DESC
LIMIT 1;

-- 24.which office has the biggest sales?
SELECT o.officeCode, o.city, SUM(p.amount) AS salesAmount
FROM classicmodels.payments p
JOIN classicmodels.customers c ON p.customerNumber = c.customerNumber
JOIN classicmodels.employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN classicmodels.offices o ON e.officeCode = o.officeCode
GROUP BY o.officeCode
ORDER BY salesAmount DESC
LIMIT 1;

-- Advanched homework: join all tables together
SELECT * -- 12,015
FROM classicmodels.orders o
JOIN classicmodels.customers c ON o.customerNumber = c.customerNumber
JOIN classicmodels.payments pay ON c.customerNumber = pay.customerNumber
JOIN classicmodels.employees e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN classicmodels.offices ofs ON e.officeCode = ofs.officeCode
JOIN classicmodels.orderdetails det ON o.orderNumber = det.orderNumber
JOIN classicmodels.products prod ON det.productCode = prod.productCode
JOIN classicmodels.productlines pl ON prod.productLine = pl.productLine;

SELECT * -- COUNT(1)-- 2,996
FROM classicmodels.customers c
JOIN classicmodels.employees e ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN classicmodels.offices o ON e.officeCode = o.officeCode
JOIN (SELECT customerNumber, MAX(paymentDate) AS paymentDate, SUM(amount) AS amount 
FROM classicmodels.payments GROUP BY customerNumber) p ON c.customerNumber = p.customerNumber
JOIN classicmodels.orders orders ON c.customerNumber = orders.customerNumber
JOIN classicmodels.orderdetails det ON orders.orderNumber = det.orderNumber
JOIN classicmodels.products pr ON det.productCode = pr.productCode
JOIN classicmodels.productlines pl ON pr.productLine = pl.productLine;
-- -----------------------------------------------------------------------------------------------------
/* 					Homework - Part #2 
Find any dataset you want to analyze (csv, xls, etc.) and import the data 
https://www.dataquest.io/blog/free-datasets-for-projects/
https://www.kaggle.com/datasets
https://catalog.data.gov/dataset
https://data.world
https://datasf.org/opendata/

Import this dataset to mysql database: 
1. create a database
2. right click on that database - Table Data Import Wizard - next - next - next ...
*/

/*Film Locations in San Francisco
-- https://data.sfgov.org/Culture-and-Recreation/Film-Locations-in-San-Francisco/yitu-d5am
-- import csv file Film_Locations_in_San_Francisco.csv
-- in MySQL Workbanch: create database Film
-- right click on Film database - Import Table - Wizard - Next ...
-- select * from film.film_locations_in_san_francisco;
Queries:
count distinct movies
count of all films by release year
count of all films by 'production company'
count of all films directed by Woody Allen
how many movies have/don't have fun facts?
in how many movies were Keanu Reeves and Robin Williams?
*/
CREATE DATABASE Film;
select * from film.film_locations_in_san_francisco;

-- count distinct movies
SELECT DISTINCT Title FROM film.film_locations_in_san_francisco;

-- count of all films by release year
SELECT `Release Year`, COUNT(DISTINCT Title) AS Films_count
FROM film.film_locations_in_san_francisco
GROUP BY `Release Year`
ORDER BY `Release Year`;

-- count of all films by 'production company'
SELECT `Production Company`, COUNT(DISTINCT Title) AS Films_count
FROM film.film_locations_in_san_francisco
GROUP BY `Production Company`
ORDER BY Films_count DESC;

-- count of all films directed by Woody Allen
SELECT Director, COUNT(DISTINCT Title) AS Films_count
FROM film.film_locations_in_san_francisco
WHERE Director LIKE '%Woody Allen%'
GROUP BY Director;

-- how many movies have/don't have fun facts?
SELECT CASE WHEN `Fun facts` = '' THEN 'No' ELSE 'Yes' END AS Fun_fact, 
COUNT(DISTINCT Title) AS Films_cnt
FROM film.film_locations_in_san_francisco
GROUP BY CASE WHEN `Fun facts` = '' THEN 'No' ELSE 'Yes' END;

-- in how many movies were Keanu Reeves and Robin Williams?
SELECT COUNT(DISTINCT Title) Films
FROM film.film_locations_in_san_francisco
WHERE `Actor 1` IN ('Keanu Reeves', 'Robin Williams')
OR `Actor 2` IN ('Keanu Reeves', 'Robin Williams')
OR `Actor 3` IN ('Keanu Reeves', 'Robin Williams');

-- SELECT `Actor 3`, COUNT(DISTINCT Title) AS Films
-- FROM film.film_locations_in_san_francisco
-- WHERE `Actor 3` LIKE '%Keanu Reeves%'
-- UNION
-- SELECT `Actor 3`, COUNT(DISTINCT Title)
-- FROM film.film_locations_in_san_francisco
-- WHERE `Actor 3` LIKE '%Robin Williams%';