-- indexes/IX_Students_Email
CREATE NONCLUSTERED INDEX [IX_Students_Email] 
ON [dbo].[Students] ([Email] ASC)
GO

-- indexes/IX_Instructors_Email
CREATE NONCLUSTERED INDEX [IX_Instructors_Email] 
ON [dbo].[Instructors] ([Email] ASC)
GO

-- indexes/IX_Grades_EnrollmentID
CREATE NONCLUSTERED INDEX [IX_Grades_EnrollmentID] 
ON [dbo].[Grades] ([EnrollmentID] ASC)
GO

-- indexes/IX_Grades_Grade
CREATE NONCLUSTERED INDEX [IX_Grades_Grade] 
ON [dbo].[Grades] ([Grade] ASC)
GO

-- indexes/IX_Courses_CourseName
CREATE NONCLUSTERED INDEX [IX_Courses_CourseName] 
ON [dbo].[Courses] ([CourseName] ASC)
GO

-- indexes/IX_Courses_InstructorId
CREATE NONCLUSTERED INDEX [IX_Courses_InstructorId] 
ON [dbo].[Courses] ([InstructorId] ASC)
GO

-- indexes/IX_Enrollments_StudentID
CREATE NONCLUSTERED INDEX [IX_Enrollments_StudentID]
ON [dbo].[Enrollments] ([StudentID])
GO


-- indexes/IX_Enrollments_CourseID
CREATE NONCLUSTERED INDEX [IX_Enrollments_CourseID]
ON [dbo].[Enrollments] ([CourseID])
GO

-- indexes/IX_Enrollments_Semester
CREATE NONCLUSTERED INDEX [IX_Enrollments_Semester]
ON [dbo].[Enrollments] ([Semester])
GO

-- constraints/FK_Courses_InstructorId
ALTER TABLE [dbo].[Courses]
ADD CONSTRAINT [FK_Courses_InstructorId]
FOREIGN KEY ([InstructorId])
REFERENCES [dbo].[Instructors] ([Id])
GO

-- constraints/FK_Enrollments_CourseID
ALTER TABLE [dbo].[Enrollments]
ADD CONSTRAINT [FK_Enrollments_CourseID]
FOREIGN KEY ([CourseID])
REFERENCES [dbo].[Courses] ([ID])
GO

-- constraints/FK_Enrollments_StudentID
ALTER TABLE [dbo].[Enrollments]
ADD CONSTRAINT [FK_Enrollments_StudentID]
FOREIGN KEY ([StudentID])
REFERENCES [dbo].[Students] ([Id])
GO

-- constraints/FK_Grades_EnrollmentID
ALTER TABLE [dbo].[Grades] 
ADD CONSTRAINT [FK_Grades_EnrollmentID]
FOREIGN KEY ([EnrollmentID]) 
REFERENCES [dbo].[Enrollments] ([Id])
GO


