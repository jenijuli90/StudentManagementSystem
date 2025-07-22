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
CREATE TABLE [dbo].[Students] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [FirstName] VARCHAR(100) NOT NULL,
    [LastName] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(100) NOT NULL,
    [DateOfBirth] DATE NOT NULL,
    [IsActive] BIT NOT NULL,
    [Address] VARCHAR(255) NOT NULL,
    [PhoneNumber] VARCHAR(20) NOT NULL,
    [CreatedOn] DATETIME NOT NULL,
    [UpdatedOn] DATETIME NOT NULL,
    CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED ([Id] ASC)
)

-- Instructors table
CREATE TABLE [dbo].[Instructors] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [InstructorName] VARCHAR(100) NULL,
    [Department] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(100) NOT NULL,
    [IsActive] BIT NOT NULL,
    [CreatedOn] DATETIME NOT NULL,
    [UpdateOn] DATETIME NOT NULL,
    CONSTRAINT [PK_Instructors] PRIMARY KEY CLUSTERED ([Id] ASC)
)
    
-- Courses table
CREATE TABLE [dbo].[Courses] (
    [ID] INT IDENTITY(1,1) NOT NULL,
    [CourseName] VARCHAR(100) NOT NULL,
    [Credits] INT NOT NULL,
    [InstructorId] INT NOT NULL,
    [IsActive] BIT NOT NULL,
    [CreatedOn] DATETIME NOT NULL,
    [UpdatedOn] DATETIME NOT NULL,
    CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED ([ID] ASC)
)

-- Enrollments table
CREATE TABLE [dbo].[Enrollments] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [StudentID] INT NOT NULL,
    [CourseID] INT NOT NULL,
    [EnrollmentDate] DATETIME NOT NULL,
    [Semester] VARCHAR(20) NOT NULL,
    CONSTRAINT [PK_Enrollments] PRIMARY KEY CLUSTERED ([Id] ASC)
)

-- Grades table
CREATE TABLE [dbo].[Grades] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [EnrollmentID] INT NOT NULL,
    [Grade] DECIMAL(3,1) NOT NULL CHECK (Grade >= 0 AND Grade <= 4.0),
    [GradeDate] DATE NULL,
    CONSTRAINT [PK_Grades] PRIMARY KEY CLUSTERED ([Id] ASC)
)

--ErrorLog table
CREATE TABLE [dbo].[ErrorLog] (
    [ErrorID] INT IDENTITY(1,1) NOT NULL,
    [UserName] VARCHAR(100) NULL,
    [ErrorNumber] INT NULL,
    [ErrorState] INT NULL,
    [ErrorSeverity] INT NULL,
    [ErrorMessage] VARCHAR(MAX) NULL,
    [ErrorDateTime] DATETIME NULL,
    CONSTRAINT [PK_ErrorLog] PRIMARY KEY CLUSTERED ([ErrorID] ASC)
) 
