-----------------------------------------------------------------------
-- procedures/Error_Log.sql
-- Purpose: Logs error details into the dbo.ErrorLog table.
-- Usage: Called from a CATCH block with the current procedure name.

CREATE PROCEDURE [dbo].[Error_Log]
    @procName VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @error_message VARCHAR(MAX)

    -- Combine procedure name and actual error message
    SET @error_message = CONCAT_WS(':', @procName, ERROR_MESSAGE())

    -- Insert error details into the ErrorLog table
    INSERT INTO dbo.ErrorLog (
        UserName,
        ErrorNumber,
        ErrorState,
        ErrorSeverity,
        ErrorMessage,
        ErrorDateTime
    )
    VALUES (
        SUSER_SNAME(),
        ERROR_NUMBER(),
        ERROR_STATE(),
        ERROR_SEVERITY(),
        @error_message,
        GETDATE()
    )
END
GO

---------------------------------------------------------------------------------
-- procedures/Error_Throw.sql
-- Purpose: Re-throws the current error with the procedure name prepended.
-- Usage: Call from CATCH block to forward errors up the call chain.

CREATE PROCEDURE [dbo].[Error_Throw]
    @procName VARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @message  VARCHAR(MAX) = ERROR_MESSAGE()
    DECLARE @severity INT         = ERROR_SEVERITY()
    DECLARE @state    SMALLINT    = ERROR_STATE()

    -- Prepend procedure name to the error message
    SET @message = @procName + ':' + @message

    -- Raise the error
    RAISERROR (
        @message,
        @severity,
        @state
    )
END
GO

----------------------------------------------------------------------------------------
-- procedures/DBmail_Create.sql
-- Stored Procedure to configure Database Mail with Gmail SMTP
-- This procedure enables Database Mail, creates a mail profile and account,
-- and links them together for sending emails from SQL Server.

CREATE PROCEDURE [dbo].[DBmail_Create]
AS
BEGIN
    SET NOCOUNT ON

    -- Variable to store current procedure name for error messages
    DECLARE @procname VARCHAR(MAX) = OBJECT_NAME(@@PROCID)

    BEGIN TRY
        -- Enable advanced options to allow enabling Database Mail XPs
        EXEC sp_configure 'show advanced options', 1
        RECONFIGURE;

        -- Enable Database Mail extended stored procedures
        EXEC sp_configure 'Database Mail XPs', 1
        RECONFIGURE;

        -- Create a Database Mail profile named 'LibraryManagement Mail'
        EXEC msdb.dbo.sysmail_add_profile_sp  
            @profile_name = 'StudentManagement Mail',
            @description = 'Profile for sending email through Gmail'

        -- Grant access to the profile to the 'public' role and set it as default
        EXEC msdb.dbo.sysmail_add_principalprofile_sp 
            @profile_name = 'StudentManagement Mail',
            @principal_name = 'public',
            @is_default = 1

        -- Create a Database Mail account using Gmail SMTP settings
        EXEC msdb.dbo.sysmail_add_account_sp  
            @account_name = 'StudentManagement Info',
            @description = 'Gmail account for Database Mail',
            @email_address = 'your_email@gmail.com',     -- Replace with the sender Gmail address
            @display_name = 'StudentEnrollment Notification',
            @mailserver_name = 'smtp.gmail.com',
            @port = 587,
            @enable_ssl = 1,
            @username = 'your_email@gmail.com',   -- Gmail username
            @password = 'your_app_password_here'  -- Replace with a Gmail App Password


        -- Add the account to the profile with sequence number 1
        EXEC msdb.dbo.sysmail_add_profileaccount_sp  
            @profile_name = 'LibraryManagement Mail',
            @account_name = 'LibraryManagement Info',
            @sequence_number = 1

    END TRY
    BEGIN CATCH
        -- Capture error details
        DECLARE 
            @Message VARCHAR(MAX) = ERROR_MESSAGE(),
            @Severity INT = ERROR_SEVERITY(),
            @State SMALLINT = ERROR_STATE()

        -- Prefix error message with procedure name
        SET @Message = @procname + ': ' + @Message

        -- Raise the error to caller
        RAISERROR(@Message, @Severity, @State)
    END CATCH
END
GO


-------------------------------------------------------------------------------------------------
-- procedures/EnrollStudent.sql
-- Purpose: Enroll a student into a course.
--          Prevents duplicate enrollments and sends an XML message via Service Broker.
--          Includes error logging and handling through custom error procedures.

CREATE PROCEDURE [dbo].[EnrollStudent]
    @StudentID INT,
    @CourseID INT
	@Semester VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON

    -- Declare variables
    DECLARE @procname       VARCHAR(MAX)
          , @error_message  VARCHAR(MAX)
          , @student_id     INT
          , @XmlMessage     XML
          , @StudentEmail   VARCHAR(255)
          , @DialogHandle   UNIQUEIDENTIFIER

    SET @procname = OBJECT_NAME(@@PROCID)

    BEGIN TRY

        -- Check if student is already enrolled in the course
        IF EXISTS (
            SELECT 1
            FROM Enrollments
            WHERE StudentID = @StudentID AND CourseID = @CourseID
        )
        BEGIN
            SET @error_message = 'Student is already registered for the course.'
            RAISERROR (@error_message, 16, 1)
        END
        ELSE
        BEGIN
            -- Insert enrollment record
            INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Semester)
            VALUES (@StudentID, @CourseID, GETDATE(), @Semester)

            SET @student_id = SCOPE_IDENTITY()

            -- Retrieve the student's email
            SELECT @StudentEmail = Email
            FROM Students
            WHERE ID = @StudentID

            -- Create XML message for Service Broker
            SET @XmlMessage = 
                N'<Enrollment>' +
                N'  <StudentID>' + CAST(@StudentID AS NVARCHAR) + N'</StudentID>' +
                N'  <StudentEmail>' + @StudentEmail + N'</StudentEmail>' +
                N'  <CourseID>' + CAST(@CourseID AS NVARCHAR) + N'</CourseID>' +
                N'</Enrollment>'

            -- Begin a Service Broker dialog
            BEGIN DIALOG CONVERSATION @DialogHandle
                FROM SERVICE EnrollmentService
                TO SERVICE 'EnrollmentService'
                ON CONTRACT EnrollmentContract
                WITH ENCRYPTION = OFF

            -- Send message to the queue
            SEND ON CONVERSATION @DialogHandle
                MESSAGE TYPE EnrollmentMessage (@XmlMessage)

            -- End the dialog
            END CONVERSATION @DialogHandle
        END

    END TRY

    BEGIN CATCH
        -- Call custom error logging procedure
        EXEC dbo.Error_Log @procname = @procname

        -- Call custom error throw procedure
        EXEC dbo.Error_Throw @procname = @procname
    END CATCH
END
GO

----------------------------------------------------------------------------------------------
-- procedures/ProcessEnrollmentMessage.sql
-- Purpose: Receives enrollment XML messages from Service Broker queue,
--          parses student and course info, and sends a confirmation email.
--          Includes error handling and logs issues using custom procedures.

CREATE PROCEDURE [dbo].[ProcessEnrollmentMessage]
AS
BEGIN
    SET NOCOUNT ON

    -- Declare variables
    DECLARE @procname        VARCHAR(MAX)
          , @error_message   VARCHAR(MAX)
          , @MessageBody     XML
          , @DialogHandle    UNIQUEIDENTIFIER
          , @StudentID       INT
          , @StudentEmail    VARCHAR(255)
          , @CourseID        INT
          , @Subject         NVARCHAR(255)
          , @Body            NVARCHAR(MAX)

    SET @procname = OBJECT_NAME(@@PROCID)

    BEGIN TRY

        -- Receive XML message from Service Broker queue
        RECEIVE TOP(1)
            @MessageBody = message_body,
            @DialogHandle = conversation_handle
        FROM EnrollmentQueue

        -- Extract data from XML
        SET @StudentID = CAST(@MessageBody.value('(/Enrollment/StudentID)[1]', 'INT') AS INT)
        SET @StudentEmail = @MessageBody.value('(/Enrollment/StudentEmail)[1]', 'VARCHAR(255)')
        SET @CourseID = CAST(@MessageBody.value('(/Enrollment/CourseID)[1]', 'INT') AS INT)

        -- Validate email
        IF @StudentEmail IS NULL OR @StudentEmail = ''
        BEGIN
            SET @error_message = 'No valid email found for the student.'
            RAISERROR (@error_message, 16, 1)
            RETURN
        END

        -- Compose email
        SET @Subject = 'Enrollment Successful'
        SET @Body = 'Dear Student,' + CHAR(13) + CHAR(10) +
                    'Your enrollment in the course has been successfully completed.' + CHAR(13) + CHAR(10) +
                    'Course Details:' + CHAR(13) + CHAR(10) +
                    'Course ID: ' + CAST(@CourseID AS VARCHAR(10)) + CHAR(13) + CHAR(10) +
                    'Enrollment ID: ' + CAST(@StudentID AS VARCHAR(10))

        -- Send email using Database Mail
        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'StudentManagement Mail',
            @recipients   = @StudentEmail,
            @subject      = @Subject,
            @body         = @Body,
            @body_format  = 'TEXT'

        -- End the conversation
        END CONVERSATION @DialogHandle

    END TRY

    BEGIN CATCH
        -- Only log and throw if not already nested inside another catch
        IF @@NESTLEVEL = 1
        BEGIN
            EXEC dbo.Error_Log @procname = @procname
        END

        EXEC dbo.Error_Throw @procname = @procname
    END CATCH
END
GO

