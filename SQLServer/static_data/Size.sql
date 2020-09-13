SET IDENTITY_INSERT dbo.Size ON;

INSERT INTO dbo.Size
(
  SizeID
 ,NumberOfBlocks
)
VALUES
    (1, 9)
   ,(2, 16);

SET IDENTITY_INSERT dbo.Size OFF;
