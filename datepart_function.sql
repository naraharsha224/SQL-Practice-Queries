/*DATEPART() Function: 
1. Retrieves specific part of a date/time such as day, month, second, quarter, week etc.,
2. Takes two arguments.
3. Returns an integer value which is a part of date/time.
4. DATEPART function works in SQLServer, Oracle, Azure SQLDB.
5. DATEPART can be used in SELECT, WHERE, HAVING, GROUP BY, ORDER BY.


Syntax: DATEPART(date_part, input_date)
1. date_part is the part of a date/time to be retrieved like a day, month, week, minute etc.
2. input_date is the date/time or a date/time based column from which date_part is extracted.
*/


SELECT DATEPART(DAY, CURRENT_TIMESTAMP)  AS 'day',
       DATEPART(MONTH, CURRENT_TIMESTAMP) AS 'month',
	   DATEPART(YEAR, CURRENT_TIMESTAMP) AS 'year',
	   DATEPART(QUARTER, CURRENT_TIMESTAMP) AS 'quarter',
	   DATEPART(HOUR, CURRENT_TIMESTAMP) AS 'hour',
	   DATEPART(MINUTE, CURRENT_TIMESTAMP) AS 'minute',
	   DATEPART(SECOND, CURRENT_TIMESTAMP) AS 'second',
	   DATEPART(MILLISECOND, CURRENT_TIMESTAMP) AS 'millisecond',
	   DATEPART(MICROSECOND, CURRENT_TIMESTAMP) AS 'microsecond',
	   DATEPART(NANOSECOND, CURRENT_TIMESTAMP) AS 'nanosecond',
	   DATEPART(WEEK, CURRENT_TIMESTAMP) AS 'week',
	   DATEPART(WEEKDAY, CURRENT_TIMESTAMP) AS 'weekday',
	   DATEPART(DAYOFYEAR, CURRENT_TIMESTAMP) AS 'dayofyear'
     
     
