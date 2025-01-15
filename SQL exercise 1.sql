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
SELECT * FROM world.city LIMIT 5 OFFSET 15;
