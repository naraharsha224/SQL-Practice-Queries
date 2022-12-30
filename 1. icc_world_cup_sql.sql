-- Write a query to fetch the matches played by each team, and consolidate their wins and losses as well.

-- Table schema as below

create table icc_world_cup(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');


-- Solution 1 by using CTE
WITH team_list AS(
SELECT Team_1 AS team_name,
CASE WHEN Team_1=Winner THEN 1 ELSE 0 END as Wins
FROM icc_world_cup
UNION ALL
SELECT Team_2 AS team_name,
CASE WHEN Team_2=Winner THEN 1 ELSE 0 END as Wins
FROM icc_world_cup)

SELECT team_name, COUNT(team_name) AS Matches_played,
       SUM(wins) AS no_of_wins,
	   (COUNT(team_name) - SUM(wins)) AS no_of_losses
FROM team_list
GROUP BY team_name
ORDER BY no_of_wins DESC


-- Solution 2 by using subquery

SELECT team_name,
       COUNT(team_name) AS no_of_matches_played,
       SUM(win_flag) AS no_of_matches_won, 
	   COUNT(team_name)-SUM(win_flag) AS no_of_matches_lost
FROM
(
SELECT team_1 AS team_name,
CASE WHEN team_1=winner THEN 1 ELSE 0 END AS win_flag
FROM icc_world_cup
UNION ALL
SELECT team_2 AS team_name,
CASE WHEN team_2=winner THEN 1 ELSE 0 END AS win_flag
FROM icc_world_cup) AS cricket_table
GROUP BY team_name
ORDER BY no_of_matches_won DESC
