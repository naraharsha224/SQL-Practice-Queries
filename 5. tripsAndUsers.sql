/*   https://www.youtube.com/watch?v=EjzhMv0E_FE&list=PLBTZqjSKn0IeKBQDjLmzisazhqQy4iGkb&index=8


write a SQL query to find the cancellation rate of requets with unbanned users
(both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03".
Round the cancellation rate to two decimal points.

The cancellation rate is computed by dividing the number of cancelled (by client or driver)
requests with unbanned users by the total number of requests with unbanned users on that day.
*/

-- Table schema as below

Create table  Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table Users (users_id int, banned varchar(50), role varchar(50));
Truncate table Trips;
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');
Truncate table Users;
insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');

-- Solution 1

SELECT t.request_at,
       COUNT(CASE
                 WHEN status IN ( 'cancelled_by_driver', 'cancelled_by_client' ) THEN 1
                 ELSE NULL
                 END) AS cancelled_count, -- counting cancelled trips by clients and drivers
       COUNT(id) AS trip_count, -- Total trip count 
       FORMAT(1.0 * COUNT(CASE 
	                          WHEN status IN ( 'cancelled_by_driver', 'cancelled_by_client' ) THEN 1
                              ELSE NULL
                              END) / COUNT(id) * 100, 'N2') AS cancellation_rate -- (Cancelled_count/trip_count)*100 = cancellation_rate
FROM trips t
    JOIN users u1
        ON u1.users_id = t.client_id
           AND u1.banned = 'NO'
           AND u1.role = 'client'
    JOIN users u2
        ON u2.users_id = t.driver_id
           AND u2.banned = 'NO'
           AND u2.role = 'driver'
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at


-- Solution 2

SELECT request_at,
       COUNT(CASE WHEN status in ( 'cancelled_by_client', 'cancelled_by_driver' ) THEN 1
                  ELSE NULL
                  END) AS cancelled_trip_count,
       COUNT(1) AS total_trips,
       FORMAT(1.0 * COUNT(CASE WHEN status in ( 'cancelled_by_client', 'cancelled_by_driver' ) THEN 1
                               ELSE NULL
                               END) / COUNT(1) * 100, 'N2') AS cancelled_trips_percent
FROM trips t
    JOIN users c
        ON t.client_ID = c.users_ID
    JOIN users d
        ON t.driver_ID = d.users_ID
WHERE c.banned = 'NO' AND d.banned = 'NO' 
      AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at
