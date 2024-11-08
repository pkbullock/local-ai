-- Insert record for creating a file
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        101, -- EntityID
        'File', -- EntityType
        'CREATE', -- ActionType
        'alice', -- CreatedBy
        '2023-09-20 10:15:00', -- CreatedDate
        NULL, -- UpdatedBy
        NULL, -- UpdatedDate
        201, -- FolderLocationID
        NULL, -- ContainerLocationID
        'Initial file creation'    -- Remarks
);

-- Insert record for updating a file
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        101,
        'File',
        'UPDATE',
        'alice',
        '2023-09-20 10:15:00',
        'bob',
        '2023-09-21 11:30:00',
        201,
        NULL,
        'Updated file content'
);

-- Insert record for creating a folder
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        102,
        'Folder',
        'CREATE',
        'carol',
        '2023-09-22 09:00:00',
        NULL,
        NULL,
        202,
        NULL,
        'Created new project folder'
);

-- Insert record for updating a folder
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        102,
        'Folder',
        'UPDATE',
        'carol',
        '2023-09-22 09:00:00',
        'dave',
        '2023-09-23 14:45:00',
        202,
        NULL,
        'Renamed folder'
);

-- Insert record for creating a container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        103,
        'Container',
        'CREATE',
        'eve',
        '2023-09-24 08:20:00',
        NULL,
        NULL,
        NULL,
        301,
        'Initialized data container'
);

-- Insert record for updating a container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        103,
        'Container',
        'UPDATE',
        'eve',
        '2023-09-24 08:20:00',
        'frank',
        '2023-09-25 16:00:00',
        NULL,
        301,
        'Container configuration updated'
);

-- Insert record for file moved to a different folder
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        104,
        'File',
        'UPDATE',
        'alice',
        '2023-09-26 13:00:00',
        'carol',
        '2023-09-27 10:15:00',
        203, -- New FolderLocationID after move
        NULL,
        'File moved to a different folder'
);

-- Insert record for deleting a file
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        105,
        'File',
        'DELETE',
        'bob',
        '2023-09-28 11:45:00',
        'bob',
        '2023-09-28 11:45:00',
        204,
        NULL,
        'Deleted obsolete file'
);

-- Insert record for creating another container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        106,
        'Container',
        'CREATE',
        'frank',
        '2023-09-29 09:30:00',
        NULL,
        NULL,
        NULL,
        302,
        'New container for backups'
);

-- Insert record for updating a container location
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        106,
        'Container',
        'UPDATE',
        'frank',
        '2023-09-29 09:30:00',
        'dave',
        '2023-09-30 17:25:00',
        NULL,
        303, -- Updated ContainerLocationID
        'Moved container to new server'
);

-- Insert record for creating a file in a container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        107,
        'File',
        'CREATE',
        'eve',
        '2023-10-01 12:00:00',
        NULL,
        NULL,
        NULL,
        303,
        'Added file to container'
);

-- Insert record for updating the file in the container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        107,
        'File',
        'UPDATE',
        'eve',
        '2023-10-01 12:00:00',
        'alice',
        '2023-10-02 14:30:00',
        NULL,
        303,
        'Updated file metadata'
);

-- Insert record for creating a new file
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        108,
        'File',
        'CREATE',
        'george',
        '2023-10-03 09:15:00',
        NULL,
        NULL,
        205,
        NULL,
        'Uploaded financial report'
);

-- Insert record for updating the file
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        108,
        'File',
        'UPDATE',
        'george',
        '2023-10-03 09:15:00',
        'helen',
        '2023-10-04 10:40:00',
        205,
        NULL,
        'Corrected data in report'
);

-- Insert record for creating a new folder
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        109,
        'Folder',
        'CREATE',
        'irene',
        '2023-10-05 14:00:00',
        NULL,
        NULL,
        206,
        NULL,
        'Added marketing materials folder'
);

-- Insert record for moving a folder to a different location
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        109,
        'Folder',
        'UPDATE',
        'irene',
        '2023-10-05 14:00:00',
        'george',
        '2023-10-06 11:20:00',
        207, -- New FolderLocationID after moving
        NULL,
        'Moved folder to shared directory'
);

-- Insert record for deleting a container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        110,
        'Container',
        'DELETE',
        'frank',
        '2023-10-07 08:45:00',
        'frank',
        '2023-10-07 08:45:00',
        NULL,
        304,
        'Removed deprecated container'
);

-- Insert record for creating a new container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        111,
        'Container',
        'CREATE',
        'james',
        '2023-10-08 15:30:00',
        NULL,
        NULL,
        NULL,
        305,
        'Container for archived files'
);

-- Insert record for updating container settings
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        111,
        'Container',
        'UPDATE',
        'james',
        '2023-10-08 15:30:00',
        'helen',
        '2023-10-09 09:50:00',
        NULL,
        305,
        'Adjusted permissions for container'
);

-- Insert record for creating a file inside a folder
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        112,
        'File',
        'CREATE',
        'kate',
        '2023-10-10 12:10:00',
        NULL,
        NULL,
        208,
        NULL,
        'Draft of new policy document'
);

-- Insert record for updating the file content
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        112,
        'File',
        'UPDATE',
        'kate',
        '2023-10-10 12:10:00',
        'james',
        '2023-10-11 14:00:00',
        208,
        NULL,
        'Reviewed and edited policy document'
);

-- Insert record for archiving a file by moving it to a container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        112,
        'File',
        'UPDATE',
        'kate',
        '2023-10-10 12:10:00',
        'luke',
        '2023-10-12 16:30:00',
        NULL,
        305, -- Moved to container for archiving
        'Archived the policy document'
);

-- Insert record for creating a new folder hierarchy
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        113,
        'Folder',
        'CREATE',
        'mary',
        '2023-10-13 09:00:00',
        NULL,
        NULL,
        209,
        NULL,
        'Set up folder for project X'
);

-- Insert record for adding files to the new folder
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        114,
        'File',
        'CREATE',
        'mary',
        '2023-10-13 09:30:00',
        NULL,
        NULL,
        209,
        NULL,
        'Uploaded initial project documents'
);

-- Insert record for updating folder permissions
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        113,
        'Folder',
        'UPDATE',
        'mary',
        '2023-10-13 09:00:00',
        'nina',
        '2023-10-14 10:15:00',
        209,
        NULL,
        'Changed folder access permissions'
);

-- Insert record for deleting a file
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        115,
        'File',
        'DELETE',
        'oliver',
        '2023-10-15 11:45:00',
        'oliver',
        '2023-10-15 11:45:00',
        210,
        NULL,
        'Removed outdated schedule'
);

-- Insert record for creating a container for backups
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        116,
        'Container',
        'CREATE',
        'paula',
        '2023-10-16 13:20:00',
        NULL,
        NULL,
        NULL,
        306,
        'Backup container for quarterly data'
);

-- Insert record for updating backup container schedule
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        116,
        'Container',
        'UPDATE',
        'paula',
        '2023-10-16 13:20:00',
        'roger',
        '2023-10-17 09:55:00',
        NULL,
        306,
        'Set up automatic backups'
);

-- Insert record for moving a file to a different container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        117,
        'File',
        'UPDATE',
        'sophie',
        '2023-10-18 08:10:00',
        'paula',
        '2023-10-19 11:25:00',
        NULL,
        306, -- Moved to backup container
        'File moved for backup purposes'
);

-- Insert record for restoring a file from a backup container
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        117,
        'File',
        'UPDATE',
        'sophie',
        '2023-10-18 08:10:00',
        'tina',
        '2023-10-20 14:45:00',
        211, -- Restored to original folder
        NULL,
        'Restored file from backup'
);

-- Insert record for creating a new folder structure
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        118,
        'Folder',
        'CREATE',
        'ursula',
        '2023-10-21 10:30:00',
        NULL,
        NULL,
        212,
        NULL,
        'Initiated folder for annual reports'
);

-- Insert record for bulk uploading files into the folder
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        119,
        'File',
        'CREATE',
        'ursula',
        '2023-10-21 11:00:00',
        NULL,
        NULL,
        212,
        NULL,
        'Bulk upload of reports'
);

-- Insert record for updating folder details
INSERT INTO AuditHistory
    (
    EntityID,
    EntityType,
    ActionType,
    CreatedBy,
    CreatedDate,
    UpdatedBy,
    UpdatedDate,
    FolderLocationID,
    ContainerLocationID,
    Remarks
    )
VALUES
    (
        118,
        'Folder',
        'UPDATE',
        'ursula',
        '2023-10-21 10:30:00',
        'victor',
        '2023-10-22 09:05:00',
        212,
        NULL,
        'Updated folder with additional metadata'
);