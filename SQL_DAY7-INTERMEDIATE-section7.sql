-- SECTION 7
    

USE Employee_db;
SELECT * FROM EMPLOYEE;
SELECT fname , lname FROM EMPLOYEE 

-- ALTERING TABLES.

    -- 7.1 HOW to add / remove a column ?
        ALTER TABLE EMPLOYEE
        ADD phone VARCHAR(15);

        ALTER TABLE EMPLOYEE
        DROP COLUMN phone;

    -- 7.2 How to modify a column ? (eg: changing datatype)

        /* How to change datatype of a column ?
            Now in EMPLOYEE TABLE you have lname of VARCHAR(50). You need to make it VARCHAR(100).
            
            TO VIEW STRUCTURE OF EXISTING EMPLOYEE TABLE : */  EXEC sp_help 'EMPLOYEE'; 
        ALTER TABLE EMPLOYEE
        ALTER COLUMN lname VARCHAR(100) NOT NULL;
    
    -- 7.3 How to rename a column or table name ?

        -- Change column name.
        EXEC sp_rename 
        'EMPLOYEE.fname','first_name','COLUMN';  -- revert  back to fname after running this command.

        -- change table name.
        EXEC sp_rename
        'EMPLOYEE','STAFF'; -- revert back changes after running this command.

-- ADD / DROP CONSTRAINT
    EXEC sp_help EMPLOYEE;

    -- ADD CONSTRAINT:
        -- ADD DEFAULT
        ALTER TABLE EMPLOYEE
        ADD CONSTRAINT default_dept DEFAULT 'Trainee'
        FOR department;

        -- Validation
        INSERT INTO EMPLOYEE
        (fname,lname,email,job_title,city)
        VALUES
        ('paul','philip','paul.philip@example.com','Fresher','Mumbai');

        -- ADD UNIQUE
        ALTER TABLE EMPLOYEE
        ADD UNIQUE (department);  -- THIS COMMAND Will throw error as in our  table we have many departments (duplicates). 
    
    --CHECK CONSTRAINT:
        -- insert dummy data (with negative salary)
        INSERT INTO EMPLOYEE
        (fname,lname,email,job_title,salary,city)
        VALUES
        ('Alex','John','alex.john@example.com','Fresher',-10000,'Mumbai');

        DELETE FROM EMPLOYEE WHERE emp_id = 121;

        -- Check Constraint.
            --METHOD 1:
            CREATE TABLE EMP(
                name varchar(50),
                salary DECIMAL(10,2) CHECK(salary>0)
            );

            --METHOD 2: NAMED CONSTRAINT.
            CREATE TABLE contacts(
                name VARCHAR(50),
                salary DECIMAL(10,2)
                CONSTRAINT chk_emp_positive_salary CHECK (salary>0)
            );

            -- EXAMPLE:
            ALTER TABLE EMPLOYEE
            ADD CONSTRAINT chk_emp_positive_sal CHECK(salary>0);

    -- DROP CONSTRAINT:
        ALTER TABLE EMPLOYEE
        DROP CONSTRAINT chk_emp_positive_sal;

        


    

