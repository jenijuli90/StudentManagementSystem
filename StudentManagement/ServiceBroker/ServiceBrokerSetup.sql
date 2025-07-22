-- Defines the message type (no validation on message content)
CREATE MESSAGE TYPE [EnrollmentMessage] VALIDATION = NONE
GO

-- Defines the contract for the conversation, specifying which message type is allowed
CREATE CONTRACT [EnrollmentContract] ([EnrollmentMessage] SENT BY INITIATOR)
GO

-- Creates a queue to hold incoming messages for the service
CREATE QUEUE [dbo].[EnrollmentQueue] WITH STATUS = ON , RETENTION = OFF , ACTIVATION (  STATUS = ON , PROCEDURE_NAME = [dbo].[ProcessEnrollmentMessage] , MAX_QUEUE_READERS = 5 , EXECUTE AS N'dbo'  ), POISON_MESSAGE_HANDLING (STATUS = ON)  ON [PRIMARY] 
GO

-- Creates a service linked to the queue and contract, which clients communicate with
CREATE SERVICE [EnrollmentService]  
ON QUEUE [dbo].[EnrollmentQueue] ([EnrollmentContract])
GO
