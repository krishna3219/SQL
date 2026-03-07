-- SECTION 4 : Getting the data you really need

    SELECT * FROM EMPLOYEE;
-- 4.1: CLAUSES
    -- WHERE
    SELECT * FROM EMPLOYEE
    WHERE emp_id =105;

    --• Find employees in the IT department
    SELECT * FROM EMPLOYEE
    WHERE department ='Tech';

    --• Find employees with salary above 50,000
    SELECT * FROM EMPLOYEE
    WHERE salary > 50000;

    --• Find employees hired after 2020
    SELECT * FROM EMPLOYEE
    WHERE Hire_date > '2020-12-31'

    --• Find employees whose department is not HR
    SELECT * FROM EMPLOYEE
    WHERE department != 'Human Resources';

    -- DISTINCT
    SELECT DISTINCT department FROM EMPLOYEE;

    SELECT DISTINCT city FROM EMPLOYEE;

    -- ORDER BY
    SELECT * FROM EMPLOYEE ORDER BY Salary;

	SELECT * FROM EMPLOYEE ORDER BY Salary DESC ;

    SELECT * FROM EMPLOYEE ORDER BY department,lname; -- ORDER BY ON MULTIPLE COLUMNS

    -- LIKE
    SELECT  * FROM EMPLOYEE WHERE fname LIKE 'a%';  -- Employees whose first name starts with A/a

	SELECT  * FROM EMPLOYEE WHERE fname LIKE '[abcde]%'; -- Employees whose  name start with A, B ,C, D,E

	SELECT  * FROM EMPLOYEE WHERE fname LIKE '[^a]%';  -- employees whose name does not start with a.

    SELECT  * FROM EMPLOYEE WHERE lname LIKE '%a';  -- Employees whose last name ends with A/a.

	SELECT email FROM EMPLOYEE WHERE email LIKE '%gupta%'; -- email contains 'gupta'.

	SELECT * FROM EMPLOYEE WHERE fname LIKE '_a%' -- employees who contain 'a' as second letter in their name.

	-- TOP
    SELECT TOP 3 * FROM EMPLOYEE ORDER BY Salary DESC;  -- top 3 HIGHEST paid employees.

    SELECT TOP 5 * FROM EMPLOYEE ORDER BY Hire_date DESC; -- TOP 5 RECENTLY hired employees.

    SELECT TOP 1  * FROM EMPLOYEE WHERE department = 'Marketing' ORDER BY hire_date DESC -- Top 1 latest hire employee  from marketing 


    -- Exercise:
        --1: Find Different type of departments in database?
        SELECT DISTINCT department FROM EMPLOYEE;

        --2: Display records with High-low salary
        SELECT * FROM EMPLOYEE ORDER BY Salary DESC;

        --3: How to see only top 3 records from a table?
        SELECT  TOP 3 * FROM EMPLOYEE;

        --4: Show records where first name start with letter 'A'
        SELECT  * FROM EMPLOYEE WHERE fname LIKE 'A%';

        --5: Show records where length of the lname is 4 characters
        SELECT * FROM EMPLOYEE WHERE lname LIKE  '____'
		

-- 4.2: LOGICAL OPERATORS.
    -- 1) AND
    SELECT * FROM EMPLOYEE WHERE salary = 75000 AND department = 'Sales';

    SELECT * FROM EMPLOYEE WHERE salary = 75000 AND department = 'Tech';


    --2) OR
	SELECT * FROM EMPLOYEE WHERE salary = 75000 OR department = 'Sales';

    SELECT * FROM EMPLOYEE WHERE salary = 75000 OR department = 'Tech';

	SELECT * FROM EMPLOYEE WHERE city = 'Mumbai' OR department = 'Tech'; 

-- 4.3: IN | NOT IN | BETWEEN

    -- IN: Find employees from following department  -  Tech , Sales , Marketing.
    SELECT * FROM EMPLOYEE WHERE department IN ('Marketing','Tech','Sales');

        --or (OPTIONAL)
        SELECT  * FROM EMPLOYEE WHERE department = 'Marketing' OR department ='Tech' OR department = 'Sales';

    -- BETWEEN: Find employees whose salary is more than 60000  and less than 65000.
    SELECT * FROM EMPLOYEE WHERE Salary BETWEEN 60000 AND 650000;

        --or (Optional)
        SELECT  * FROM EMPLOYEE WHERE Salary >= 60000 AND  Salary <= 65000; 

    -- NOT IN: 
    SELECT * FROM EMPLOYEE WHERE department NOT IN ('Marketing','Tech','Sales');
    
-- ADDITIONALTOPIC:  CASE (Conditional Expression)










    


