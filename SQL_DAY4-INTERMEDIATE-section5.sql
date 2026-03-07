-- SECTION 5
USE Employee_db;
SELECT * FROM EMPLOYEE;
-- 5.1 AGGREGATE FUNCTIONS : COUNT, SUM, MIN , MAX , AVG
    -- 1) COUNT:
    SELECT  COUNT(emp_id) as Total_employees FROM EMPLOYEE;

    -- 2)  MIN:
    SELECT MIN(Salary) AS Minimum_salary FROM EMPLOYEE;

    --3) MAX:
    SELECT MAX(Salary) AS Maximum_salary FROM EMPLOYEE;

    --4) AVG:
    SELECT AVG(Salary) AS Average_salary FROM EMPLOYEE;

    --5) SUM:
    SELECT SUM(Salary) AS Total_salary FROM EMPLOYEE;

-- 5.2 GROUP BY:
    -- USECASE 1 - Find number of employees in each department.
    SELECT department FROM EMPLOYEE GROUP BY department;

    SELECT department, COUNT(emp_id) AS count FROM EMPLOYEE GROUP BY department;

    -- USECASE 2 - Find  number of employees in each city.
    SELECT city , COUNT(emp_id) AS COUNT FROM EMPLOYEE GROUP BY city;

    -- USECASE 3 - Find average salary in each department.
    SELECT  department , AVG(salary) AS Average_salary FROM EMPLOYEE GROUP BY department;

    -- MULTI COLUMN GROUPING: ( EG har dept me har city ke kitne log hai  unka data  nikalna)
    SELECT  department , city, count(emp_id) AS employee_count FROM EMPLOYEE GROUP BY department,city ORDER BY department;

-- Having:
    -- Find departments with  more than 2 employees.
    SELECT department , COUNT(emp_id) AS Emp_Count FROM EMPLOYEE GROUP BY (department) HAVING COUNT(emp_id) >2;

    -- Find Job titles with an average salary above  90000.
    SELECT job_title, AVG(salary) AS Average_salary FROM EMPLOYEE GROUP BY job_title HAVING AVG(salary) > 90000;

    -- Find department with Total salary above 300000.
    SELECT  department , SUM(salary) AS Total_salary FROM EMPLOYEE GROUP BY department HAVING SUM(Salary) > 200000;

-- GROUP BY ROLLUP
    -- Find departments with  more than 2 employees.
    SELECT department , COUNT(emp_id) AS Emp_Count 
    FROM EMPLOYEE 
    GROUP BY ROLLUP (department) HAVING COUNT(emp_id) > 2; 


    -- USE CASE: 
    -- Employee Headcount by City and Department.
    -- You want a report showing the number of employees for each city within each department, a subtotal for each department, and a grand total for the entire company.
    SELECT COALESCE(city,'Grand Total') AS city , COALESCE (department,'Total') AS department , COUNT(emp_id) AS emp_count
    FROM EMPLOYEE
    GROUP BY ROLLUP(city,department);

-- 5.3 SUB QUERIES:

    -- USECASES:
    -- 1) Find employees earning more than the company average.
    SELECT * FROM EMPLOYEE WHERE Salary > (SELECT  AVG(Salary) FROM EMPLOYEE); -- SINGLE ROW SUB QUERY

	-- 2) Find employees who work in departments  with atleast one person in Mumbai.
    SELECT  *
    FROM EMPLOYEE
    WHERE department IN (
        SELECT department                                                         --Multi Row Sub query
        FROM EMPLOYEE
        WHERE city = 'Mumbai'      
    );

    -- 3) Find employees with highest salary in each department.
	SELECT * FROM EMPLOYEE e1 WHERE salary = (
    SELECT MAX(salary) 
    FROM EMPLOYEE e2                                                              -- Correlated Subquery
    WHERE e2.department = e1.department);


    SELECT * FROM EMPLOYEE WHERE
    salary IN (SELECT MAX(Salary) FROM E,[EMPLOYEE] GROUP BY department)              -- Groupby method.


    -- 4) Find department whose average salary is above 90000.
    SELECT department, avg_salary 
    FROM ( SELECT department , AVG(salary) AS avg_salary                          -- inline view subquery
            FROM employee
            GROUP BY department) 
    AS department_average                           -- department_average -> temp table name 
    WHERE avg_salary > 90000;
    









