-- 1. Top 3 students by GPA
SELECT TOP 3 
    S.StudentID,
    S.Name,
    AVG(G.Grade) AS GPA
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Grades G ON E.EnrollmentID = G.EnrollmentID
GROUP BY S.StudentID, S.Name
ORDER BY GPA DESC

-- 2. Students who failed more than 2 courses (Grade < 2.0)
SELECT 
    S.StudentID,
    S.Name,
    COUNT(*) AS FailedCourses
FROM Students S
JOIN Enrollments E ON S.StudentID = E.StudentID
JOIN Grades G ON E.EnrollmentID = G.EnrollmentID
WHERE G.Grade < 2.0
GROUP BY S.StudentID, S.Name
HAVING COUNT(*) > 2

-- 3. Average grade per course
SELECT 
    C.CourseName,
    AVG(G.Grade) AS AverageGrade
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID
JOIN Grades G ON E.EnrollmentID = G.EnrollmentID
GROUP BY C.CourseName

-- 4. Improvement detection
WITH GradesBySemester AS (
    SELECT 
        S.StudentID,
        S.Name,
        E.CourseID,
        E.Semester,
        G.Grade,
        ROW_NUMBER() OVER (PARTITION BY S.StudentID, E.CourseID ORDER BY E.Semester) AS SemesterOrder
    FROM Students S
    JOIN Enrollments E ON S.StudentID = E.StudentID
    JOIN Grades G ON E.EnrollmentID = G.EnrollmentID
)
SELECT DISTINCT
    g1.StudentID,
    g1.Name,
    g1.CourseID,
    g1.Semester AS EarlierSemester,
    g2.Semester AS LaterSemester,
    g1.Grade AS EarlierGrade,
    g2.Grade AS LaterGrade
FROM GradesBySemester g1
JOIN GradesBySemester g2 
    ON g1.StudentID = g2.StudentID 
    AND g1.CourseID = g2.CourseID
    AND g2.SemesterOrder = g1.SemesterOrder + 1
WHERE g2.Grade > g1.Grade