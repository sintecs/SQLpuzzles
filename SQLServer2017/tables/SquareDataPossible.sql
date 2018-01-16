CREATE TABLE dbo.SquareDataPossible
(
	PuzzleID						INT NOT NULL
	,BlockID						INT NOT NULL
	,RowID							INT NOT NULL
	,ColumnID						INT NOT NULL
	,PossibleValue					INT NOT NULL
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
