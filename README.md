# StudentManagementSystem

# Student Management System in SQL Server to analyze academic performance using joins, views, procedures, and optimized queries.

##  Overview

This project simulates a **Student Management System** using SQL Server. It is designed to manage and analyze student data, course enrollments, grades, and academic performance. The goal is to extract useful academic insights that help in identifying top performers, failure rates, and course-wise performance trends.

This project was built as a learning exercise to apply SQL concepts such as joins, grouping, aggregation, views, stored procedures, and indexing — similar to tasks faced in real-world data analysis or software development roles.

## Dataset Description

The database consists of four core tables:

1. **Students** – Contains information about each student  
   - 'StudentID', 'Name', 'DateOfBirth'

2. **Courses** – Contains available courses offered  
   - 'CourseID', 'CourseName', 'Credits'

3. **Enrollments** – Tracks which students enrolled in which courses and when  
   - 'EnrollmentID', 'StudentID', 'CourseID', 'EnrollmentDate', 'Semester'

4. **Grades** – Stores the grades assigned for each enrollment  
   - 'GradeID', 'EnrollmentID', 'Grade' (on a 4.0 scale)

## Business Questions Answered

The project addresses the following academic and administrative questions:

- **Top 3 Students by GPA** – Identify the highest performing students.
- **Students Who Failed More Than 2 Courses** – List students with more than 2 failing grades (grade < 2.0).
- **Average Grade Per Course** – Understand course difficulty or student performance.
- **Student Performance Summary View** – Show total courses taken and GPA per student.
- **Grade Improvement Over Time** – Detect whether a student has improved their grade upon retaking a course.


##  Techniques Used

- **Joins**: 'INNER JOIN', 'LEFT JOIN'
- **Aggregation**: 'COUNT()', 'AVG()', 'SUM()'
- **Grouping and Filtering**: 'GROUP BY', 'HAVING'
- **Views**: For summarizing GPA and course load
- **Stored Procedures**: For secure and reusable course enrollment logic
- **Window Functions**: 'ROW_NUMBER()' for grade trend analysis
- **Indexes**: For query performance tuning


## Files Included

| File | Description |
|------|-------------|
| '01_create_tables.sql' | Creates the database schema (tables with constraints) |
| '02_insert_data.sql' | Inserts sample student, course, enrollment, and grade data |
| '03_views_and_procedures.sql' | Contains views, stored procedures, and indexes |
| '04_sample_queries.sql' | Business logic queries to analyze academic performance |


##  How to Run

1. **Set up the schema**  
   Run '01_create_tables.sql' to create all the necessary tables in SQL Server.

2. **Insert sample data**  
   Execute '02_insert_data.sql' to populate the database with mock data.

3. **Create views and procedures**  
   Run '03_views_and_procedures.sql' to build helper views and procedures.

4. **Answer the business questions**  
   Use '04_sample_queries.sql' to generate reports and insights.


##  Learning Outcomes

By working through this project, you will practice:

- Database design and normalization
- Writing reusable stored procedures
- Building views for reporting
- Analytical SQL queries using 'GROUP BY', 'HAVING', 'CASE', and window functions
- Using indexes to optimize performance


##  Future Enhancements

- **Role Management**: Add user types like student, admin, and instructor
- **Assignments & Exams**: Expand grading beyond single values
- **Attendance Tracking**
- **Dashboards**: Integrate with Power BI or Tableau


##  Tech Stack

- 'SQL Server 2019'
- 'T-SQL (Transact-SQL)'
- 'SSMS (SQL Server Management Studio)'


## License

This project is intended for educational and non-commercial use.


##  Acknowledgments

Inspired by real-world academic database systems and interview preparation content.
