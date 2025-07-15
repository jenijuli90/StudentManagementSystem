-- Create database (optional)
CREATE DATABASE StudentManagement
GO
USE StudentManagement
GO

-- Drop tables if exist
IF OBJECT_ID('Grades', 'U') IS NOT NULL DROP TABLE Grades
IF OBJECT_ID('Enrollments', 'U') IS NOT NULL DROP TABLE Enrollments
IF OBJECT_ID('Courses', 'U') IS NOT NULL DROP TABLE Courses
IF OBJECT_ID('Students', 'U') IS NOT NULL DROP TABLE Students

-- Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    DateOfBirth DATE
)

-- Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL
)

-- Enrollments table
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
    CourseID INT FOREIGN KEY REFERENCES Courses(CourseID),
    EnrollmentDate DATE DEFAULT GETDATE(),
    Semester VARCHAR(10)
)

-- Grades table
CREATE TABLE Grades (
    GradeID INT PRIMARY KEY IDENTITY(1,1),
    EnrollmentID INT FOREIGN KEY REFERENCES Enrollments(EnrollmentID),
    Grade DECIMAL(3,2) CHECK (Grade >= 0 AND Grade <= 4.0)
)