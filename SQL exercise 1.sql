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
