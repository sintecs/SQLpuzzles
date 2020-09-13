CREATE TABLE dbo.Difficulty
(
   DifficultyID                     TINYINT IDENTITY (1, 1) NOT NULL
   ,DifficultyName                  NVARCHAR(100) NOT NULL
);

ALTER TABLE
   dbo.Difficulty
ADD CONSTRAINT
   PK_Difficulty
PRIMARY KEY
(
   DifficultyID
);
