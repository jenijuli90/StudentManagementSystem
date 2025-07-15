-- Insert students
INSERT INTO Students (Name, DateOfBirth) VALUES
('Alice Johnson', '2001-05-14'),
('Bob Smith', '2000-09-10'),
('Charlie Lee', '2002-01-22')

-- Insert courses
INSERT INTO Courses (CourseName, Credits) VALUES
('Mathematics', 3),
('Science', 4),
('History', 2)

-- Insert enrollments
INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Semester) VALUES
(1, 1, '2024-01-10', '2024_Spring'),
(1, 2, '2024-01-11', '2024_Spring'),
(2, 1, '2024-01-12', '2024_Spring'),
(2, 3, '2024-09-01', '2024_Fall'),
(3, 1, '2024-01-14', '2024_Spring'),
(3, 2, '2024-09-02', '2024_Fall')

-- Insert grades
INSERT INTO Grades (EnrollmentID, Grade) VALUES
(1, 3.5),
(2, 2.0),
(3, 1.8),
(4, 1.0),
(5, 3.8),
(6, 4.0)