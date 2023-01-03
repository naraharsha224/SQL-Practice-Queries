/*Write a query to find personId, name, number of friends, sum of marks of person who have friends with total score greater than 100 */

/* Table schema in the below link
https://www.youtube.com/watch?v=SfzbR69LquU&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=6 
*/

WITH score_data    -- Step 1 - Summation of score to each personId by grouping with friendscore
     AS (SELECT f.personid,
                Sum(p.score) AS total_score
         FROM   person p
                JOIN friend f
                  ON f.friendid = p.personid
         GROUP  BY f.personid),
     friends_count -- Step 2 - Counting no. of friends to each personId 
     AS (SELECT personid,
                Count(friendid) AS no_of_friends
         FROM   friend
         GROUP  BY personid)

SELECT sd.personid,
       p.name,
       fc.no_of_friends,
       sd.total_score
FROM   score_data sd
       JOIN friends_count fc
         ON fc.personid = sd.personid
       JOIN person p
         ON p.personid = sd.personid
WHERE  sd.total_score > 100 -- Step 3 - Filtering the friends with total score greater than 100
