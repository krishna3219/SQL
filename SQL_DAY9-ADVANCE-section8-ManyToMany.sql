-- MANY TO MANY Relationship.

CREATE  DATABASE institute_k;
use institute_k;

    -- TABLE 1 COURSES
        CREATE TABLE courses ( 
        course_id INT IDENTITY(1,1) PRIMARY KEY, 
        course_name VARCHAR(100) NOT NULL, 
        course_fee NUMERIC(10, 2) NOT NULL 
        );

        --Data
        INSERT INTO courses(course_name, course_fee)
        VALUES
        ('Mathematics', 500.00),
        ('Physics', 600.00),
        ('Chemistry', 700.00);

        -- view
        SELECT * FROM courses;

    -- TABLE 2 STUDENTS
        CREATE TABLE students (
        student_id INT IDENTITY(1,1) PRIMARY KEY,
        student_name VARCHAR(100) NOT NULL
        );

        -- Data
        INSERT INTO students (student_name) VALUES
        ('Raju'),
        ('Sham'),
        ('Baburao'),
        ('Alex');

        -- view
        SELECT * FROM students

    -- TABLE 3  ENROLLMENT (junction table)
        CREATE TABLE enrollment(
        enrollment_id INT IDENTITY(1,1) PRIMARY KEY,
        student_id INT NOT NULL,
        course_id INT NOT NULL,
        enrollment_date DATE NOT NULL,
    
        FOREIGN KEY (student_id) REFERENCES students(student_id),
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
        );

        --Data
        INSERT INTO enrollment (student_id, course_id, enrollment_date)
        VALUES
        (1, 1, '2025-01-01'), -- Raju enrolled in Mathematics
        (1, 2, '2025-01-15'), -- Raju enrolled in Physics
        (2, 1, '2025-02-01'), -- Sham enrolled in Mathematics
        (2, 3, '2025-02-15'), -- Sham enrolled in Chemistry
        (3, 3, '2025-03-25'); -- Alex enrolled in Chemistry

        -- view
        SELECT * FROM enrollment

    -- VIEW all 3 tables

        SELECT * FROM courses
        SELECT * FROM students
        SELECT * FROM enrollment
        

    -- USECASE: TO GATHER DATA FROM ALL 3 TABLES.
        SELECT * FROM enrollment e
        INNER JOIN students s ON e.student_id = s.student_id
        INNER JOIN courses c ON e.course_id = c.course_id

        SELECT  s.student_name, c.course_name , e.enrollment_date , c.course_fee  FROM enrollment e
        INNER JOIN students s ON e.student_id = s.student_id
        INNER JOIN courses c ON e.course_id = c.course_id


