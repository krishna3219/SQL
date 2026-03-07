-- Comment : This is the first SQL Command

-- Listing existing databases.
select name from sys.databases;
GO

exec sp_databases;
Go

SELECT name, database_id, state_desc
FROM sys.databases;
Go


-- =======================================================xx=====================================

--CREATING A NEW DATA BASE

 CREATE DATABASE school_db;
 CREATE DATABASE K_WASTE;

 -- Selecting a Database
 USE school_db;
 SELECT DB_NAME();

 -- DELETING A DATABASE
 DROP DATABASE K_WASTE;

 -- ================================================================================================================

 -- ****************CRUD:*********************

 -- 1) CREATING TABLE
    CREATE TABLE students (
	student_id INT,
	name VARCHAR(100),
	age INT,
	grade INT
	);


-- CHECKING YOUR TABLE
	EXEC sp_help 'students';


-- INSERTING data into TABLE
	INSERT INTO students(student_id,name,age,grade) 
	VALUES(101,'Raju',10,5),(102,'Shyam',12,7),(103,'Baburao',14,9);

	INSERT INTO students VALUES (104,'Paul',11,6);

-- 2) READING DATA
	SELECT * FROM students;
    -- Reading specific column data :
		SELECT name FROM students;


-- 3)  UPDATING DATA
	UPDATE students
	SET grade = 12
	WHERE student_id = 103;


-- 4) DELETING A DATA
       DELETE FROM students
	   WHERE student_id = 104;

	   -- USE DELETE TO DELETE ENTIRE TABLE ?
	       DELETE FROM students;
		   DELETE FROM students 
		   WHERE 1=1;

-- 5) TRUNCATE TABLE :
     TRUNCATE TABLE students;


--XXXXXXXXXXXXXXXXXXXXXXXXXXXXX EXERCISE XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

-- 1) Write a query to change grade of Raju from 5 to 6.
	  UPDATE students
	  SET grade = 6
	  WHERE student_id = 101;

-- 2) Add a student to the table : (104,'Alex',11,6)
      INSERT INTO students VALUES  (104,'Alex',11,6);

-- 3) Write a query to remove Baburao from table
		DELETE FROM students
		WHERE student_id = 103;

-- 4) Write a query to retrieve only the details for the student named shyam.
		SELECT * FROM students
		WHERE name = 'shyam';

-- 5) Write a query to print / get age of raju ?
		SELECT age FROM students
		WHERE name = 'Raju';

SELECT * FROM students;
