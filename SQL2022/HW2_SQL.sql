-- HOMEWORK #2

-- show all customers in Australia
SELECT * FROM classicmodels.customers
WHERE country = 'Australia';

-- show First and Last name of customers in Melbourne
SELECT contactFirstName, contactLastName FROM classicmodels.customers
WHERE city = 'Melbourne';

-- show all customers with Credit Limit over $200,000
SELECT * FROM classicmodels.customers
WHERE creditLimit >= 200000;

-- who is the president of the company?
SELECT * FROM classicmodels.employees
WHERE jobTitle = 'President';

-- how many Sales Reps are in the company? (17)
SELECT * FROM classicmodels.employees
WHERE jobTitle = 'Sales Rep';

-- show payments in descending order
SELECT * FROM classicmodels.payments
ORDER BY amount desc;

-- what was the check# for the payment done on December 17th 2004
SELECT checkNumber FROM classicmodels.payments
WHERE paymentDate = '2004-12-17';

-- show product line with the word 'realistic' in the description
SELECT * FROM classicmodels.productlines
WHERE textDescription like '%realistic %';

-- show product name for vendor 'Unimax Art Galleries'
SELECT productName FROM classicmodels.products
WHERE productVendor = 'Unimax Art Galleries';

-- what is the customer number for the highest amount of payment
-- 1 variant
SELECT customerNumber, amount FROM classicmodels.payments
WHERE amount = (SELECT max(amount) FROM classicmodels.payments);
-- 2 variant
SELECT customerNumber, amount FROM classicmodels.payments
ORDER BY amount desc
limit 1;