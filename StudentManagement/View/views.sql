-- View: Student Performance Summary
-- View: Student Performance Summary
CREATE VIEW [dbo].[StudentPerformanceSummary] AS
SELECT 
    s.ID,
    s.firstName,
	s.lastname,
    COUNT(DISTINCT e.CourseID) AS TotalCourses,
    CAST(ROUND(AVG(G.Grade), 2) AS DECIMAL(4,2)) AS GPA
FROM Students s
JOIN Enrollments e ON s.ID = e.StudentID
JOIN Grades g ON e.ID = g.EnrollmentID
GROUP BY s.ID, s.firstName,s.LastName
GO