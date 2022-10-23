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
