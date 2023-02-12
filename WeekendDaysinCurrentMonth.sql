-- Write a SQL query to return the total number of weekend days (Saturday & Sunday) in the current month.


-- Solution
DECLARE @StartDate DATE = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0);
DECLARE @EndDate DATE = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) + 1, -1);

WITH WeekendDays AS
(
    SELECT @StartDate AS TheDate
    UNION ALL
    SELECT DATEADD(DAY, 1, TheDate)
    FROM WeekendDays
    WHERE DATEADD(DAY, 1, TheDate) <= @EndDate
)
SELECT COUNT(CASE WHEN DATEPART(WEEKDAY, TheDate) IN (1, 7) THEN 1 END) AS WeekendDays
FROM WeekendDays;



--Steps Followed
1. DECLARE statements: The query starts by declaring two variables @StartDate and @EndDate to represent the start and end of the current month. 
   The DATEDIFF and DATEADD functions are used to calculate the first and last day of the current month, respectively.

2. WITH clause: A Common Table Expression (CTE) named WeekendDays is created to generate a list of dates between @StartDate and @EndDate. 
   The CTE uses a recursive UNION ALL query to add one day to the date each iteration until the end date is reached.
   
3. SELECT statement: The main SELECT statement counts the number of weekend days (Saturday and Sunday) by using a CASE statement in combination with the DATEPART function. 
   The DATEPART function returns the weekday of each date in the WeekendDays CTE, and the CASE statement checks if the weekday is either 1 (Sunday) or 7 (Saturday). 
   If the condition is true, the count is incremented.
   
4. The final result of the query is the number of weekend days in the current month.
