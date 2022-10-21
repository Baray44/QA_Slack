--                    HOMEWORK #5

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
-- ---------------------------------------------------------------------------------
				-- Part #1

-- 1. SQL statement (classicmodels db) using union: show products with buyPrice > 100 and <200
				-- 1 variant
SELECT productName, buyPrice FROM classicmodels.products
WHERE buyPrice > 100
UNION
SELECT productName, buyPrice FROM classicmodels.products
WHERE buyPrice <  200;

				-- 2 variant (a much better query)
SELECT productName, buyPrice FROM classicmodels.products
WHERE buyPrice BETWEEN 100 AND 200;

-- 2. SQL statement (classicmodels db) using subquery: show all customer names with employees in San Francisco office
			-- 1 variant
SELECT customerName, salesRepEmployeeNumber
FROM classicmodels.customers
WHERE salesRepEmployeeNumber IN
(SELECT employeeNumber
FROM classicmodels.employees
WHERE officeCode IN
(SELECT officeCode FROM classicmodels.offices
WHERE city = 'San Francisco'));

			-- 2 variant
SELECT customerName, salesRepEmployeeNumber
FROM classicmodels.customers
WHERE salesRepEmployeeNumber IN
(SELECT employeeNumber
FROM classicmodels.employees e
INNER JOIN classicmodels.offices o ON e.officeCode = o.officeCode
WHERE o.city = 'San Francisco');

			-- 3 variant
SELECT cc.customerName, cc.salesRepEmployeeNumber, e.firstName, e.lastName
FROM classicmodels.customers AS cc,
	(SELECT lastName, firstName, employeeNumber 
		FROM classicmodels.employees AS e
        INNER JOIN classicmodels.offices o ON e.officeCode = o.officeCode
		WHERE o.city = 'San Francisco') AS e
WHERE e.employeeNumber = cc.salesRepEmployeeNumber;

				-- Part #2
                
-- 1.how many vendors, product lines, and products exist in the database?
				-- variant 1
SELECT COUNT(DISTINCT p.productCode) AS productCode,
	COUNT(DISTINCT p.productVendor) AS productVendor,
	COUNT(DISTINCT pl.productLine) AS productLine
FROM classicmodels.products AS P
RIGHT JOIN classicmodels.productlines AS pl ON p.productLine = pl.productLine;

				-- variant 2
SELECT COUNT(DISTINCT p.productCode) AS productCode,
	COUNT(DISTINCT p.productVendor) AS productVendor,
    COUNT(DISTINCT pl.productLine) AS productLine
FROM classicmodels.products AS p, classicmodels.productlines AS pl;

-- 2.what is the average price (buy price, MSRP) per vendor?

SELECT productVendor, AVG(buyPrice), AVG(MSRP)
FROM classicmodels.products
GROUP BY productVendor;

-- 3.what is the average price (buy price, MSRP) per customer?

SELECT co.customerNumber, AVG(priceEach), AVG(buyPrice), AVG(MSRP)
FROM classicmodels.orders AS co
INNER JOIN classicmodels.orderdetails AS cod ON co.orderNumber = cod.orderNumber
INNER JOIN classicmodels.products AS cp ON cod.productCode = cp.productCode
GROUP BY co.customerNumber
ORDER BY co.customerNumber;

-- 4.what product was sold the most?

SELECT COUNT(cod.productCode) AS count_product, cp.productName, MAX(cod.quantityOrdered) AS count_order
FROM classicmodels.orderdetails AS cod
INNER JOIN classicmodels.products AS cp ON cod.productCode = cp.productCode
GROUP BY cod.productCode
ORDER BY count_product DESC
LIMIT 1;

-- 5.how much money was made between buyPrice and MSRP?
-- 7.which vendor sells more products?