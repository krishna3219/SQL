-- SECTION 6
    -- STRING FUNCTIONS 

USE Employee_db;
SELECT * FROM EMPLOYEE;
SELECT fname , lname FROM EMPLOYEE 

    -- CONCAT.
    SELECT CONCAT ('HI','HELLO');
    SELECT CONCAT ('HI',' ', 'HELLO');
    SELECT CONCAT(fname, ' ', lname) AS full_name FROM EMPLOYEE;

    -- CONCAT_WS.
    -- One:Two:Three:Four
    SELECT CONCAT_WS(':','One','Two','Three','Four');
    SELECT CONCAT_WS(' ','One','Two','Three','Four');
    SELECT CONCAT_WS(',',emp_id,fname,lname,department) FROM EMPLOYEE;

    -- SUBSTRING.
    SELECT SUBSTRING('Hello Krishna',7,13); -- 7(start character) , 9 (end character)

    -- REPLACE.
    SELECT REPLACE ('Hey Buddy','Hey', 'Hello');
    SELECT  REPLACE (department,'Human Resource','HR') AS department FROM EMPLOYEE; -- REPLACE Human Resource with HR

    -- REVERSE.
    SELECT REVERSE('HELLO KRISHNA');  -- Reverse Function.

    --LENGTH. (LEN)
    SELECT LEN('SRIKRISHNA sharma');

    --UPPER & LOWER.
    SELECT UPPER('Hello World');
    SELECT LOWER('Hello World');

    -- LEFT & RIGHT.
    SELECT LEFT('Abcdefghij',3);
    SELECT RIGHT('Abcdefghij',4);

    -- TRIM
    SELECT TRIM('    Alright!   ');
	SELECT LTRIM('    Alright!    ');
	SELECT RTRIM('    Alright!     ');

    --CHARINDEX.
    SELECT CHARINDEX('om','Thomas');  -- Prints start index of the searching element.

    --TASK.
    -- 1. 101:Aarav:Sharma:Management
    SELECT CONCAT_WS(':',emp_id,fname,lname,department) FROM EMPLOYEE;

    --2. 102:Diya Patel:Tech:120000
    SELECT CONCAT_WS(':',emp_id,CONCAT(fname, ' ',lname),department,salary) FROM EMPLOYEE;

-- SECTION 7 
    -- DATE FUNCTIONS.

    SELECT  GETDATE();   -- GIVES Todays date and time.


	-- DATEADD() -syntax -  SELECT DATEADD(INTERVAL, NUMBER , DATE)  : INTERVAL can be , MONTH , YEAR, DAY
    SELECT DATEADD(YEAR, 2, GETDATE()) -- IF you need date , 2 years from today.
	SELECT DATEADD(MONTH , 3, GETDATE())

    --DATEDIFF(interval,start_date,end_Date)
    SELECT DATEDIFF(MONTH, '2025-07-31', GETDATE())
    SELECT DATEDIFF(DAY, '2025-07-31', GETDATE())

    --DATEPART(interval,date) / YEAR(DATE),MONTH(DATE) , DAY(DATE)
	SELECT DATEPART(MONTH, '12-11-2025');
    SELECT MONTH(GETDATE());
    SELECT YEAR(GETDATE());
    SELECT DAY(GETDATE());

    -- FORMAT(date, format_string)
    SELECT  FORMAT(GETDATE(), 'dd-MM-yyyy');

    -- USECASES.
    -- 1) FIND OUT EACH EMPLOYEES 5 YEAR ANNIVERSARY DATE.
        SELECT  hire_date, DATEADD(YEAR,5, hire_date) AS AnniversaryDate FROM EMPLOYEE;
    
    -- 2) Find Employees hired in march.
        SELECT * FROM EMPLOYEE WHERE MONTH(hire_date) = 3;

	-- 3) Show the Year , Month and Day each employee was hired separately
        SELECT *, YEAR(hire_date) AS H_year ,MONTH(hire_date) AS H_month ,DAY(hire_date) AS H_day 
        FROM EMPLOYEE;

    -- 4) Display Hire date in standard US format (MM/dd/yyyy)
        SELECT * , FORMAT(hire_date,'MM/dd/yyyy') AS H_Date_US_Format FROM EMPLOYEE;







    
