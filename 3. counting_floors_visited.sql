/* Problem Statement: There's a company which allows only one entry to thier employees in a day, so what happened is if a person A can only enter
once into the company but while entering the employee should give their email-id and the problem here is the same person can enter again into 
the company by giving different mail-id in a day.
*/

/* Write a query to fetch that how many times an employee entered into the company, the most visited floors and resourses used inside the company.
*/

-- Table schema as below

create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')


-- Solution

WITH enames AS (
SELECT DISTINCT name AS emp_name
FROM entries), --fetching distinct employees names by eliminating duplicates
visits AS (
SELECT name, COUNT(email) AS no_of_visits
FROM entries
GROUP BY name),-- counting the number of floors visited by each employee 
visited_floors AS
(SELECT name, floor AS most_visited_floor, visited_floor_count
FROM(
SELECT name, floor, COUNT(floor) AS visited_floor_count,
DENSE_RANK() OVER(PARTITION BY name ORDER BY COUNT(floor) DESC) AS rn
FROM entries
GROUP BY name, floor) A
WHERE rn=1),-- Fetching the most visited floors by an employee using Window function
res AS
(SELECT name, STRING_AGG(resources,', ') AS resources_used
FROM(
SELECT DISTINCT name, resources
FROM entries) B
GROUP BY name) -- Using string aggregate function to gather the resources together used by an employee

SELECT e.emp_name, v.no_of_visits, vf.most_visited_floor, r.resources_used
FROM enames e
JOIN visits v ON v.name = e.emp_name
JOIN visited_floors vf ON vf.name = e.emp_name
JOIN res r ON r.name = e.emp_name
