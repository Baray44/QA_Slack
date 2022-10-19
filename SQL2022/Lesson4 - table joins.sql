
-- Lesson #4 Table Joins
-- Homework #3 Answers
-- Part 1 - mywork database

-- 1. Add column 'country' to dept table
select * from mywork.dept;
alter table mywork.dept add column country varchar (10);

-- 2. Rename column 'loc' to 'city'
alter table mywork.dept rename column loc to city;
-- or this: alter table mywork.dept change loc city varchar (15);

-- 3. Add three more departments: HR, Engineering, Marketing
insert into mywork.dept (deptno, dname, city)
values 
(5, 'HR', 'MOSCOW'),
(6, 'ENGINEERING','NEW YORK'),
(7, 'MARKETING', 'SAN DIEGO');
select * from mywork.dept;

-- 4. Write sql statement to show which department is in Atlanta
select deptno, city
from mywork.dept 
where city = 'ATLANTA';

-- Part 2  - library_simple database
-- 1. What is the first name of the author with the last name Swanson?
select * from library_simple.author where last_name = 'Swanson';
-- 2. How many pages are in Men Without Fear book?
select name, page_num from library_simple.book where name = 'Men Without Fear';
-- 3. Show all book categories that start with with letter 'W'
select * from library_simple.category where name like 'W%';

-- -------------------------- End of Homework#3 ----------------------
-- -------------------------- Lesson #4 Table Joins ------------------
-- inner join
-- left join
-- self join
-- full join
 -- ---------------------------------------------------
select * from mywork.dept; -- 7
select * from mywork.emp; -- 13

-- inner join
-- table alias 
-- 13 records
select * 
from mywork.emp e
inner join mywork.dept d on e.dept = d.deptno
order by empno;

-- inner join vs. left join

-- inner join = join
-- 100
select *
from classicmodels.customers c -- 122
inner join classicmodels.employees e -- 23
 on c.salesrepemployeenumber=e.employeenumber;

-- 122
select *
from classicmodels.customers c -- 122
left join classicmodels.employees e -- 23
 on c.salesrepemployeenumber=e.employeenumber;

-- full join 
/*The FULL OUTER JOIN return all records when there is a match in either 
left (table1) or right (table2) table records.*/
/* there is no full join in MySQL -- this sql below doesn't work
select * 
from mywork.emp e
full outer join mywork.dept d on e.dept = d.deptno
order by empno; 

-- same as this union 
select * 
from mywork.emp e
left join mywork.dept d on e.dept = d.deptno
union
select * 
from mywork.emp e
right join mywork.dept d on e.dept = d.deptno;
*/

-- self join 
/*A self-join joins data from the same table. In other words, it joins a table with itself. 
Records taken from the table are matched to other records from the same table. 
Why would you do this? You may need to compare a value with another value from the same row. 
You can’t do that unless you join the table to itself and compare the values as if 
they were in two separate records.
*/
select * from classicmodels.employees;

select e1.employeeNumber, e1.firstName, e1.lastName, e1.jobTitle, e1.reportsTo,  -- employee level
e2.firstName as boss_firstName, e2.lastName as boss_lastName, e2.jobTitle as boss_jobTitle -- manager level
from classicmodels.employees e1
left join classicmodels.employees e2 on e1.reportsTo = e2.employeeNumber;


-- ----------------------------------------
-- classicmodels table counts 
select count(*) from classicmodels.customers;-- 122
select count(*) from classicmodels.employees; -- 23
select count(*) from classicmodels.offices; -- 7
select count(*) from classicmodels.orderdetails; -- 2996
select count(*) from classicmodels.orders; -- 326
select count(*) from classicmodels.payments; -- 273
select count(*) from classicmodels.productlines; -- 7
select count(*) from classicmodels.products; -- 110


-- 23
select *  -- select count(*) 
from classicmodels.employees emp -- 23
join classicmodels.offices office -- 7
on emp.officeCode = office.officeCode;

-- 100
select *  -- select count(*) 
from classicmodels.customers cust -- 122
INNER join classicmodels.employees emp -- 23
on cust.SalesRepEmployeeNumber = emp.employeeNumber;

-- 122
select *  -- select count(*) 
from classicmodels.customers cust -- 122
LEFT join classicmodels.employees emp -- 23
on cust.SalesRepEmployeeNumber = emp.employeeNumber;

-- 326
select *  -- select count(*) 
from classicmodels.customers cust -- 122
JOIN classicmodels.orders orders  -- 326
on cust.customerNumber = orders.customerNumber
where cust.customerNumber = 339;
 
-- 2996
select *   -- select count(*) 
from classicmodels.orders orders -- 326
JOIN classicmodels.orderdetails orderd -- 2996
on orders.orderNumber = orderd.orderNumber
where orders.orderNumber in (10183,10307);

-- 110
select *   -- select count(*) 
from classicmodels.products prod -- 110
JOIN classicmodels.productLines prodline -- 7 
on prod.productLine = prodline.productLine;

-- 273
select *  -- select count(*) 
from classicmodels.customers cust -- 122
JOIN classicmodels.payments pay -- 273
on cust.customerNumber = pay.customerNumber
where cust.customerNumber = 339;


-- ---------------------------------------------------			
-- Homework for Lesson #4 
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