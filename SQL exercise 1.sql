--part 1 (Sakila)

-- Q1: Display all tables available in the database “sakila”
SHOW TABLES 
FROM sakila;
-- Q2: Display the structure of the table “actor”
DESCRIBE sakila.actor;
-- Q3: Display the schema which was used to create the table “actor”
SHOW CREATE TABLE sakila.actor;
-- Q4: Display the first and last names of all actors from the table actor
SELECT first_name, last_name 
FROM sakila.actor;
-- Q5: Which actors have the last name ‘Johansson’
SELECT * 
FROM sakila.actor 
WHERE last_name = 'Johansson';
-- Q6: Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
SELECT UPPER(CONCAT(first_name, ' ', last_name)) 
AS 'Actor Name' 
FROM sakila.actor;
-- Q7: Find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe"
SELECT actor_id, first_name, last_name 
FROM sakila.actor 
WHERE first_name = 'Joe';
-- Q8: Which last names are not repeated
SELECT last_name 
FROM sakila.actor 
GROUP BY last_name 
HAVING COUNT(last_name) = 1;
-- Q9: List the last names of actors, as well as how many actors have that last name
SELECT last_name, COUNT(*) AS actor_count 
FROM sakila.actor 
GROUP BY last_name 
ORDER BY actor_count DESC;
-- Q10: Use JOIN to display the first and last names, as well as the address, of each staff member
SELECT staff.first_name, staff.last_name, address.address 
FROM sakila.staff 
JOIN sakila.address ON staff.address_id = address.address_id;

--part 1 (World)

-- Q1: Display all columns and 10 rows from the table “city”
SELECT * 
FROM world.city 
LIMIT 10;
-- Q2: Display from row #16 to 20 with all columns
SELECT * 
FROM world.city 
LIMIT 5 OFFSET 15;
-- Q3: How many rows are available in the table city
SELECT COUNT(*) 
AS total_rows 
FROM world.city;
-- Q4: Find the most populated city
SELECT name, population 
FROM world.city 
ORDER BY population DESC 
LIMIT 1;
-- Q5: Find the least populated city
SELECT name, population 
FROM world.city 
ORDER BY population ASC 
LIMIT 1;
-- Q6: Display the names of all cities where the population is between 670,000 and 700,000
SELECT name 
FROM world.city 
WHERE population BETWEEN 670000 AND 700000;
-- Q7: Find the 10 most populated cities and display them in decreasing order
SELECT name, population 
FROM world.city 
ORDER BY population DESC 
LIMIT 10;
-- Q8: Order the data by city name and get the first 10 cities from the city table
SELECT name 
FROM world.city 
ORDER BY name ASC 
LIMIT 10;
-- Q9: Display all the districts of the USA where the population is greater than 3,000,000
SELECT district 
FROM world.city 
WHERE countrycode = 'USA' AND population > 3000000;

--part 2 (Sakila)

-- Q1: Which actor has appeared in the most films? (‘107', 'GINA', 'DEGENERES', '42')
SELECT 
    sakila.actor.actor_id, 
    sakila.actor.first_name, 
    sakila.actor.last_name, 
    COUNT(*) AS film_count
FROM 
    sakila.actor
JOIN 
    sakila.film_actor 
ON 
    sakila.actor.actor_id = sakila.film_actor.actor_id
GROUP BY 
    sakila.actor.actor_id, sakila.actor.first_name, sakila.actor.last_name
ORDER BY 
    film_count DESC
LIMIT 1;

-- Q2: What is the average length of films by category? (16 rows)
SELECT 
    sakila.category.name AS category, 
    AVG(sakila.film.length) AS average_length
FROM 
    sakila.category
JOIN 
    sakila.film_category 
ON 
    sakila.category.category_id = sakila.film_category.category_id
JOIN 
    sakila.film 
ON 
    sakila.film_category.film_id = sakila.film.film_id
GROUP BY 
    sakila.category.category_id, sakila.category.name;

-- Q3: Which film categories are long? (5 rows)
SELECT 
    sakila.category.name AS category, 
    AVG(sakila.film.length) AS average_length
FROM 
    sakila.category
JOIN 
    sakila.film_category 
ON 
    sakila.category.category_id = sakila.film_category.category_id
JOIN 
    sakila.film 
ON 
    sakila.film_category.film_id = sakila.film.film_id
GROUP BY 
    sakila.category.category_id, sakila.category.name
HAVING 
    AVG(sakila.film.length) > 120;
-- Q4: How many copies of the film “Hunchback Impossible” exist in the inventory system? (6)
SELECT 
    COUNT(*) AS copies_count
FROM 
    sakila.inventory
JOIN 
    sakila.film 
ON 
    sakila.inventory.film_id = sakila.film.film_id
WHERE 
    sakila.film.title = 'Hunchback Impossible';
-- Q5: Using the tables “payment” and “customer” and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT 
    sakila.customer.first_name, 
    sakila.customer.last_name, 
    SUM(sakila.payment.amount) AS total_paid
FROM 
    sakila.customer
JOIN 
    sakila.payment 
ON 
    sakila.customer.customer_id = sakila.payment.customer_id
GROUP BY 
    sakila.customer.customer_id, sakila.customer.first_name, sakila.customer.last_name
ORDER BY 
    sakila.customer.last_name;

--part 2 (world)

-- Q1: Find all countries where the second-to-last letter of the name is 'd'.
SELECT Code, Name, Continent, GNP
FROM country
WHERE SUBSTRING(REVERSE(Name), 2, 1) = 'd';
-- Q2: Find the countries with the 2nd and 3rd highest GNP.
SELECT Code, Name, Continent, GNP
FROM country
ORDER BY GNP DESC
LIMIT 2 OFFSET 1;

--New Db Task

CREATE DATABASE Corporate_Office;
USE Corporate_Office;

CREATE TABLE IF NOT EXISTS `departments` (
  `DEPARTMENT_ID` decimal(4,0) NOT NULL DEFAULT '0',
  `DEPARTMENT_NAME` varchar(30) NOT NULL,
  `MANAGER_ID` decimal(6,0) DEFAULT NULL,
  `LOCATION_ID` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`DEPARTMENT_ID`),
  KEY `DEPT_MGR_FK` (`MANAGER_ID`),
  KEY `DEPT_LOCATION_IX` (`LOCATION_ID`)
);

\
