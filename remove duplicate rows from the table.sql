-- Write a sql query to eliminate the duplicate rows from the table and select only unique rows.

-- Table schema as below

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);


INSERT INTO employees (id, name, department, salary) VALUES 
    (1, 'Harsha', 'IT', 50000),
    (2, 'Kiran', 'HR', 60000),
    (3, 'Harsha', 'IT', 50000),
    (4, 'Mokshit', 'Finance', 65000),
    (5, 'Kiran', 'HR', 60000);


-- Solution

WITH duplicate_removal
AS (SELECT *,
           ROW_NUMBER() OVER (PARTITION BY name, department ORDER BY id) AS row_num
    FROM employees
   )
SELECT id,
       name,
       department,
       salary
FROM duplicate_removal
WHERE row_num = 1


-- Explanation
1. ROW_NUMBER() function assigns a unique number to each row within a partition, in this case the partition is defined by the name, department columns. 
2. ROW_NUMBER() function also allows us to specify an ORDER BY clause, which determines the order in which the rows are assigned numbers. In this query, the rows are ordered by the id column.
3. The outer SELECT statement selects only the rows where the "row_num" is 1, effectively removing any duplicate rows with the same name and department.


-- Input Dataset

id	  name	   department	  salary
1	    Harsha	    IT	      50000
2	    Kiran	      HR	      60000
3	    Harsha	    IT       	50000
4	    Mokshit	  Finance	    65000
5	    Kiran	      HR	      60000

-- Output Dataset
id	 name	    department	salary
1	   Harsha	     IT	      50000
2    Kiran	     HR	      60000
4	   Mokshit	 Finance	    65000

