-- SECTION 8
    -- WINDOW FUNCTIONS

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



