CREATE TABLE dbo.SquareDataPossible
(
   PuzzleID                   TINYINT NOT NULL
   ,BlockID                   TINYINT NOT NULL
   ,RowID                     TINYINT NOT NULL
   ,ColumnID                  TINYINT NOT NULL
   ,PossibleValue             TINYINT NOT NULL
);

ALTER TABLE
   dbo.SquareDataPossible
ADD CONSTRAINT
   PK_SquareDataPossible
PRIMARY KEY
(
   PuzzleID
   ,BlockID
   ,RowID
   ,ColumnID
   ,PossibleValue
);
