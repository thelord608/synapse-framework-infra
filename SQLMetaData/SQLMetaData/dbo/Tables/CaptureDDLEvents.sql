CREATE TABLE dbo.CaptureDDLEvents
(
    EventDate    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EventType    NVARCHAR(100),
    EventDDL     NVARCHAR(MAX),
    EventXML     XML,
    DatabaseName NVARCHAR(255),
    SchemaName   NVARCHAR(255),
    ObjectName   NVARCHAR(255),
    HostName     VARCHAR(64),
    IPAddress    VARCHAR(48),
    ProgramName  NVARCHAR(255),
    LoginName    NVARCHAR(255)
);