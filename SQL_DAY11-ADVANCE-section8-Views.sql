-- VIEWS

-- REFER TO TABLE CREATED IN SQL_DAY9_ADVANCE-section8-ManyToMany.sql
use institute_k;

-- check ur db.
SELECT DB_NAME();

-- VIEW all 3 tables

        SELECT * FROM courses
        SELECT * FROM students
        SELECT * FROM enrollment

-- CREATION OF VIEW
    CREATE VIEW vw_enrollment_details AS
    
    SELECT s.student_name,  c.course_name, e.enrollment_date, c.course_fee
    FROM enrollment e
    INNER JOIN students s ON e.student_id = s.student_id
    JOIN courses c ON e.course_id = c.course_id;

-- VIEW the data from view
    SELECT * FROM vw_enrollment_details

-- How to check existing views.
    SELECT TABLE_SCHEMA, TABLE_NAME
    FROM INFORMATION_SCHEMA.VIEWS;

-- How to check code of views.
    sp_helptext 'vw_enrollment_details'
        


