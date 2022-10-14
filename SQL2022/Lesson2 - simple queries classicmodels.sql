-- Lesson #2 Simple Queries
Link: http://www.mysqltutorial.org/mysql-sample-database.aspx
Name: MySQL Sample Database classicmodels
select * from classicmodels.customers;

/* Lesson2 Plan */
-- EER Diagram
-- number of records
-- sql statement - syntax
-- commit
-- record count
-- SQL shortcuts
-- order by
-- INFORMATION_SCHEMA
-- operators
-- simple queries


-- --------------------------------------------------------------------------------

-- EER or ER or ERD Diagram (Enhanced Entry Relationship) 
-- Database - Reverse Engineer - Next - Enter Password - Next - Choose Databae - Next - Next - Execute - Finish

-- To restrict number of returned records in Result Grid: 
select * from classicmodels.customers
limit 3;
/*
MySQL:       limit 3
SQL Server:  top 4
Oracle:      rownum = 3
 */
 

-- SQL statement syntax
-- how to retrieve infromation from a table?
 select column
 from database.table;
-- upper or lower case in sql statements - no difference (case-insensetive)
-- reserved words (blue)
-- commit  ;


-- * (means all columns)
select * from classicmodels.customers;-- 122     
select * from classicmodels.employees; -- 23
select * from classicmodels.offices; -- 7
select * from classicmodels.orderdetails; -- 2996
select * from classicmodels.orders; -- 326
select * from classicmodels.payments; -- 273
select * from classicmodels.productlines; -- 7
select * from classicmodels.products; -- 110


-- Why count records?
/* 
3 ways to count records: 
1.select * and check the message
2.hover over a table click on i to see info on that table
3.count(*)
*/
select count(*) from classicmodels.customers; -- 122
select count(*) from classicmodels.employees; -- 23
select count(*) from classicmodels.offices; -- 7
select count(*) from classicmodels.orderdetails; -- 2996
select count(*) from classicmodels.orders; -- 326
select count(*) from classicmodels.payments; -- 273
select count(*) from classicmodels.productlines; -- 7
select count(*) from classicmodels.products; -- 110

-- SQL shortcuts
-- use database
use classicmodels; 
select * from customers; 
show tables;

-- SQL statement sructure with where clause
-- single quotes for text, no quotes for numbers
-- order by (asc and desc order)
 select column
 from table
 where column = 'xxx'
 order by column;
 
-- SQL mnemonic device for select statement: Single Cats Fly to West Cost
  
 /* SQL Operators in Where Clause/Condition					
 +, -, *, /, %, &, |, ^, =, >, >, >=, <=, <>, AND, ALL, ANY, BETWEEN, EXISTS, IN, LIKE, NOT, OR, SOME */
 
 
-- Information schema (database metadata about all tables, columns, keys, etc.)
 
-- to see primary and foreign keys  (constraints)       
SELECT *  
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'classicmodels'
AND TABLE_NAME = 'customers';  

-- to see all tables in database
SELECT *  
FROM INFORMATION_SCHEMA.tables
WHERE TABLE_SCHEMA = 'classicmodels'; 

-- to see all columns in database
SELECT *  
FROM INFORMATION_SCHEMA.columns
WHERE TABLE_SCHEMA = 'classicmodels';

-- to see structure of one table (columns, datatypes, keys)
desc classicmodels.customers;



/* ---------------------- SQL Queries ------------------------ */
-- show all customers in Norway
select * from classicmodels.customers 
where country = 'Norway';

-- show all customers in Nevada
select * from classicmodels.customers 
where state = 'NV';

-- show all customers with Credit Limit between 50k and 60k
select * from classicmodels.customers 
where creditLimit>=50000 and creditLimit<=60000;

select * from classicmodels.customers 
where creditLimit between 50000 and 60000;

-- show the name of all VPs
select * from classicmodels.employees
where jobTitle like '%VP%';

-- show the phone number of offices in San Francisco and Boston
select city, phone from classicmodels.offices
where city in ('San Francisco', 'Boston');

select city, phone from classicmodels.offices
where city = 'San Francisco' or city = 'Boston';

-- show city with a null state
select * from classicmodels.offices
where state is null; 

-- show order numbers in the order of higest quantity ordered
select orderNumber, quantityOrdered from classicmodels.orderdetails
order by quantityOrdered desc;

-- show orders > $200
select * from classicmodels.orderdetails
where priceEach >=200;

-- what kind of statuses exist in orders
select distinct `status` from classicmodels.orders;

-- show payments >2005
select * from classicmodels.payments
where paymentDate >= '2005-01-01';

-- show descriiption of productLines for Ships and Trains
select * from classicmodels.productlines
where productLine in ('Ships','Trains');

-- show distinct product lines in ascending order
select distinct ProductLine from classicmodels.products
order by ProductLine;

-- what kind of product lines exist for BMW
select productName, productLine from classicmodels.products
where productName like '%BMW%';

-- Homework #2
-- show all customers in Australia
-- show First and Last name of customers in Melbourne
-- show all customers with Credit Limit over $200,000
-- who is the president of the company?
-- how many Sales Reps are in the company?
-- show payments in descending order
-- what was the check# for the payment done on December 17th 2004
-- show product line with the word 'realistic' in the description
-- show product name for vendor 'Unimax Art Galleries'
-- what is the customer number for the highest amount of payment
-- Save your work in Homework2_Answers.sql
 -- ------------------------------------

