CREATE TABLE dbo.SquareData
(
	PuzzleID						INT NOT NULL
	,BlockID						INT NOT NULL
	,RowID							INT NOT NULL
	,ColumnID						INT NOT NULL
	,SquareValue					INT
	,InitialValue					INT
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
