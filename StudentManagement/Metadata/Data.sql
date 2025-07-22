USE [StudentManagement]
GO
SET IDENTITY_INSERT [dbo].[Students] ON 
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [Email], [DateOfBirth], [IsActive], [Address], [PhoneNumber], [CreatedOn], [UPdatedOn]) VALUES (1, N'John', N'Doe', N'john.doe@example.com', CAST(N'2000-06-15' AS Date), 1, N'123 Main St, Cityville, CA', N'555-1234', CAST(N'2025-07-22T12:12:49.623' AS DateTime), CAST(N'2025-07-22T12:12:49.623' AS DateTime))
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [Email], [DateOfBirth], [IsActive], [Address], [PhoneNumber], [CreatedOn], [UPdatedOn]) VALUES (2, N'Jane', N'Smith', N'jane.smith@example.com', CAST(N'1999-11-25' AS Date), 1, N'456 Oak Rd, Townsville, TX', N'555-5678', CAST(N'2025-07-22T12:12:49.623' AS DateTime), CAST(N'2025-07-22T12:12:49.623' AS DateTime))
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [Email], [DateOfBirth], [IsActive], [Address], [PhoneNumber], [CreatedOn], [UPdatedOn]) VALUES (3, N'Michael', N'Johnson', N'kjj.juliya@gmail.com', CAST(N'2001-03-05' AS Date), 1, N'789 Pine Ave, Springdale, FL', N'555-8765', CAST(N'2025-07-22T12:12:49.623' AS DateTime), CAST(N'2025-07-22T12:12:49.623' AS DateTime))
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [Email], [DateOfBirth], [IsActive], [Address], [PhoneNumber], [CreatedOn], [UPdatedOn]) VALUES (4, N'Emily', N'Brown', N'emily.brown@example.com', CAST(N'2000-07-20' AS Date), 0, N'101 Maple St, Lakeside, IL', N'555-3456', CAST(N'2025-07-22T12:12:49.623' AS DateTime), CAST(N'2025-07-22T12:12:49.623' AS DateTime))
GO
INSERT [dbo].[Students] ([Id], [FirstName], [LastName], [Email], [DateOfBirth], [IsActive], [Address], [PhoneNumber], [CreatedOn], [UPdatedOn]) VALUES (5, N'James', N'Wilson', N'james.wilson@example.com', CAST(N'1998-02-17' AS Date), 1, N'202 Birch Rd, Riverside, NY', N'555-2345', CAST(N'2025-07-22T12:12:49.623' AS DateTime), CAST(N'2025-07-22T12:12:49.623' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET IDENTITY_INSERT [dbo].[Instructors] ON 
GO
INSERT [dbo].[Instructors] ([Id], [InstructorName], [Department], [Email], [IsActive], [CreatedOn], [UpdateOn]) VALUES (1, N'Dr. Alice Johnson', N'Computer Science', N'alice.johnson@university.com', 1, CAST(N'2025-07-22T12:18:09.173' AS DateTime), CAST(N'2025-07-22T12:18:09.173' AS DateTime))
GO
INSERT [dbo].[Instructors] ([Id], [InstructorName], [Department], [Email], [IsActive], [CreatedOn], [UpdateOn]) VALUES (2, N'Prof. Bob Smith', N'Mathematics', N'bob.smith@university.com', 1, CAST(N'2025-07-22T12:18:09.173' AS DateTime), CAST(N'2025-07-22T12:18:09.173' AS DateTime))
GO
INSERT [dbo].[Instructors] ([Id], [InstructorName], [Department], [Email], [IsActive], [CreatedOn], [UpdateOn]) VALUES (3, N'Dr. Carol Davis', N'Biology', N'carol.davis@university.com', 1, CAST(N'2025-07-22T12:18:09.173' AS DateTime), CAST(N'2025-07-22T12:18:09.173' AS DateTime))
GO
INSERT [dbo].[Instructors] ([Id], [InstructorName], [Department], [Email], [IsActive], [CreatedOn], [UpdateOn]) VALUES (4, N'Prof. David Lee', N'History', N'david.lee@university.com', 0, CAST(N'2025-07-22T12:18:09.173' AS DateTime), CAST(N'2025-07-22T12:18:09.173' AS DateTime))
GO
INSERT [dbo].[Instructors] ([Id], [InstructorName], [Department], [Email], [IsActive], [CreatedOn], [UpdateOn]) VALUES (5, N'Dr. Emma Wilson', N'Chemistry', N'emma.wilson@university.com', 1, CAST(N'2025-07-22T12:18:09.173' AS DateTime), CAST(N'2025-07-22T12:18:09.173' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Instructors] OFF
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 
GO
INSERT [dbo].[Courses] ([ID], [CourseName], [Credits], [InstructorId], [IsActive], [CreatedOn], [UpdatedOn]) VALUES (1, N'Introduction to Computer Science', 3, 1, 1, CAST(N'2025-07-22T12:29:26.993' AS DateTime), CAST(N'2025-07-22T12:29:26.993' AS DateTime))
GO
INSERT [dbo].[Courses] ([ID], [CourseName], [Credits], [InstructorId], [IsActive], [CreatedOn], [UpdatedOn]) VALUES (2, N'Calculus I', 4, 2, 1, CAST(N'2025-07-22T12:29:26.993' AS DateTime), CAST(N'2025-07-22T12:29:26.993' AS DateTime))
GO
INSERT [dbo].[Courses] ([ID], [CourseName], [Credits], [InstructorId], [IsActive], [CreatedOn], [UpdatedOn]) VALUES (3, N'Biology 101', 3, 3, 1, CAST(N'2025-07-22T12:29:26.993' AS DateTime), CAST(N'2025-07-22T12:29:26.993' AS DateTime))
GO
INSERT [dbo].[Courses] ([ID], [CourseName], [Credits], [InstructorId], [IsActive], [CreatedOn], [UpdatedOn]) VALUES (4, N'History of Art', 3, 4, 0, CAST(N'2025-07-22T12:29:26.993' AS DateTime), CAST(N'2025-07-22T12:29:26.993' AS DateTime))
GO
INSERT [dbo].[Courses] ([ID], [CourseName], [Credits], [InstructorId], [IsActive], [CreatedOn], [UpdatedOn]) VALUES (5, N'Organic Chemistry', 4, 5, 1, CAST(N'2025-07-22T12:29:26.993' AS DateTime), CAST(N'2025-07-22T12:29:26.993' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Enrollments] ON 
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (1, 1, 1, CAST(N'2024-01-10T00:00:00.000' AS DateTime), N'2024_Spring')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (2, 2, 2, CAST(N'2024-02-15T00:00:00.000' AS DateTime), N'2024_Spring')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (3, 3, 3, CAST(N'2024-03-05T00:00:00.000' AS DateTime), N'2024_Spring')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (4, 4, 4, CAST(N'2024-04-20T00:00:00.000' AS DateTime), N'2024_Spring')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (5, 5, 5, CAST(N'2024-05-25T00:00:00.000' AS DateTime), N'2024_Spring')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (6, 1, 2, CAST(N'2024-08-20T00:00:00.000' AS DateTime), N'2024_Fall')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (7, 2, 3, CAST(N'2024-09-01T00:00:00.000' AS DateTime), N'2024_Fall')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (8, 3, 4, CAST(N'2024-09-15T00:00:00.000' AS DateTime), N'2024_Fall')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (9, 4, 5, CAST(N'2024-10-10T00:00:00.000' AS DateTime), N'2024_Fall')
GO
INSERT [dbo].[Enrollments] ([Id], [StudentID], [CourseID], [EnrollmentDate], [Semester]) VALUES (10, 5, 1, CAST(N'2024-10-20T00:00:00.000' AS DateTime), N'2024_Fall')
GO
SET IDENTITY_INSERT [dbo].[Enrollments] OFF
GO
