-- 1. How can we quickly add a new student to the system with all their details?
CALL new_students('ST051', 'Aisha Bello', 'Female', '2003-05-14', 'DT001');
CALL new_students('ST052', 'Jimoh Fawziyyah', 'Female', '2001-12-21', 'DT003');

-- To see the updated student table,
SELECT * 
FROM Students;


-- ========================================================


-- 2. How can we enroll a student into a specific course efficiently?
CALL new_enrollments('EN101', 'ST051', 'CS003', '2023-10-20');
CALL new_enrollments('EN102', 'ST052', 'CS001', '2023-10-20');

-- To see the updated enrollment table,
SELECT * 
From enrollments;


-- ========================================================


-- 3. How can we get a list of all students enrolled in a specific course?
-- Using Procedures
CALL student_and_courses('CS002');

-- Using Functions
SELECT *
FROM students_and_courses('CS002');


-- ========================================================


-- 4. Which students are being taught by a particular instructor?
-- Using Procedures
CALL student_and_instructors ('ST002');

-- Using Functions
SELECT *
FROM students_and_instructors ('ST002');


-- ========================================================


-- 5. How can we update a student’s contact information automatically?
CALL update_student_contact ('ST001', '08116463286');

-- To see the updated students table,
SELECT *
FROM students
ORDER BY student_id ASC;


-- ========================================================


-- 6. What courses is a specific student currently enrolled in?
-- Using Procedures
CALL course_and_students ('ST032');

-- Using Functions
SELECT *
FROM courses_and_students ('ST032');


-- ========================================================


-- 7. How do we retrieve a summary of enrollment counts per course?
-- Using Procedures
CALL summary_enrollment ('CS005');

-- Using Functions
SELECT *
FROM summary_enrollments ('CS005');