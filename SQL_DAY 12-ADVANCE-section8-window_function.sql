-- SECTION 8: WINDOW FUNCTIONS

    -- view all databases in the server.
    SELECT NAME FROM sys.databases;

    -- view current database.
    SELECT DB_NAME();

    -- use employee_db database.
    USE Employee_db;

    -- view all tables in employee_db database.
    SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
    
    -- VIEW All data in employee table.
    SELECT * FROM EMPLOYEE;

    -- WINDOW FUNCTION USECASE: 

    -- Scenario 1: You want to compare of each employee's salary with total salary and find the percentage contribution of each employee to the total salary.
    SELECT emp_id, fname, salary, SUM(salary) OVER () AS Total_Salary, 
    CAST(salary * 100.0 / SUM(salary) OVER () AS DECIMAL(10,2)) AS Percentage_Contribution   
    FROM EMPLOYEE;

    -- Scenario 2: Compare each employee's salary to total salary in each department and find percentage contribution of each employee to total salary in their respective department.
    SELECT emp_id, fname , department, salary, SUM(salary) OVER(PARTITION BY department) AS Total_Salary_Department,
    CAST(salary * 100 / SUM(salary) OVER(PARTITION BY department) AS DECIMAL (10,2)) AS Percentage_Contribution_Department
    FROM EMPLOYEE;

    -- PREDEFINED WINDOW FUNCTIONS:
    -- ROW_NUMBER() , RANK() , DENSE_RANK() , NTILE(), LAG() , LEAD()

        -- Scenario 1: Add row number for each employee in table.
        -- ROW_NUMBER()
        SELECT  ROW_NUMBER() OVER (ORDER BY fname) AS Row_Num, emp_id, fname, department, salary 
        FROM EMPLOYEE;

        -- Scenario 2: Rank employees based on their salary from highest to lowest.
        -- RANK()
        SELECT RANK() OVER(ORDER BY salary DESC) AS Rank_Num, emp_id, fname, department, salary
        FROM EMPLOYEE;

        -- Scenario 3: Rank employees based on their salary from highest to lowest without skipping ranks.
        -- DENSE_RANK()
        SELECT DENSE_RANK() OVER(ORDER BY salary DESC) AS Dense_Rank_Num, emp_id, fname, department, salary 
        FROM EMPLOYEE;

        -- update employee table with some duplicate salaries to show the difference between RANK and DENSE_RANK.
        UPDATE EMPLOYEE
        SET salary = 95000
        WHERE emp_id = 110;  -- Kavy's salary updated to 95000 (same as Priya's salary)

        -- Now rerun the RANK and DENSE_RANK queries to see the difference in ranking for employees with same salary.

        -- Scenario 4: LAG() and LEAD()
        -- LAG() accesses the previous row data
        SELECT emp_id, fname, salary, LAG(salary) OVER (ORDER BY salary DESC) AS Previous_Salary
        FROM EMPLOYEE;

        -- LEAD() accesses the next row data
        SELECT emp_id, fname, salary, LEAD(salary) OVER (ORDER BY salary DESC) AS Next_Salary
        FROM EMPLOYEE;
