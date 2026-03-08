-- SECTION 8:WINDOW FUNCTIONS

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
    -- ROW_NUMBER() , RANK() , DENSE_RANK() , NTILE(), LAG() , LEAD(), FIRST_VALUE(), LAST_VALUE()

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
            -- Compare employee's salary with previous hire employe
            SELECT emp_id, fname, hire_date, salary, LAG(salary) OVER(ORDER BY hire_date) AS Previous_Hire_Salary
            FROM EMPLOYEE;

        -- LEAD() accesses the next row data
        SELECT emp_id, fname, salary, LEAD(salary) OVER (ORDER BY salary DESC) AS Next_Salary
        FROM EMPLOYEE;

        -- Scenario 5: Rank employees within each department based on salary.
        SELECT emp_id, fname, department, salary, RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS Department_Rank
        FROM EMPLOYEE;

        -- Scenario 6: Calculate a Running total of salary budget in each department.
            SELECT emp_id, fname, department, salary , SUM(salary) OVER (PARTITION BY department ORDER BY salary, emp_id) AS Running_Total_Salary_Department
            FROM EMPLOYEE;

            -- ROWS BETWEEN: (More preferred for running total as it considers physical rows)
            SELECT emp_id, fname, department, salary, SUM(salary) OVER (ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total_Salary
            FROM EMPLOYEE; 

            -- RANGE BETWEEN:
            SELECT emp_id, fname, department, salary, SUM(salary) OVER (ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total_Salary
            FROM EMPLOYEE;

        -- ADVANCED USECASE: Calculate 3 Row Moving Average
          -- Calculate the average salary of the current employee , one hired just before and one hired just after the current employee based on hire date.

          SELECT fname, hire_date, salary, 
          AVG(salary) OVER(
                ORDER BY hire_date
                ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
                ) AS 3ROW_Average_Salary
          FROM EMPLOYEE;
          
         /* AGGREGATE_FUNCTION() OVER (
                PARTITION BY ...
                ORDER BY ...
                ROWS BETWEEN <start_boundary> AND <end_boundary>
            )

            The power of ROWS BETWEEN comes from defining the start and end of your frame.
            The most common boundaries are:

            • CURRENT ROW: The row being processed right now.

            • UNBOUNDED PRECEDING: All rows before the current row in the partition.

            • UNBOUNDED FOLLOWING: All rows after the current row in the partition.

            • n PRECEDING: A specific number (n) of rows before the current row.

            • n FOLLOWING: A specific number (n) of rows after the current row.
         */
        
        -- FIRST_VALUE()
        SELECT fname, department,
        FIRST_VALUE(fname) OVER (
            PARTITION BY department
            ORDER BY fname) AS First_Employee_Department
        FROM EMPLOYEE;

        -- LAST_VALUE()
        SELECT fname, department,
        LAST_VALUE(fname) OVER (
            PARTITION BY department
            ORDER BY fname
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING  -- MUST LINE TO GET THE CORRECT LAST VALUE IN THE PARTITION
            ) AS Last_Employee_Department
        FROM EMPLOYEE;

        --  NTILE()
        -- Distributes rows in an ordered partition into a specified number of groups (buckets) and assigns a group number to each row.
        -- For example, if you want to divide employees into 4 salary quartiles based on salary.
        SELECT emp_id, fname, salary,
        NTILE(4) OVER (ORDER BY salary DESC) AS Salary_Quartile
        FROM EMPLOYEE;

        -- usecase: find top , middle and bottom 3 employees based on salary of each department.
        SELECT emp_id, fname, department, salary,
        NTILE(3) OVER (PARTITION BY department ORDER BY salary DESC) AS Salary_Tertile_Department
        FROM EMPLOYEE;

        
            
            
