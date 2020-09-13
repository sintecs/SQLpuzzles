CREATE TABLE dbo.SquareData
(
   PuzzleID                   INT NOT NULL
   ,BlockID                   TINYINT NOT NULL
   ,RowID                     TINYINT NOT NULL
   ,ColumnID                  TINYINT NOT NULL
   ,SquareValue               TINYINT
   ,InitialValue              TINYINT
);

ALTER TABLE
   dbo.SquareData
ADD CONSTRAINT
   PK_SquareData
PRIMARY KEY
(
   PuzzleID
   ,BlockID
   ,RowID
   ,ColumnID
);
