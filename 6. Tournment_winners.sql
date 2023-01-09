-- Write an SQL query to find the winner in each group.
-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowset player_id wins.

-- Table schema as below

create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_player_score int,
second_player_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);


-- Solution

WITH player_scores  -- Step1 - Combining the player Ids and theirs scores to single column using UNION ALL.
AS (SELECT first_player AS player_id,
           first_player_score AS player_score
    FROM matches
    UNION ALL
    SELECT second_player AS player_id,
           second_player_score AS player_score
    FROM matches
   ),
     final_scores   -- Step2 - Summing each player score by grouping with group_id, player_id to the ResultSet from player_Scores CTE.
AS (SELECT p.group_id,
           ps.player_id,
           SUM(ps.player_score) AS scores
    FROM players p
        JOIN player_scores ps
            ON ps.player_id = p.player_id
    GROUP By p.group_id,
             ps.player_id
   ),
     final_ranking  -- Step3 - Ranking the scores from max and for tie scores taking the player_id in Ascending order.
AS (SELECT *,
           RANK() OVER (PARTITION BY group_id ORDER BY scores DESC, player_id ASC) AS rn
    FROM final_scores
   )
SELECT *
FROM final_ranking
WHERE rn = 1
