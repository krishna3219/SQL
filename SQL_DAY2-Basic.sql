-- DAY 2 

USE school_db;
SELECT * FROM students;

UPDATE 
-- MODULE 3

-- 1) DATATYPES 
  -- NUMERIC - INT , DECIMAL(5,2) , FLOAT 
  -- STRING  - CHAR, VARCHAR , NVARCHAR
  -- DATE - DATE , DATETIME
  -- BOOLEAN - BIT


-- 2) CONSTRAINTS ( Decides which kind of data is allowed in a column)
	-- PRIMARY KEY:
	-- UNIQUE
	-- NOT NULL
	-- DEFAULT
	-- IDENTITY

   -- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   -- TASK:
   -- � emp_id set as primary key and its value should be auto-increment by 1 starting from 101.
	-- � Email should be Unique
	-- � Null value should not be allowed in
	--   > fname, lname, email, job_title
	-- � Salary column � default set to 30,000 if not provided
	-- � Hire_date � default set to today�s date

 
  -- SOL:
  CREATE DATABASE Employee_db;
   USE Employee_db;

   SELECT DB_NAME();
 --=====================
   CREATE TABLE EMPLOYEE 
   (
     emp_id INT IDENTITY (101,1) PRIMARY KEY,
	 fname VARCHAR(50) NOT NULL,
	 lname VARCHAR(50) NOT NULL,
	 email  VARCHAR(100) NOT NULL UNIQUE,
	 job_title VARCHAR(50) NOT NULL,
	 department VARCHAR(50),
	 salary INT DEFAULT 30000,
	 hire_date DATE DEFAULT GETDATE(),
	 city VARCHAR(30) 
   );
   
   EXEC  sp_help EMPLOYEE;

	INSERT INTO EMPLOYEE
	(fname, lname, email, job_title, department, salary, hire_date, city)
	VALUES
	('Aarav', 'Sharma', 'aarav.sharma@example.com', 'Director', 'Management', 180000, '2019-02-10', 'Mumbai'),
	('Diya', 'Patel', 'diya.patel@example.com', 'Lead Engineer', 'Tech', 120000, '2020-08-15', 'Bengaluru'),
	('Rohan', 'Mehra', 'rohan.mehra@example.com', 'Software Engineer', 'Tech', 85000, '2022-05-20', 'Bengaluru'),
	('Priya', 'Singh', 'priya.singh@example.com', 'HR Manager', 'Human Resources', 95000, '2019-11-05', 'Mumbai'),
	('Arjun', 'Kumar', 'arjun.kumar@example.com', 'Data Scientist', 'Tech', 110000, '2021-07-12', 'Hyderabad'),
	('Ananya', 'Gupta', 'ananya.gupta@example.com', 'Marketing Lead', 'Marketing', 90000, '2020-03-01', 'Delhi'),
	('Vikram', 'Reddy', 'vikram.reddy@example.com', 'Sales Executive', 'Sales', 75000, '2023-01-30', 'Mumbai'),
	('Sameera', 'Rao', 'sameera.rao@example.com', 'Software Engineer', 'Tech', 88000, '2023-06-25', 'Pune'),
	('Ishaan', 'Verma', 'ishaan.verma@example.com', 'Recruiter', 'Human Resources', 65000, '2022-09-01', 'Mumbai'),
	('Kavya', 'Joshi', 'kavya.joshi@example.com', 'Product Designer', 'Design', 92000, '2021-04-18', 'Bengaluru'),
	('Zain', 'Khan', 'zain.khan@example.com', 'Sales Manager', 'Sales', 115000, '2019-09-14', 'Delhi'),
	('Nisha', 'Desai', 'nisha.desai@example.com', 'Jr. Data Analyst', 'Tech', 70000, '2024-02-01', 'Hyderabad'),
	('Aditya', 'Nair', 'aditya.nair@example.com', 'Marketing Analyst', 'Marketing', 68000, '2022-10-10', 'Delhi'),
	('Fatima', 'Ali', 'fatima.ali@example.com', 'Sales Executive', 'Sales', 78000, '2022-11-22', 'Mumbai'),
	('Kabir', 'Shah', 'kabir.shah@example.com', 'DevOps Engineer', 'Tech', DEFAULT ,'2020-12-01', 'Pune');

	SELECT * FROM EMPLOYEE;

	INSERT INTO EMPLOYEE (fname, lname, email, job_title, department, salary, hire_date, city)
	VALUES
	('SriKrishna','Sharma','Srikrishna.Sharma@example.com', 'Solution Architect', 'Tech' , 150000, DEFAULT , 'Delhi');

	--  TESTING
	INSERT INTO EMPLOYEE (emp_id,fname, lname, email, job_title, department, city)
	VALUES
	(116,'Rahul','Jha','Srikrishna.Sharma@example.com', 'Solution Architect', 'Tech' , 'Delhi');
	-- ERROR: "Cannot insert explicit value for identity column in table 'EMPLOYEE' when IDENTITY_INSERT is set to OFF"

	INSERT INTO EMPLOYEE (fname, lname, email, job_title, department, city)
	VALUES
	('Rahul','Jha','Srikrishna.Sharma@example.com', 'Solution Architect', 'Tech' , 'Delhi');
	-- ERROR: "Violation of UNIQUE KEY constraint 'UQ__EMPLOYEE__AB6E616434774387'. Cannot insert duplicate key in object 'dbo.EMPLOYEE'. The duplicate key value is (Srikrishna.Sharma@example.com)"

	INSERT INTO EMPLOYEE (fname, lname, email, job_title, department, city)
	VALUES
	('Rahul','Jha','rahul.sharma@example.com', 'Solution Architect', 'Tech' , 'Delhi');
	-- Success.

	DELETE FROM EMPLOYEE 
	WHERE emp_id = 119;























   
  