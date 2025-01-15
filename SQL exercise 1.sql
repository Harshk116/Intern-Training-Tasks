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
INSERT INTO `departments` (`DEPARTMENT_ID`, `DEPARTMENT_NAME`, `MANAGER_ID`, `LOCATION_ID`) VALUES 
('10', 'Administration', '200', '1700'), 
('20', 'Marketing', '201', '1800'), 
('30', 'Purchasing', '114', '1700'), 
('40', 'Human Resources', '203', '2400'), 
('50', 'Shipping', '121', '1500'), 
('60', 'IT', '103', '1400'), 
('70', 'Public Relations', '204', '2700'), 
('80', 'Sales', '145', '2500'), 
('90', 'Executive', '100', '1700'), 
('100', 'Finance', '108', '1700'), 
('110', 'Accounting', '205', '1700'), 
('120', 'Treasury', '0', '1700'), 
('130', 'Corporate Tax', '0', '1700'), 
('140', 'Control And Credit', '0', '1700'), 
('150', 'Shareholder Services', '0', '1700'), 
('160', 'Benefits', '0', '1700'), 
('170', 'Manufacturing', '0', '1700'), 
('180', 'Construction', '0', '1700'), 
('190', 'Contracting', '0', '1700'), 
('200', 'Operations', '0', '1700'), 
('210', 'IT Support', '0', '1700'), 
('220', 'NOC', '0', '1700'), 
('230', 'IT Helpdesk', '0', '1700'), 
('240', 'Government Sales', '0', '1700'), 
('250', 'Retail Sales', '0', '1700'), 
('260', 'Recruiting', '0', '1700'), 
('270', 'Payroll', '0', '1700');

CREATE TABLE IF NOT EXISTS `employees` ( 
  `EMPLOYEE_ID` decimal(6,0) NOT NULL DEFAULT '0', 
  `FIRST_NAME` varchar(20) DEFAULT NULL, 
  `LAST_NAME` varchar(25) NOT NULL, 
  `EMAIL` varchar(25) NOT NULL, 
  `PHONE_NUMBER` varchar(20) DEFAULT NULL, 
  `HIRE_DATE` date NOT NULL, 
  `JOB_ID` varchar(10) NOT NULL, 
  `SALARY` decimal(8,2) DEFAULT NULL, 
  `COMMISSION_PCT` decimal(2,2) DEFAULT NULL, 
  `MANAGER_ID` decimal(6,0) DEFAULT NULL, 
  `DEPARTMENT_ID` decimal(4,0) DEFAULT NULL, 
  PRIMARY KEY (`EMPLOYEE_ID`), 
  UNIQUE KEY `EMP_EMAIL_UK` (`EMAIL`), 
  KEY `EMP_DEPARTMENT_IX` (`DEPARTMENT_ID`), 
  KEY `EMP_JOB_IX` (`JOB_ID`), 
  KEY `EMP_MANAGER_IX` (`MANAGER_ID`), 
  KEY `EMP_NAME_IX` (`LAST_NAME`,`FIRST_NAME`) 
);

INSERT INTO `employees` (`EMPLOYEE_ID`, `FIRST_NAME`, `LAST_NAME`, `EMAIL`, `PHONE_NUMBER`, `HIRE_DATE`, `JOB_ID`, `SALARY`, `COMMISSION_PCT`, `MANAGER_ID`, `DEPARTMENT_ID`) VALUES 
('100', 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', '24000.00', '0.00', '0', '90'), 
('101', 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1987-06-18', 'AD_VP', '17000.00', '0.00', '100', '90'), 
('102', 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1987-06-19', 'AD_VP', '17000.00', '0.00', '100', '90'), 
('103', 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1987-06-20', 'IT_PROG', '9000.00', '0.00', '102', '60'), 
('104', 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1987-06-21', 'IT_PROG', '6000.00', '0.00', '103', '60'), 
('105', 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1987-06-22', 'IT_PROG', '4800.00', '0.00', '103', '60'), 
('106', 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1987-06-23', 'IT_PROG', '4800.00', '0.00', '103', '60'), 
('107', 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1987-06-24', 'IT_PROG', '4200.00', '0.00', '103', '60'), 
('108', 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1987-06-25', 'FI_MGR', '12000.00', '0.00', '101', '100'), 
('109', 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1987-06-26', 'FI_ACCOUNT', '9000.00', '0.00', '108', '100'), 
('110', 'John', 'Chen', 'JCHEN', '515.124.4269', '1987-06-27', 'FI_ACCOUNT', '8200.00', '0.00', '108', '100'), 
('111', 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '1987-06-28', 'FI_ACCOUNT', '7700.00', '0.00', '108', '100'), 
('112', 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '1987-06-29', 'FI_ACCOUNT', '7800.00', '0.00', '108', '100'), 
('113', 'Luis', 'Popp', 'LPOPP', '515.124.4567', '1987-06-30', 'FI_ACCOUNT', '6900.00', '0.00', '108', '100'),
('114', 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '1987-07-01', 'PU_MAN', '11000.00', '0.00', '100', '30'), 
('115', 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '1987-07-02', 'PU_CLERK', '3100.00', '0.00', '114', '30'), 
('116', 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '1987-07-03', 'PU_CLERK', '2900.00', '0.00', '114', '30'), 
('117', 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '1987-07-04', 'PU_CLERK', '2800.00', '0.00', '114', '30');

-- Q1: Query to display Employee ID and First Name of employees whose department ID is 100 (using subquery).
SELECT EMPLOYEE_ID, FIRST_NAME
FROM employees e1
WHERE e1.DEPARTMENT_ID = (
    SELECT DEPARTMENT_ID
    FROM employees e2
    WHERE e2.DEPARTMENT_ID = 100
    limit 1
);
-- Q2: Query to display department ID and maximum salary of departments where
-- the maximum salary is greater than the average salary in the same department (using subquery).
SELECT DEPARTMENT_ID, MAX(SALARY) AS MAX_SALARY
FROM employees e1
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > (
    SELECT AVG(SALARY)
    FROM employees e2
    WHERE e2.DEPARTMENT_ID = e1.DEPARTMENT_ID
);
-- Q3: Query to display department name and department ID of employees whose salary is less than 35000 (using subquery).
SELECT department.DEPARTMENT_NAME, department.DEPARTMENT_ID
FROM departments department
WHERE department.DEPARTMENT_ID IN (
    SELECT DISTINCT DEPARTMENT_ID
    FROM employees
    WHERE SALARY < 35000
);
