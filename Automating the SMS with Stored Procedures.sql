-- Automating the Student Management System with Stored Procedures

-- Description: This project demonstrates how stored procedures can be used to automate and simplify database operations 
-- in a Student Management System (SMS). The goal is to improve efficiency, maintainability, and security by 
-- encapsulating repetitive SQL tasks into reusable procedures.

-- =============================================

-- Below are stored procedures that answer specific operational questions related to managing students, courses, 
-- instructors, and enrollments.

-- =============================================


-- 1. How can we quickly add a new student to the system with all their details?

CREATE PROCEDURE new_students(
	p_Student_ID varchar(5), 
	p_Name varchar, 
	p_Gender varchar, 
	p_DOB date, 
	p_Department_ID varchar)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO Students (Student_ID, Name, Gender, DOB, Department_ID)
	VALUES(p_Student_ID, p_Name, p_Gender, p_DOB, p_Department_ID);
END;
$$;

CALL new_students('ST051', 'Aisha Bello', 'Female', '2003-05-14', 'DT001');
CALL new_students('ST052', 'Jimoh Fawziyyah', 'Female', '2001-12-21', 'DT003');


-- To see the updated student table,
SELECT * 
FROM Students;


-- =============================================


-- 2. How can we enroll a student into a specific course efficiently?
CREATE PROCEDURE new_enrollments(
	p_Enrollment_ID varchar(5),
	p_Student_ID varchar(5),
	p_Course_ID varchar(5),
	P_Enrollment_Date date)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO enrollments(Enrollment_ID, Student_ID, Course_ID, Enrollment_Date)
	VALUES(p_Enrollment_ID, p_Student_ID, p_Course_ID, p_Enrollment_Date);
END;
$$

CALL new_enrollments('EN101', 'ST051', 'CS003', '2023-10-20');
CALL new_enrollments('EN102', 'ST052', 'CS001', '2023-10-20');


-- To see the updated enrollment table,
SELECT * 
From enrollments;


-- =============================================


-- 3. How can we get a list of all students enrolled in a specific course?

-- Using Procedures
CREATE PROCEDURE student_and_courses
	(p_course_id VARCHAR(5))
LANGUAGE plpgsql
AS $$
BEGIN
	-- Return all students enrolled in a specific course
	SELECT s.student_id, s.name, e.course_id, e.enrollment_id
	FROM Students AS s
	JOIN enrollments AS e
		ON s.student_id = e.student_id
	WHERE p_course_id = e.course_id;
END;
$$

CALL student_and_courses('CS002');


-- Using Functions
CREATE FUNCTION students_and_courses
	(p_course_id VARCHAR(5))
RETURNS TABLE (
    student_id VARCHAR(5),
    name VARCHAR,
    course_id VARCHAR(5),
    enrollment_id VARCHAR(5)
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	-- Return all students enrolled in a specific course
	SELECT s.student_id, s.name, e.course_id, e.enrollment_id
	FROM Students AS s
	JOIN enrollments AS e
		ON s.student_id = e.student_id
	WHERE p_course_id = e.course_id;
END;
$$

SELECT *
FROM students_and_courses('CS002');


-- =============================================


-- 4. Which students are being taught by a particular instructor?

-- Using Procedures
CREATE PROCEDURE student_and_instructors
	(p_student_id VARCHAR(5))
LANGUAGE plpgsql
AS $$
BEGIN
	--Returns all students and their instructors 
	SELECT s.student_id, s.name AS student_name, i.name AS instructor_name, c.course_id, c.course_name
	FROM students AS s
	JOIN enrollments AS e
		ON s.student_id = e.student_id
	JOIN courses AS c
		ON c.course_id = e.course_id
	JOIN courseinstructors AS ci
		ON ci.course_id = c.course_id
	JOIN instructors AS i
		ON i.instructor_id = ci.instructor_id
	WHERE s.student_id = p_student_id;
END;
$$

CALL student_and_instructors ('ST002');


-- Using Functions
CREATE FUNCTION students_and_instructors
	(p_student_id VARCHAR(5))
RETURNS TABLE (
	student_id VARCHAR(5), 
	student_name VARCHAR,
	instructor_name VARCHAR,
	course_id VARCHAR(5), 
	course_name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	--Returns all students and their instructors 
	SELECT s.student_id, s.name AS student_name, i.name AS instructor_name, c.course_id, c.course_name
	FROM students AS s
	JOIN enrollments AS e
		ON s.student_id = e.student_id
	JOIN courses AS c
		ON c.course_id = e.course_id
	JOIN courseinstructors AS ci
		ON ci.course_id = c.course_id
	JOIN instructors AS i
		ON i.instructor_id = ci.instructor_id
	WHERE s.student_id = p_student_id;
END;
$$

SELECT *
FROM students_and_instructors ('ST002');


-- =============================================


-- 5. How can we update a student’s contact information automatically?

-- Firstly, we are going to alter the students' table and append the student's phone number to a new column.
ALTER TABLE students
ADD COLUMN phone_number VARCHAR(12);

-- 	Creating a temporary table to house the phone numbers.
CREATE TEMP TABLE student_numbers (
	student_id VARCHAR(5), 
	phone_number VARCHAR(12)
);

INSERT INTO student_numbers
VALUES('ST001', '08031234561'),
	  ('ST002', '08124567892'),
	  ('ST003', '07063451209'),
	  ('ST004', '09027896543'),
	  ('ST005', '08051234980'),
	  ('ST006', '08167345902'),
	  ('ST007', '07019876542'),
	  ('ST008', '09052347890'),
	  ('ST009', '08074213569'),
	  ('ST010', '08129475630'),
	  ('ST011', '07084561293'),
	  ('ST012', '09067543012'),
	  ('ST013', '08092874351'),
	  ('ST014', '08173549026'),
	  ('ST015', '07023458917'),
	  ('ST016', '09085437219'),
	  ('ST017', '08061293475'),
	  ('ST018', '08194576023'),
	  ('ST019', '07037584916'),
	  ('ST020', '09076341258'),
	  ('ST021', '08092563147'),
	  ('ST022', '08150372894'),
	  ('ST023', '07028475903'),
	  ('ST024', '09061234870'),
	  ('ST025', '08078452319'),
	  ('ST026', '08193457620'),
	  ('ST027', '07014689523'),
	  ('ST028', '09028765134'),
	  ('ST029', '08062347918'),
	  ('ST030', '08184576129'),
	  ('ST031', '07097351428'),
	  ('ST032', '09078451326'),
	  ('ST033', '08031249758'),
	  ('ST034', '08127893410'),
	  ('ST035', '07058934271'),
	  ('ST036', '09031876420'),
	  ('ST037', '08067451239'),
	  ('ST038', '08173645920'),
	  ('ST039', '07041239875'),
	  ('ST040', '09081234597'),
	  ('ST041', '08058934127'),
	  ('ST042', '08190347265'),
	  ('ST043', '07076234891'),
	  ('ST044', '09025673918'),
	  ('ST045', '08019458723'),
	  ('ST046', '08134756920'),
	  ('ST047', '07056481937'),
	  ('ST048', '09084572316'),
	  ('ST049', '08093576148'),
	  ('ST050', '08174593210'),
	  ('ST051', '07068451297'),
	  ('ST052', '09013487529');

-- Populating the students' phone number column...
UPDATE Students AS s
SET phone_number = sn.phone_number
FROM student_numbers AS sn
WHERE s.student_id = sn.student_id;

SELECT *
FROM students;

-- To update a student’s contact information automatically,
CREATE PROCEDURE update_student_contact
	(p_student_id VARCHAR(5),
	 P_phone_number VARCHAR(100))
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE students
	SET phone_number = p_phone_number
	WHERE student_id = p_student_id;
END;
$$

CALL update_student_contact ('ST001', '08116463286');

-- To see the updated students table,
SELECT *
FROM students
ORDER BY student_id ASC;


-- =============================================


-- 6. What courses is a specific student currently enrolled in?

-- Using Procedures
CREATE PROCEDURE course_and_students
	(p_student_id VARCHAR(5))
LANGUAGE plpgsql
AS $$
BEGIN
	-- Returns all courses enrolled by a specific student
	SELECT s.student_id, s.name, c.course_id, c.course_name
	FROM students AS s
	JOIN enrollments AS e
		ON s.student_id = e.student_id
	JOIN courses AS c
		ON c.course_id = e.course_id
	WHERE p_student_id = s.student_id;
END;
$$
	
CALL course_and_students ('ST032');


-- Using Functions
CREATE FUNCTION courses_and_students
	(p_student_id VARCHAR(5))
RETURNS TABLE(
	student_id VARCHAR (5), 
	student_name VARCHAR, 
	course_id VARCHAR(5), 
	course_name VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	-- Returns all courses enrolled by a specific student
	SELECT s.student_id, s.name AS student_name, c.course_id, c.course_name
	FROM students AS s
	JOIN enrollments AS e
		ON s.student_id = e.student_id
	JOIN courses AS c
		ON c.course_id = e.course_id
	WHERE p_student_id = s.student_id;
END;
$$

SELECT *
FROM courses_and_students ('ST032');


-- =============================================


-- 7. How do we retrieve a summary of enrollment counts per course?

-- Using Procedures
CREATE PROCEDURE summary_enrollment
	(p_course_id VARCHAR(5))
LANGUAGE plpgsql
AS $$
BEGIN
	-- Returns total enrollments per course
	SELECT c.course_id, c.course_name, COUNT(e.enrollment_id) AS Total_Enrollments
	FROM enrollments AS e
	JOIN courses AS c
		ON e.course_id = c.course_id
	WHERE p_course_id = c.course_id
	GROUP BY c.course_id, c.course_name;
END;
$$

CALL summary_enrollment ('CS005');


-- Using Functions
CREATE FUNCTION summary_enrollmentS
	(p_course_id VARCHAR(5))
RETURNS TABLE(
	course_id VARCHAR(5),
	course_name VARCHAR,
	Total_Enrollments BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
	-- Returns total enrollments per course
	SELECT c.course_id, c.course_name, COUNT(e.enrollment_id) AS Total_Enrollments
	FROM enrollments AS e
	JOIN courses AS c
		ON e.course_id = c.course_id
	WHERE p_course_id = c.course_id
	GROUP BY c.course_id, c.course_name;
END;
$$

SELECT *
FROM summary_enrollments ('CS005');