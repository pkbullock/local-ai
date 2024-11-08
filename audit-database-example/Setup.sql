CREATE TABLE AuditHistory (
    LogID INT IDENTITY(1,1) PRIMARY KEY,        -- Unique identifier for each log entry
    EntityID INT NOT NULL,                      -- ID of the entity being logged (e.g., folder or container)
    EntityType NVARCHAR(150) NOT NULL,           -- Type of entity (e.g., 'Folder', 'Container')
    ActionType NVARCHAR(150) NOT NULL,           -- Type of action ('CREATE', 'UPDATE')
    CreatedBy NVARCHAR(255),                    -- User who created the record
    CreatedDate DATETIME DEFAULT GETDATE(),     -- Date and time the record was created
    UpdatedBy NVARCHAR(255),                    -- User who last updated the record
    UpdatedDate DATETIME,                       -- Date and time the record was last updated
    FolderLocationID INT,                       -- ID for the folder location
    ContainerLocationID INT,                    -- ID for the container location
    Remarks NVARCHAR(255)                       -- Additional comments or remarks
);

