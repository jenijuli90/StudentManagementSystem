-- View: Student Performance Summary
CREATE VIEW StudentPerformanceSummary AS
SELECT 
    S.StudentID,
    S.Name,
    COUNT(DISTINCT E.CourseID) AS TotalCourses,
    CAST(ROUND(AVG(G.Grade), 2) AS DECIMAL(4,2)) AS GPA
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Grades G ON E.EnrollmentID = G.EnrollmentID
GROUP BY S.StudentID, S.Name

-- Stored procedure: Enroll Student
CREATE PROCEDURE EnrollStudent
    @StudentID INT,
    @CourseID INT
AS
BEGIN
    SET NOCOUNT ON

    IF EXISTS (
        SELECT 1 FROM Enrollments 
        WHERE StudentID = @StudentID AND CourseID = @CourseID
    )
    BEGIN
        PRINT 'Student already enrolled in this course.'
        RETURN
    END

    INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Semester)
    VALUES (@StudentID, @CourseID, GETDATE(), '2024_Fall')

    PRINT 'Enrollment successful.'
END

-- Indexes for performance
CREATE INDEX IX_Enrollments_StudentID ON Enrollments(StudentID)
CREATE INDEX IX_Enrollments_CourseID ON Enrollments(CourseID)
CREATE INDEX IX_Grades_EnrollmentID ON Grades(EnrollmentID)