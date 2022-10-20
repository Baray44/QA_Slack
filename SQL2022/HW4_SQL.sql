--             HOMEWORK #4 
-- Part #1 classicmodels database 
-- (write sql for #6, 8, 9, 10, 11, 14, 16, 17, 21) -- easy questions

-- 1.how many vendors, product lines, and products exist in the database?
-- 2.what is the average price, buy price, MSRP per vendor?
-- 3.what is the average price, buy price, MSRP per customer?
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

-- Part #2  -- library_simple database
-- 1.find all information (query each table seporately for book_id = 252)
-- 2.which books did Van Parks write?
-- 3.which books where published in 2003?
-- --------------------------------------------------------------------------------
-- Part #1 classicmodels database
-- 1.how many vendors, product lines, and products exist in the database?
SELECT count(productCode), count(DISTINCT productVendor), count(DISTINCT classicmodels.productlines.productLine) FROM classicmodels.products
RIGHT JOIN classicmodels.productlines ON classicmodels.products.productLine = classicmodels.productlines.productLine;

-- 6.which vendor sells 1966 Shelby Cobra?
-- SELECT * FROM classicmodels.products;
SELECT productVendor, productName FROM classicmodels.products
WHERE productName LIKE '%1966 Shelby Cobra%';

-- 8.which product is the most and least expensive?
SELECT productName, MSRP AS mostExpensive FROM classicmodels.products
ORDER BY MSRP DESC
LIMIT 1;

SELECT productName, MSRP AS leastExpensive FROM classicmodels.products
ORDER BY MSRP
LIMIT 1;

-- 9.which product has the most quantityInStock?
SELECT productName, quantityInStock FROM classicmodels.products
ORDER BY quantityInStock DESC
LIMIT 1;

-- 10.list all products that have quantity in stock less than 20
SELECT productName, quantityInStock FROM classicmodels.products
WHERE quantityInStock <= 20;

-- 11.which customer has the highest and lowest credit limit?
-- SELECT * FROM classicmodels.customers;
SELECT customerName, creditLimit AS maxCreditLimit FROM classicmodels.customers
ORDER BY creditLimit DESC
LIMIT 1;

SELECT customerName, creditLimit AS minCreditLimit FROM classicmodels.customers
ORDER BY creditLimit
LIMIT 1;

-- 14.customers in what city are the most profitable to the company? -- based on highest single payment
-- SELECT * FROM classicmodels.payments;
SELECT cc.customerName, cc.city, cp.amount
FROM classicmodels.customers AS cc
INNER JOIN classicmodels.payments AS cp
ON cc.customerNumber = cp.customerNumber
ORDER BY cp.amount DESC
LIMIT 1;

-- 16.who is the best customer? --based on single payment
SELECT cc.customerName AS bestCustomer, cp.amount
FROM classicmodels.payments cp
JOIN classicmodels.customers cc ON cp.customerNumber = cc.customerNumber
ORDER BY amount DESC
LIMIT 1;

-- 17.customers without payment
SELECT customerName, amount FROM classicmodels.customers AS cc
LEFT JOIN classicmodels.payments AS cp ON cc.customerNumber = cp.customerNumber
WHERE amount IS NULL;

-- 21.list all employees by their (full name: first + last) in alpabetical order
SELECT
CONCAT(lastName, ' ', firstName) as fullName
FROM classicmodels.employees
ORDER BY fullName;

-- ---------------------------------------------------------------------------
-- Part #2  -- library_simple database
-- 1.find all information (query each table seporately for book_id = 252)
-- 2.which books did Van Parks write?
-- 3.which books where published in 2003?
-- ---------------------------------------------------------------------------
-- 1.find all information (query each table seporately for book_id = 252)
SELECT lscp.book_id, ISBN, lsb.name AS book_name, page_num, pub_year, lscp.id AS copy_id, `number`, admission_date, category_id, lsc.name AS category_name,
author_id, lsa.first_name AS author_first_name, lsa.last_name AS author_last_name, lsi.id AS issuance_id, issue_date, release_date, deadline_date,
reader_id, lsr.first_name AS reader_first_name, lsr.last_name AS reader_last_name, reader_num
FROM library_simple.book AS lsb
INNER JOIN library_simple.copy AS lscp ON lsb.id = lscp.book_id
INNER JOIN library_simple.category_has_book AS lschb ON lsb.id = lschb.book_id
INNER JOIN library_simple.category AS lsc ON lschb.category_id = lsc.id
INNER JOIN library_simple.author_has_book AS lsahb ON lsb.id = lsahb.book_id
INNER JOIN library_simple.author AS lsa ON lsahb.author_id = lsa.id
INNER JOIN library_simple.issuance AS lsi ON lscp.id = lsi.copy_id
INNER JOIN library_simple.reader AS lsr ON lsi.reader_id = lsr.id
WHERE lsb.id = 252;

-- 2.which books did Van Parks write?
-- SELECT lsa.first_name, lsa.last_name, lsb.name
SELECT 
CONCAT(first_name, ' ', last_name) AS full_name, lsb.name AS book_name
FROM library_simple.author AS lsa
INNER JOIN library_simple.author_has_book AS lsahb ON lsa.id = lsahb.author_id
INNER JOIN library_simple.book AS lsb ON lsahb.book_id = lsb.id
WHERE lsa.first_name = 'Van' AND lsa.last_name = 'Parks';
-- WHERE lsa.first_name = 'Van' AND lsa.last_name = 'Parks'

-- 3.which books where published in 2003?
-- 1 variant
SELECT `name`, pub_year
FROM library_simple.book
WHERE pub_year = 2003;
-- 2 variant
SELECT lsa.id, lsa.first_name, lsa.last_name, lsahb.author_id, lsahb.book_id, lsb.id, lsb.ISBN, lsb.name, lsb.page_num, lsb.pub_year
FROM library_simple.author lsa
JOIN library_simple.author_has_book lsahb ON lsa.id = lsahb.author_id
JOIN library_simple.book lsb ON lsahb.book_id = lsb.id
WHERE lsb.pub_year = '2003';
-- -----------------------------------------------------------------------------------------