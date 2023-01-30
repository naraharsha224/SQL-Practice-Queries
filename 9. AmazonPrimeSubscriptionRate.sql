/*
Write a SQL query to find the users who have accessed Amazon music and upgraded to prime membership within the last 30 days of signing up
and round the result to two decimal places.
*/

-- Table schema as below

create table users
(
user_id integer,
name varchar(20),
join_date date
);

insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'Prime', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'Prime', CAST('3-16-20' AS date)), 
(3, 'Prime', CAST('3-22-20' AS date));


-- Solution-1
WITH user_events AS (
  SELECT u.user_id, 
         DATEDIFF(day, u.join_date, e.access_date) AS days_since_join
  FROM users u
  LEFT JOIN events e ON u.user_id = e.user_id AND e.type = 'prime'
  WHERE u.user_id IN (SELECT user_id FROM events WHERE type = 'Music'))

SELECT COUNT(DISTINCT user_id) AS total_users,
       COUNT(DISTINCT CASE WHEN days_since_join <= 30 THEN user_id END) AS users_with_30_day_streak,
       FORMAT(1.0*COUNT(DISTINCT CASE WHEN days_since_join <= 30 THEN user_id END) / COUNT(DISTINCT user_id) * 100, 'N2') AS ratio
FROM user_events



-- Solution-2
SELECT COUNT(DISTINCT u.user_id) AS total_users,
       COUNT(DISTINCT CASE WHEN DATEDIFF(day,u.join_date,e.access_date) <= 30 THEN u.user_id END) AS 'UsersWith30DayStreak',
	   FORMAT(1.0*COUNT(DISTINCT CASE WHEN DATEDIFF(day,u.join_date,e.access_date) <= 30 THEN u.user_id END)/COUNT(DISTINCT u.user_id)*100,'N2') AS ratio
FROM users u
LEFT JOIN events e ON u.user_id=e.user_id AND e.type='prime'
WHERE u.user_id IN (SELECT user_id FROM events WHERE type='Music')


Explanation:
/*
1. A Common Table Expression (CTE) named user_events is created.
2. user_events CTE selects the user_id and the number of days between each user's join_date and access_date for events of type 'prime' from the users and events tables.
3. The CTE is filtered to only include users who have an event of type 'Music' in the events table.
4. A SELECT statement calculates the following information from the user_events CTE:
   4a. Total number of distinct users.
   4b. Number of users with a '30-day streak' (i.e., accessing the 'prime' service within 30 days of joining).
   4c. Ratio of '30-day streak' users to total users as a percentage to 2 decimal places.
5. The final result includes the total number of users, the number of users with a 30-day streak, and the ratio of users with a 30-day streak to total users.

*/
