-- 1. Top 3 students by GPA
SELECT TOP 3 
    S.ID,
    S.FirstName,
    S.LastName,
    CAST(AVG(G.Grade) AS DECIMAL(4, 2)) AS GPA
FROM Students S
JOIN Enrollments E ON S.ID = E.StudentID
JOIN Grades G ON E.ID = G.EnrollmentID
GROUP BY S.ID, S.FirstName, S.LastName
ORDER BY GPA DESC

-- 2. Students who failed more than 2 courses (Grade < 2.0)
SELECT 
    S.Id,
    S.FirstName,
	s.LastName,
    COUNT(*) AS FailedCourses
FROM Students S
JOIN Enrollments E ON S.Id = E.StudentID
JOIN Grades G ON E.Id = G.EnrollmentID
WHERE G.Grade < 2.0
GROUP BY S.Id , S.FirstName,s.LastName
HAVING COUNT(*) >= 2

-- 3. Average grade per course
SELECT 
    C.CourseName,
    CAST(AVG(G.Grade) AS DECIMAL(4, 2)) AS AverageGrade
FROM Courses C
JOIN Enrollments E ON C.Id = E.CourseID
JOIN Grades G ON E.Id = G.EnrollmentID
GROUP BY C.CourseName;

-- 4. Improvement detection
WITH GradesBySemester AS (
    SELECT 
        S.Id,
        S.FirstName,
		S.LastName,
        E.CourseID,
        E.Semester,
        G.Grade,
        ROW_NUMBER() OVER (PARTITION BY S.Id, E.CourseID ORDER BY E.Semester) AS SemesterOrder
    FROM Students S
    JOIN Enrollments E ON S.Id = E.StudentID
    JOIN Grades G ON E.Id = G.EnrollmentID
)
SELECT DISTINCT
    g1.Id,
    g1.FirstName,
	g1.LastName,
    g1.CourseID,
    g1.Semester AS EarlierSemester,
    g2.Semester AS LaterSemester,
    g1.Grade AS EarlierGrade,
    g2.Grade AS LaterGrade
FROM GradesBySemester g1
JOIN GradesBySemester g2 
    ON g1.Id = g2.Id 
    AND g1.CourseID = g2.CourseID
    AND g2.SemesterOrder = g1.SemesterOrder + 1
WHERE g2.Grade > g1.Grade 

--5.Calculate GPA Categories (Segmenting students based on GPA)
SELECT 
    S.id, 
    S.FirstName,
	S.LastName,
    CAST(AVG(G.Grade) AS DECIMAL(4, 2)) AS GPA,
    CASE 
        WHEN AVG(Grade) >= 3.5 THEN 'Excellent'
        WHEN AVG(Grade) BETWEEN 3.0 AND 3.49 THEN 'Good'
        WHEN AVG(Grade) BETWEEN 2.5 AND 2.99 THEN 'Average'
        ELSE 'Below Average'
    END AS GPA_Category
FROM Students S
JOIN Enrollments E ON s.id = E.StudentID
JOIN Grades G ON G.EnrollmentID = E.Id
GROUP BY S.Id, S.FirstName,S.LastName
ORDER BY GPA DESC
