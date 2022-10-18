
-- Lesson #3 SQL = DDL + DQL + DML
-- -----------------------------------------
-- Homework #2
-- show all customers in Australia
select * from classicmodels.customers where country = 'Australia';
-- show First and Last name of customers in Melbourne
select contactFirstName,contactLastName, city from classicmodels.customers where city = 'Melbourne';
-- show all customers with Credit Limit over $200,000
select * from classicmodels.customers where creditLimit > 200000;
-- who is the president of the company?
select * from classicmodels.employees where jobTitle = 'President';
-- how many Sales Reps are in the company?
select count(*) from classicmodels.employees where jobTitle like 'Sales%Rep%';
-- show payments in descending order
select * from classicmodels.payments
order by amount desc;
-- what was the check# for the payment done on December 17th 2004
select checkNumber, paymentDate from classicmodels.payments
where paymentDate = '2004-12-17';
-- show product line with the word 'realistic' in the description
select productLine, textDescription from classicmodels.productlines
where textDescription like '%realistic%';
-- show product name for vendor 'Unimax Art Galleries'
select productName, productVendor from classicmodels.products
where productVendor = 'Unimax Art Galleries';
-- what is the customer number for the highest amount of payment
select customerNumber, amount from classicmodels.payments
order by amount desc
limit 1;

-- end of Homework#2

-- -------------------- Lesson #3 SQL = DDL + DQL + DML -------------------

-- Data Definition Language (DDL): CREATE TABLE, ALTER TABLE, DROP TABLE		
	
    -- CREATE DATABASE or SCHEMA 
	CREATE DATABASE database_name;
    DROP DATABASE database_name;
    -- same as
    CREATE SCHEMA database_name;
    DROP SCHEMA database_name;
    
  -- CREATE TABLE
    CREATE TABLE table_name 
    (column1 datatype,	
	 column2 datatype,	
	 column3 datatype);	

-- practice table mywork.EMPLOYEE_TEST  -- DROP DATABASE mywork;
CREATE DATABASE mywork;
 
CREATE TABLE mywork.EMPLOYEE_TEST (
EMPLOYEE_ID int not null,
FIRST_NAME varchar (75),
LAST_NAME varchar (75),
ADDRESS varchar (100),
CITY varchar (30),
STATE  varchar (20),
ZIP_CODE varchar (20),
PHONE varchar (25),
COUNTRY varchar (50),
HIREDATE date,
SALARY decimal (6,2),
PRIMARY KEY (EMPLOYEE_ID));

select * from mywork.EMPLOYEE_TEST;
-- DROP TABLE mywork.EMPLOYEE_TEST;

	-- ADD COLUMN	 
	ALTER TABLE table_name	
	ADD column column_name datatype;	
    
    ALTER TABLE mywork.EMPLOYEE_TEST add column EMAIL varchar (50);
 
	
    -- DROP COLUMN	
	ALTER TABLE table_name	
	DROP COLUMN column_name;
	
	ALTER TABLE mywork.EMPLOYEE_TEST drop column EMAIL;
    
	-- DROP TABLE	
	DROP TABLE table_name;	
    
-- ------------------------------------------		
-- Data Query Language (DQL): SELECT		
	SELECT column1, column2	
	FROM table_name;	
-- ------------------------------------------		
-- Data Manipulation Language (DML): INSERT, UPDATE, DELETE		
	-- INSERT
    INSERT INTO table_name (column1, column2, column3, ...)	
	VALUES (value1, value2, value3, ...);	
  
	INSERT INTO mywork.EMPLOYEE_TEST (EMPLOYEE_ID, HIREDATE, LAST_NAME, FIRST_NAME, PHONE)  
    VALUES (999999, DATE '2018-12-01', 'Smith', 'Kathy', '415-999-9999');	
	
    select * from mywork.EMPLOYEE_TEST;
    
    -- UPDATE	
	UPDATE table_name	
	SET column1 = value1, column2 = value2, ...	
	WHERE condition;	
	
    UPDATE mywork.EMPLOYEE_TEST SET SALARY = (SALARY * 1.1);
   
   -- DELETE
    DELETE FROM table_name
	WHERE condition;
	
    DELETE FROM mywork.EMPLOYEE_TEST WHERE FIRST_NAME = 'Kathy';

-- if you need to drop the table (DDL Language) DROP table mywork.EMPLOYEE_TEST;
-- ----------------- End of Theory ----------------------

-- Two ways to create a schema/database
-- Error Message if database exists
DROP DATABASE mywork;
CREATE DATABASE mywork;
-- No Error Message 
DROP DATABASE IF EXISTS mywork;
CREATE DATABASE mywork;

-- drop table
-- Error Message if database exists
DROP TABLE mywork.emp;
-- No Error Message
DROP TABLE IF EXISTS mywork.emp;

-- create table with primary key constraints
CREATE TABLE mywork.emp (
empno INT (10) NOT NULL,
ename VARCHAR(10) DEFAULT NULL,
job VARCHAR(9) DEFAULT NULL,
mgr INT(10) DEFAULT NULL,
hiredate DATE,
sal NUMERIC(7,2),
comm NUMERIC(7,2) NULL,
dept INT (10),
 PRIMARY KEY (empno));

-- to see the structure of the table 
desc mywork.emp;
-- to see all records in the table
select * from mywork.emp;
-- insert records in the table ('' for varchar colomns)
insert into mywork.emp (empno,ename,job,mgr,hiredate,sal,comm,dept)
values
    (1,'JOHNSON','ADMIN',6,'1990-12-17',18000,NULL,4);
    
insert into mywork.emp (empno,ename,job,mgr,hiredate,sal,comm,dept)
values
    (2,'HARDING','MANAGER',9,'1990-12-17',52000,300,3),
	(3,'TAFT','SALES I',2,'1995-12-17',25000,500,3),
    (4,'HOOVER','SALES I',2,'1990-04-02',27000,NULL,3),
    (5,'LINCOLN','TECH',6,'1994-06-23',22500,1400,4),
    (6,'GARFIELD','MANAGER',9,'1993-05-01',54000,NULL,4),
    (7,'POLK','TECH',6,'1997-09-22',25000,NULL,4),
    (8,'GRANT','ENGINEER',10,'1997-03-30',32000,NULL,2),
    (9,'JACKSON','CEO',NULL,'1990-01-01',75000,NULL,4),
    (10,'FILLMORE','MANAGER',9,'1994-08-09',56000,NULL,2),
    (11,'ADAMS','ENGINEER',10,'1996-03-15',34000,NULL,2),
    (12,'WASHINGTON','ADMIN',6,'1998-04-16',18000,NULL,4),
    (13,'MONROE','ENGINEER',10,'2000-12-03',30000,NULL,2),
    (14,'ROOSEVELT','CPA',9,'1995-10-12',35000,NULL,1);
-- rename column
alter table mywork.emp rename column job to job_title;

select * from mywork.emp;
-- update records
update mywork.emp set ename = 'SMITH' where ename = 'POLK';
-- delete records
delete from mywork.emp where ename = 'ROOSEVELT';
-- add column
alter table mywork.emp add column bonus_percent int (3);
-- drop column
alter table mywork.emp drop column bonus_percent;

-- CREATE TABLE mywork.dept;
CREATE TABLE IF NOT EXISTS mywork.dept (
deptno INT NOT NULL,
dname VARCHAR(14),
loc VARCHAR(13),
 PRIMARY KEY (deptno));
 
 select * from mywork.dept;
 
 -- ALTER TABLE mywork.emp drop foreign key fk_dept;
 -- to create foreign key
ALTER TABLE mywork.emp
ADD FOREIGN KEY fk_dept(dept)
REFERENCES dept(deptno)
ON DELETE NO ACTION
ON UPDATE CASCADE;
 
insert into mywork.dept values (1,'ACCOUNTING','ST LOUIS');
insert into mywork.dept values (2,'RESEARCH','NEW YORK');
insert into mywork.dept values (3,'SALES','ATLANTA');
insert into mywork.dept values (4,'OPERATIONS','SEATTLE');

desc mywork.emp;
select * from mywork.dept;
-- show all records in department #4
select * from mywork.dept where deptno =4;
-- show distinct department name
select distinct dname from mywork.dept order by dname;
-- show all departments that start with A
select * from mywork.dept where dname like 'A%';
-- show all records for departments between 1 and 3
select * from mywork.dept where deptno between 1 and 3;

select * from mywork.dept;

-- ------------------------------------
-- create new schema/database 
DROP DATABASE IF EXISTS `PETS`;
CREATE DATABASE PETS;

CREATE TABLE pets.pet 
(`name` VARCHAR(20), 
`owner` VARCHAR(20),
species VARCHAR(20), 
sex CHAR(1), 
birth DATE, 
death DATE);

insert into pets.pet  (`name`, `owner`, species, sex, birth, death)
values ('Pepper','Michael', 'hamster', 'F',  '2015-01-01', '2021-02-26');

select * from pets.pet;

-- delete all records from a table
-- #1
truncate table pets.pet;
-- #2
delete from pets.pet;

select * from pets.pet;

-- rename table, column
rename table pets.pet to pets.mypet;
-- select * from pets.mypet; 
alter table pets.mypet rename column `owner` to owners; 

-- delete table/drop table
drop table pets.mypet;
drop database pets;
-- ---------------------------------------------------
-- some info used by DBA (Database Administrator)
-- timestamps
select now();
-- all users info
select * from mysql.user;
-- to look up a version of MySQL server
show variables like "version%";
-- ---------------------------------------------------
/*
Homework #3  
Part 1 - mywork database
Write sql 
	1. Add column 'country' to dept table in mywork database
	2. Rename column 'loc' to 'city'
	3. Add three more departments: HR, Engineering, Marketing
	4. Write sql statement to show which department is in Atlanta
    Save your work in Homework3_Answers.sql


Part 2  - library_simple database
Run library_simple.sql script  (takes a few minutes)
(source: https://github.com/amyasnov/stepic-db-intro/tree/2650f9a7f9c72e1219ea93cb4c4e410cca046e54 )

Look at table relationships in EER Diagram

Write sql 
	1. What is the first name of the author with the last name Swanson?
	2. How many pages are in Men Without Fear book?
	3. Show all book categories that start with with letter 'W'
*/
-- ---------------------------------------------------
