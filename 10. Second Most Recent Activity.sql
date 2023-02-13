-- Write a SQL query that retrieves the user information with the second most recent activity. 
-- In the case where there is only one activity, return the information for that single user.

-- Table Schema as below

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


-- Solution

WITH processed_data
AS (SELECT *,
           COUNT(*) OVER (PARTITION BY username) AS total_activities,
           RANK() OVER (PARTITION BY username ORDER BY startdate DESC) AS rn
    FROM UserActivity
   )
SELECT *
FROM processed_data
WHERE rn = 2
      OR total_activities = 1
      

-- Steps

1. The query starts with a Common Table Expression (CTE) named "processed_data" that takes data from the "UserActivity" table.

2. Within the CTE, a new column "total_activities" is created that counts the total number of activities per username using the COUNT function and the OVER clause with a partition on username.

3. Another column named "rn" is created using the RANK function and the OVER clause with a partition on username and an order by startdate.

4. The final SELECT statement selects all columns from the processed_data CTE.

5. The WHERE clause filters the result to only show rows where "rn" is equal to 2 or "total_activities" is equal to 1. This means that the result will only show the second most recent activity for each username or the only activity for usernames with only one activity.






