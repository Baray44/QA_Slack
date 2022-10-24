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