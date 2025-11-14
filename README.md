# Automating-Student-management-system-with-Stored-procedures
This Projects focuses on creating stored procedures to automate tasks and increase efficiency in the SMS database environment 

📚 Automating the Student Management System (SMS) with Stored Procedures
🌟 Project Overview
This project demonstrates the powerful use of Stored Procedures and Functions in a PostgreSQL database to automate and simplify common database operations within a Student Management System (SMS).
By encapsulating complex or repetitive SQL logic into reusable routines, this project achieves:
 * Efficiency: Faster execution of multi-step database tasks.
 * Maintainability: Easier updates and bug fixes for core logic.
 * Security: Reduced exposure to SQL injection risks.
🛠️ Technology Stack
| Component | Detail |
|---|---|
| Database | PostgreSQL |
| Language | SQL (using the plpgsql procedural language) |
| Focus | Stored Procedures and Functions |
🚀 Key Automation Features
The provided SQL script addresses several core operational questions for managing the SMS database. Each feature is implemented using both Stored Procedures (CALL) and, where appropriate, Functions (SELECT * FROM).
1. Student & Enrollment Management
| Feature | Procedure/Function Names | Description |
|---|---|---|
| Add New Student | new_students | Quickly inserts a new student record into the Students table. |
| Enroll Student | new_enrollments | Efficiently enrolls a student into a specific course. |
| Update Contact | update_student_contact | Automatically updates a student's phone number. |
2. Retrieval & Reporting
| Feature | Procedure/Function Names | Description |
|---|---|---|
| Students in a Course | student_and_courses / students_and_courses | Retrieves all students currently enrolled in a specified course. |
| Courses per Student | course_and_students / courses_and_students | Lists all courses a specific student is currently enrolled in. |
| Instructor Details | student_and_instructors / students_and_instructors | Identifies which instructor(s) are teaching a specific student's courses. |
| Enrollment Summary | summary_enrollment / summary_enrollments | Calculates the total enrollment count for a given course. |
📖 Installation and Usage
To run this SQL script, you must have a PostgreSQL database configured with the necessary tables (Students, Enrollments, Courses, Instructors, CourseInstructors, etc.).
Prerequisites
 * A running PostgreSQL instance.
 * A SQL client (like pgAdmin or DBeaver) or the psql command-line tool.
Setup Steps
 * Clone the Repository:
https://github.com/TimmyX27/Automating-Student-management-system-with-Stored-procedures/edit/main/README.md

 * Connect to your PostgreSQL Database.
 * Execute the Script:
   Run the contents of the Automating the SMS with Stored Procedures.sql file. This will create all the procedures and functions defined in the file.
   Note: The script also includes temporary table creation and UPDATE statements to populate a phone_number column for demonstration purposes.
Example Usage
Once the procedures are created, you can call them directly:
| Task | SQL Command Example |
|---|---|
| Add a New Student | CALL new_students('ST053', 'New User', 'Male', '2000-01-01', 'DT002'); |
| Check Student's Courses | SELECT * FROM courses_and_students('ST002'); |
| Update Contact Info | CALL update_student_contact('ST001', '08116463286'); |
🤝 Contributing
If you have suggestions for further automation or optimization of the stored procedures, feel free to open an issue or submit a pull request!
