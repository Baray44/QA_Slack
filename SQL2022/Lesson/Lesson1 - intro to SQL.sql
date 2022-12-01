
-- Lesson #1 Intro to SQL
-- Lesson Plan
-- Costco Database
-- Inroduction to SQL
-- Installation of MySQL and MySQL Workbench

-- MySQL Workbench 
-- Why MySQL Workbench? other tools e.g. SQL Navigator, SQL Assistant, Toad
-- In MySQL Workbench remove Safe mode: Edit - Preferences - Sql editor - Safe Updates - uncheck the box
select * from classicmodels.customers;
-- MySQL Workbench layout - three boxes in the right upper corner, play with them
-- MySQL Workbench has Results Grid and Auction Output windows

-- SHEMAS (on the left). Sys schema (do not touch!) 
-- SHEMAS Check out databases, tables, columns, relationship structure
-- SHEMAS Right click options (create table, create schema)
-- SHEMAS If you don't see the changes after your action - right click on a white space - Refresh All

-- File. SQL files have extention .sql
-- File. To open a new query: File - New Query Tab. 
-- File. To open a script: File - Open Sql Script.
-- File. To save a query: File - Save Script as xxxxxx.


/*Run a sql statement: 
highlight statement - Query - Execute (All or Selection) or click on 'yellow lightning' as a shortcuts */
-- Action Output. Error messages - read them!
-- Writing SQL Notes, 2 ways: -- text OR /*text*/ 
-- SQL reserved words are in green; to use them as regular words, quote them with ~ tilde/`grave accent mark e.g.`database`
-- EER Diagram: Database - Reverse Engineer - Next - Next - Choose the Database - Next - Next - Excecute - Finish



-- -------------------------------------------------------------
-- SQL Homework #1
-- 1.Install MySQL and MySQL Workbench
-- 2.In MySQL Workbench remove Safe Mode: Edit - Preferences - Sql editor - Safe Updates - uncheck the box
-- 3.Create 'SQL2022' Folder in your local drive 
/* 
4.Download our 1st database (Sample Database classicmodels)
https://www.mysqltutorial.org/mysql-sample-database.aspx 
Click on Link: Download MySQL Sample Database
Move mysqlsampledatabase.zip from your download folder to SQL2022 folder 
Unnzip 
*/
-- 5.In MySQL Workbench: File - Open SQL Script - SQL2022\mysqlsampledatabase.sql
-- File - Run SQL Script (Check if the database was created)
select * from classicmodels.customers;
