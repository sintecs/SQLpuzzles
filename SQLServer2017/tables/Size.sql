CREATE TABLE dbo.Size
(
   SizeID                        TINYINT IDENTITY(1, 1) NOT NULL
   ,NumberOfBlocks               TINYINT NOT NULL
);

ALTER TABLE
   dbo.Size
ADD CONSTRAINT
   PK_Size
PRIMARY KEY
(
   SizeID
);
