/*
		HOMEWORK #3  
Part 1 - mywork database
Write sql 
	1. Add column 'country' to dept table in mywork database
	2. Rename column 'loc' to 'city'
	3. Add three more departments: HR, Engineering, Marketing
	4. Write sql statement to show which department is in Atlanta
*/
-- 1. Add column 'country' to dept table in mywork database
ALTER TABLE mywork.dept ADD COLUMN country VARCHAR (50);
-- SELECT * FROM mywork.dept;

-- 2. Rename column 'loc' to 'city'
ALTER TABLE mywork.dept RENAME COLUMN loc TO city;

-- 3. Add three more departments: HR, Engineering, Marketing
INSERT INTO mywork.dept
VALUES
	(5,'HR',NULL,NULL),
    (6,'ENGINEERING',NULL,NULL),
    (7,'MARKETING',NULL,NULL);
    
-- 4. Write sql statement to show which department is in Atlanta
SELECT dname, city FROM mywork.dept
WHERE city = 'ATLANTA';

-- -----------------------------------------------------------

/* Part 2  - library_simple database
Run library_simple.sql script  (takes a few minutes)
(source: https://github.com/amyasnov/stepic-db-intro/tree/2650f9a7f9c72e1219ea93cb4c4e410cca046e54 )

Look at table relationships in EER Diagram

Write sql 
	1. What is the first name of the author with the last name Swanson?
	2. How many pages are in Men Without Fear book?
	3. Show all book categories that start with with letter 'W'
*/
-- 1. What is the first name of the author with the last name Swanson?
-- SELECT * FROM library_simple.author;
SELECT first_name, last_name FROM library_simple.author
WHERE last_name = 'Swanson';

-- 2. How many pages are in Men Without Fear book?
-- SELECT * FROM library_simple.book;
SELECT `name`, page_num FROM library_simple.book
WHERE `name` LIKE '%Men Without Fear%';

-- 3. Show all book categories that start with letter 'W'
-- SELECT * FROM library_simple.category;
SELECT * FROM library_simple.category
WHERE `name` LIKE 'W%';
-- ----------------------------------------------------------